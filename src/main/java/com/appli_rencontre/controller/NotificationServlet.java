package com.appli_rencontre.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import com.appli_rencontre.model.Utilisateur;
import com.appli_rencontre.model.Kismet;
import com.appli_rencontre.dao.KismetDAO;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {
    private KismetDAO kismetDAO = new KismetDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Récupération des Kismets reçus
        List<Kismet> notifs = kismetDAO.recupererNotifications(currentUser.getId());
        request.setAttribute("notifications", notifs);
        
        request.getRequestDispatcher("notifications.jsp").forward(request, response);
    }
}