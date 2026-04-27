package com.appli_rencontre.model;

import java.sql.Timestamp;

public class Kismet {
    private int id;
    private int expediteurId;
    private int destinataireId;
    private String statut; // 'en_attente', 'accepte', 'decline'
    private Timestamp dateEnvoi;
    
    // Champs supplémentaires pour l'affichage des notifications
    // Évite de devoir recharger l'objet Utilisateur complet juste pour un nom
    private String prenomExpediteur;

    // Constructeur vide (nécessaire pour le DAO)
    public Kismet() {}

    // Constructeur complet
    public Kismet(int id, int expediteurId, int destinataireId, String statut, Timestamp dateEnvoi) {
        this.id = id;
        this.expediteurId = expediteurId;
        this.destinataireId = destinataireId;
        this.statut = statut;
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

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Timestamp getDateEnvoi() {
        return dateEnvoi;
    }

    public void setDateEnvoi(Timestamp dateEnvoi) {
        this.dateEnvoi = dateEnvoi;
    }

    public String getPrenomExpediteur() {
        return prenomExpediteur;
    }

    public void setPrenomExpediteur(String prenomExpediteur) {
        this.prenomExpediteur = prenomExpediteur;
    }
}