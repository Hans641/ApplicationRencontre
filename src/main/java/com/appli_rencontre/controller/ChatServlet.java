package com.appli_rencontre.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import com.appli_rencontre.model.Utilisateur;
import com.appli_rencontre.model.Message;
import com.appli_rencontre.dao.MessageDAO;
import com.appli_rencontre.dao.UtilisateurDAO;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {
    private MessageDAO messageDAO = new MessageDAO();
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idDestinataireStr = request.getParameter("id");
        if (idDestinataireStr != null) {
            int idDestinataire = Integer.parseInt(idDestinataireStr);
            
            // 1. Récupérer les infos de l'interlocuteur
           Utilisateur interlocuteur = utilisateurDAO.recupererParId(idDestinataire);
            
            // 2. Récupérer l'historique des messages
            List<Message> discussion = messageDAO.recupererDiscussion(currentUser.getId(), idDestinataire);
            
            request.setAttribute("interlocuteur", interlocuteur);
            request.setAttribute("discussion", discussion);
            
            request.getRequestDispatcher("chat.jsp").forward(request, response);
        } else {
            response.sendRedirect("messages");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");
        
        String idDestinataireStr = request.getParameter("idDestinataire");
        String contenu = request.getParameter("contenu");

        if (currentUser != null && idDestinataireStr != null && contenu != null && !contenu.trim().isEmpty()) {
            int idDestinataire = Integer.parseInt(idDestinataireStr);
            messageDAO.envoyerMessage(currentUser.getId(), idDestinataire, contenu);
            
            // Redirection vers le même chat pour voir le nouveau message
            response.sendRedirect("chat?id=" + idDestinataire);
        }
    }
}