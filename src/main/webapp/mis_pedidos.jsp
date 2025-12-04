<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.courier.config.ConexionDB, com.courier.modelo.usuarios"%>
<%
    // 1. SEGURIDAD: Verificar si el usuario es cliente
    usuarios u = (usuarios) session.getAttribute("usuario");
    if (u == null) {
        response.sendRedirect("Utilidad/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Pedidos - GigiCourier</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        
        /* Navbar estilo GigiCourier */
        .navbar { background-color: white; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .navbar-brand { color: #D32F2F !important; font-weight: 900; letter-spacing: -1px; }
        
        /* Cabecera */
        .page-header { background: #D32F2F; color: white; padding: 40px 0; margin-bottom: 30px; }
        
        /* Tarjetas de Pedidos */
        .order-card { background: white; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 20px; border-left: 5px solid #ccc; transition: transform 0.2s; }
        .order-card:hover { transform: translateY(-3px); }
        
        /* Colores de estado */
        .border-pendiente { border-left-color: #6c757d; } /* Gris */
        .border-camino { border-left-color: #ffc107; } /* Amarillo */
        .border-entregado { border-left-color: #198754; } /* Verde */
        
        .badge-pendiente { background-color: #6c757d; }
        .badge-camino { background-color: #ffc107; color: black; }
        .badge-entregado { background-color: #198754; }
        
        .guia-text { font-size: 1.2rem; font-weight: bold; color: #333; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <span class="material-icons" style="vertical-align: middle;">local_shipping</span> GIGICOURIER
            </a>
            <div class="d-flex align-items-center">
                <span class="me-3 text-muted d-none d-md-block">Hola, <%= u.getNombre_completo() %></span>
                <a href="LoginServlet?accion=Logout" class="btn btn-outline-danger btn-sm">Cerrar Sesión</a>
            </div>
        </div>
    </nav>
    <br><br>

    <div class="page-header text-center">
        <h2>📦 Mis Envíos</h2>
        <p class="mb-0">Historial de tus paquetes y solicitudes.</p>
    </div>

    <div class="container">
        
        <div class="text-end mb-4">
            <a href="solicitar_envio.jsp" class="btn btn-danger fw-bold">+ NUEVO ENVÍO</a>
        </div>

        <% 
            // ALERTAS DE ÉXITO
            String exito = request.getParameter("exito");
            String nuevo = request.getParameter("nuevo");
            if(exito != null || nuevo != null) {
        %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <strong>¡Excelente!</strong> Tu solicitud de envío ha sido creada exitosamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <div class="row">
            <%
                // --- AQUÍ ESTABA EL ERROR: AHORA USAMOS SQL CLÁSICO ---
                String sql = "SELECT e.*, u.nombre_completo AS nombre_courier " +
                             "FROM envios e " +
                             "LEFT JOIN usuarios u ON e.curier_id = u.id " +
                             "WHERE e.cliente_id = ? " +
                             "ORDER BY e.id_envio DESC";

                try (Connection con = ConexionDB.getConexion();
                     PreparedStatement ps = con.prepareStatement(sql)) {
                    
                    ps.setInt(1, u.getId());
                    ResultSet rs = ps.executeQuery();
                    
                    boolean hayDatos = false;
                    while (rs.next()) {
                        hayDatos = true;
                        String estado = rs.getString("estado");
                        String claseBorde = "border-pendiente";
                        String claseBadge = "badge-pendiente";
                        
                        if ("En camino".equals(estado)) { claseBorde = "border-camino"; claseBadge = "badge-camino"; }
                        if ("Entregado".equals(estado)) { claseBorde = "border-entregado"; claseBadge = "badge-entregado"; }
            %>
            
            <div class="col-md-6 col-lg-4">
                <div class="order-card p-3 <%= claseBorde %>">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <div>
                            <span class="text-muted small">GUÍA:</span>
                            <div class="guia-text"><%= rs.getString("n_guia") %></div>
                        </div>
                        <span class="badge <%= claseBadge %> rounded-pill"><%= estado %></span>
                    </div>
                    
                    <p class="mb-1 text-truncate"><strong>Contenido:</strong> <%= rs.getString("descripcion") %></p>
                    
                    <div class="d-flex justify-content-between small text-muted mt-3">
                        <span>Origen: <%= rs.getString("inicio") %></span>
                        <span class="material-icons" style="font-size: 14px;">arrow_forward</span>
                        <span>Destino: <%= rs.getString("destino") %></span>
                    </div>
                    
                    <hr class="my-2">
                    
                    <div class="d-flex justify-content-between align-items-center">
                        <small class="text-muted">Courier: <%= rs.getString("nombre_courier") != null ? rs.getString("nombre_courier") : "Sin asignar" %></small>
                        <a href="consultaEnvio.jsp?guia=<%= rs.getString("n_guia") %>" class="btn btn-sm btn-outline-dark">Ver Rastreo</a>
                    </div>
                </div>
            </div>

            <% 
                    } // Fin While 
                    
                    if (!hayDatos) {
            %>
                <div class="col-12 text-center py-5">
                    <h3 class="text-muted">Aún no tienes envíos.</h3>
                    <p>¡Realiza tu primera solicitud hoy mismo!</p>
                </div>
            <%
                    }
                } catch (Exception e) {
                    out.print("<div class='alert alert-danger'>Error: " + e + "</div>");
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>