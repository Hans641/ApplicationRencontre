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
import com.appli_rencontre.dao.MessageDAO;

@WebServlet("/messages")
public class MessagesServlet extends HttpServlet {
    private KismetDAO kismetDAO = new KismetDAO();

protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    Utilisateur user = (Utilisateur) request.getSession().getAttribute("utilisateurConnecte");
    if (user == null) { response.sendRedirect("login.jsp"); return; }

    List<Utilisateur> mesMatches = kismetDAO.recupererMatches(user.getId());
    
    // Création d'une Map pour stocker [ID du contact -> Dernier message]
    java.util.Map<Integer, String> derniersMessages = new java.util.HashMap<>();
    MessageDAO messageDAO = new MessageDAO();

    for (Utilisateur m : mesMatches) {
        String msg = messageDAO.recupererDernierMessage(user.getId(), m.getId());
        derniersMessages.put(m.getId(), msg);
    }

    request.setAttribute("matches", mesMatches);
    request.setAttribute("derniersMessages", derniersMessages);
    
    request.getRequestDispatcher("messages.jsp").forward(request, response);
}
}