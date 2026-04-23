package com.appli_rencontre.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.appli_rencontre.model.Utilisateur;
import com.appli_rencontre.dao.UtilisateurDAO; // Vérifie ton package DAO

@WebServlet("/modifierProfil") // <--- LE "/" EST OBLIGATOIRE ICI
public class ModifierProfilServlet extends HttpServlet {
    
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateurConnecte");

        if (user != null) {
            try {
                // Récupération et conversion des données
                int age = Integer.parseInt(request.getParameter("age"));
                user.setAge(age);
                user.setSigneAstro(request.getParameter("signe"));
                user.setSituation(request.getParameter("situation"));
                user.setReligion(request.getParameter("religion"));
                user.setBio(request.getParameter("bio"));
                user.setInterets(request.getParameter("interets"));
                user.setRedFlags(request.getParameter("redflags"));

                // Mise à jour via le DAO
                utilisateurDAO.mettreAJourDescription(user);
                
                // Redirection vers le profil avec un succès
                response.sendRedirect("profil.jsp?success=1");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("profil.jsp?error=1");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}