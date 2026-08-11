package com.devi.controller;

import com.devi.dao.UsuarioDAO;
import com.devi.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegistrarServlet", urlPatterns = {"/RegistrarServlet"})
public class RegistrarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // SOPORTE PARA Ñ Y TILDES: Fuerza al sistema a leer los textos del formulario en UTF-8
        request.setCharacterEncoding("UTF-8");
        
        // 1. Recibir los datos que el usuario escribió en el formulario HTML
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String contrasena = request.getParameter("contrasena");
        String rol = "agente"; // Rol por defecto

        // Empaqueta los datos en tu objeto Usuario
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombre(nombre);
        nuevoUsuario.setCorreo(correo);
        nuevoUsuario.setTelefono(telefono);
        nuevoUsuario.setContrasena(contrasena);
        nuevoUsuario.setRol(rol);

        // 3. Entregarle el modelo al DAO para que haga la inserción y encriptación en la BD
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean registrado = usuarioDAO.registrarUsuario(nuevoUsuario);

        // 4. Redireccionar al usuario dependiendo del resultado
        if (registrado) {
            // Si todo salió bien, va al login con un mensaje de éxito
            response.sendRedirect("index.jsp?msg=Usuario registrado correctamente");
        } else {
            // Si hubo falla (ej. correo ya registrado), regresa al registro con un error
            response.sendRedirect("registro.jsp?error=No se pudo completar el registro");
        }
    }
}