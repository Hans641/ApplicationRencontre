<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.appli_rencontre.model.Message, com.appli_rencontre.model.Utilisateur" %>
<%
    Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");
    Utilisateur interlocuteur = (Utilisateur) request.getAttribute("interlocuteur");
    List<Message> discussion = (List<Message>) request.getAttribute("discussion");

    if (currentUser == null || interlocuteur == null) {
        response.sendRedirect("messages");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Kismet - Chat avec <%= interlocuteur.getPrenom() %></title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #121212; color: #fff; margin: 0; display: flex; flex-direction: column; height: 100vh; }
        
        /* Header du Chat */
        .chat-header { background: #1e1e1e; padding: 15px 25px; border-bottom: 2px solid #ff4b2b; display: flex; align-items: center; }
        .back-btn { color: #ff4b2b; text-decoration: none; margin-right: 20px; font-weight: bold; }
        .interlocuteur-info { display: flex; flex-direction: column; }
        .interlocuteur-name { font-weight: 600; font-size: 1.1em; }
        .interlocuteur-city { font-size: 0.8em; color: #888; font-style: italic; }

        /* Zone de messages */
        .chat-window { flex: 1; overflow-y: auto; padding: 20px; display: flex; flex-direction: column; gap: 15px; background: #121212; }
        
        .message { max-width: 70%; padding: 12px 18px; border-radius: 15px; font-size: 0.95em; line-height: 1.4; position: relative; }
        
        /* Message reçu (Interlocuteur) - Gauche */
        .message.received { align-self: flex-start; background: #252525; color: #e0e0e0; border-bottom-left-radius: 2px; border: 1px solid #333; }
        
        /* Message envoyé (Moi) - Droite */
        .message.sent { align-self: flex-end; background: #ff4b2b; color: white; border-bottom-right-radius: 2px; }

        .message-time { font-size: 0.7em; opacity: 0.6; margin-top: 5px; display: block; text-align: right; }

        /* Zone de saisie */
        .input-area { background: #1e1e1e; padding: 20px; border-top: 1px solid #333; }
        .input-form { display: flex; gap: 10px; max-width: 800px; margin: 0 auto; }
        .chat-input { flex: 1; background: #252525; border: 1px solid #444; border-radius: 25px; padding: 12px 20px; color: white; font-family: inherit; }
        .chat-input:focus { outline: none; border-color: #ff4b2b; }
        
        .send-btn { background: #ff4b2b; border: none; color: white; padding: 10px 25px; border-radius: 25px; font-weight: 600; cursor: pointer; transition: 0.3s; }
        .send-btn:hover { background: #ff3916; transform: scale(1.05); }

        /* Scrollbar custom pour le look sombre */
        .chat-window::-webkit-scrollbar { width: 6px; }
        .chat-window::-webkit-scrollbar-thumb { background: #333; border-radius: 10px; }
    </style>
</head>
<body>

    <div class="chat-header">
        <a href="messages" class="back-btn">←</a>
        <div class="interlocuteur-info">
            <span class="interlocuteur-name"><%= interlocuteur.getPrenom() %></span>
            <span class="interlocuteur-city">📍 <%= interlocuteur.getVille() %></span>
        </div>
    </div>

    <div class="chat-window" id="chatWindow">
        <% 
            if (discussion != null && !discussion.isEmpty()) {
                for (Message m : discussion) {
                    boolean isMe = (m.getExpediteurId() == currentUser.getId());
        %>
            <div class="message <%= isMe ? "sent" : "received" %>">
                <%= m.getContenu() %>
                <span class="message-time"><%= m.getDateEnvoi() %></span>
            </div>
        <% 
                }
            } else { 
        %>
            <div style="text-align: center; color: #555; margin-top: 100px;">
                C'est le début de votre destin avec <%= interlocuteur.getPrenom() %>. <br>
                Dites bonjour !
            </div>
        <% } %>
    </div>

    <div class="input-area">
        <form action="chat" method="post" class="input-form">
            <input type="hidden" name="idDestinataire" value="<%= interlocuteur.getId() %>">
            <input type="text" name="contenu" class="chat-input" placeholder="Écrivez votre message..." required autocomplete="off">
            <button type="submit" class="send-btn">Envoyer</button>
        </form>
    </div>

    <script>
        // Script pour toujours afficher le bas de la discussion au chargement
        const chatWindow = document.getElementById('chatWindow');
        chatWindow.scrollTop = chatWindow.scrollHeight;
    </script>

</body>
</html>