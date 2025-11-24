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
            .btn-logout { background: #dc3545; color: white; padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 0.8rem; margin-left: 10px;}
        </style>
    </head>
    <body>
        <%
            String nombreUsuario = (String) session.getAttribute("usuario");
            String rol = (String) session.getAttribute("rol");
            if (nombreUsuario == null) {
                nombreUsuario = null; //sin sesión
            }
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

                    <%--Detectamos si el usuario está logueado--%>
                    <%
                        String usuario = (String) session.getAttribute("usuario");
                        if (usuario != null) {
                            //LOGUEADO
                    %>
                    <span class="navbar-text me-3">
                        Hola, <%= session.getAttribute("usuario")%> <!--Lo ideal es que sea el nombre-->
                        (Rol: <strong><%= session.getAttribute("rol") %></strong>)
                    </span>
                    <a href="<%= request.getContextPath() %>/logout" class="btn-logout">Cerrar Sesión</a> 
                    <%
                    } else {
                        //SIN LOGUEADO
                    %>
                    <a href="<%= request.getContextPath()%>/Utilidad/login.jsp" class="btn btn-outline-light btn-sm">
                        Ingresar
                    </a>
                    <%
                        }
                    %>
                </div>
            </div>
        </nav>
    </body>
</html>