package com.appli_rencontre.dao;

import com.appli_rencontre.model.Message;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {
    
    // Enregistrer un nouveau message
    public boolean envoyerMessage(int from, int to, String texte) {
        String sql = "INSERT INTO messages (expediteur_id, destinataire_id, contenu) VALUES (?, ?, ?)";
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, from);
            ps.setInt(2, to);
            ps.setString(3, texte);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // Récupérer la discussion entre deux utilisateurs (triée par date)
    public List<Message> recupererDiscussion(int user1, int user2) {
        List<Message> chat = new ArrayList<>();
        String sql = "SELECT * FROM messages WHERE (expediteur_id = ? AND destinataire_id = ?) " +
                     "OR (expediteur_id = ? AND destinataire_id = ?) ORDER BY date_envoi ASC";
        try (Connection conn = DBConnexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user1);
            ps.setInt(2, user2);
            ps.setInt(3, user2);
            ps.setInt(4, user1);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Message m = new Message();
                m.setContenu(rs.getString("contenu"));
                m.setExpediteurId(rs.getInt("expediteur_id"));
                m.setDateEnvoi(rs.getTimestamp("date_envoi"));
                chat.add(m);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return chat;
    }
    public String recupererDernierMessage(int user1, int user2) {
    String dernierMessage = "Cliquez pour envoyer un message...";
    String sql = "SELECT contenu FROM messages WHERE (expediteur_id = ? AND destinataire_id = ?) " +
                 "OR (expediteur_id = ? AND destinataire_id = ?) " +
                 "ORDER BY date_envoi DESC LIMIT 1";
    
    try (Connection conn = DBConnexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, user1);
        ps.setInt(2, user2);
        ps.setInt(3, user2);
        ps.setInt(4, user1);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                dernierMessage = rs.getString("contenu");
                // On tronque le message s'il est trop long pour l'affichage
                if (dernierMessage.length() > 40) {
                    dernierMessage = dernierMessage.substring(0, 37) + "...";
                }
            }
        }
    } catch (SQLException e) { e.printStackTrace(); }
    return dernierMessage;
}
}