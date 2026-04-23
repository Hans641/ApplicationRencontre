<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Kismet - Connexion</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #121212; color: #e0e0e0; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .form-container { width: 100%; max-width: 400px; background: #1e1e1e; padding: 30px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.5); border-top: 4px solid #ff4b2b; }
        .logo-kismet { font-family: 'Playfair Display', serif; font-size: 3rem; color: #ff4b2b; text-align: center; margin-bottom: 10px; letter-spacing: 2px; text-transform: uppercase; }
        h2 { text-align: center; color: #ffffff; margin-bottom: 25px; font-weight: 300; font-size: 1.2rem; text-transform: uppercase; }
        input { width: 100%; padding: 12px; margin: 8px 0; border-radius: 6px; border: 1px solid #333; background: #252525; color: white; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background-color: #ff4b2b; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; margin-top: 20px; }
        .alert { padding: 10px; border-radius: 6px; text-align: center; margin-bottom: 20px; font-size: 0.85em; background-color: rgba(183, 28, 28, 0.8); color: #ffcdd2; border: 1px solid #c62828; }
        .footer-link { text-align: center; margin-top: 20px; font-size: 0.9em; }
        .footer-link a { color: #ff4b2b; text-decoration: none; }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="logo-kismet">Kismet</div>
        <h2>Connexion</h2>

        <% if(request.getParameter("error") != null) { %>
            <div class="alert">Email ou mot de passe incorrect.</div>
        <% } %>

        <form action="login" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mot de passe" required>
            <button type="submit">Se connecter</button>
        </form>

        <div class="footer-link">
            Pas encore membre ? <a href="inscription.jsp">Créer un compte</a>
        </div>
    </div>
</body>
</html>