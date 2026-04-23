package com.appli_rencontre.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.appli_rencontre.model.Utilisateur;
import com.appli_rencontre.dao.UtilisateurDAO;

@WebServlet("/detailProfil") // L'URL qui manquait !
public class DetailProfilServlet extends HttpServlet {
    
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // On récupère l'ID passé dans l'URL (?id=1)
        String idParam = request.getParameter("id");
        
        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            // On utilise ta nouvelle méthode du DAO qui récupère TOUT (bio, age, etc.)
            Utilisateur membre = utilisateurDAO.recupererParId(id);
            
            if (membre != null) {
                // On transmet l'objet à la JSP
                request.setAttribute("profilAffiche", membre); 
                request.getRequestDispatcher("detail_profil.jsp").forward(request, response);
            } else {
                response.sendRedirect("decouvrir");
            }
        } else {
            response.sendRedirect("decouvrir");
        }
    }
}