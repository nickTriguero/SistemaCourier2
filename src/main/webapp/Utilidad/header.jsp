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
                        <li class="nav-item"> <a class="nav-link" data-bs-toggle="modal" data-bs-target="#modalConsultarEnvio" style="cursor: pointer;">Consultar Envío</a></li>
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

<!-- ======================MODAL Consultar Envío sin login====================== -->
<div class="modal fade" id="modalConsultarEnvio" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Consulta tu envío</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <form action="<%= request.getContextPath()%>/consultaEnvio.jsp" method="get">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="nGuia" class="form-label fw-bold">Número de Guía</label>
                        <input type="text" class="form-control form-control-lg text-center" 
                               id="nGuia" name="guia" placeholder="Ej: Cl999" 
                               maxlength="20" required autocomplete="off">
                        <div class="form-text">Ingresa el número de guía del envío que desea consultar.</div>
                    </div>
                    <div style="display: flex; justify-content: flex-end; gap: 0.35rem;">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary btn-lg px-4">Buscar Envío</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
    .navbar .btn-seguimiento {
        font-size: 0.95rem;
    }
</style>