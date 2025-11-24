/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.courier.controlador;

import com.courier.dao.UsuarioDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Esta línea define la URL a la que llamará el formulario
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Recibimos qué acción quiere hacer el usuario (ingresar o recuperar)
        String accion = request.getParameter("accion");
        UsuarioDAO dao = new UsuarioDAO();

        if ("ingresar".equals(accion)) {
            // 1. Lógica de Login
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            
            String rol = dao.validarUsuario(email, pass);

            if (rol != null) {
                // Login correcto: Creamos una sesión para recordar al usuario
                HttpSession session = request.getSession();
                session.setAttribute("usuario", email);
                session.setAttribute("rol", rol);
                
                // Lo enviamos al menú principal
                response.sendRedirect("index.jsp"); 
            } else {
                // Login fallido: Lo devolvemos con error
                response.sendRedirect(request.getContextPath() + "/Utilidad/login.jsp?error=true");
            }
        } 
        else if ("recuperar".equals(accion)) {
            // 2. Lógica de Recuperar Contraseña
            String email = request.getParameter("email");
            String nuevaPass = request.getParameter("newPassword");
            
            boolean exito = dao.cambiarPassword(email, nuevaPass);
            
            if(exito){
                response.sendRedirect("index.jsp?mensaje=clave_cambiada");
            } else {
                response.sendRedirect("recuperar.jsp?error=true");
            }
        }
    }
}