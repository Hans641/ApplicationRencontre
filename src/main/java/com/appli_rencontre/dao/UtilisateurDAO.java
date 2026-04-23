package com.appli_rencontre.dao;

import com.appli_rencontre.model.Utilisateur;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // Ajouté pour la lecture des données
import java.sql.SQLException;

public class UtilisateurDAO {
    
    // Méthode d'inscription (déjà fonctionnelle)
    public boolean inscrireUtilisateur(Utilisateur user) {
        String sql = "INSERT INTO utilisateurs (nom, prenom, email, mot_de_passe, genre, interet, ville) VALUES (?, ?, ?, ?, ?, ?, ?)";        
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getNom());
            ps.setString(2, user.getPrenom());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getMotDePasse());
            ps.setString(5, user.getGenre());
            ps.setString(6, user.getInteret());
            ps.setString(7, user.getVille());
            
            int rows = ps.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // NOUVELLE MÉTHODE : Vérification de la connexion
    public Utilisateur verifierLogin(String email, String password) {
        String sql = "SELECT * FROM utilisateurs WHERE email = ? AND mot_de_passe = ?";
        
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // On crée l'objet utilisateur avec les données récupérées
                    Utilisateur user = new Utilisateur();
                    user.setId(rs.getInt("id"));
                    user.setNom(rs.getString("nom"));
                    user.setPrenom(rs.getString("prenom"));
                    user.setEmail(rs.getString("email"));
                    user.setGenre(rs.getString("genre"));
                    user.setInteret(rs.getString("interet"));
                    user.setVille(rs.getString("ville"));
                    
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la vérification du login");
            e.printStackTrace();
        }
        return null; // Retourne null si aucun utilisateur ne correspond
    }
    public boolean emailExiste(String email) {
    String sql = "SELECT COUNT(*) FROM utilisateurs WHERE email = ?";
    try (Connection conn = DBConnexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, email);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
}