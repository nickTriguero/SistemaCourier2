<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.courier.modelo.envios"%>
<%@page import="com.courier.modelo.usuarios"%>

<%
    // Seguridad: Solo Admins
    usuarios usuarioLogueado = (usuarios) session.getAttribute("usuario");
    if (usuarioLogueado == null || !usuarioLogueado.getRol().equals("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Recuperar datos enviados por el Servlet
    List<envios> listaEnvios = (List<envios>) request.getAttribute("misEnvios");
    List<usuarios> listaCouriers = (List<usuarios>) request.getAttribute("listaCouriers");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Envíos</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; margin: 0; background-color: #f8f9fa; }
        /* Barra de Navegación */
        .navbar { background-color: #343a40; padding: 15px; display: flex; align-items: center; }
        .navbar a { color: white; text-decoration: none; margin-right: 20px; font-weight: bold; }
        .navbar a:hover { color: #ffc107; }
        .active { border-bottom: 2px solid #ffc107; }
        
        h2 { text-align: center; margin-top: 20px; }
        table { width: 95%; margin: 20px auto; border-collapse: collapse; background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #007bff; color: white; }
        
        /* Estilos para controles */
        select { padding: 5px; border-radius: 4px; }
        .btn-save { background-color: #28a745; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 4px; }
    </style>
</head>
<body>

    <!-- BARRA DE NAVEGACIÓN COMPARTIDA -->
    <div class="navbar">
        <h3 style="color:white; margin:0 20px 0 0;">🚚 AdminPanel</h3>
        <a href="dashboard.jsp">👥 Gestionar Usuarios</a>
        <a href="EnvioServlet?accion=listar" class="active">📦 Gestionar Envíos</a>
        <a href="LoginServlet?accion=Logout" style="margin-left: auto; color: #ff6b6b;">Cerrar Sesión</a>
    </div>

    <h2>📦 Control de Paquetes y Asignaciones</h2>

    <table>
        <thead>
            <tr>
                <th>Guía</th>
                <th>Descripción</th>
                <th>Cliente ID</th>
                <th>Estado Actual</th>
                <th>Repartidor (Courier)</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody>
            <% 
            if (listaEnvios != null) {
                for (envios e : listaEnvios) { 
            %>
            <tr>
                <!-- Formulario INDIVIDUAL por fila -->
                <form action="EnvioServlet" method="POST">
                    <input type="hidden" name="accion" value="actualizar">
                    <input type="hidden" name="id_envio" value="<%= e.getId_envio() %>">
                    
                    <td><%= e.getN_guia() %></td>
                    <td><%= e.getDescripcion() %></td>
                    <td><%= e.getCliente_id() %></td>
                    
                    <td>
                        <!-- Dropdown de ESTADO -->
                        <select name="estado">
                            <option value="Pendiente" <%= "Pendiente".equals(e.getEstado()) ? "selected" : "" %>>Pendiente</option>
                            <option value="En camino" <%= "En camino".equals(e.getEstado()) ? "selected" : "" %>>En camino</option>
                            <option value="Entregado" <%= "Entregado".equals(e.getEstado()) ? "selected" : "" %>>Entregado</option>
                        </select>
                    </td>
                    
                    <td>
                        <!-- Dropdown de COURIER (Llenado dinámico) -->
                        <select name="id_courier">
                            <option value="0">-- Sin asignar --</option>
                            <% for (usuarios c : listaCouriers) { %>
                                <option value="<%= c.getId() %>" <%= c.getId() == e.getCurier_id() ? "selected" : "" %>>
                                    <%= c.getNombre_completo() %>
                                </option>
                            <% } %>
                        </select>
                    </td>
                    
                    <td>
                        <button type="submit" class="btn-save">💾 Guardar</button>
                    </td>
                </form>
            </tr>
            <% 
                } 
            } else { 
            %>
                <tr><td colspan="6">No hay envíos registrados.</td></tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>