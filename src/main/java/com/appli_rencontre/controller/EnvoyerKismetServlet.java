package com.appli_rencontre.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.appli_rencontre.model.Utilisateur;
import com.appli_rencontre.dao.KismetDAO;

@WebServlet("/envoyerKismet")
public class EnvoyerKismetServlet extends HttpServlet {
    private KismetDAO kismetDAO = new KismetDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");
        
        String idDestinataireStr = request.getParameter("id");

        if (currentUser != null && idDestinataireStr != null) {
            int idDestinataire = Integer.parseInt(idDestinataireStr);
            
            // On empêche de s'envoyer un Kismet à soi-même
            if (currentUser.getId() != idDestinataire) {
                kismetDAO.envoyerKismet(currentUser.getId(), idDestinataire);
            }
        }
        
        // Redirection vers la page découvrir avec un petit message de succès (optionnel)
        response.sendRedirect("decouvrir?success=1");
    }
}