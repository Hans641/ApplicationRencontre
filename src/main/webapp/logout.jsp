<%
    // Détruit la session pour déconnecter l'utilisateur
    session.invalidate(); 
    
    // Redirige vers la page d'inscription au lieu de la page de login
    response.sendRedirect("inscription.jsp");
%>