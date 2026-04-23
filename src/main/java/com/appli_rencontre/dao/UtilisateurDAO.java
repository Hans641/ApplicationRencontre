package com.appli_rencontre.dao;

import com.appli_rencontre.model.Utilisateur;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UtilisateurDAO {
    
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
}