<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.courier.config.ConexionDB, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mis Envíos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%
            //Formateador de fechas
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

            Integer cliente_id = null;
            String emailUsuario = (String) session.getAttribute("email");
            if (emailUsuario == null) {
                response.sendRedirect("Utilidad/login.jsp");
                return;
            }

            // Obtener ID del cliente logueado
            try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement("SELECT id FROM usuarios WHERE email = ?")) {
                ps.setString(1, emailUsuario);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    cliente_id = rs.getInt("id");
                }
            }
        %>
        
         <jsp:include page="/Utilidad/header.jsp" />
        
        <div class="container mt-5">
            <h2 class="mb-4">Mis Envíos</h2>
            <div class="card shadow-lg">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Seguimiento</th>
                                    <th>Origen</th>
                                    <th>Destino</th>
                                    <th>Descripción</th>
                                    <th>Peso</th>
                                    <th>Precio</th>
                                    <th>Fecha Creación</th>
                                    <th>Fecha Entrega</th>
                                    <th>Servicio</th>
                                    <th>Estado</th>
                                    <th>Repartidor</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (cliente_id != null) {
                                        String sql = """
                                            SELECT e.*, u.nombre_completo AS nombre_courier 
                                            FROM envios e
                                            LEFT JOIN usuarios u ON e.curier_id = u.id
                                            WHERE e.cliente_id = ?
                                            ORDER BY e.fecha_creacion DESC
                                            """;

                                        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

                                            ps.setInt(1, cliente_id);
                                            ResultSet rs = ps.executeQuery();

                                            while (rs.next()) {
                                                String nombreCourier = rs.getString("nombre_courier");
                                                if (nombreCourier == null) {
                                                    nombreCourier = "Sin asignar";
                                                }

                                                //Formateo de fechas
                                                Date fechaCreacion = rs.getTimestamp("fecha_creacion");
                                                String fechaCreacionStr = fechaCreacion != null ? sdf.format(fechaCreacion) : "—";

                                                Date fechaEntrega = rs.getDate("fecha_entregado");
                                                String fechaEntregaStr = fechaEntrega != null ? sdf.format(fechaEntrega) : "—";
                                %>
                                <tr style="text-align: center;">
                                    <td><strong><%= rs.getInt("id_envio")%></strong></td>
                                    <td><%= rs.getString("n_guia") != null ? rs.getString("n_guia") : "—"%></td>
                                    <td><%= rs.getString("inicio")%></td>
                                    <td><%= rs.getString("destino")%></td>
                                    <td><%= rs.getString("descripcion")%></td>
                                    <td><%= String.format("%.2f", rs.getDouble("peso_kg"))%> kg</td>
                                    <td><%= rs.getString("costo")%></td>
                                    <td><%= fechaCreacionStr%></td>
                                    <td><%= fechaEntregaStr%></td>
                                    <td>
                                        <span class="badge bg-<%="Express".equals(rs.getString("servicio")) ? "success"
                                                : "Standard".equals(rs.getString("servicio")) ? "secondary" : "info"%>">
                                        <%= rs.getString("servicio")%></span> </td>
                                    <td>
                                        <span class="badge bg-<%="Entregado".equals(rs.getString("estado")) ? "success"
                                                : "En camino".equals(rs.getString("estado")) ? "warning"
                                                : "Pendiente".equals(rs.getString("estado")) ? "secondary" : "info"%>">
                                            <%= rs.getString("estado")%></span> </td>
                                    <td><%= nombreCourier%></td>
                                </tr>
                                <%
                                            }
                                        } catch (Exception e) {
                                            out.println("<tr><td colspan='12' class='text-danger text-center'>Error: " + e.getMessage() + "</td></tr>");
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
                            
        <jsp:include page="/Utilidad/footer.jsp" />
    </body>
</html>