package com.devi.controller;

import com.devi.dao.UsuarioDAO;
import com.devi.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Soporte para caracteres especiales (por si usan eñes o tildes en sus claves)
        request.setCharacterEncoding("UTF-8");
        
        // 1. Capturar los datos que vienen del formulario web
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        // 2. Llamar al DAO para validar si el usuario existe y la clave es correcta
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuarioLogueado = usuarioDAO.login(correo, contrasena);

        // 3. Verificar el resultado de la autenticación
        if (usuarioLogueado != null) {
            // ¡Login Exitoso! Creamos una sesión en el servidor para mantenerlo conectado
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuarioLogueado);
            
            // Redireccionamos a la página principal o panel de control
            response.sendRedirect("dashboard.jsp");
        } else {
            // Login Fallido: Regresa al login con un parámetro de error para avisarle al usuario
            response.sendRedirect("index.jsp?error=Correo o contrasena incorrectos");
        }
    }
}