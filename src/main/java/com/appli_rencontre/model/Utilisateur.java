package com.appli_rencontre.model;

/**
 * Classe Model représentant un Utilisateur de l'application de rencontre.
 */
public class Utilisateur {
    private int id;
    private String nom;
    private String prenom;
    private String email;
    private String motDePasse;
    private String genre;
    private String interet;
    private String ville;

    // Constructeur Vide
    public Utilisateur() {
    }

    // Constructeur Complet
    public Utilisateur(int id, String nom, String email, String motDePasse, String genre, String interet, String ville) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.genre = genre;
        this.interet = interet;
        this.ville = ville;
    }

    // --- GETTERS ET SETTERS ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getInteret() {
        return interet;
    }

    public void setInteret(String interet) {
        this.interet = interet;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getPrenom() { 
        return prenom;
     }

    public void setPrenom(String prenom) { 
        this.prenom = prenom; 
    }
}