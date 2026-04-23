package com.appli_rencontre.dao;

import com.appli_rencontre.model.Utilisateur;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UtilisateurDAO {
    
    // Inscription
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
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Connexion : on récupère TOUT pour mettre l'utilisateur complet en session
    public Utilisateur verifierLogin(String email, String password) {
        String sql = "SELECT * FROM utilisateurs WHERE email = ? AND mot_de_passe = ?";
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapperUtilisateur(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean emailExiste(String email) {
        String sql = "SELECT COUNT(*) FROM utilisateurs WHERE email = ?";
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // Découverte : Correction ici pour inclure la BIO dans les cartes
    public List<Utilisateur> recupererParFiltre(int idConnecte, String interetRecherche) {
        List<Utilisateur> liste = new ArrayList<>();
        String sql = interetRecherche.equals("Les deux") 
                     ? "SELECT * FROM utilisateurs WHERE id != ?" 
                     : "SELECT * FROM utilisateurs WHERE id != ? AND genre = ?";
        
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idConnecte);
            if (!interetRecherche.equals("Les deux")) ps.setString(2, interetRecherche);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    liste.add(mapperUtilisateur(rs)); // Utilisation du mapper complet
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return liste;
    }

    // Mise à jour du profil complet
    public boolean mettreAJourDescription(Utilisateur u) {
        String sql = "UPDATE utilisateurs SET age=?, signe_astro=?, situation=?, religion=?, bio=?, interets=?, red_flags=? WHERE id=?";
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, u.getAge());
            ps.setString(2, u.getSigneAstro());
            ps.setString(3, u.getSituation());
            ps.setString(4, u.getReligion());
            ps.setString(5, u.getBio());
            ps.setString(6, u.getInterets());
            ps.setString(7, u.getRedFlags());
            ps.setInt(8, u.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Récupérer un profil par ID
    public Utilisateur recupererParId(int id) {
        String sql = "SELECT * FROM utilisateurs WHERE id = ?";
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapperUtilisateur(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /**
     * MÉTHODE PRIVÉE : Centralise la création d'un utilisateur à partir d'un ResultSet
     * Évite d'oublier des colonnes (comme la bio) dans les différentes méthodes.
     */
    private Utilisateur mapperUtilisateur(ResultSet rs) throws SQLException {
        Utilisateur u = new Utilisateur();
        u.setId(rs.getInt("id"));
        u.setNom(rs.getString("nom"));
        u.setPrenom(rs.getString("prenom"));
        u.setEmail(rs.getString("email"));
        u.setGenre(rs.getString("genre"));
        u.setInteret(rs.getString("interet"));
        u.setVille(rs.getString("ville"));
        u.setAge(rs.getInt("age"));
        u.setSigneAstro(rs.getString("signe_astro"));
        u.setSituation(rs.getString("situation"));
        u.setReligion(rs.getString("religion"));
        u.setBio(rs.getString("bio")); // <--- C'était ça qui manquait !
        u.setInterets(rs.getString("interets"));
        u.setRedFlags(rs.getString("red_flags"));
        return u;
    }
}