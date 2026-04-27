package com.appli_rencontre.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.appli_rencontre.dao.KismetDAO;

@WebServlet("/repondreKismet")
public class RepondreKismetServlet extends HttpServlet {
    private KismetDAO kismetDAO = new KismetDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // On récupère les paramètres envoyés par la JSP notifications.jsp
        String idStr = request.getParameter("id");
        String action = request.getParameter("action"); // "accepte" ou "decline"

        if (idStr != null && action != null) {
            int kismetId = Integer.parseInt(idStr);
            
            // On met à jour le statut dans la table MySQL
            boolean success = kismetDAO.mettreAJourStatut(kismetId, action);
            
            if (success) {
                // Si accepté, on pourrait plus tard rediriger vers la messagerie
                // Pour l'instant, on revient aux notifications avec un succès
                response.sendRedirect("notifications?status=" + action);
            } else {
                response.sendRedirect("notifications?error=1");
            }
        } else {
            response.sendRedirect("notifications");
        }
    }
}