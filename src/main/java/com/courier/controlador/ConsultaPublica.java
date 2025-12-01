package com.courier.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author RinRi
 */

@WebServlet("/consultar")
public class ConsultaPublica extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String guia = request.getParameter("guia");
        if (guia != null && !guia.trim().isEmpty()) {
            request.setAttribute("guia", guia.trim().toUpperCase());
        } else {
            request.setAttribute("guia", null); //
        }
        
        request.getRequestDispatcher("/consultaEnvio.jsp").forward(request, response);
    }
}