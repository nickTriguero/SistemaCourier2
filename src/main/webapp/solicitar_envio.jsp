<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.courier.modelo.usuarios"%>
<%
    // Seguridad: Solo Clientes logueados
    usuarios u = (usuarios) session.getAttribute("usuario");
    if (u == null) { response.sendRedirect("Utilidad/login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Crear Nuevo Pedido - GigiCourier</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .header-bg { background: linear-gradient(90deg, #D32F2F 0%, #B71C1C 100%); color: white; padding: 40px 0; text-align: center; margin-bottom: 30px; }
        .form-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .btn-pay { background-color: #28a745; color: white; font-weight: bold; width: 100%; padding: 12px; border: none; }
        .btn-pay:hover { background-color: #218838; }
        .credit-card { background: linear-gradient(135deg, #333 0%, #000 100%); color: white; padding: 20px; border-radius: 10px; margin-top: 20px; }
    </style>
    
    <script>
        function simularPago(event) {
            event.preventDefault(); // Detiene el envío real por un momento
            
            // Simulación visual
            let btn = document.getElementById("btnPagar");
            btn.innerHTML = "Procesando pago...";
            btn.disabled = true;

            setTimeout(function() {
                alert("✅ ¡Pago Aprobado con Éxito!\nSe ha debitado el valor de su tarjeta.\nCreando pedido...");
                document.getElementById("formPedido").submit(); // Ahora sí envía al Servlet
            }, 1500); // Espera 1.5 segundos
        }
    </script>
</head>
<body>

    <div class="header-bg">
        <h1>Solicitud de Envío</h1>
        <p>Completa los datos y realizaremos la recolección.</p>
    </div>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="form-card">
                    <form id="formPedido" action="EnvioServlet" method="POST" onsubmit="simularPago(event)">
                        <input type="hidden" name="accion" value="crear_pedido">

                        <h4 class="mb-3 text-danger">1. Datos del Paquete</h4>
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label>Descripción del contenido:</label>
                                <input type="text" name="descripcion" class="form-control" required placeholder="Ej: Laptop HP en caja">
                            </div>
                            <div class="col-md-6">
                                <label>Ciudad de Origen:</label>
                                <select name="origen" class="form-select">
                                    <option>Guayaquil</option>
                                    <option>Quito</option>
                                    <option>Cuenca</option>
                                    <option>Manabí</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label>Ciudad de Destino:</label>
                                <select name="destino" class="form-select">
                                    <option>Quito</option>
                                    <option>Guayaquil</option>
                                    <option>Cuenca</option>
                                    <option>Ambato</option>
                                    <option>Machala</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label>Peso estimado (Kg):</label>
                                <input type="number" step="0.1" name="peso" class="form-control" required placeholder="Ej: 2.5">
                            </div>
                            <div class="col-md-6">
                                <label>Tipo de Servicio:</label>
                                <select name="servicio" class="form-select">
                                    <option value="Standard">Standard (24-48h) - $3.00 base</option>
                                    <option value="Express">Express (Hoy mismo) - $5.00 base</option>
                                </select>
                            </div>
                        </div>

                        <hr class="my-4">

                        <h4 class="mb-3 text-danger">2. Pago del Servicio (Simulado)</h4>
                        <div class="alert alert-info">
                            <small>ℹ️ El costo se calculará automáticamente según el peso y se debitará de esta tarjeta.</small>
                        </div>

                        <div class="credit-card mb-3">
                            <div class="d-flex justify-content-between">
                                <span>CREDIT CARD</span>
                                <span>VISA</span>
                            </div>
                            <div class="my-3 fs-4" style="letter-spacing: 2px;">
                                **** **** **** 4242
                            </div>
                            <div class="d-flex justify-content-between small">
                                <span>TITULAR: <%= u.getNombre_completo().toUpperCase() %></span>
                                <span>EXP: 12/28</span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <input type="text" class="form-control" placeholder="CVC (Ej: 123)" required maxlength="3">
                            </div>
                            <div class="col-6">
                                <input type="text" class="form-control" placeholder="Nombre en tarjeta" required>
                            </div>
                        </div>

                        <br>
                        <button type="submit" id="btnPagar" class="btn-pay">PAGAR Y CREAR PEDIDO</button>
                        <a href="index.jsp" class="btn btn-link w-100 mt-2 text-secondary">Cancelar</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>