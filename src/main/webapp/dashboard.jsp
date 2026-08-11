<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.util.List" %>
        <%@page import="com.devi.model.Cliente" %>
            <%@page import="com.devi.dao.ClienteDAO" %>
                <%@page import="com.devi.model.Usuario" %>
                    <% Usuario usuarioLogueado=(Usuario) session.getAttribute("usuario"); if (usuarioLogueado==null) {
                        response.sendRedirect("index.jsp"); return; } ClienteDAO clienteDAO=new ClienteDAO();
                        List<Cliente> clientes = clienteDAO.listarClientesPorAgente(usuarioLogueado.getId());
                        %>
                        <!DOCTYPE html>
                        <html lang="es">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Dashboard - CallCenter DEV-I</title>
                            <link rel="stylesheet" href="estilos.css?v=2">
                            <style>
                                body {
                                    padding: 10px !important;
                                }

                                .dashboard-wrapper {
                                    width: 100%;
                                    max-width: 1200px;
                                    margin: 0 auto;
                                }

                                .dashboard-grid {
                                    display: grid;
                                    grid-template-columns: 350px 1fr;
                                    gap: 15px;
                                }

                                @media (max-width: 900px) {
                                    .dashboard-grid {
                                        grid-template-columns: 1fr;
                                    }
                                }

                                .panel {
                                    background: rgba(15, 15, 15, 0.7);
                                    backdrop-filter: blur(15px);
                                    border: 1px solid rgba(212, 175, 55, 0.3);
                                    border-radius: 12px;
                                    padding: 15px;
                                }

                                .panel-title {
                                    color: #d4af37;
                                    margin-bottom: 15px;
                                    text-transform: uppercase;
                                    border-bottom: 1px solid rgba(212, 175, 55, 0.2);
                                    padding-bottom: 10px;
                                    font-size: 14px;
                                }

                                /* TABLA COMPACTA */
                                .tabla-datos {
                                    width: 100%;
                                    color: white;
                                    border-collapse: collapse;
                                    table-layout: fixed;
                                    font-size: 10px;
                                }

                                .tabla-datos th,
                                .tabla-datos td {
                                    padding: 6px 3px;
                                    border-bottom: 1px solid #333;
                                    text-align: left;
                                    overflow: hidden;
                                    text-overflow: ellipsis;
                                    white-space: nowrap;
                                }

                                /* BOTONES */
                                .btn-gold {
                                    background: #d4af37;
                                    border: none;
                                    padding: 8px;
                                    width: 100%;
                                    cursor: pointer;
                                    color: black;
                                    font-weight: bold;
                                    border-radius: 4px;
                                    margin-top: 5px;
                                    font-size: 12px;
                                }

                                .btn-secondary {
                                    background: transparent;
                                    border: 1px solid #555;
                                    color: white;
                                    padding: 8px;
                                    width: 100%;
                                    cursor: pointer;
                                    border-radius: 4px;
                                    margin-top: 5px;
                                    font-size: 12px;
                                }

                                .btn-edit {
                                    background: #2ecc71;
                                    color: white;
                                    border: none;
                                    padding: 4px 6px;
                                    border-radius: 4px;
                                    cursor: pointer;
                                    font-size: 10px;
                                }

                                .btn-danger {
                                    background: #ff4d4d;
                                    color: white;
                                    border: none;
                                    padding: 4px 6px;
                                    border-radius: 4px;
                                    cursor: pointer;
                                    font-size: 10px;
                                    display: inline-flex;
                                    align-items: center;
                                    justify-content: center;
                                }

                                input[type="datetime-local"]::-webkit-calendar-picker-indicator {
                                    filter: invert(1);
                                    cursor: pointer;
                                }

                                .modal-overlay {
                                    display: none;
                                    position: fixed;
                                    top: 0;
                                    left: 0;
                                    width: 100%;
                                    height: 100%;
                                    background: rgba(0, 0, 0, 0.8);
                                    backdrop-filter: blur(5px);
                                    z-index: 9999;
                                    justify-content: center;
                                    align-items: center;
                                }

                                .confirm-box {
                                    background: rgba(20, 20, 20, 0.95);
                                    border: 1px solid #ff4d4d;
                                    padding: 20px;
                                    border-radius: 12px;
                                    text-align: center;
                                    width: 90%;
                                    max-width: 250px;
                                }

                                #notification {
                                    position: fixed;
                                    top: 20px;
                                    right: 20px;
                                    padding: 10px 20px;
                                    border-radius: 8px;
                                    color: white;
                                    font-family: monospace;
                                    z-index: 1000;
                                    opacity: 0;
                                    background: rgba(0, 0, 0, 0.8);
                                    border: 1px solid rgba(255, 255, 255, 0.2);
                                }

                                #notification.show {
                                    opacity: 1;
                                }
                            </style>
                        </head>

                        <body>
                            <div id="notification"></div>
                            <div id="confirm-modal" class="modal-overlay">
                                <div class="confirm-box">
                                    <svg viewBox="0 0 24 24" width="40" height="40" fill="#ff4d4d"
                                        style="margin-bottom: 10px;">
                                        <path
                                            d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z" />
                                    </svg>
                                    <p style="color: white; font-size: 14px;">¿ELIMINAR CITA?</p>
                                    <div style="display: flex; gap: 10px; justify-content: center;">
                                        <button class="btn-secondary" style="font-size: 10px;"
                                            onclick="cerrarConfirmacion()">NO</button>
                                        <button class="btn-danger" id="confirm-delete-btn"
                                            style="padding: 5px 15px;">SÍ</button>
                                    </div>
                                </div>
                            </div>

                            <div class="dashboard-wrapper">
                                <div
                                    style="background: rgba(255,255,255,0.05); padding: 5px; border-radius: 8px; margin-bottom: 10px; color: #666; font-size: 10px; text-align: center;">
                                    DEV-I SYSTEM v1.0 | AGENTE: <%= usuarioLogueado.getId() %> | CITAS: <%=
                                            clientes.size() %>
                                </div>

                                <div class="top-bar"
                                    style="display: flex; justify-content: space-between; align-items: center; background: rgba(15, 15, 15, 0.7); padding: 10px; border-radius: 12px; margin-bottom: 20px;">
                                    <h2 style="font-size: 16px; color: white;">AGENTE: <%=
                                            usuarioLogueado.getNombre().toUpperCase() %>
                                    </h2>
                                    <a href="index.jsp" style="color: #ff4d4d; font-size: 12px;">SALIR</a>
                                </div>

                                <div class="dashboard-grid">
                                    <div class="panel">
                                        <h3 class="panel-title">GESTIÓN CITA</h3>
                                        <form action="ClienteServlet" method="POST" id="formCita">
                                            <input type="hidden" name="accion" id="accionForm" value="registrar">
                                            <input type="hidden" name="idCliente" id="idCliente">
                                            <input type="text" id="documento" name="documento" placeholder="Documento"
                                                required
                                                style="width: 100%; padding: 6px; margin-bottom: 5px; background: #222; border: 1px solid #444; color: white;">
                                            <input type="text" id="nombre" name="nombre" placeholder="Nombre" required
                                                style="width: 100%; padding: 6px; margin-bottom: 5px; background: #222; border: 1px solid #444; color: white;">
                                            <input type="email" id="correo" name="correo" placeholder="Correo"
                                                style="width: 100%; padding: 6px; margin-bottom: 5px; background: #222; border: 1px solid #444; color: white;">
                                            <input type="text" id="telefono" name="telefono" placeholder="Teléfono"
                                                required
                                                style="width: 100%; padding: 6px; margin-bottom: 5px; background: #222; border: 1px solid #444; color: white;">
                                            <input type="datetime-local" id="fechaCita" name="fechaCita" required
                                                style="width: 100%; padding: 6px; margin-bottom: 10px; background: #222; border: 1px solid #444; color: white;">
                                            <button type="submit" class="btn-gold">GUARDAR</button>
                                            <button type="button" class="btn-secondary"
                                                onclick="limpiarFormulario()">NUEVA</button>
                                        </form>
                                    </div>

                                    <div class="panel">
                                        <h3 class="panel-title">CITAS ACTIVAS</h3>
                                        <table class="tabla-datos">
                                            <thead>
                                                <tr>
                                                    <th style="width: 30px;">ID</th>
                                                    <th>Doc</th>
                                                    <th>Cliente</th>
                                                    <th>Tel</th>
                                                    <th>Cita</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (Cliente c : clientes) { %>
                                                    <tr>
                                                        <td>#<%= c.getIdCliente() %>
                                                        </td>
                                                        <td>
                                                            <%= (c.getDocumento() !=null) ? c.getDocumento() : "" %>
                                                        </td>
                                                        <td>
                                                            <%= c.getNombre() %>
                                                        </td>
                                                        <td>
                                                            <%= c.getTelefono() %>
                                                        </td>
                                                        <td>
                                                            <%= c.getFechaCita() %>
                                                        </td>
                                                        <td class="acciones-td" style="display: flex; gap: 4px;">
                                                            <button type="button" class="btn-edit"
                                                                onclick="editar('<%= c.getIdCliente() %>', '<%= c.getDocumento() %>', '<%= c.getNombre() %>', '<%= c.getCorreo() %>', '<%= c.getTelefono() %>', '<%= c.getFechaCita() %>')">Edit</button>
                                                            <form id="form-delete-<%= c.getIdCliente() %>"
                                                                action="ClienteServlet" method="POST"
                                                                style="display:inline;">
                                                                <input type="hidden" name="accion" value="eliminar">
                                                                <input type="hidden" name="idCliente"
                                                                    value="<%= c.getIdCliente() %>">
                                                                <button type="button" class="btn-danger"
                                                                    onclick="abrirConfirmacion('<%= c.getIdCliente() %>')"
                                                                    title="Eliminar">
                                                                    <svg viewBox="0 0 24 24" width="12" height="12"
                                                                        fill="currentColor">
                                                                        <path
                                                                            d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z" />
                                                                    </svg>
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <script>
                                let idToDelete = null;
                                function abrirConfirmacion(id) { idToDelete = id; document.getElementById('confirm-modal').style.display = 'flex'; }
                                function cerrarConfirmacion() { document.getElementById('confirm-modal').style.display = 'none'; }
                                document.getElementById('confirm-delete-btn').addEventListener('click', function () { if (idToDelete) document.getElementById('form-delete-' + idToDelete).submit(); });
                                function showNotification(m, t) { let n = document.getElementById('notification'); n.innerText = m; n.classList.add('show'); setTimeout(() => n.classList.remove('show'), 2000); }
                                function limpiarFormulario() { document.getElementById('formCita').reset(); document.getElementById('accionForm').value = 'registrar'; document.getElementById('idCliente').value = ''; }
                                function editar(id, doc, nom, corr, tel, fec) {
                                    document.getElementById('accionForm').value = "actualizar";
                                    document.getElementById('idCliente').value = id;
                                    document.getElementById('documento').value = doc;
                                    document.getElementById('nombre').value = nom;
                                    document.getElementById('correo').value = corr;
                                    document.getElementById('telefono').value = tel;
                                    document.getElementById('fechaCita').value = fec;
                                }
                            </script>
                        </body>

                        </html>