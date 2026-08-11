package com.devi.controller;

import com.devi.dao.UsuarioDAO;
import com.devi.model.Usuario;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(urlPatterns = {"/DashboardServlet"})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Llamamos al DAO para traer los datos
        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> lista = dao.listarUsuarios();
        
        // 2. Enviamos la lista al dashboard.jsp
        request.setAttribute("listaUsuarios", lista);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}