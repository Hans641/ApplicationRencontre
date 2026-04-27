package com.appli_rencontre.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.appli_rencontre.model.Utilisateur;
import com.appli_rencontre.dao.KismetDAO;

@WebServlet("/messages")
public class MessagesServlet extends HttpServlet {
    private KismetDAO kismetDAO = new KismetDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Utilisateur user = (Utilisateur) request.getSession().getAttribute("utilisateurConnecte");
        if (user == null) { response.sendRedirect("login.jsp"); return; }

        List<Utilisateur> mesMatches = kismetDAO.recupererMatches(user.getId());
        request.setAttribute("matches", mesMatches);
        
        request.getRequestDispatcher("messages.jsp").forward(request, response);
    }
}