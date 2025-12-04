<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.courier.modelo.usuarios"%>
<%@page import="com.courier.dao.UsuarioDAO"%>

<%
    // 1. SEGURIDAD: Verificar si hay alguien logueado
    usuarios usuarioLogueado = (usuarios) session.getAttribute("usuario");
    
    // Si no hay sesión o no es admin, fuera
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Courier</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; margin: 0; background-color: #f8f9fa; }
        
        /* --- ESTILOS DE LA BARRA DE NAVEGACIÓN (CORREGIDOS) --- */
        .navbar { 
            background-color: #343a40; 
            padding: 15px 20px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links h3 { color: white; margin: 0; margin-right: 10px; font-size: 1.2rem; }
        .nav-links a { text-decoration: none; color: #ccc; font-weight: 500; font-size: 0.95rem; }
        .nav-links a:hover { color: white; }
        .nav-links a.active { color: #ffc107; border-bottom: 2px solid #ffc107; padding-bottom: 2px;}

        .user-info { color: white; font-size: 0.9rem; display: flex; align-items: center; gap: 15px; }
        .btn-logout { background-color: #dc3545; color: white; padding: 5px 12px; text-decoration: none; border-radius: 4px; font-size: 0.85rem; transition: background 0.3s;}
        .btn-logout:hover { background-color: #bb2d3b; }

        /* --- CONTENEDOR PRINCIPAL --- */
        .container { padding: 2rem; max-width: 1200px; margin: 0 auto; }
        .card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); border-top: 4px solid #0d6efd; }
        
        /* --- TABLAS --- */
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #dee2e6; padding: 12px; text-align: left; }
        th { background-color: #f8f9fa; color: #495057; font-weight: 600; }
        tr:nth-child(even) { background-color: #f8f9fa; }
        
        .rol-badge { padding: 4px 8px; border-radius: 12px; font-size: 0.75em; font-weight: bold; letter-spacing: 0.5px; }
        
        /* Botones de acción */
        .btn-action { cursor: pointer; border: none; padding: 5px 10px; border-radius: 4px; color: white; font-size: 0.8rem; margin-right: 5px; }
        .btn-edit { background-color: #6c757d; }
        .btn-delete { background-color: #dc3545; }
        .btn-restore { background-color: #28a745; }
        
        /* Botón Nuevo Usuario */
        .btn-new { background-color: #0d6efd; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 1rem; text-decoration: none; display: inline-block; }
        .btn-new:hover { background-color: #0b5ed7; }
    </style>
</head>
<body>

    <div class="navbar">
        <div class="nav-links">
            <h3>🚚 GIGICOURIER </h3>
            <a href="dashboard.jsp" class="active">👥 Usuarios</a>
            <a href="EnvioServlet?accion=listar">📦 Envíos</a>
        </div>
        
        <div class="user-info">
            <span>Hola, <strong><%= usuarioLogueado.getNombre_completo() %></strong></span>
            <a href="LoginServlet?accion=Logout" class="btn-logout">Cerrar Sesión</a>
        </div>
    </div>

    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2>Gestión de Usuarios</h2>
            <a href="nuevo_usuario.jsp" class="btn-new">+ Nuevo Usuario</a>
        </div>

        <div class="card">
            <h3 style="margin-top: 0; color: #495057;">Usuarios Activos</h3>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre Completo</th>
                        <th>Email</th>
                        <th>Rol</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        UsuarioDAO dao = new UsuarioDAO();
                        // Listamos solo los activos
                        List<usuarios> lista = dao.listarUsuarios();
                        
                        for (usuarios u : lista) {
                    %>
                    <tr>
                        <td><%= u.getId() %></td>
                        <td><%= u.getNombre_completo() %></td>
                        <td><%= u.getEmail() %></td>
                        <td>
                            <span class="rol-badge" style="background-color: <%= u.getRol().equals("admin") ? "#ffc107" : "#198754" %>; color: <%= u.getRol().equals("admin") ? "black" : "white" %>;">
                                <%= u.getRol().toUpperCase() %>
                            </span>
                        </td>
                        <td>
                            <a href="UsuarioServlet?accion=cargar&id=<%= u.getId() %>">
                                <button class="btn-action btn-edit">Editar</button>
                            </a>
                            <a href="UsuarioServlet?accion=eliminar&id=<%= u.getId() %>" onclick="return confirm('¿Estás seguro de desactivar a este usuario?')">
                                <button class="btn-action btn-delete">Eliminar</button>
                            </a>
                        </td>
                    </tr>
                    <% } %>
                    
                    <% if (lista.isEmpty()) { %>
                        <tr><td colspan="5" style="text-align:center; padding: 20px;">No hay usuarios activos.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <div class="card" style="border-top: 4px solid #6c757d; background-color: #fdfdfe;">
            <h3 style="margin-top: 0; color: #6c757d; font-size: 1rem;">🗑️ Papelera (Usuarios Eliminados)</h3>
            
            <table style="margin-top: 10px;">
                <thead>
                    <tr style="background-color: #e9ecef;">
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<usuarios> listaBorrados = dao.listarInactivos();
                        for (usuarios u : listaBorrados) {
                    %>
                    <tr>
                        <td><%= u.getId() %></td>
                        <td><%= u.getNombre_completo() %></td>
                        <td><%= u.getEmail() %></td>
                        <td>
                            <a href="UsuarioServlet?accion=restaurar&id=<%= u.getId() %>">
                                <button class="btn-action btn-restore">♻️ Restaurar</button>
                            </a>
                        </td>
                    </tr>
                    <% } %>
                    <% if (listaBorrados.isEmpty()) { %>
                        <tr><td colspan="4" style="text-align:center; color: #adb5bd;">Papelera vacía.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>