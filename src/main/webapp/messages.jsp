<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, com.appli_rencontre.model.Utilisateur" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Kismet - Mes Messages</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #121212; color: #fff; margin: 0; }
        nav { background: #1e1e1e; padding: 15px 50px; border-bottom: 2px solid #ff4b2b; display: flex; justify-content: space-between; align-items: center; }
        .container { max-width: 600px; margin: 50px auto; padding: 0 20px; }
        
        .match-item { 
            background: #1e1e1e; padding: 15px; border-radius: 10px; 
            margin-bottom: 10px; display: flex; align-items: center; 
            text-decoration: none; color: white; border: 1px solid #333;
            transition: 0.3s;
        }
        .match-item:hover { border-color: #ff4b2b; background: #252525; transform: translateX(5px); }
        
        .avatar-small { 
            width: 45px; height: 45px; background: #ff4b2b; 
            border-radius: 50%; margin-right: 15px; 
            display: flex; align-items: center; justify-content: center; font-weight: bold;
        }
        
        .status-online { width: 10px; height: 10px; background: #2ecc71; border-radius: 50%; margin-left: auto; }
        
        /* Style pour l'aperçu du message */
        .last-message-preview {
            font-size: 0.85em;
            color: #888;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 350px; /* Évite que le message ne déforme la carte */
        }
        
        h2 span { color: #ff4b2b; }
    </style>
</head>
<body>

    <nav>
        <a href="decouvrir" style="color: #ff4b2b; text-decoration: none; font-weight: bold; font-size: 1.5rem;">Kismet</a>
        <a href="profil.jsp" style="color: #ccc; text-decoration: none; font-size: 0.9em;">Retour au profil</a>
    </nav>

    <div class="container">
        <h2>Vos <span>Conversations</span></h2>
        
        <% 
            List<Utilisateur> matches = (List<Utilisateur>) request.getAttribute("matches");
            Map<Integer, String> derniersMessages = (Map<Integer, String>) request.getAttribute("derniersMessages");
            
            if (matches != null && !matches.isEmpty()) {
                for (Utilisateur m : matches) {
                    // On récupère le dernier message depuis la Map, ou un texte par défaut
                    String apercu = (derniersMessages != null && derniersMessages.containsKey(m.getId())) 
                                    ? derniersMessages.get(m.getId()) 
                                    : "Cliquez pour envoyer un message...";
        %>
            <a href="chat?id=<%= m.getId() %>" class="match-item">
                <div class="avatar-small"><%= m.getPrenom().substring(0, 1).toUpperCase() %></div>
                <div style="flex-grow: 1;">
                    <strong style="display: block;"><%= m.getPrenom() %></strong>
                    <div class="last-message-preview">
                        <%= apercu %>
                    </div>
                </div>
                <div class="status-online"></div>
            </a>
        <% 
                }
            } else { 
        %>
            <div style="text-align: center; opacity: 0.5; margin-top: 80px;">
                <p style="font-size: 1.2em;">🕊️ Pas encore de destin partagé.</p>
                <p style="font-size: 0.9em;">Explorez de nouveaux profils pour commencer à discuter !</p>
                <a href="decouvrir" style="color: #ff4b2b; text-decoration: none; font-weight: bold; border-bottom: 1px solid;">Découvrir</a>
            </div>
        <% } %>
    </div>

</body>
</html>