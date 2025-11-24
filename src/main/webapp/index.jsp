<%-- 
    Document   : index
    Created on : 20 nov 2025, 12:52:15 p. m.
    Author     : amy_t
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mi Proyecto</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style> body {
            padding-top: 70px;
        } </style>
    </head>
    <body>
        <jsp:include page="/Utilidad/header.jsp" />

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

        <%--  <jsp:include page="/Utilidad/header.jsp" /> --%>
    </body>
</html> 