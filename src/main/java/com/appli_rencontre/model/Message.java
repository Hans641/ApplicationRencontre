package com.appli_rencontre.model;

import java.sql.Timestamp;

/**
 * Modèle représentant un message échangé entre deux utilisateurs.
 * Respecte la structure de données utilisée pour le projet Kismet.
 */
public class Message {
    private int id;
    private int expediteurId;
    private int destinataireId;
    private String contenu;
    private Timestamp dateEnvoi;

    // Constructeur vide nécessaire pour le DAO
    public Message() {}

    // Constructeur complet pour une instanciation rapide
    public Message(int id, int expediteurId, int destinataireId, String contenu, Timestamp dateEnvoi) {
        this.id = id;
        this.expediteurId = expediteurId;
        this.destinataireId = destinataireId;
        this.contenu = contenu;
        this.dateEnvoi = dateEnvoi;
    }

    // --- Getters et Setters ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getExpediteurId() {
        return expediteurId;
    }

    public void setExpediteurId(int expediteurId) {
        this.expediteurId = expediteurId;
    }

    public int getDestinataireId() {
        return destinataireId;
    }

    public void setDestinataireId(int destinataireId) {
        this.destinataireId = destinataireId;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    public Timestamp getDateEnvoi() {
        return dateEnvoi;
    }

    public void setDateEnvoi(Timestamp dateEnvoi) {
        this.dateEnvoi = dateEnvoi;
    }
}