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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Utilisation de la méthode verifierLogin créée précédemment dans le DAO
        Utilisateur user = utilisateurDAO.verifierLogin(email, password);

        if (user != null) {
            // Création de la session
            HttpSession session = request.getSession();
            session.setAttribute("utilisateurConnecte", user);
            
            // Redirection vers l'accueil ou le profil (à créer)
            response.sendRedirect("profil.jsp");
        } else {
            // Redirection vers login avec message d'erreur
            response.sendRedirect("login.jsp?error=1");
        }
    }
}