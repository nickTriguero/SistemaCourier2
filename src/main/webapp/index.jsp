<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GigiCourier - Envíos Rápidos y Seguros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
    <style>
        :root {
            --gigi-red: #D32F2F; /* Rojo Intenso Gigicourier */
            --gigi-dark-red: #B71C1C;
        }

        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        /* --- 1. BARRA DE NAVEGACIÓN --- */
        .navbar { background-color: white; box-shadow: 0 2px 10px rgba(0,0,0,0.1); padding: 15px 0; }
        .navbar-brand { font-weight: 900; font-size: 1.8rem; color: var(--gigi-red) !important; letter-spacing: -1px; text-transform: uppercase; }
        .nav-link { color: #444; font-weight: 600; margin-left: 20px; transition: color 0.3s; }
        .nav-link:hover { color: var(--gigi-red); }
        
        .btn-ingresar { 
            background-color: var(--gigi-red); color: white; border-radius: 50px; 
            padding: 8px 25px; font-weight: bold; border: none; transition: all 0.3s; 
        }
        .btn-ingresar:hover { background-color: var(--gigi-dark-red); color: white; transform: translateY(-2px); box-shadow: 0 4px 10px rgba(211, 47, 47, 0.3); }

        /* --- 2. HERO SECTION (FONDO PRINCIPAL) --- */
        .hero {
            position: relative;
            /* Imagen de fondo de logística (Avión/Carga) */
            background-image: url('https://images.unsplash.com/photo-1578575437130-527eed3abbec?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80');
            background-size: cover;
            background-position: center;
            height: 85vh; /* Altura casi completa de la pantalla */
            display: flex;
            align-items: center;
            color: white;
        }
        
        /* Capa Roja Semitransparente (El "filtro" rojo) */
        .hero-overlay {
            position: absolute; top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(90deg, rgba(183, 28, 28, 0.9) 0%, rgba(211, 47, 47, 0.6) 100%);
        }
        
        .hero-content { position: relative; z-index: 2; width: 100%; }
        .hero h1 { font-size: 3.5rem; font-weight: 800; line-height: 1.1; margin-bottom: 20px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); }
        .hero p { font-size: 1.3rem; margin-bottom: 30px; opacity: 0.95; font-weight: 300; }

        /* --- 3. CAJA DE RASTREO (La cajita blanca flotante) --- */
        .tracking-box {
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
            max-width: 450px;
        }
        .tracking-title { color: #333; font-weight: 800; margin-bottom: 15px; display: flex; align-items: center; gap: 10px; font-size: 1.4rem; }
        .btn-rastrear { background-color: #222; color: white; width: 100%; font-weight: bold; padding: 12px; border: none; border-radius: 6px; margin-top: 10px; transition: background 0.3s; }
        .btn-rastrear:hover { background-color: black; }

        /* --- 4. TARJETAS DE SERVICIOS (Abajo) --- */
        .features-section { margin-top: -60px; position: relative; z-index: 3; padding-bottom: 80px; }
        .feature-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            border-bottom: 5px solid var(--gigi-red);
            transition: transform 0.3s;
            height: 100%;
            text-align: center;
        }
        .feature-card:hover { transform: translateY(-10px); }
        .feature-icon { font-size: 3.5rem; color: var(--gigi-red); margin-bottom: 15px; }
        .price { font-size: 2rem; font-weight: 800; color: #333; }
        .price small { font-size: 1rem; color: #666; font-weight: normal; }

        /* --- FOOTER --- */
        footer { background-color: #1a1a1a; color: white; padding: 50px 0 20px 0; }
        footer h5 { color: var(--gigi-red); font-weight: bold; margin-bottom: 20px; }
        footer a { color: #aaa; text-decoration: none; display: block; margin-bottom: 10px; }
        footer a:hover { color: white; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <span class="material-icons" style="vertical-align: middle; margin-right:5px; font-size: 1.2em;">local_shipping</span>
                GIGICOURIER
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav align-items-center">
                    <li class="nav-item"><a class="nav-link" href="#">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Servicios</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Tarifas</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Contacto</a></li>
                    <li class="nav-item ms-3">
                        <a href="Utilidad/login.jsp" class="btn btn-ingresar">INGRESAR</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="hero">
        <div class="hero-overlay"></div> <div class="container hero-content">
            <div class="row align-items-center">
                <div class="col-lg-7 text-white">
                    <h1>TU PAQUETE VUELA,<br>EL PRECIO NO.</h1>
                    <p>Envíos internacionales y nacionales con la seguridad y rapidez que necesitas. Con GigiCourier, llegamos más lejos.</p>
                    <a href="solicitud_express.jsp" class="btn btn-outline-light btn-lg fw-bold px-4 rounded-pill">COTIZAR ENVÍO</a>
                </div>

                <div class="col-lg-5">
                    <div class="tracking-box ms-auto">
                        <h4 class="tracking-title">
                            <span class="material-icons text-danger">search</span>
                            Rastrea tu envío
                        </h4>
                        <p class="text-muted small mb-3">Ingresa tu número de guía para ver el estado en tiempo real.</p>
                        
                        <form action="consultaEnvio.jsp" method="GET">
                            <div class="mb-3">
                                <input type="text" name="guia" class="form-control form-control-lg bg-light" placeholder="Ej: CI123456" required>
                            </div>
                            <button type="submit" class="btn btn-rastrear">BUSCAR AHORA</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="features-section">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <span class="material-icons feature-icon">flight_takeoff</span>
                        <h4>Importaciones USA</h4>
                        <p class="text-muted">Traemos tus compras desde Miami hasta la puerta de tu casa en Ecuador.</p>
                        <div class="price text-danger">$5.50 <small>/ libra</small></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <span class="material-icons feature-icon">local_shipping</span>
                        <h4>Envíos Nacionales</h4>
                        <p class="text-muted">Cobertura total en las 24 provincias. Entrega garantizada en 24h.</p>
                        <div class="price text-danger">$3.50 <small>/ base</small></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <span class="material-icons feature-icon">inventory_2</span>
                        <h4>Carga Pesada</h4>
                        <p class="text-muted">Soluciones logísticas para empresas. Manejo de contenedores y palets.</p>
                        <div class="price text-danger">Cotizar <small>ahora</small></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5 style="color:var(--gigi-red);">GIGICOURIER</h5>
                    <p class="text-muted small">Somos tu socio estratégico en logística. Conectando personas y negocios a través de envíos rápidos y seguros.</p>
                </div>
                <div class="col-md-2 mb-4">
                    <h5>Enlaces</h5>
                    <a href="#">Inicio</a>
                    <a href="#">Nosotros</a>
                    <a href="#">Servicios</a>
                </div>
                <div class="col-md-2 mb-4">
                    <h5>Ayuda</h5>
                    <a href="#">Rastreo</a>
                    <a href="#">Preguntas Frecuentes</a>
                    <a href="#">Contacto</a>
                </div>
                <div class="col-md-4 mb-4">
                    <h5>Contáctanos</h5>
                    <p class="small text-muted"><span class="material-icons" style="font-size:14px; vertical-align:middle;">call</span> (04) 123-4567</p>
                    <p class="small text-muted"><span class="material-icons" style="font-size:14px; vertical-align:middle;">email</span> info@gigicourier.com</p>
                    <p class="small text-muted"><span class="material-icons" style="font-size:14px; vertical-align:middle;">location_on</span> Av. Principal 123, Guayaquil</p>
                </div>
            </div>
            <hr style="border-color:#333;">
            <p class="small text-muted text-center m-0">&copy; 2025 GigiCourier S.A. Todos los derechos reservados.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>