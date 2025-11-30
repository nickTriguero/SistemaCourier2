<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Ignorar</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { font-family: 'Segoe UI', sans-serif; margin: 0; background-color: #f8f9fa; }
            .navbar { background-color: #343a40; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
            .navbar h1 { margin: 0; font-size: 1.5rem; }
            .user-info { font-size: 0.9rem; }
            .container { padding: 2rem; }
            .card { background: white; padding: 20px; margin-top: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); border-left: 5px solid #0d6efd; }
            .btn-logout { background: #dc3545; color: white; padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 0.8rem; margin-left: 10px; }
            .dropdown-item.danger { color: #dc3545; font-weight: 500; }
            .dropdown-item.danger:hover { background-color: #f8d7da; color: #721c24; }
        </style>
    </head>
    <body>
        <%
            String nombreUsuario = (String) session.getAttribute("usuario");
            String rol = (String) session.getAttribute("rol");
        %>

        <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand" href="<%= request.getContextPath()%>/index.jsp">
                    <strong>🚚 Sistema Courier</strong> <%--Nombre pendiente--%>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/index.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Contacto</a></li>
                    </ul>

                    <% if (nombreUsuario != null) {%>
                    <!--Menú desplegable usando el nombre -->
                    <div class="dropdown"> Hola,
                        <a class="btn btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <strong><%= nombreUsuario%></strong>
                            <% if (rol != null) {%>
                            <small class="text-light opacity-75">(<%= rol%>)</small>
                            <% }%>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="<%= request.getContextPath()%>/perfil.jsp">Mi Perfil</a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath()%>/mis_pedidos.jsp">Mis Pedidos</a></li>
                            <li><hr class="dropdown-divider"></li>

                            <!--Opciones según el rol-->
                            <% if ("admin".equalsIgnoreCase(rol)) {%>
                            <!--Cambiar, borrar o mantener según lo que se quiera agregar-->
                            <li><h6 class="dropdown-header text-primary fw-bold">Administración</h6></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath()%>/admin/usuarios.jsp">Gestionar Usuarios</a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath()%>/admin/reportes.jsp">Reportes</a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath()%>/admin/config.jsp">Configuración</a></li>
                            <li><hr class="dropdown-divider"></li>
                                <% } else if ("cliente".equalsIgnoreCase(rol)) { %>
                            <!--<li><a class="dropdown-item" href="#">Historial de Envíos</a></li> Agregar si hay una opción para agregar
                            <li><hr class="dropdown-divider"></li>-->
                                <% } else if ("courier".equalsIgnoreCase(rol)) { %>
                            <!--Cambiar, borrar o mantener según lo que se quiera agregar-->
                            <li><a class="dropdown-item" href="#">Rutas Asignadas</a></li>
                            <li><a class="dropdown-item" href="#">Entregas Pendientes</a></li>
                            <li><hr class="dropdown-divider"></li>
                                <% }%>

                            <li><a class="dropdown-item danger" href="<%= request.getContextPath()%>/logout">Cerrar Sesión</a></li>
                        </ul>
                    </div>
                    <% } else { //SIN LOGIN%>
                    <a href="<%= request.getContextPath()%>/Utilidad/login.jsp" class="btn btn-outline-light btn-sm">Ingresar</a><%}%>
                </div>
            </div>
        </nav>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
