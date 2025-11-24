<%-- 
    Página sin usar - Borrable
    Document   : dashboard
    Created on : 20 nov 2025, 12:53:54 p. m.
    Author     : amy_t
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--
    // 1. SEGURIDAD: Verificar si hay alguien logueado
    // Si la sesión es nula o no hay usuario, lo pateamos fuera
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
--%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Courier</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; margin: 0; background-color: #f8f9fa; }
        .navbar { background-color: #343a40; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { margin: 0; font-size: 1.5rem; }
        .user-info { font-size: 0.9rem; }
        .container { padding: 2rem; }
        .card { background: white; padding: 20px; margin-top: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); border-left: 5px solid #0d6efd; }
        .btn-logout { background: #dc3545; color: white; padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 0.8rem; margin-left: 10px;}
    </style>
</head>
<body>
    <div class="navbar">
        <h1>🚚 Sistema Courier</h1>
        <div class="user-info">
            Hola, <%= session.getAttribute("usuario") %> 
            (Rol: <strong><%= session.getAttribute("rol") %></strong>)
            <a href="index.jsp" class="btn-logout">Cerrar Sesión</a> 
            </div>
    </div>

    <div class="container">
        <h2>Panel Principal</h2>
        <p>Bienvenido al primer avance del sistema.</p>

        <div class="card">
            <h3>Estado del Proyecto</h3>
            <ul>
                <li>✅ Base de Datos conectada</li>
                <li>✅ Login funcional</li>
                <li>✅ Seguridad de sesión implementada</li>
                <li>⏳ Módulos de envíos (Pendiente para el Grupo)</li>
            </ul>
        </div>
    </div>
</body>
</html>
