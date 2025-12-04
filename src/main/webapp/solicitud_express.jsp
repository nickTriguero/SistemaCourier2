<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cotizar y Enviar - GigiCourier</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .hero-header { background: linear-gradient(135deg, #D32F2F 0%, #b71c1c 100%); color: white; padding: 60px 0 30px; text-align: center; }
        .form-container { max-width: 900px; margin: -50px auto 50px; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .section-title { color: #D32F2F; border-bottom: 2px solid #eee; padding-bottom: 10px; margin-bottom: 20px; font-weight: bold; }
        .btn-gigi { background-color: #D32F2F; color: white; padding: 15px 30px; font-size: 1.2rem; font-weight: bold; border: none; border-radius: 50px; width: 100%; transition: all 0.3s; }
        .btn-gigi:hover { background-color: #b71c1c; transform: translateY(-2px); }
    </style>
</head>
<body>

    <div class="hero-header">
        <h1>📦 Realiza tu Envío Ahora</h1>
        <p class="lead">Completa tus datos y los del paquete. Nosotros nos encargamos del resto.</p>
    </div>

    <div class="container">
        <div class="form-container">
            <form action="EnvioServlet" method="POST">
                <input type="hidden" name="accion" value="pedido_express">

                <div class="row">
                    <div class="col-md-6 border-end">
                        <h4 class="section-title">1. Tus Datos Personales</h4>
                        <div class="mb-3">
                            <label>Nombre Completo</label>
                            <input type="text" name="nombre" class="form-control" required placeholder="Ej: Juan Perez">
                        </div>
                        <div class="mb-3">
                            <label>Correo Electrónico</label>
                            <input type="email" name="email" class="form-control" required placeholder="juan@ejemplo.com">
                            <small class="text-muted">Te enviaremos la guía a este correo.</small>
                        </div>
                        <div class="mb-3">
                            <label>Crea una Contraseña</label>
                            <input type="password" name="password" class="form-control" required placeholder="******">
                            <small class="text-muted">Para que puedas entrar a ver tu envío después.</small>
                        </div>
                    </div>

                    <div class="col-md-6 ps-md-4">
                        <h4 class="section-title">2. Datos del Envío</h4>
                        <div class="mb-3">
                            <label>¿Qué envías?</label>
                            <input type="text" name="descripcion" class="form-control" required placeholder="Ej: Documentos, Ropa, Caja...">
                        </div>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <label>Origen</label>
                                <select name="origen" class="form-select">
                                    <option>Guayaquil</option><option>Quito</option><option>Cuenca</option><option>Manabí</option>
                                </select>
                            </div>
                            <div class="col-6 mb-3">
                                <label>Destino</label>
                                <select name="destino" class="form-select">
                                    <option>Quito</option><option>Guayaquil</option><option>Cuenca</option><option>Ambato</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <label>Peso (Kg)</label>
                                <input type="number" step="0.1" name="peso" class="form-control" required value="1">
                            </div>
                            <div class="col-6 mb-3">
                                <label>Servicio</label>
                                <select name="servicio" class="form-select">
                                    <option value="Standard">Standard</option>
                                    <option value="Express">Express</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <hr class="my-4">
                
                <div class="text-center">
                    <button type="submit" class="btn-gigi">CONFIRMAR PEDIDO</button>
                    <p class="mt-3"><a href="index.jsp" class="text-secondary">Cancelar y volver al inicio</a></p>
                </div>
            </form>
        </div>
    </div>

</body>
</html>