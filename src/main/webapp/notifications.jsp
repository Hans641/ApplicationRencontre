<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.appli_rencontre.model.Kismet, com.appli_rencontre.model.Utilisateur" %>
<%
    Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");
    if (currentUser == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Kismet - Notifications</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #121212; color: #e0e0e0; margin: 0; }
        nav { width: 100%; background: #1e1e1e; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; box-sizing: border-box; border-bottom: 2px solid #ff4b2b; position: sticky; top: 0; z-index: 1000; }
        .nav-logo { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: #ff4b2b; text-decoration: none; font-weight: bold; }
        
        .container { max-width: 800px; margin: 50px auto; padding: 0 20px; }
        h2 { font-family: 'Playfair Display', serif; font-size: 2rem; border-bottom: 1px solid #333; padding-bottom: 15px; }
        h2 span { color: #ff4b2b; }

        .notif-card { 
            background: #1e1e1e; border-radius: 12px; padding: 20px; 
            margin-bottom: 15px; display: flex; align-items: center; 
            justify-content: space-between; border-left: 4px solid #ff4b2b;
            transition: 0.3s;
        }
        .notif-card:hover { transform: scale(1.01); background: #252525; }
        
        .notif-info { display: flex; align-items: center; }
        .notif-avatar { width: 50px; height: 50px; background: #ff4b2b; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; margin-right: 15px; }
        
        .actions { display: flex; gap: 10px; }
        .btn { padding: 8px 18px; border-radius: 20px; text-decoration: none; font-size: 0.85em; font-weight: 600; transition: 0.3s; cursor: pointer; border: none; }
        .btn-accept { background: #ff4b2b; color: white; }
        .btn-decline { background: transparent; color: #999; border: 1px solid #444; }
        .btn-accept:hover { background: #ff3916; }
        .btn-decline:hover { background: #333; color: #fff; }
        
        .empty-state { text-align: center; margin-top: 100px; opacity: 0.5; }
    </style>
</head>
<body>

    <nav>
        <a href="profil.jsp" class="nav-logo">Kismet</a>
        <div style="display: flex; gap: 20px;">
            <a href="decouvrir" style="color: #e0e0e0; text-decoration: none;">Découvrir</a>
            <a href="logout.jsp" style="color: #ff4b2b; text-decoration: none;">Déconnexion</a>
        </div>
    </nav>

    <div class="container">
        <h2>Vos <span>Destins</span> en attente</h2>

        <% 
            List<Kismet> notifs = (List<Kismet>) request.getAttribute("notifications");
            if (notifs != null && !notifs.isEmpty()) {
                for (Kismet k : notifs) {
        %>
            <div class="notif-card">
                <div class="notif-info">
                    <div class="notif-avatar"><%= k.getPrenomExpediteur().substring(0, 1).toUpperCase() %></div>
                    <div>
                        <strong style="color: #fff;"><%= k.getPrenomExpediteur() %></strong> vous a envoyé un Kismet !
                        <div style="font-size: 0.75em; color: #666;">Il y a quelques instants</div>
                    </div>
                </div>
                <div class="actions">
                    <a href="repondreKismet?id=<%= k.getId() %>&action=accepte" class="btn btn-accept">Confirmer</a>
                    <a href="repondreKismet?id=<%= k.getId() %>&action=decline" class="btn btn-decline">Décliner</a>
                </div>
            </div>
        <% 
                }
            } else { 
        %>
            <div class="empty-state">
                <p>🕊️ Aucune nouvelle notification pour le moment.</p>
            </div>
        <% } %>
    </div>

</body>
</html>