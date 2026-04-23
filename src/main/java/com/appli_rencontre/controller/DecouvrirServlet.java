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
import java.util.List;

@WebServlet("/decouvrir")
public class DecouvrirServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

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

        // Appel de la méthode de filtrage du DAO
        // On récupère les gens qui correspondent à l'intérêt de currentUser
        List<Utilisateur> membres = utilisateurDAO.recupererParFiltre(
            currentUser.getId(), 
            currentUser.getInteret()
        );
        
        request.setAttribute("membres", membres);
        request.getRequestDispatcher("decouvrir.jsp").forward(request, response);
    }
}