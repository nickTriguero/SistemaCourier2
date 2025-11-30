<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.courier.config.ConexionDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mi perfil</title>
    </head>
    <body>
        <%
            String emailUsuario = (String) session.getAttribute("email");
            if (emailUsuario == null) {
                response.sendRedirect(request.getContextPath() + "/Utilidad/login.jsp");
                return;
            }

            java.util.Map<String, Object> usuario = new java.util.HashMap<>();
            String sql = "SELECT * FROM usuarios WHERE email = ?";

            try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, emailUsuario);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    java.sql.ResultSetMetaData meta = rs.getMetaData();
                    int columnCount = meta.getColumnCount();

                    for (int i = 1; i <= columnCount; i++) {
                        String columnName = meta.getColumnName(i);
                        Object value = rs.getObject(i);
                        usuario.put(columnName, value != null ? value : "No especificado");
                    }
                }
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Error al cargar perfil: " + e.getMessage() + "</div>");
            }
        %>

        <jsp:include page="/Utilidad/header.jsp" />

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h3 class="mb-0">Mi Perfil</h3>
                        </div>
                        <div class="card-body">
                            <div class="text-center mb-4">
                                <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center" 
                                     style="width: 120px; height: 120px; font-size: 3rem;">
                                    <%= ((String)usuario.get("nombre_completo")).substring(0, 1).toUpperCase()%>
                                </div>
                                <h4 class="mt-3"><%=usuario.get("nombre_completo")%></h4>
                                <span class="badge bg-success fs-6"><%=usuario.get("rol")%></span>
                            </div>

                            <hr>
                            <div class="row">
                                <div class="col-sm-4"><strong>Email:</strong></div>
                                <div class="col-sm-8"><%=usuario.get("email") != null ? usuario.get("email") : "Sin registrar"%></div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-sm-4"><strong>Rol:</strong></div>
                                <div class="col-sm-8 text-capitalize"><%=usuario.get("rol") != null ? usuario.get("rol") : "Sin registrar"%></div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-sm-4"><strong>Miembro desde:</strong></div>
                                <div class="col-sm-8"><%=usuario.get("fecha_creacion") != null ? usuario.get("fecha_creacion") : "Sin registrar"%></div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-sm-4"><strong>Prefijo de seguimiento:</strong></div>
                                <div class="col-sm-8"><%=usuario.get("guia") != null ? usuario.get("guia") : "Sin registrar"%></div>
                            </div>

                            <div class="mt-4 text-center">
                                <a href="<%= request.getContextPath()%>/mis_pedidos.jsp" class="btn btn-primary">Ver Mis Envíos →</a>
                                <a href="<%= request.getContextPath()%>/Utilidad/recuperar.jsp?from=perfil" class="btn btn-secondary">Cambiar Contraseña</a>
                                <a href="<%= request.getContextPath()%>/logout" class="btn btn-danger">Cerrar Sesión</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/Utilidad/footer.jsp" />
    </body>
</html>
