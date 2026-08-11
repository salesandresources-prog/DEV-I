package com.devi.controller;

import com.devi.dao.ClienteDAO;
import com.devi.model.Cliente;
import com.devi.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ClienteServlet", urlPatterns = {"/ClienteServlet"})
public class ClienteServlet extends HttpServlet {

    // Este método maneja las peticiones de búsqueda (Fetch/AJAX)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("buscar".equals(accion)) {
            String doc = request.getParameter("documento");
            ClienteDAO clienteDAO = new ClienteDAO();
            Cliente cliente = clienteDAO.buscarPorDocumento(doc);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            if (cliente != null) {
                String json = String.format("{\"nombre\":\"%s\", \"correo\":\"%s\", \"telefono\":\"%s\", \"documento\":\"%s\"}", 
                              cliente.getNombre(), cliente.getCorreo(), cliente.getTelefono(), cliente.getDocumento());
                response.getWriter().write(json);
            } else {
                response.getWriter().write("{\"error\": \"No encontrado\"}");
            }
        }
    }

    // Este método maneja los formularios (Registrar, Eliminar, Actualizar)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        ClienteDAO clienteDAO = new ClienteDAO();
        
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");
        
        if (usuarioLogueado == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if ("registrar".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");
            String fechaCita = request.getParameter("fechaCita");
            String documento = request.getParameter("documento");
            
            Cliente nuevoCliente = new Cliente();
            nuevoCliente.setNombre(nombre);
            nuevoCliente.setCorreo(correo);
            nuevoCliente.setTelefono(telefono);
            nuevoCliente.setFechaCita(fechaCita);
            nuevoCliente.setDocumento(documento);
            nuevoCliente.setIdAgente(usuarioLogueado.getId());
            
            clienteDAO.registrarCliente(nuevoCliente);
            response.sendRedirect("dashboard.jsp?msg=Cliente registrado correctamente");
            
        } else if ("eliminar".equals(accion)) {
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            clienteDAO.eliminarCliente(idCliente);
            response.sendRedirect("dashboard.jsp?msg=Cliente eliminado");
            
        } else if ("actualizar".equals(accion)) {
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");
            String fechaCita = request.getParameter("fechaCita");
            String documento = request.getParameter("documento"); // Corregido: capturamos el documento
            
            Cliente clienteModificado = new Cliente();
            clienteModificado.setIdCliente(idCliente);
            clienteModificado.setNombre(nombre);
            clienteModificado.setCorreo(correo);
            clienteModificado.setTelefono(telefono);
            clienteModificado.setFechaCita(fechaCita);
            clienteModificado.setDocumento(documento); // Corregido: seteamos el documento
            
            clienteDAO.actualizarCliente(clienteModificado);
            response.sendRedirect("dashboard.jsp?msg=Datos actualizados con exito");
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    }
}