package com.appli_rencontre.controller;

import com.appli_rencontre.dao.UtilisateurDAO;
import com.appli_rencontre.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/inscription")
public class InscriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    // 1. Récupération des paramètres du formulaire
    String nom = request.getParameter("nom");
    String prenom = request.getParameter("prenom");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");
    String genre = request.getParameter("genre");
    String interet = request.getParameter("interet");
    String ville = request.getParameter("ville");

    // 2. Vérification : Les mots de passe correspondent-ils ?
    if (password == null || !password.equals(confirmPassword)) {
        response.sendRedirect("inscription.jsp?status=password_mismatch");
        return; 
    }

    // 3. Vérification : L'email existe-t-il déjà dans Kismet ?
    if (utilisateurDAO.emailExiste(email)) {
        response.sendRedirect("inscription.jsp?status=email_exists");
        return;
    }

    // 4. Création de l'objet utilisateur
    Utilisateur nouvelUtilisateur = new Utilisateur();
    nouvelUtilisateur.setNom(nom);
    nouvelUtilisateur.setPrenom(prenom);
    nouvelUtilisateur.setEmail(email);
    nouvelUtilisateur.setMotDePasse(password); // En situation réelle, on hacherait ce MDP
    nouvelUtilisateur.setGenre(genre);
    nouvelUtilisateur.setInteret(interet);
    nouvelUtilisateur.setVille(ville);

    // 5. Tentative d'inscription via le DAO
    boolean succes = utilisateurDAO.inscrireUtilisateur(nouvelUtilisateur);

    // 6. Redirection finale selon le résultat
    if (succes) {
        response.sendRedirect("inscription.jsp?status=success");
    } else {
        response.sendRedirect("inscription.jsp?status=error");
    }
}
}