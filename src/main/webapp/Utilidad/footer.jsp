<%-- 
    Document   : footer
    Created on : 29 nov 2025, 10:41:29 p. m.
    Author     : RinRi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ignorar</title>
        <style>
            .hover-opacity-100:hover {
                opacity: 1 !important;
            }
        </style>
    </head>
    <body>

        <footer class="bg-dark text-white mt-5 py-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <h5 class="fw-bold mb-3">
                            Sistema Courier
                        </h5>
                        <p class="text-light opacity-75">
                            Tu solución confiable de envíos nacionales.<br>
                            Rápido • Seguro • Siempre a tiempo.
                        </p>
                    </div>

                    <div class="col-md-4 mb-4">
                        <h5 class="fw-bold mb-3">Enlaces rápidos</h5>
                        <ul class="list-unstyled">
                            <li><a href="<%= request.getContextPath()%>/index.jsp" class="text-white text-decoration-none opacity-75 hover-opacity-100">Inicio</a></li>
                            <li><a href="<%= request.getContextPath()%>/mis_pedidos.jsp" class="text-white text-decoration-none opacity-75 hover-opacity-100">Mis Envíos</a></li>
                            <li><a href="#" class="text-white text-decoration-none opacity-75 hover-opacity-100">Tarifas</a></li>
                        </ul>
                    </div>

                    <div class="col-md-4 mb-4">
                        <h5 class="fw-bold mb-3">Contacto</h5>
                        <p class="mb-1 opacity-75">
                            ✉️ soporte@courier.com
                        </p>
                        <p class="mb-1 opacity-75">
                            ☎️ +593 123 456 7890
                        </p>
                        <p class="mb-0 opacity-75">
                            Guayaquil, Ecuador
                        </p>
                    </div>
                </div>

                <hr class="bg-white opacity-25">

                <div class="text-center pt-3">
                    <small class="opacity-75">
                        © 2025 Sistema Courier • Todos los derechos reservados
                    </small>
                </div>
            </div>
        </footer>
    </body>
</html>
