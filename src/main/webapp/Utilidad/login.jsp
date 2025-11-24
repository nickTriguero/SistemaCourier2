<%-- 
    Document   : index
    Created on : 20 nov 2025, 12:52:15 p. m.
    Author     : amy_t
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Courier System</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; background-color: #e9ecef; margin: 0; }
        .card { background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 350px; }
        h2 { text-align: center; color: #333; margin-bottom: 1.5rem; }
        .form-group { margin-bottom: 1rem; }
        label { display: block; margin-bottom: 0.5rem; color: #666; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        button { width: 100%; padding: 10px; background: #0d6efd; color: white; border: none; border-radius: 5px; font-size: 1rem; cursor: pointer; transition: 0.3s; }
        button:hover { background: #0b5ed7; }
        .links { text-align: center; margin-top: 1rem; font-size: 0.9rem; }
        .links a { color: #0d6efd; text-decoration: none; }
        .alert { padding: 10px; background: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 1rem; text-align: center; font-size: 0.9rem; }
        .success { background: #d1e7dd; color: #0f5132; }
    </style>
</head>
<body>
    <div class="card">
        <h2>📦 Sistema Courier</h2>  <%--Nombre Pendiente--%>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="alert">Usuario o contraseña incorrectos.</div>
        <% } %>
        <% if (request.getParameter("mensaje") != null) { %>
            <div class="alert success">¡Contraseña actualizada! Ingresa ahora.</div>
        <% } %>
        
        <form action="<%= request.getContextPath() %>/LoginServlet" method="POST">
            <div class="form-group">
                <label>Correo Electrónico</label>
                <input type="email" name="email" placeholder="ej. admin@courier.com" required>
            </div>
            <div class="form-group">
                <label>Contraseña</label>
                <input type="password" name="password" placeholder="******" required>
            </div>
            <button type="submit" name="accion" value="ingresar">Iniciar Sesión</button>
        </form>
        
        <div class="links">
            <a href="recuperar.jsp">¿Olvidaste tu contraseña?</a>
        </div>
    </div>
</body>
</html>