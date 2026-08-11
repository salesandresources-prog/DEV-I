<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DEV-I - Iniciar Sesión</title>
        <link rel="stylesheet" href="estilos.css?v=2">
    </head>

    <body class="auth-page">
        <div class="main-container">
            <div class="auth-wrapper">
                <section class="auth-card" id="login-section">
                    <h2>DEV-I</h2>

                    <% if (request.getParameter("msg") !=null) { %>
                        <div
                            style="background: rgba(0, 255, 204, 0.1); border: 1px solid #00ffcc; padding: 10px; margin-bottom: 15px; border-radius: 4px;">
                            <p style="color: #00ffcc; font-size: 0.85rem; margin: 0; text-align: center;">
                                <%= request.getParameter("msg") %>
                            </p>
                        </div>
                        <% } %>
                            <% if (request.getParameter("error") !=null) { %>
                                <div
                                    style="background: rgba(255, 77, 77, 0.1); border: 1px solid #ff4d4d; padding: 10px; margin-bottom: 15px; border-radius: 4px;">
                                    <p style="color: #ff4d4d; font-size: 0.85rem; margin: 0; text-align: center;">
                                        <%= request.getParameter("error") %>
                                    </p>
                                </div>
                                <% } %>

                                    <form action="LoginServlet" method="POST">
                                        <div class="input-group">
                                            <input type="email" name="correo" placeholder="Correo electrónico..."
                                                required>
                                            <input type="password" name="contrasena" placeholder="Contraseña..."
                                                required>
                                            <a href="recuperar.jsp" class="forgot-pw">¿Olvidaste tu contraseña?</a>
                                        </div>
                                        <button type="submit" class="btn-gold">INICIAR SESIÓN</button>
                                    </form>

                                    <p style="color: white; font-size: 0.8rem; margin-top: 15px; text-align: center;">
                                        ¿No tienes cuenta? <a href="registro.jsp" class="forgot-pw"
                                            style="display: inline; margin: 0;">Regístrate aquí</a>
                                    </p>
                </section>
            </div>
        </div>
    </body>

    </html>