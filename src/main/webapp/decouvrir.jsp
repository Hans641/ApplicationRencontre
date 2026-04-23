<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.appli_rencontre.model.Utilisateur" %>
<%
    // Vérification de sécurité locale
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
        
        /* Navigation (identique au profil pour la cohérence) */
        nav { width: 100%; background: #1e1e1e; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; box-sizing: border-box; border-bottom: 2px solid #ff4b2b; position: sticky; top: 0; z-index: 1000; }
        .nav-logo { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: #ff4b2b; text-decoration: none; font-weight: bold; }
        .nav-links a { color: #e0e0e0; text-decoration: none; margin-left: 20px; font-size: 0.9em; transition: 0.3s; }
        .nav-links a:hover { color: #ff4b2b; }

        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        h2 { font-family: 'Playfair Display', serif; color: #fff; font-size: 2rem; margin-bottom: 30px; text-align: center; }
        h2 span { color: #ff4b2b; }

        /* Grille de cartes */
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }
        
        .card { background: #1e1e1e; border-radius: 15px; padding: 30px; text-align: center; border-bottom: 4px solid transparent; transition: 0.3s; box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
        .card:hover { transform: translateY(-10px); border-bottom-color: #ff4b2b; background: #252525; }
        
        .avatar { width: 90px; height: 90px; background: linear-gradient(45deg, #ff4b2b, #ff3916); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; font-weight: bold; margin: 0 auto 20px; box-shadow: 0 4px 10px rgba(255, 75, 43, 0.3); }
        
        h3 { margin: 10px 0 5px; color: #fff; font-size: 1.4rem; }
        .city { color: #ff4b2b; font-size: 0.9em; font-style: italic; display: block; margin-bottom: 15px; }
        
        .badge { background: #333; padding: 5px 12px; border-radius: 20px; font-size: 0.75em; color: #aaa; text-transform: uppercase; letter-spacing: 1px; }
        
        .btn-match { margin-top: 25px; background: transparent; color: #ff4b2b; border: 1px solid #ff4b2b; padding: 10px 20px; border-radius: 25px; cursor: pointer; font-weight: 600; text-decoration: none; display: inline-block; transition: 0.3s; }
        .btn-match:hover { background: #ff4b2b; color: #fff; box-shadow: 0 5px 15px rgba(255, 75, 43, 0.4); }

        .empty-state { text-align: center; padding: 100px 20px; color: #888; }
    </style>
</head>
<body>

    <nav>
        <a href="profil.jsp" class="nav-logo">Kismet</a>
        <div class="nav-links">
            <a href="decouvrir" style="color: #ff4b2b;">Découvrir</a>
            <a href="#">Messages</a>
            <a href="logout.jsp" style="background: #ff4b2b; color: white; padding: 8px 15px; border-radius: 20px;">Déconnexion</a>
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
                    
                    <p style="font-size: 0.85em; color: #888; line-height: 1.6;">
                        Recherche : <%= m.getInteret() %><br>
                        "L'amour n'est qu'un hasard qui nous attend."
                    </p>
                    
                    <a href="#" class="btn-match">Lancer un Kismet</a>
                </div>
            <% 
                    }
                } else { 
            %>
                </div> <%-- Fermeture de grid si vide --%>
                <div class="empty-state">
                    <div style="font-size: 4rem; margin-bottom: 20px;">🕊️</div>
                    <p>Mince ! Aucun nouveau profil ne correspond à votre recherche pour le moment.</p>
                    <a href="profil.jsp" style="color: #ff4b2b; text-decoration: none;">Modifier mes préférences</a>
                </div>
            <% } %>
        </div>
    </div>

</body>
</html>