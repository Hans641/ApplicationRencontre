package com.appli_rencontre.dao;

import com.appli_rencontre.model.Kismet;
import com.appli_rencontre.model.Utilisateur;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class KismetDAO {

    // Enregistrer un nouveau Kismet (Demande)
    public boolean envoyerKismet(int idExpediteur, int idDestinataire) {
        String sql = "INSERT INTO kismets (expediteur_id, destinataire_id, statut) VALUES (?, ?, 'en_attente')";
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idExpediteur);
            ps.setInt(2, idDestinataire);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Récupérer les notifications pour l'utilisateur connecté
    public List<Kismet> recupererNotifications(int idUtilisateur) {
        List<Kismet> notifications = new ArrayList<>();
        String sql = "SELECT k.*, u.prenom FROM kismets k " +
                     "JOIN utilisateurs u ON k.expediteur_id = u.id " +
                     "WHERE k.destinataire_id = ? AND k.statut = 'en_attente'";
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUtilisateur);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Kismet k = new Kismet();
                    k.setId(rs.getInt("id"));
                    k.setExpediteurId(rs.getInt("expediteur_id"));
                    k.setDestinataireId(rs.getInt("destinataire_id"));
                    k.setStatut(rs.getString("statut"));
                    k.setDateEnvoi(rs.getTimestamp("date_envoi"));
                    k.setPrenomExpediteur(rs.getString("prenom"));
                    notifications.add(k);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return notifications;
    }

    // Modifier le statut (Accepter ou Décliner)
    public boolean mettreAJourStatut(int kismetId, String nouveauStatut) {
        String sql = "UPDATE kismets SET statut = ? WHERE id = ?";
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nouveauStatut);
            ps.setInt(2, kismetId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Utilisateur> recupererMatches(int userId) {
    List<Utilisateur> matches = new ArrayList<>();
    // On cherche les Kismets acceptés où l'utilisateur est soit l'expéditeur, soit le destinataire
    String sql = "SELECT u.* FROM utilisateurs u " +
                 "JOIN kismets k ON (u.id = k.expediteur_id OR u.id = k.destinataire_id) " +
                 "WHERE (k.expediteur_id = ? OR k.destinataire_id = ?) " +
                 "AND u.id != ? AND k.statut = 'accepte'";
    
    try (Connection conn = DBConnexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setInt(2, userId);
        ps.setInt(3, userId);
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Utilisateur u = new Utilisateur();
            u.setId(rs.getInt("id"));
            u.setPrenom(rs.getString("prenom"));
            u.setVille(rs.getString("ville"));
            u.setGenre(rs.getString("genre"));
            matches.add(u);
        }
    } catch (SQLException e) { e.printStackTrace(); }
    return matches;
}
// À ajouter dans KismetDAO.java
public List<Integer> recupererIdsMatches(int userId) {
    List<Integer> ids = new ArrayList<>();
    // Utilisation stricte des noms de colonnes confirmés par ton DESC :
    // expediteur_id, destinataire_id et statut
    String sql = "SELECT expediteur_id, destinataire_id FROM kismets WHERE (expediteur_id = ? OR destinataire_id = ?) AND statut = 'accepte'";
    
    try (Connection conn = DBConnexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, userId);
        ps.setInt(2, userId);
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int expediteur = rs.getInt("expediteur_id");
                int destinataire = rs.getInt("destinataire_id");
                
                // Si l'expéditeur c'est moi, j'ajoute l'ID du destinataire. 
                // Sinon, j'ajoute l'ID de l'expéditeur.
                if (expediteur == userId) {
                    ids.add(destinataire);
                } else {
                    ids.add(expediteur);
                }
            }
        }
    } catch (SQLException e) { 
        System.err.println("Erreur dans recupererIdsMatches : " + e.getMessage());
        e.printStackTrace(); 
    }
    return ids;
}
}