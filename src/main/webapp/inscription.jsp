<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription - Rencontre</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #121212; color: #e0e0e0; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .form-container { width: 100%; max-width: 450px; background: #1e1e1e; padding: 30px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.5); margin: 20px; }
        h2 { text-align: center; color: #ffffff; margin-bottom: 20px; }
        .row { display: flex; gap: 10px; }
        input, select { width: 100%; padding: 12px; margin: 8px 0; border-radius: 6px; border: 1px solid #333; background: #252525; color: white; box-sizing: border-box; }
        label { font-size: 0.9em; color: #bbb; margin-top: 10px; display: block; }
        button { width: 100%; padding: 12px; background-color: #ff4b2b; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; margin-top: 20px; transition: 0.3s; }
        button:hover { background-color: #ff3916; transform: translateY(-2px); }
        .alert { padding: 12px; border-radius: 6px; text-align: center; margin-bottom: 20px; font-size: 0.9em; }
        .success { background-color: rgba(27, 94, 32, 0.8); color: #c8e6c9; border: 1px solid #2e7d32; }
        .error { background-color: rgba(183, 28, 28, 0.8); color: #ffcdd2; border: 1px solid #c62828; }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Créer un compte</h2>

        <%
            // UN SEUL bloc de récupération du paramètre status
            String status = request.getParameter("status");
            if(status != null) {
                if("success".equals(status)) {
        %>
                    <div class="alert success">Inscription réussie ! Connectez-vous.</div>
        <%      } else if("error".equals(status)) { %>
                    <div class="alert error">Erreur lors de l'insertion en base de données.</div>
        <%      } else if("password_mismatch".equals(status)) { %>
                    <div class="alert error">Les mots de passe ne correspondent pas.</div>
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
                <option value="homme">Un homme</option>
                <option value="femme">Une femme</option>
                <option value="autre">Autre</option>
            </select>

            <label>Vous cherchez :</label>
            <select name="interet">
                <option value="femme">Une femme</option>
                <option value="homme">Un homme</option>
                <option value="les_deux">Les deux</option>
            </select>

            <input type="text" name="ville" placeholder="Ville (ex: Antananarivo)">
            
            <button type="submit">S'inscrire</button>
        </form>
    </div>

</body>
</html>