package com.courier.controlador;

import com.courier.dao.UsuarioDAO;
import com.courier.modelo.usuarios;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    UsuarioDAO dao = new UsuarioDAO();

    // -----------------------------------------------------------
    // MÉTODO DOGET: Maneja Cargar (Editar), Eliminar y Restaurar
    // -----------------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("cargar".equals(accion)) {
            // 1. EDITAR: Busca datos y los manda al formulario
            int id = Integer.parseInt(request.getParameter("id"));
            usuarios u = dao.obtenerPorId(id);
            request.setAttribute("usuario_a_editar", u);
            request.getRequestDispatcher("editar_usuario.jsp").forward(request, response);
            
        } else if ("eliminar".equals(accion)) { 
            // 2. ELIMINAR: Desactiva al usuario
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);
            response.sendRedirect("dashboard.jsp");
            
        } else if ("restaurar".equals(accion)) { 
            // 3. RESTAURAR: Reactiva al usuario (Papelera)
            int id = Integer.parseInt(request.getParameter("id"));
            dao.activar(id); // <--- Este es el método nuevo
            response.sendRedirect("dashboard.jsp");
        }
    }

    // -----------------------------------------------------------
    // MÉTODO DOPOST: Maneja Actualizar (Guardar cambios del form)
    // -----------------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("actualizar".equals(accion)) {
            // Recibimos los datos modificados
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String rol = request.getParameter("rol");
            String pass = request.getParameter("password");
            
            // Creamos el objeto usuario actualizado
            usuarios u = new usuarios();
            u.setId(id);
            u.setNombre_completo(nombre);
            u.setEmail(email);
            u.setRol(rol);
            u.setPassword(pass);
            
            // Guardamos en BD y volvemos
            dao.actualizar(u);
            response.sendRedirect("dashboard.jsp");
            
        } else if ("registrar".equals(accion)) { // <--- ESTO ES LO NUEVO
            // 1. Recibimos los datos del formulario nuevo
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String rol = request.getParameter("rol");
            String pass = request.getParameter("password");
            
            // 2. Creamos el objeto (Sin ID, porque es nuevo y la base lo genera sola)
            usuarios u = new usuarios();
            u.setNombre_completo(nombre);
            u.setEmail(email);
            u.setRol(rol);
            u.setPassword(pass);
            u.setActivo(true);
            
            // 3. Guardamos
            dao.registrar(u);
            
            // 4. Volvemos al dashboard
            response.sendRedirect("dashboard.jsp");
        }
    }
}