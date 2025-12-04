<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.courier.modelo.usuarios"%>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Usuario</title>
    <style>
        body { font-family: sans-serif; display: flex; justify-content: center; padding-top: 50px; background-color: #f0f2f5; }
        form { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 300px; }
        input, select { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;}
        button { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; }
        h2 { text-align: center; color: #333; }
    </style>
</head>
<body>
    <% 
        // Recuperamos el usuario que nos mandó el Servlet
        usuarios u = (usuarios) request.getAttribute("usuario_a_editar");
    %>
    
    <form action="UsuarioServlet" method="POST">
        <h2>Editar Usuario</h2>
        
        <input type="hidden" name="accion" value="actualizar">
        <input type="hidden" name="id" value="<%= u.getId() %>">
        
        <label>Nombre Completo:</label>
        <input type="text" name="nombre" value="<%= u.getNombre_completo() %>" required>
        
        <label>Email:</label>
        <input type="email" name="email" value="<%= u.getEmail() %>" required>
        
        <label>Contraseña:</label>
        <input type="text" name="password" value="<%= u.getPassword() %>" required>
        
        <label>Rol:</label>
        <select name="rol">
            <option value="admin" <%= u.getRol().equals("admin") ? "selected" : "" %>>Admin</option>
            <option value="cliente" <%= u.getRol().equals("cliente") ? "selected" : "" %>>Cliente</option>
            <option value="courier" <%= u.getRol().equals("courier") ? "selected" : "" %>>Courier</option>
        </select>
        
        <button type="submit">Guardar Cambios</button>
        <br><br>
        <a href="dashboard.jsp" style="display:block; text-align:center;">Cancelar</a>
    </form>
</body>
</html>
