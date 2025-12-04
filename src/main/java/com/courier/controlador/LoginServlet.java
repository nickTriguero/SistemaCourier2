package com.courier.controlador;

import com.courier.dao.UsuarioDAO;
import com.courier.modelo.usuarios;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    // 1. Agregamos doGet para que funcione el botón "Cerrar Sesión" (Logout)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("Logout".equals(accion)) {
            HttpSession session = request.getSession();
            session.invalidate(); // Destruye la sesión
            response.sendRedirect("index.jsp"); // Manda al inicio
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        UsuarioDAO dao = new UsuarioDAO();

        if ("ingresar".equals(accion)) {
            // Recibimos los datos del formulario (names: email, password)
            String email = request.getParameter("email");
            String pass = request.getParameter("password");

            usuarios Usuario = dao.validarUsuario(email, pass);

            if (Usuario != null) {
                // Login correcto
                HttpSession session = request.getSession();
                
                // --- CAMBIO IMPORTANTE ---
                // Guardamos el OBJETO COMPLETO 'Usuario', no solo el nombre string.
                // Esto es vital para que el dashboard pueda leer info del usuario.
                session.setAttribute("usuario", Usuario); 
                session.setAttribute("rol", Usuario.getRol());

                // --- LÓGICA DE REDIRECCIÓN POR ROL ---
                if (Usuario.getRol().equalsIgnoreCase("admin")) {
                    response.sendRedirect("dashboard.jsp");
                    
                } else if (Usuario.getRol().equalsIgnoreCase("courier")) {
                    // ¡AQUÍ ESTÁ EL CAMBIO! Lo mandamos a pedir sus entregas
                    response.sendRedirect("EnvioServlet?accion=mis_entregas");
                    
                } else {
                    // Clientes
                    response.sendRedirect("index.jsp");
                }
                
            } else {
                // Login fallido: Lo devolvemos con error
                // Nota: Asumo que tu login.jsp está en la carpeta Utilidad según tu código anterior
                response.sendRedirect(request.getContextPath() + "/Utilidad/login.jsp?error=true");
            }
            
        } else if ("recuperar".equals(accion)) {
            // Lógica de Recuperar Contraseña
            String email = request.getParameter("email");
            String nuevaPass = request.getParameter("newPassword");

            boolean exito = dao.cambiarPassword(email, nuevaPass);

            if (exito) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect(request.getContextPath() + "/Utilidad/login.jsp?mensaje=cambiada");
            } else {
                response.sendRedirect("recuperar.jsp?error=true");
            }
        }
    }
}