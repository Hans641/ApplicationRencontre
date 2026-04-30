package com.appli_rencontre.controller;

import com.appli_rencontre.dao.UtilisateurDAO;
import com.appli_rencontre.dao.KismetDAO;
import com.appli_rencontre.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/decouvrir")
public class DecouvrirServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
    private KismetDAO kismetDAO = new KismetDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");

        // Sécurité : redirection si session expirée
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Récupération des membres suggérés selon les filtres
        List<Utilisateur> membres = utilisateurDAO.recupererParFiltre(
            currentUser.getId(), 
            currentUser.getInteret()
        );
        
        // 2. Récupération des IDs des personnes déjà en Kismet (accepté)
        // Cette liste permettra à la JSP d'afficher "Vous êtes actuellement en Kismet"
        List<Integer> matchedIds = kismetDAO.recupererIdsMatches(currentUser.getId()); // C'est cette ligne qui envoie les données à la JSP
        
        // 3. Passage des données à la vue
        request.setAttribute("membres", membres);
        request.setAttribute("matchedIds", matchedIds);
        
        request.getRequestDispatcher("decouvrir.jsp").forward(request, response);
    }
}