<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Nuevo Usuario</title>
    <style>
        body { font-family: sans-serif; display: flex; justify-content: center; padding-top: 50px; background-color: #f0f2f5; }
        form { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 300px; }
        input, select { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;}
        button { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }
        h2 { text-align: center; color: #333; }
        .btn-cancel { background-color: #6c757d; display: block; text-align: center; text-decoration: none; margin-top: 10px; padding: 10px; border-radius: 4px; color: white;}
    </style>
</head>
<body>
    <form action="UsuarioServlet" method="POST">
        <h2>Registrar Nuevo</h2>
        
        <input type="hidden" name="accion" value="registrar">
        
        <label>Nombre Completo:</label>
        <input type="text" name="nombre" required placeholder="Ej: Maria Lopez">
        
        <label>Email:</label>
        <input type="email" name="email" required placeholder="correo@ejemplo.com">
        
        <label>Contraseña:</label>
        <input type="password" name="password" required placeholder="******">
        
        <label>Rol:</label>
        <select name="rol">
            <option value="cliente">Cliente</option>
            <option value="courier">Courier</option>
            <option value="admin">Administrador</option>
        </select>
        
        <button type="submit">Crear Usuario</button>
        <a href="dashboard.jsp" class="btn-cancel">Cancelar</a>
    </form>
</body>
</html>