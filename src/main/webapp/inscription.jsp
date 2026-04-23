<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Kismet - Inscription</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #121212; color: #e0e0e0; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .logo-kismet { font-family: 'Playfair Display', serif; font-size: 3.2rem; color: #ff4b2b; text-align: center; margin-bottom: 5px; letter-spacing: 2px; text-transform: uppercase; text-shadow: 2px 2px 10px rgba(255, 75, 43, 0.2); }
        .form-container { width: 100%; max-width: 450px; background: #1e1e1e; padding: 35px; border-radius: 15px; box-shadow: 0 15px 35px rgba(0,0,0,0.6); margin: 20px; border-top: 4px solid #ff4b2b; }
        h2 { text-align: center; color: #ffffff; margin-bottom: 25px; font-weight: 300; font-size: 1.1rem; text-transform: uppercase; letter-spacing: 2px; }
        .row { display: flex; gap: 12px; }
        input, select { width: 100%; padding: 12px; margin: 10px 0; border-radius: 8px; border: 1px solid #333; background: #252525; color: white; box-sizing: border-box; font-size: 0.95em; transition: border-color 0.3s; }
        input:focus, select:focus { border-color: #ff4b2b; outline: none; }
        label { font-size: 0.85em; color: #888; margin-top: 10px; display: block; padding-left: 5px; }
        button { width: 100%; padding: 14px; background-color: #ff4b2b; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: 600; font-size: 1em; margin-top: 25px; transition: all 0.3s ease; }
        button:hover { background-color: #ff3916; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255, 75, 43, 0.3); }
        .alert { padding: 12px; border-radius: 8px; text-align: center; margin-bottom: 20px; font-size: 0.9em; border: 1px solid; }
        .error { background-color: rgba(183, 28, 28, 0.2); color: #ffcdd2; border-color: #c62828; }
        .footer-link { text-align: center; margin-top: 20px; font-size: 0.9em; color: #888; }
        .footer-link a { color: #ff4b2b; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>

    <div class="form-container">
        <div class="logo-kismet">Kismet</div>
        <h2>Rejoignez l'aventure</h2>

        <%
            String status = request.getParameter("status");
            if(status != null) {
                if("error".equals(status)) { %>
                    <div class="alert error">Une erreur technique est survenue.</div>
        <%      } else if("password_mismatch".equals(status)) { %>
                    <div class="alert error">Les mots de passe ne sont pas identiques.</div>
        <%      } else if("email_exists".equals(status)) { %>
                    <div class="alert error">Cet email est déjà lié à un compte.</div>
        <%      }
            }
        %>

        <form action="inscription" method="post">
            <div class="row">
                <input type="text" name="nom" placeholder="Nom" required>
                <input type="text" name="prenom" placeholder="Prénom" required>
            </div>
            
            <input type="email" name="email" placeholder="Email" required>
            
            <input type="password" name="password" placeholder="Mot de passe" required>
            <input type="password" name="confirm_password" placeholder="Confirmer le mot de passe" required>            
            
            <label>Vous êtes :</label>
            <select name="genre">
                <option value="Homme">Un homme</option>
                <option value="Femme">Une femme</option>
                <option value="Autre">Autre</option>
            </select>

            <label>Vous cherchez :</label>
            <select name="interet">
                <option value="Femme">Une femme</option>
                <option value="Homme">Un homme</option>
                <option value="Les deux">Les deux</option>
            </select>

            <input type="text" name="ville" placeholder="Ville (ex: Antananarivo)" required>
            
            <button type="submit">Commencer l'aventure</button>
        </form>

        <div class="footer-link">
            Déjà inscrit ? <a href="login.jsp">Se connecter</a>
        </div>
    </div>

</body>
</html>