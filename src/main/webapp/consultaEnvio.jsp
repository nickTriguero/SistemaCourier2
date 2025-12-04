<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.courier.config.ConexionDB, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Seguimiento de Envío</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { min-height: 100vh; color: white; }
            .card { background: rgba(0,0,0,0.7); border: none; }
            .progress { height: 40px; }
            .progress-bar { font-size: 1.1rem; font-weight: bold; }
        </style>
    </head>
    <body>

        <jsp:include page="/Utilidad/header.jsp" />

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-lg-9">
                    <div class="card shadow-lg">
                        <div class="card-header bg-primary text-center">
                            <h2 class="mb-0 fw-bold">Seguimiento de Envío</h2>
                        </div>
                        <div class="card-body p-5">

                            <%
                                String guia = request.getParameter("guia");
                                SimpleDateFormat sdf = new SimpleDateFormat("dd 'de' MMMM 'de' yyyy, hh:mm a");

                                if (guia == null || guia.trim().isEmpty()) {
                                    out.print("<h3 class='text-center text-danger'>No se ingresó número de guía</h3>");
                                } else {
                                    guia = guia.trim().toUpperCase();

                                    // CORRECCIÓN 1: Usamos concatenación (+) en lugar de bloques de texto (""")
                                    String sql = "SELECT e.*, u.nombre_completo AS nombre_courier " +
                                                 "FROM envios e " +
                                                 "LEFT JOIN usuarios u ON e.curier_id = u.id " +
                                                 "WHERE UPPER(e.n_guia) = ?";
                                    
                                    try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

                                        ps.setString(1, guia);
                                        ResultSet rs = ps.executeQuery();
                                        
                                        if (rs.next()) {
                                            String estado = rs.getString("estado");
                                            
                                            // CORRECCIÓN 2: Usamos IF-ELSE en lugar de SWITCH moderno
                                            String color = "info"; // Color por defecto
                                            int porcentaje = 35;   // Porcentaje por defecto

                                            if ("Entregado".equals(estado)) {
                                                color = "success";
                                                porcentaje = 100;
                                            } else if ("En camino".equals(estado)) {
                                                color = "warning";
                                                porcentaje = 70;
                                            } else if ("Pendiente".equals(estado)) {
                                                color = "secondary";
                                                porcentaje = 35;
                                            }
                            %>

                            <div class="text-center mb-5">
                                <h1 class="display-4 fw-bold"><%= rs.getString("n_guia")%></h1>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-lg-3 col-md-6"><h5><strong>Descripción:</strong></h5><p class="fs-4"><%= rs.getString("descripcion")%></p></div>
                                <div class="col-lg-3 col-md-6"><h5><strong>Peso:</strong></h5><p class="fs-4"><%= String.format("%.2f", rs.getDouble("peso_kg"))%> kg</p></div>
                                <div class="col-lg-3 col-md-6"><h5><strong>Servicio:</strong></h5>
                                    <p class="fs-4"><span class="badge bg-<%= "Express".equals(rs.getString("servicio")) ? "success" : "warning"%>">
                                            <%= rs.getString("servicio")%></span></p></div>
                                <div class="col-lg-3 col-md-6"><h5><strong>Costo:</strong></h5><p class="fs-4 text-success fw-bold"><%= rs.getString("costo")%></p></div>
                            </div>
                            <div class="row g-4">
                                <div class="col-lg-4 col-md-6"><h5><strong>Lugar de Origen:</strong></h5><p class="fs-4"><%= rs.getString("inicio") != null ? rs.getString("inicio") : "Bodega Central" %></p></div>
                                <div class="col-lg-4 col-md-6"><h5><strong>Lugar de Destino:</strong></h5><p class="fs-4"><%= rs.getString("destino")%></p></div>
                                <div class="col-lg-4 col-md-6"><h5><strong>Repartidor:</strong></h5><p class="fs-4"><%= rs.getString("nombre_courier") != null ? rs.getString("nombre_courier") : "Sin asignar aún"%></p></div>
                            </div>
                            <div class="row g-4 mb-4">
                                <div class="col-lg-6 col-md-6"><h5><strong>Fecha de creación:</strong></h5><p class="fs-4"><%= rs.getTimestamp("fecha_creacion") != null ? sdf.format(rs.getTimestamp("fecha_creacion")) : "N/A" %></p></div>
                                <div class="col-lg-6 col-md-6"><h5><strong>Fecha de entrega:</strong></h5>
                                            <% if (rs.getDate("fecha_entregado") != null) {%>
                                    <p class="fs-4"><%= sdf.format(rs.getDate("fecha_entregado"))%></p>
                                    <%} else {%><p class="fs-4">Sin entregar</p><%}%></div>
                            </div>

                            <div class="mt-5">
                                <h3 class="text-center mb-4 bold">Estado del envío</h3>
                                <div class="progress" style="height: 50px;">
                                    <div class="progress-bar bg-<%= color%> progress-bar-striped progress-bar-animated d-flex align-items-center justify-content-center"
                                         style="width: <%= porcentaje %>%;">
                                        <h4 class="mb-0"><%= estado.toUpperCase()%></h4>
                                    </div>
                                </div>
                            </div>
                            <%
                            } else {
                            %>
                            <div class="text-center py-5">
                                <h1 class="display-3 fw-bold">Envío no encontrado</h1>
                                <p class="lead fs-3">El envío con el número de guía <span class="text fw-bold"><%= guia%></span> no existe en nuestro sistema.</p>
                                <p>Puede que aún no haya sido registrado o el número de guía sea incorrecto.</p>
                            </div>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.print("<div class='alert alert-danger text-center fs-4'>Error del sistema: " + e.getMessage() + "</div>");
                                }
                            }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <jsp:include page="/Utilidad/footer.jsp" />
</html>