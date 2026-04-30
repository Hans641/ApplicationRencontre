package com.appli_rencontre.controller;

import com.appli_rencontre.dao.UtilisateurDAO;
import com.appli_rencontre.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/toggleIncognito")
public class ToggleIncognitoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");

        if (currentUser != null) {
            // 1. Inverser l'état actuel
            boolean nouvelEtat = !currentUser.isModeIncognito();
            currentUser.setModeIncognito(nouvelEtat);

            // 2. Mettre à jour dans la base de données
            boolean updateOk = utilisateurDAO.mettreAJourModeIncognito(currentUser.getId(), nouvelEtat);

            if (updateOk) {
                // 3. Mettre à jour l'objet en session pour que la JSP le détecte
                session.setAttribute("utilisateurConnecte", currentUser);
            }
        }

        // Redirection vers le profil pour voir le changement
        response.sendRedirect("profil.jsp");
    }
}