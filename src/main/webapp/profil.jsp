<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.appli_rencontre.model.Utilisateur" %>
<%
    // Sécurité : Vérifier si l'utilisateur est bien connecté
    Utilisateur user = (Utilisateur) session.getAttribute("utilisateurConnecte");
    if (user == null) {
        // Si personne n'est en session, on redirige vers le login
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Kismet - Mon Profil</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Poppins', sans-serif; background-color: #121212; color: #e0e0e0; margin: 0; display: flex; flex-direction: column; align-items: center; min-height: 100vh; }
    
    /* Barre de navigation */
    nav { width: 100%; background: #1e1e1e; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; box-sizing: border-box; border-bottom: 2px solid #ff4b2b; }
    .nav-logo { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: #ff4b2b; text-decoration: none; font-weight: bold; }
    
    /* Liens nav standard */
    .nav-links a { color: #e0e0e0; text-decoration: none; margin-left: 20px; font-size: 0.9em; transition: 0.3s; }
    .nav-links a:hover:not(.btn-logout) { color: #ff4b2b; }

    /* Carte Profil */
    .profile-container { width: 90%; max-width: 800px; margin-top: 50px; background: #1e1e1e; border-radius: 15px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.5); display: flex; }
    .profile-header { background: linear-gradient(45deg, #ff4b2b, #ff3916); width: 30%; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 40px; }
    .avatar-circle { width: 100px; height: 100px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 3rem; color: #ff4b2b; font-weight: bold; margin-bottom: 15px; }
    
    .profile-content { padding: 40px; width: 70%; }
    
    /* Correctif Titre : Évite l'invisibilité au survol */
    h1 { margin: 0; color: #ffffff; font-size: 2rem; transition: 0.3s; }
    h1:hover { color: #ff4b2b !important; }

    .location { color: #ff4b2b; font-style: italic; margin-bottom: 20px; display: block; }
    
    .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 30px; }
    
    /* Correctif Items : Force la couleur du texte au survol */
    .info-item { background: #252525; padding: 15px; border-radius: 8px; border-left: 3px solid #ff4b2b; transition: 0.3s; }
    .info-item:hover { background: #2a2a2a; transform: translateX(5px); }
    
    .info-label { font-size: 0.8em; color: #888; text-transform: uppercase; display: block; }
    .info-value { font-size: 1.1em; color: #fff; font-weight: 500; }

    /* Maintien de la lisibilité sur les infos au survol */
    .info-item:hover .info-value { color: #ffffff !important; }
    .info-item:hover .info-label { color: #ff4b2b; }

    /* Nouveau style pour le bouton Déconnexion */
    .btn-logout { 
        background-color: #ff4b2b !important; /* Fond rouge */
        color: white !important; /* Texte blanc */
        padding: 10px 20px !important; 
        border-radius: 25px !important; 
        font-weight: 600;
        border: none !important;
        cursor: pointer; 
        transition: 0.3s; 
        display: inline-block;
    }
    .btn-logout:hover { 
        background-color: #ff3916 !important; 
        box-shadow: 0 4px 12px rgba(255, 75, 43, 0.4);
        transform: translateY(-2px);
    }
</style>
</head>
<body>

    <nav>
        <a href="#" class="nav-logo">Kismet</a>
        <div class="nav-links">
            <a href="decouvrir">Découvrir</a>
            <a href="#">Messages</a>
            <a href="logout.jsp" class="btn-logout">Déconnexion</a>
        </div>
    </nav>

    <div class="profile-container">
        <div class="profile-header">
            <div class="avatar-circle">
                <%= user.getPrenom().substring(0, 1).toUpperCase() %>
            </div>
            <span style="color: white; font-weight: bold;"><%= user.getGenre() %></span>
        </div>

        <div class="profile-content">
            <h1>Bonjour, <%= user.getPrenom() %> <%= user.getNom() %> !</h1>
            <span class="location">📍 <%= user.getVille() %></span>

            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Email</span>
                    <span class="info-value"><%= user.getEmail() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Recherche</span>
                    <span class="info-value"><%= user.getInteret() %></span>
                </div>
            </div>
            
            <p style="margin-top: 40px; color: #888;">Bienvenue sur votre espace personnel Kismet. Complétez votre profil pour faire de nouvelles rencontres à <%= user.getVille() %>.</p>
        </div>
    </div>

</body>
</html>