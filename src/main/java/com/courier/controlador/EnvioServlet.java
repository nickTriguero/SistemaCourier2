package com.courier.controlador;

import com.courier.dao.EnvioDAO;
import com.courier.dao.UsuarioDAO; // Importante para el registro express
import com.courier.modelo.envios;
import com.courier.modelo.usuarios;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "EnvioServlet", urlPatterns = {"/EnvioServlet"})
public class EnvioServlet extends HttpServlet {

    EnvioDAO dao = new EnvioDAO();

    // -------------------------------------------------------------------------
    // DOGET: Para consultar datos (Listar envíos, ver mis entregas, etc.)
    // -------------------------------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("listar".equals(accion)) {
            // ADMIN: Ver todos los envíos
            List<envios> listaEnvios = dao.listar();
            List<usuarios> listaCouriers = dao.listarCouriers();
            request.setAttribute("misEnvios", listaEnvios);
            request.setAttribute("listaCouriers", listaCouriers);
            request.getRequestDispatcher("gestion_envios.jsp").forward(request, response);
            
        } else if ("mis_entregas".equals(accion)) {
            // COURIER: Ver sus paquetes asignados
            HttpSession session = request.getSession();
            usuarios u = (usuarios) session.getAttribute("usuario");
            if(u != null){
                List<envios> misPaquetes = dao.listarPorCourier(u.getId());
                request.setAttribute("misPaquetes", misPaquetes);
                request.getRequestDispatcher("courier_dashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect("index.jsp");
            }
        
        } else if ("confirmar_entrega".equals(accion)) {
            // COURIER: Marcar paquete como entregado
            int idEnvio = Integer.parseInt(request.getParameter("id"));
            dao.marcarEntregado(idEnvio);
            response.sendRedirect("EnvioServlet?accion=mis_entregas");
        }
    }

    // -------------------------------------------------------------------------
    // DOPOST: Para guardar datos (Actualizar, Crear Pedido, Pedido Express)
    // -------------------------------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        // 1. ADMIN ACTUALIZA ESTADO O ASIGNA COURIER
        if ("actualizar".equals(accion)) {
            int idEnvio = Integer.parseInt(request.getParameter("id_envio"));
            String estado = request.getParameter("estado");
            int idCourier = Integer.parseInt(request.getParameter("id_courier"));
            
            dao.actualizarEnvio(idEnvio, estado, idCourier);
            response.sendRedirect("EnvioServlet?accion=listar");

        // 2. CLIENTE LOGUEADO CREA PEDIDO
        } else if ("crear_pedido".equals(accion)) {
            HttpSession session = request.getSession();
            usuarios u = (usuarios) session.getAttribute("usuario");
            
            if(u != null) {
                String descripcion = request.getParameter("descripcion");
                String origen = request.getParameter("origen");
                String destino = request.getParameter("destino");
                double peso = Double.parseDouble(request.getParameter("peso"));
                String servicio = request.getParameter("servicio");
                
                envios e = new envios();
                e.setCliente_id(u.getId());
                e.setDescripcion(descripcion);
                e.setInicio(origen);
                e.setDestino(destino);
                e.setPeso_kg(peso);
                e.setServicio(servicio);
                
                dao.solicitarEnvio(e);
                response.sendRedirect("mis_pedidos.jsp?exito=true");
            } else {
                response.sendRedirect("Utilidad/login.jsp");
            }

        // 3. PEDIDO EXPRESS (CLIENTE NUEVO - REGISTRO + PEDIDO)
        } else if ("pedido_express".equals(accion)) {
            
            // A. Recoger datos del Cliente
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            
            // B. Registrar al Usuario
            UsuarioDAO usuDao = new UsuarioDAO();
            usuarios nuevoUsuario = new usuarios();
            nuevoUsuario.setNombre_completo(nombre);
            nuevoUsuario.setEmail(email);
            nuevoUsuario.setPassword(pass);
            nuevoUsuario.setRol("cliente");
            
            usuDao.registrar(nuevoUsuario); // Registramos
            
            // C. Obtener el ID real del usuario recién creado
            usuarios usuarioConId = usuDao.validarUsuario(email, pass);
            
            if (usuarioConId != null) {
                // D. Recoger datos del Paquete
                String descripcion = request.getParameter("descripcion");
                String origen = request.getParameter("origen");
                String destino = request.getParameter("destino");
                double peso = Double.parseDouble(request.getParameter("peso"));
                String servicio = request.getParameter("servicio");

                // E. Crear el envío vinculado
                envios e = new envios();
                e.setCliente_id(usuarioConId.getId());
                e.setDescripcion(descripcion);
                e.setInicio(origen);
                e.setDestino(destino);
                e.setPeso_kg(peso);
                e.setServicio(servicio);

                dao.solicitarEnvio(e);

                // F. Auto-Login y Redirección
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuarioConId);
                
                // --- AQUÍ OCURRÍA EL ERROR ANTES: AHORA SOLO HAY UN REDIRECT ---
                response.sendRedirect("mis_pedidos.jsp?nuevo=true");
                
            } else {
                response.sendRedirect("solicitud_express.jsp?error=registro");
            }
        }
    }
}

