package com.appli_rencontre.model;

import java.io.Serializable;

/**
 * Modèle Utilisateur complet pour Kismet.
 * Inclut les informations de base et les détails du profil étendu.
 */
public class Utilisateur implements Serializable {
    private static final long serialVersionUID = 1L;

    // Informations de base (Inscription/Connexion)
    private int id;
    private String nom;
    private String prenom;
    private String email;
    private String motDePasse;
    private String genre;
    private String interet;
    private String ville;

    // Détails du Profil Étendu (Description personnalisée)
    private int age;
    private String signeAstro;
    private String situation;
    private String religion;
    private String bio;
    private String interets;
    private String redFlags;

    // Constructeur vide (Indispensable pour les frameworks et DAO)
    public Utilisateur() {}

    // --- GETTERS ET SETTERS ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public String getInteret() { return interet; }
    public void setInteret(String interet) { this.interet = interet; }

    public String getVille() { return ville; }
    public void setVille(String ville) { this.ville = ville; }

    // Getters/Setters pour les nouveaux champs
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getSigneAstro() { return signeAstro; }
    public void setSigneAstro(String signeAstro) { this.signeAstro = signeAstro; }

    public String getSituation() { return situation; }
    public void setSituation(String situation) { this.situation = situation; }

    public String getReligion() { return religion; }
    public void setReligion(String religion) { this.religion = religion; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public String getInterets() { return interets; }
    public void setInterets(String interets) { this.interets = interets; }

    public String getRedFlags() { return redFlags; }
    public void setRedFlags(String redFlags) { this.redFlags = redFlags; }

    /**
     * Méthode utilitaire pour obtenir l'initiale pour l'avatar
     */
    public String getInitiale() {
        if (prenom != null && !prenom.isEmpty()) {
            return prenom.substring(0, 1).toUpperCase();
        }
        return "U";
    }
}