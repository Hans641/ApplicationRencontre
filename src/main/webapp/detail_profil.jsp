<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.appli_rencontre.model.Utilisateur" %>
<%
    // On récupère l'utilisateur envoyé par le Servlet
    Utilisateur p = (Utilisateur) request.getAttribute("profilAffiche");
    if (p == null) {
        // Si on arrive ici sans passer par le Servlet, on redirige
        response.sendRedirect(request.getContextPath() + "/decouvrir");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Kismet - Profil de <%= p.getPrenom() %></title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #121212; color: #e0e0e0; margin: 0; display: flex; flex-direction: column; align-items: center; min-height: 100vh; }
        nav { width: 100%; background: #1e1e1e; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; box-sizing: border-box; border-bottom: 2px solid #ff4b2b; position: sticky; top: 0; z-index: 1000; }
        .nav-logo { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: #ff4b2b; text-decoration: none; font-weight: bold; }
        .nav-links a { color: #e0e0e0; text-decoration: none; margin-left: 20px; font-size: 0.9em; transition: 0.3s; }
        .btn-back { color: #ff4b2b !important; font-weight: 600; }

        .profile-container { width: 90%; max-width: 900px; margin: 50px 0; background: #1e1e1e; border-radius: 15px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.5); display: flex; min-height: 500px; }
        
        .profile-header { background: linear-gradient(45deg, #ff4b2b, #ff3916); width: 35%; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 40px; text-align: center; }
        .avatar-circle { width: 120px; height: 120px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 4rem; color: #ff4b2b; font-weight: bold; margin-bottom: 15px; }
        
        .profile-content { padding: 40px; width: 65%; }
        h1 { margin: 0; color: #ffffff; font-size: 2.2rem; font-family: 'Playfair Display', serif; }
        .location { color: #ff4b2b; font-style: italic; margin-bottom: 25px; display: block; }

        .bio-section { margin-bottom: 25px; border-left: 3px solid #333; padding-left: 15px; }
        .bio-title { font-size: 0.75em; color: #ff4b2b; font-weight: 600; text-transform: uppercase; letter-spacing: 1.5px; display: block; margin-bottom: 5px; }
        .bio-text { font-size: 0.95em; color: #ccc; line-height: 1.6; }

        .stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 30px; }
        .stat-item { background: #252525; padding: 10px 15px; border-radius: 8px; border-bottom: 2px solid #333; }
        
        .red-flag-box { background: rgba(255, 75, 43, 0.05); border: 1px dashed #ff3916; padding: 15px; border-radius: 8px; }
        .btn-contact { display: block; width: 100%; text-align: center; background: #ff4b2b; color: white; padding: 15px; border-radius: 10px; text-decoration: none; font-weight: 600; margin-top: 20px; transition: 0.3s; }
        .btn-contact:hover { background: #ff3916; transform: translateY(-3px); }
    </style>
</head>
<body>

    <nav>
        <a href="${pageContext.request.contextPath}/profil.jsp" class="nav-logo">Kismet</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/decouvrir" class="btn-back">← Retour aux destins</a>
            <a href="${pageContext.request.contextPath}/logout.jsp">Déconnexion</a>
        </div>
    </nav>

    <div class="profile-container">
        <div class="profile-header">
            <div class="avatar-circle"><%= p.getPrenom().substring(0, 1).toUpperCase() %></div>
            <div style="background: rgba(0,0,0,0.2); padding: 5px 15px; border-radius: 20px; font-size: 0.8em;"><%= p.getGenre() %></div>
            <p style="margin-top: 20px; font-size: 0.9em; opacity: 0.9;">Cherche <%= p.getInteret() %></p>
        </div>

        <div class="profile-content">
            <h1><%= p.getPrenom() %> <%= (p.getNom() != null) ? p.getNom() : "" %></h1>
            <span class="location">📍 <%= p.getVille() %></span>

            <div class="stats-grid">
                <div class="stat-item">
                    <span class="bio-title">Âge</span>
                    <span class="bio-text"><%= (p.getAge() > 0) ? p.getAge() + " ans" : "Non précisé" %></span>
                </div>
                <div class="stat-item">
                    <span class="bio-title">Signe</span>
                    <span class="bio-text"><%= (p.getSigneAstro() != null) ? p.getSigneAstro() : "Mystère" %></span>
                </div>
                <div class="stat-item">
                    <span class="bio-title">Situation</span>
                    <span class="bio-text"><%= (p.getSituation() != null) ? p.getSituation() : "Célibataire" %></span>
                </div>
                <div class="stat-item">
                    <span class="bio-title">Religion</span>
                    <span class="bio-text"><%= (p.getReligion() != null) ? p.getReligion() : "Non spécifié" %></span>
                </div>
            </div>

            <div class="bio-section">
                <span class="bio-title">Bio & Personnalité</span>
                <p class="bio-text"><%= (p.getBio() != null) ? p.getBio() : "Cet utilisateur n'a pas encore rédigé sa bio." %></p>
            </div>

            <div class="bio-section">
                <span class="bio-title">Centres d'intérêt</span>
                <p class="bio-text" style="color: #fff;"><%= (p.getInterets() != null) ? p.getInterets() : "Football, Musique, Code" %></p>
            </div>

            <% if(p.getRedFlags() != null && !p.getRedFlags().isEmpty()) { %>
            <div class="red-flag-box">
                <span class="bio-title" style="color: #ff3916;">🚩 Red Flags</span>
                <p class="bio-text"><%= p.getRedFlags() %></p>
            </div>
            <% } %>

            <a href="#" class="btn-contact">Envoyer un Kismet à <%= p.getPrenom() %></a>
        </div>
    </div>

</body>
</html>