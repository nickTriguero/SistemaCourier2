<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.courier.modelo.envios"%>
<%@page import="com.courier.modelo.usuarios"%>

<%
    // SEGURIDAD: Solo Couriers
    usuarios u = (usuarios) session.getAttribute("usuario");
    if (u == null || !u.getRol().equalsIgnoreCase("courier")) {
        response.sendRedirect("index.jsp");
        return;
    }
    List<envios> lista = (List<envios>) request.getAttribute("misPaquetes");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Panel de GIGICourier</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #eef2f3; margin: 0; }
        .navbar { background-color: #009688; padding: 15px; color: white; display: flex; justify-content: space-between; align-items: center;}
        .container { max-width: 1000px; margin: 30px auto; padding: 20px; }
        
        /* Tarjetas de Paquetes (Cards) en lugar de tabla aburrida */
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .card { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); border-left: 5px solid #ccc; }
        
        .card.pendiente { border-left-color: #ff9800; } /* Naranja */
        .card.camino { border-left-color: #2196f3; } /* Azul */
        .card.entregado { border-left-color: #4caf50; opacity: 0.7; } /* Verde */

        h3 { margin-top: 0; }
        p { margin: 5px 0; color: #555; }
        .tag { display: inline-block; padding: 3px 8px; border-radius: 4px; color: white; font-size: 0.8em; font-weight: bold;}
        
        .btn-entregar { width: 100%; padding: 10px; background-color: #009688; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1rem; margin-top: 10px; }
        .btn-entregar:hover { background-color: #00796b; }
        .btn-logout { color: white; text-decoration: none; border: 1px solid white; padding: 5px 10px; border-radius: 4px; }
    </style>
</head>
<body>

    <div class="navbar">
        <h2>🏍️ Zona GIGICOURIER <h2>
        <div>
            Hola, <%= u.getNombre_completo() %> 
            <a href="LoginServlet?accion=Logout" class="btn-logout">Salir</a>
        </div>
    </div>

    <div class="container">
        <div class="container">
        <h2>📦 Mis Paquetes Asignados</h2>
        
        <div class="grid">
            <% 
            // CORRECCIÓN: Verificamos si es null O si está vacía (!lista.isEmpty())
            if (lista != null && !lista.isEmpty()) {
                for (envios e : lista) {
                    // Definimos estilo según estado
                    String clase = "pendiente";
                    String color = "#ff9800";
                    if("En camino".equals(e.getEstado())) { clase = "camino"; color = "#2196f3"; }
                    if("Entregado".equals(e.getEstado())) { clase = "entregado"; color = "#4caf50"; }
            %>
            
            <div class="card <%= clase %>">
                <div style="display:flex; justify-content:space-between;">
                    <h3>Guía: <%= e.getN_guia() %></h3>
                    <span class="tag" style="background-color: <%= color %>;"><%= e.getEstado() %></span>
                </div>
                
                <p><strong>Destino:</strong> <%= e.getDestino() %></p>
                <p><strong>Detalle:</strong> <%= e.getDescripcion() %></p>
                
                <% if (!"Entregado".equals(e.getEstado())) { %>
                    <a href="EnvioServlet?accion=confirmar_entrega&id=<%= e.getId_envio() %>" onclick="return confirm('¿Confirmas que ya entregaste este paquete?')">
                        <button class="btn-entregar">✅ Confirmar Entrega</button>
                    </a>
                <% } else { %>
                    <p style="color: green; text-align: center; font-weight: bold;">✔ Entregado con éxito</p>
                <% } %>
            </div>
            
            <% 
                } 
            } else { 
            %>
                <div style="grid-column: 1 / -1; text-align: center; color: #666; margin-top: 50px;">
                    <h3>📭 No tienes paquetes asignados.</h3>
                    <p>Pide al Administrador que te asigne una ruta.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>