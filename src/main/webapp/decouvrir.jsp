<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.appli_rencontre.model.Utilisateur" %>
<%
    // Vérification de sécurité
    Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Récupération d'un éventuel message de succès après envoi de Kismet
    String success = request.getParameter("success");
    
    // Récupération des IDs déjà en Kismet envoyé par le Servlet
    List<Integer> matchedIds = (List<Integer>) request.getAttribute("matchedIds");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Kismet - Découvrir</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Poppins', sans-serif; background-color: #121212; color: #e0e0e0; margin: 0; }
    
    /* Barre de Navigation */
    nav { 
        width: 100%; background: #1e1e1e; padding: 15px 50px; 
        display: flex; justify-content: space-between; align-items: center; 
        box-sizing: border-box; border-bottom: 2px solid #ff4b2b; 
        position: sticky; top: 0; z-index: 1000; 
    }
    .nav-logo { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: #ff4b2b; text-decoration: none; font-weight: bold; }
    .nav-links a { color: #e0e0e0; text-decoration: none; margin-left: 25px; font-size: 0.9em; transition: 0.3s; }
    .nav-links a#nav-discover { color: #ff4b2b; border-bottom: 2px solid #ff4b2b; }
    
    .notif-link { position: relative; }
    .notif-dot { 
        position: absolute; top: -5px; right: -10px; 
        width: 8px; height: 8px; background: #ff4b2b; border-radius: 50%; 
    }

    .btn-logout { 
        background-color: #ff4b2b !important; color: white !important; 
        padding: 8px 20px !important; border-radius: 20px !important; 
        font-weight: 600; text-decoration: none; margin-left: 30px;
    }

    .alert-success {
        background: rgba(46, 204, 113, 0.2); color: #2ecc71;
        border: 1px solid #2ecc71; padding: 15px; border-radius: 10px;
        text-align: center; margin-bottom: 20px; font-size: 0.9em;
    }

    /* Style spécifique pour l'alerte Incognito */
    .alert-incognito {
        background: rgba(255, 75, 43, 0.1); color: #ff4b2b;
        border: 1px dashed #ff4b2b; padding: 15px; border-radius: 10px;
        text-align: center; margin-bottom: 25px; font-size: 0.85em;
    }

    .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
    h2 { font-family: 'Playfair Display', serif; text-align: center; margin-bottom: 40px; color: #fff; }
    h2 span { color: #ff4b2b; }
    .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px; }
    
    .card { 
        background: #1e1e1e; border-radius: 20px; padding: 30px; 
        text-align: center; border: 1px solid #2a2a2a; transition: 0.3s;
        display: flex; flex-direction: column; justify-content: space-between;
    }
    .card:hover { transform: translateY(-10px); border-color: #ff4b2b; }
    
    .avatar { 
        width: 100px; height: 100px; 
        background: linear-gradient(135deg, #ff4b2b, #ff3916); 
        color: white; border-radius: 50%; 
        display: flex; align-items: center; justify-content: center; 
        font-size: 2.8rem; margin: 0 auto 20px; 
    }
    .city { color: #ff4b2b; font-size: 0.9em; font-style: italic; display: block; margin-bottom: 10px; }
    .badge { 
        background: rgba(255, 75, 43, 0.1); padding: 4px 12px; border-radius: 20px; 
        font-size: 0.7em; color: #ff4b2b; text-transform: uppercase; border: 1px solid rgba(255, 75, 43, 0.3);
    }
    
    .kismet-active-status {
        background: rgba(46, 204, 113, 0.1); color: #2ecc71;
        border: 1px solid #2ecc71; padding: 10px; border-radius: 10px;
        font-size: 0.85em; font-weight: 600; margin: 15px 0;
    }

    .bio-preview { font-size: 0.85em; color: #bbb; margin: 15px 0; line-height: 1.4; min-height: 40px; }
    .see-more { color: #ff4b2b; text-decoration: none; font-weight: bold; font-size: 0.9em; }

    .btn-match { 
        margin-top: 15px; background: transparent; color: #ff4b2b; 
        border: 2px solid #ff4b2b; padding: 10px 25px; border-radius: 30px; 
        cursor: pointer; font-weight: 600; text-decoration: none; display: inline-block; transition: 0.3s; 
    }
    .btn-match:hover:not(.btn-disabled) { background: #ff4b2b; color: #fff; }

    .btn-chat { border-color: #2ecc71; color: #2ecc71; }
    .btn-chat:hover { background: #2ecc71; color: #fff; }

    /* Nouveau style pour bouton bloqué */
    .btn-disabled { border-color: #444; color: #666; cursor: not-allowed; }
</style>
</head>
<body>

    <nav>
        <a href="${pageContext.request.contextPath}/profil.jsp" class="nav-logo">Kismet</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/profil.jsp">Mon Profil</a>
            <a href="${pageContext.request.contextPath}/decouvrir" id="nav-discover">Découvrir</a>
            <a href="${pageContext.request.contextPath}/notifications" class="notif-link">
                Notifications
                <span class="notif-dot"></span>
            </a>
           <a href="${pageContext.request.contextPath}/messages">Messages</a>
            <a href="${pageContext.request.contextPath}/logout.jsp" class="btn-logout">Déconnexion</a>
        </div>
    </nav>

    <div class="container">
        <%-- Message si le mode Incognito est actif --%>
        <% if (currentUser.isModeIncognito()) { %>
            <div class="alert-incognito">
                🕵️ <strong>Mode Incognito actif</strong> : Vous pouvez explorer les profils, mais l'envoi de Kismet est suspendu.
            </div>
        <% } %>

        <% if("1".equals(success)) { %>
            <div class="alert-success">✨ Votre Kismet a été envoyé avec succès !</div>
        <% } %>

        <h2>Découvrir des <span>destins</span> à <%= currentUser.getVille() %></h2>
        
        <div class="grid">
            <% 
                List<Utilisateur> membres = (List<Utilisateur>) request.getAttribute("membres");
                if(membres != null && !membres.isEmpty()) {
                    for(Utilisateur m : membres) {
                        boolean isAlreadyMatched = (matchedIds != null && matchedIds.contains(m.getId()));
            %>
                <div class="card">
                    <div>
                        <div class="avatar"><%= m.getPrenom().substring(0, 1).toUpperCase() %></div>
                        <h3><%= m.getPrenom() %></h3>
                        <span class="city">📍 <%= m.getVille() %></span>
                        
                        <div style="margin-bottom: 15px;">
                            <span class="badge"><%= m.getGenre() %></span>
                        </div>

                        <% if (isAlreadyMatched) { %>
                            <div class="kismet-active-status">
                                ✨ Vous êtes actuellement en Kismet
                            </div>
                        <% } else { %>
                            <div class="bio-preview">
                                <% 
                                    String bio = m.getBio(); 
                                    if(bio != null && !bio.isEmpty()) {
                                        String preview = (bio.length() > 60) ? bio.substring(0, 60) + "..." : bio;
                                %>
                                    <%= preview %>
                                    <br>
                                    <a href="${pageContext.request.contextPath}/detailProfil?id=<%= m.getId() %>" class="see-more">voir plus...</a>
                                <% } else { %>
                                    <span style="font-style: italic; opacity: 0.5;">Pas encore de bio...</span>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                    
                    <div>
                        <p style="font-size: 0.8em; color: #666; line-height: 1.4;">
                            Recherche : <%= m.getInteret() %><br>
                            "L'amour n'est qu'un hasard qui nous attend."
                        </p>
                        
                        <%-- Logique du bouton avec restriction Incognito --%>
                        <% if (isAlreadyMatched) { %>
                            <a href="${pageContext.request.contextPath}/chat?id=<%= m.getId() %>" class="btn-match btn-chat">Discuter</a>
                        <% } else if (currentUser.isModeIncognito()) { %>
                            <span class="btn-match btn-disabled" title="Désactivez le mode incognito pour interagir">Lancer un Kismet</span>
                        <% } else { %>
                            <a href="${pageContext.request.contextPath}/envoyerKismet?id=<%= m.getId() %>" class="btn-match">Lancer un Kismet</a>
                        <% } %>
                    </div>
                </div>
            <% 
                    }
                } else { 
            %>
                <p style="grid-column: 1/-1; text-align: center; margin-top: 50px;">
                    🕊️ Aucun nouveau destin trouvé pour le moment.
                </p>
            <% } %>
        </div>
    </div>
</body>
</html>