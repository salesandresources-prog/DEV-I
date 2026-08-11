<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Recuperar Acceso - DEV-I</title>
    <link rel="stylesheet" href="estilos.css?v=2">
    <style>
        /* Estilo para el h3 que se vea genial */
        .auth-card h3 {
            color: #d4af37; 
            text-align: center;
            font-family: sans-serif;
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        /* Contenedor de alertas para que no rompa el diseño */
        .contenedor-alertas { position: fixed; top: 20px; right: 20px; z-index: 9999; display: flex; flex-direction: column; gap: 10px; }
        .alerta-devi { width: 350px; padding: 15px; background: rgba(20, 20, 20, 0.95); backdrop-filter: blur(5px); color: #fff; border: 1px solid #ff4d4d; border-radius: 8px; cursor: pointer; font-family: sans-serif; box-shadow: 0 4px 10px rgba(0,0,0,0.5); }
        .titulo-alerta { font-weight: bold; color: #ff4d4d; margin-bottom: 5px; font-size: 14px; text-transform: uppercase; }
    </style>
</head>
<body>

    <div id="contenedorAlertas" class="contenedor-alertas"></div>

    <div class="main-container">
        <section class="auth-card">
            <h3>Recuperar Acceso</h3>
            
            <form id="recuperarForm" action="RecuperarPasswordServlet" method="POST">
                <div class="input-group">
                    <input type="text" id="correo" name="correo" placeholder="Correo electrónico registrado..." required>
                    <input type="text" id="telefono" name="telefono" placeholder="Teléfono asociado (10 dígitos)..." required>
                </div>
                <button type="submit" class="btn-gold">ENVIAR ENLACE</button>
            </form>

            <p style="text-align: center; margin-top: 20px;">
                <a href="index.jsp" class="forgot-pw">Volver al inicio</a>
            </p>
        </section>
    </div>

    <script>
        // Función de alertas reutilizada
        function lanzarAlerta(titulo, mensaje) {
            const contenedor = document.getElementById('contenedorAlertas');
            const div = document.createElement('div');
            div.className = 'alerta-devi';
            div.innerHTML = '<div class="titulo-alerta">' + titulo + '</div><div style="font-size: 13px;">' + mensaje + '</div>';
            div.onclick = function() { div.remove(); };
            contenedor.appendChild(div);
            setTimeout(function() { div.remove(); }, 8000);
        }

        // Lógica de validación exacta para el formulario de recuperación
        document.getElementById("recuperarForm").addEventListener("submit", function(event) {
            const correo = document.getElementById("correo").value.trim();
            const tel = document.getElementById("telefono").value.trim();
            let hayError = false;

            // 1. Validar Correo
            const regexCorreo = /^[a-zA-Z0-9._%+-]+@(gmail|outlook|hotmail|yahoo|icloud)\.com$/;
            if (!regexCorreo.test(correo)) {
                lanzarAlerta("ERROR EN CORREO", "Correo no válido. Usa: Gmail, Outlook, Hotmail, Yahoo o iCloud.");
                hayError = true;
            }

            // 2. Validar Teléfono (Solo números, exactos 10)
            if (!/^\d{10}$/.test(tel)) {
                lanzarAlerta("ERROR EN TELÉFONO", "El teléfono debe ser numérico y tener exactamente 10 dígitos.");
                hayError = true;
            }

            // Si hay algún error, detenemos el envío
            if (hayError) {
                event.preventDefault();
                return false;
            }
            return true;
        });

        // Bloqueo de letras en tiempo real para el teléfono
        document.getElementById("telefono").oninput = function() {
            this.value = this.value.replace(/[^0-9]/g, "");
        };
    </script>
</body>
</html>