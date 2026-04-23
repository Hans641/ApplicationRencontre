<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.appli_rencontre.model.Utilisateur" %>
<%
    // Vérification de sécurité
    Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateurConnecte");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
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
    
    .btn-logout { 
        background-color: #ff4b2b !important; color: white !important; 
        padding: 8px 20px !important; border-radius: 20px !important; 
        font-weight: 600; text-decoration: none; margin-left: 30px;
    }

    /* Grille & Cartes */
    .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
    h2 { font-family: 'Playfair Display', serif; text-align: center; margin-bottom: 40px; color: #fff; }
    h2 span { color: #ff4b2b; }
    .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px; }
    
    .card { 
        background: #1e1e1e; border-radius: 20px; padding: 30px; 
        text-align: center; border: 1px solid #2a2a2a; transition: 0.3s;
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
    .bio-preview { font-size: 0.85em; color: #bbb; margin: 15px 0; line-height: 1.4; min-height: 40px; }
    .see-more { color: #ff4b2b; text-decoration: none; font-weight: bold; font-size: 0.9em; }

    .btn-match { 
        margin-top: 15px; background: transparent; color: #ff4b2b; 
        border: 2px solid #ff4b2b; padding: 10px 25px; border-radius: 30px; 
        cursor: pointer; font-weight: 600; text-decoration: none; display: inline-block; transition: 0.3s; 
    }
    .btn-match:hover { background: #ff4b2b; color: #fff; }
</style>
</head>
<body>

    <nav>
        <a href="${pageContext.request.contextPath}/profil.jsp" class="nav-logo">Kismet</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/profil.jsp">Mon Profil</a>
            <a href="${pageContext.request.contextPath}/decouvrir" id="nav-discover">Découvrir</a>
            <a href="#">Messages</a>
            <a href="${pageContext.request.contextPath}/logout.jsp" class="btn-logout">Déconnexion</a>
        </div>
    </nav>

    <div class="container">
        <h2>Découvrir des <span>destins</span> à <%= currentUser.getVille() %></h2>
        
        <div class="grid">
            <% 
                List<Utilisateur> membres = (List<Utilisateur>) request.getAttribute("membres");
                if(membres != null && !membres.isEmpty()) {
                    for(Utilisateur m : membres) {
            %>
                <div class="card">
                    <div class="avatar"><%= m.getPrenom().substring(0, 1).toUpperCase() %></div>
                    <h3><%= m.getPrenom() %></h3>
                    <span class="city">📍 <%= m.getVille() %></span>
                    
                    <div style="margin-bottom: 15px;">
                        <span class="badge"><%= m.getGenre() %></span>
                    </div>

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
                    
                    <p style="font-size: 0.8em; color: #666; line-height: 1.4;">
                        Recherche : <%= m.getInteret() %><br>
                        "L'amour n'est qu'un hasard qui nous attend."
                    </p>
                    
                    <a href="#" class="btn-match">Lancer un Kismet</a>
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