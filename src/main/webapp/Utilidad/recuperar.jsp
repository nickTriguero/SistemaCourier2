<%-- 
    Document   : recuperar
    Created on : 20 nov 2025, 12:53:19 p. m.
    Author     : amy_t
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Recuperar Clave</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; background-color: #e9ecef; margin: 0; }
        .card { background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 350px; }
        h2 { text-align: center; color: #333; }
        input { width: 100%; padding: 10px; margin: 10px 0; box-sizing: border-box; border: 1px solid #ddd; border-radius: 5px;}
        button { width: 100%; padding: 10px; background: #198754; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #157347; }
        .back { display: block; text-align: center; margin-top: 15px; color: #666; text-decoration: none; }
    </style>
</head>
<body>
    <%
    String origen = request.getParameter("from");
    String volverUrl = (origen != null && origen.equals("perfil")) 
        ? request.getContextPath() + "/perfil.jsp" 
        : request.getContextPath() + "/Utilidad/login.jsp";
    %>
    
    <div class="card">
        <h2>🔐 Restablecer Clave</h2>
        <p style="text-align: center; color: #666; font-size: 0.9rem;">Simulación: Ingresa tu correo y define una nueva clave directamente.</p>
        
        <% if (request.getParameter("error") != null) { %>
            <div style="color: red; text-align: center; margin-bottom: 10px;">El correo no existe en el sistema.</div>
        <% } %>

        <form action="<%= request.getContextPath() %>/LoginServlet" method="POST">
            <label>Tu Correo:</label>
            <input type="email" name="email" required>
            
            <label>Nueva Contraseña:</label>
            <input type="password" name="newPassword" required>
            
            <button type="submit" name="accion" value="recuperar">Cambiar Contraseña</button>
        </form>
        
        <a href="<%= volverUrl %>" class="back">← Regresar</a>
    </div>
</body>
</html>
