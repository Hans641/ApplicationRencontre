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

@WebServlet("/inscription")
public class InscriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    // 1. Récupération des données du formulaire
    String nom = request.getParameter("nom");
    String prenom = request.getParameter("prenom");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");
    String genre = request.getParameter("genre");
    String interet = request.getParameter("interet");
    String ville = request.getParameter("ville");

    // 2. Sécurité : Vérification de la correspondance des mots de passe
    if (password == null || !password.equals(confirmPassword)) {
        response.sendRedirect("inscription.jsp?status=password_mismatch");
        return; 
    }

    // 3. Sécurité : Vérification si l'email existe déjà
    if (utilisateurDAO.emailExiste(email)) {
        response.sendRedirect("inscription.jsp?status=email_exists");
        return;
    }

    // 4. Préparation de l'objet Utilisateur
    Utilisateur nouvelUtilisateur = new Utilisateur();
    nouvelUtilisateur.setNom(nom);
    nouvelUtilisateur.setPrenom(prenom);
    nouvelUtilisateur.setEmail(email);
    nouvelUtilisateur.setMotDePasse(password);
    nouvelUtilisateur.setGenre(genre);
    nouvelUtilisateur.setInteret(interet);
    nouvelUtilisateur.setVille(ville);

    // 5. Action : Inscription en base de données
    boolean succes = utilisateurDAO.inscrireUtilisateur(nouvelUtilisateur);

    // 6. Gestion du résultat
    if (succes) {
        // --- CONNEXION AUTOMATIQUE ---
        // On récupère l'utilisateur complet depuis la DB (pour avoir son ID auto-généré)
        Utilisateur userConnecte = utilisateurDAO.verifierLogin(email, password);
        
        if (userConnecte != null) {
            // On crée la session immédiatement
            HttpSession session = request.getSession();
            session.setAttribute("utilisateurConnecte", userConnecte);
            
            // Redirection directe vers le profil sans repasser par le login
            response.sendRedirect("profil.jsp");
        } else {
            // Cas rare : inscrit mais non trouvé juste après (erreur DB)
            response.sendRedirect("login.jsp?status=success");
        }
    } else {
        // En cas d'erreur technique lors de l'insertion
        response.sendRedirect("inscription.jsp?status=error");
    }
}
}