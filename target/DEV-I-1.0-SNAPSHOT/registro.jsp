<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - DEV-I</title>
    <link rel="stylesheet" href="estilos.css?v=2">
    <style>
        .contenedor-alertas { position: fixed; top: 20px; right: 20px; z-index: 9999; display: flex; flex-direction: column; gap: 10px; }
        .alerta-devi { width: 350px; padding: 15px; background: rgba(20, 20, 20, 0.95); backdrop-filter: blur(5px); color: #fff; border: 1px solid #ff4d4d; border-radius: 8px; cursor: pointer; font-family: sans-serif; box-shadow: 0 4px 10px rgba(0,0,0,0.5); }
        .titulo-alerta { font-weight: bold; color: #ff4d4d; margin-bottom: 5px; font-size: 14px; text-transform: uppercase; }
    </style>
</head>
<body>

    <div id="contenedorAlertas" class="contenedor-alertas"></div>

    <div class="main-container">
        <section class="auth-card">
        
            <form id="registroForm" action="RegistrarServlet" method="POST">
                <div class="input-group">
                    <input type="text" id="nombre" name="nombre" placeholder="Nombre completo..." required>
                    <input type="email" id="correo" name="correo" placeholder="Correo electrónico..." required>
                    <input type="text" id="telefono" name="telefono" placeholder="Teléfono..." required>
                    <input type="password" id="contrasena" name="contrasena" placeholder="Contraseña..." required>
                </div>
                <button type="submit" class="btn-gold">REGISTRAR CONTACTO</button>
            </form>
             <p style="color: white; font-size: 0.8rem; margin-top: 15px; text-align: center;">
                    ¿Ya tienes cuenta? <a href="index.jsp" class="forgot-pw" style="display: inline; margin: 0;">Inicia sesión</a>
                </p>
        </section>
    </div>

    <script>
        function lanzarAlerta(titulo, mensaje) {
            const contenedor = document.getElementById('contenedorAlertas');
            const div = document.createElement('div');
            div.className = 'alerta-devi'; 
            div.innerHTML = '<div class="titulo-alerta">' + titulo + '</div><div style="font-size: 13px;">' + mensaje + '</div>';
            div.onclick = function() { div.remove(); };
            contenedor.appendChild(div);
            setTimeout(function() { div.remove(); }, 10000); // 10s para que el usuario lea
        }

        document.getElementById("registroForm").addEventListener("submit", function(event) {
            const nombre = document.getElementById("nombre").value.trim();
            const correo = document.getElementById("correo").value.trim();
            const tel = document.getElementById("telefono").value.trim();
            
            let hayError = false;

            // 1. Validación Nombre: Mínimo 10 caracteres para asegurar Nombre + Apellido
            if (nombre.length < 10) {
                lanzarAlerta("ERROR EN NOMBRE", "El nombre es muy corto. Debe incluir nombre y apellido.");
                hayError = true;
            }

            // 2. Validación Correo: Debe tener @ y dominios permitidos
            const regexCorreo = /^[a-zA-Z0-9._%+-]+@(gmail|outlook|hotmail|yahoo|icloud)\.com$/;
            if (!regexCorreo.test(correo)) {
                lanzarAlerta("ERROR EN CORREO", "Formato de correo inválido. Use proveedores aceptados (Gmail, Outlook, etc).");
                hayError = true;
            }

            // 3. Validación Teléfono: Solo números, exactos 10
            if (!/^\d{10}$/.test(tel)) {
                lanzarAlerta("ERROR EN TELÉFONO", "El teléfono debe ser numérico y contener exactamente 10 dígitos.");
                hayError = true;
            }

            // Si se detectó CUALQUIERA de los errores, bloqueamos el envío
            if (hayError) {
                event.preventDefault(); 
                return false;
            }

            return true;
        });
    </script>
</body>
</html>