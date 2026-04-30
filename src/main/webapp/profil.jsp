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
    nav { width: 100%; background: #1e1e1e; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; box-sizing: border-box; border-bottom: 2px solid #ff4b2b; position: sticky; top: 0; z-index: 1000; }
    .nav-logo { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: #ff4b2b; text-decoration: none; font-weight: bold; }
    
    .nav-links { display: flex; align-items: center; }
    .nav-links a {
        color: #e0e0e0;
        text-decoration: none;
        margin-left: 20px;
        font-size: 0.9em;
        transition: 0.3s;
        padding: 5px 10px;
    }

    #nav-home { color: #ff4b2b; border-bottom: 2px solid #ff4b2b; }

    .nav-links a:hover:not(.btn-logout) {
        color: #ff4b2b;
        border-bottom: 2px solid #ff4b2b;
    }

    .notif-link { position: relative; }
    .notif-dot { 
        position: absolute; top: -2px; right: -5px; 
        width: 8px; height: 8px; background: #ff4b2b; border-radius: 50%; 
    }

    /* Carte Profil */
    .profile-container { width: 90%; max-width: 800px; margin-top: 50px; background: #1e1e1e; border-radius: 15px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.5); display: flex; }
    .profile-header { background: linear-gradient(45deg, #ff4b2b, #ff3916); width: 30%; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 40px; }
    .avatar-circle { width: 100px; height: 100px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 3rem; color: #ff4b2b; font-weight: bold; margin-bottom: 15px; }
    
    .profile-content { padding: 40px; width: 70%; }
    
    h1 { margin: 0; color: #ffffff; font-size: 2rem; transition: 0.3s; }
    h1:hover { color: #ff4b2b !important; }

    .location { color: #ff4b2b; font-style: italic; margin-bottom: 20px; display: block; }
    
    .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 30px; }
    
    .info-item { background: #252525; padding: 15px; border-radius: 8px; border-left: 3px solid #ff4b2b; transition: 0.3s; }
    .info-item:hover { background: #2a2a2a; transform: translateX(5px); }
    
    .info-label { font-size: 0.8em; color: #888; text-transform: uppercase; display: block; }
    .info-value { font-size: 1.1em; color: #fff; font-weight: 500; }

    /* NOUVEAU STYLE : Section Incognito */
.incognito-card {
        background: #252525;
        border-radius: 8px;
        padding: 20px;
        margin-top: 30px;
        border: 1px dashed #444; /* Bordure par défaut */
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .incognito-text h4 { margin: 0; color: #fff; font-size: 1rem; }
    .incognito-text p { margin: 5px 0 0; font-size: 0.8em; color: #888; }
.btn-incognito {
        padding: 8px 15px;
        border-radius: 20px;
        text-decoration: none;
        font-size: 0.85em;
        font-weight: 600;
        transition: 0.3s;
        background: #ff4b2b; /* Couleur par défaut */
        color: white;
    }
    .btn-incognito:hover { opacity: 0.8; transform: scale(1.05); }
    .incognito-active {
        border-color: #ff4b2b;
    }
    .btn-incognito-on {
        background: #333;
    }

    .btn-logout { 
        background-color: #ff4b2b !important;
        color: white !important;
        padding: 10px 20px !important; 
        border-radius: 25px !important; 
        font-weight: 600;
        text-decoration: none;
        margin-left: 20px;
        transition: 0.3s;
    }
    .btn-logout:hover { background-color: #ff3916 !important; box-shadow: 0 4px 12px rgba(255, 75, 43, 0.4); transform: translateY(-2px); }

    .form-group { display: flex; flex-direction: column; gap: 5px; }
    .input-kismet {
        background: #252525; color: white; border: 1px solid #333;
        border-radius: 8px; padding: 12px; font-family: 'Poppins', sans-serif; font-size: 0.9em;
    }
    .input-kismet:focus { border-color: #ff4b2b; outline: none; background: #2a2a2a; }
    .bio-label { font-size: 0.75em; color: #ff4b2b; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; }
</style>
</head>
<body>

    <nav>
        <a href="${pageContext.request.contextPath}/profil.jsp" class="nav-logo">Kismet</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/profil.jsp" id="nav-home">Mon Profil</a>
            <a href="${pageContext.request.contextPath}/decouvrir" id="nav-discover">Découvrir</a>
            <a href="${pageContext.request.contextPath}/notifications" class="notif-link">
                Notifications
                <span class="notif-dot"></span>
            </a>
            <a href="${pageContext.request.contextPath}/messages">Messages</a>
            <a href="${pageContext.request.contextPath}/logout.jsp" class="btn-logout">Déconnexion</a>
        </div>
    </nav>

    <div class="profile-container">
        <div class="profile-header">
            <div class="avatar-circle">
                <%= user.getInitiale() %>
            </div>
            <span style="color: white; font-weight: bold;"><%= user.getGenre() %></span>
        </div>

        <div class="profile-content">
            <h1>Bonjour, <%= user.getPrenom() %> <%= (user.getNom() != null) ? user.getNom() : "" %> !</h1>
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

            <!-- AJOUT : Bloc Mode Incognito -->
            <!-- Bloc Mode Incognito corrigé -->
            <div class="incognito-card <%= user.isModeIncognito() ? "incognito-active" : "" %>">
                <div class="incognito-text">
                    <h4>Mode Incognito : <%= user.isModeIncognito() ? "Activé 🕵️" : "Désactivé" %></h4>
                    <p><%= user.isModeIncognito() ? "Vous êtes caché des autres mais vous ne pouvez pas lancer de Kismet." : "Tout le monde peut découvrir votre profil." %></p>
                </div>
                
                <a href="${pageContext.request.contextPath}/toggleIncognito" 
                class="btn-incognito <%= user.isModeIncognito() ? "btn-incognito-on" : "" %>">
                    <%= user.isModeIncognito() ? "Devenir Visible" : "Passer Incognito" %>
                </a>
            </div>
            
            <p style="margin-top: 20px; color: #888;">Bienvenue sur votre espace personnel Kismet. Complétez votre profil pour faire de nouvelles rencontres à <%= user.getVille() %>.</p>
        </div>
    </div>

    <div class="profile-container" style="margin-top: 20px; display: block; padding: 30px; margin-bottom: 50px;">
        <h3 style="color: #ff4b2b; font-family: 'Playfair Display', serif;">Compléter mon Destin</h3>
        <p style="font-size: 0.85em; color: #888; margin-bottom: 20px;">Ces informations aideront vos correspondants à mieux vous connaître.</p>
        
        <form action="${pageContext.request.contextPath}/modifierProfil" method="post">
            <div class="info-grid" style="grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="form-group">
                    <label class="bio-label">Âge</label>
                    <input type="number" name="age" value="<%= (user.getAge() > 0) ? user.getAge() : "" %>" placeholder="Ex: 24" class="input-kismet">
                </div>
                <div class="form-group">
                    <label class="bio-label">Signe Astrologique</label>
                    <input type="text" name="signe" value="<%= (user.getSigneAstro() != null) ? user.getSigneAstro() : "" %>" placeholder="Ex: Lion" class="input-kismet">
                </div>
                <div class="form-group">
                    <label class="bio-label">Situation Amoureuse</label>
                    <input type="text" name="situation" value="<%= (user.getSituation() != null) ? user.getSituation() : "" %>" placeholder="Ex: Célibataire" class="input-kismet">
                </div>
                <div class="form-group">
                    <label class="bio-label">Religion</label>
                    <input type="text" name="religion" value="<%= (user.getReligion() != null) ? user.getReligion() : "" %>" placeholder="Ex: Chrétien" class="input-kismet">
                </div>
                
                <div class="form-group" style="grid-column: span 2;">
                    <label class="bio-label">Bio (Ma personnalité, mes attentes)</label>
                    <textarea name="bio" placeholder="Décrivez votre genre de personne..." class="input-kismet" style="height: 80px;"><%= (user.getBio() != null) ? user.getBio() : "" %></textarea>
                </div>
                <div class="form-group" style="grid-column: span 2;">
                    <label class="bio-label">Centres d'intérêt</label>
                    <input type="text" name="interets" value="<%= (user.getInterets() != null) ? user.getInterets() : "" %>" placeholder="Ex: Musique, Voyage, Football" class="input-kismet">
                </div>
                <div class="form-group" style="grid-column: span 2;">
                    <label class="bio-label" style="color: #ff3916;">Red Flags (Ce que vous n'acceptez pas)</label>
                    <input type="text" name="redflags" value="<%= (user.getRedFlags() != null) ? user.getRedFlags() : "" %>" placeholder="Ex: Mensonge, Retard" class="input-kismet">
                </div>
            </div>
            
            <button type="submit" class="btn-logout" style="margin-top: 25px; width: 100%; margin-left: 0;">Publier mon profil complet</button>
        </form>
    </div>
</body>
</html>