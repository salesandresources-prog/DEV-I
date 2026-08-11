package WebhookServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "WebhookServlet", urlPatterns = {"/WebhookServlet"})
public class WebhookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String challenge = request.getParameter("hub.challenge");
        String verifyToken = request.getParameter("hub.verify_token");
        
        if ("my secret code".equals(verifyToken)) {
            response.getWriter().write(challenge);
        } else {
            response.getWriter().write("Token inválido");
        }
    }
}