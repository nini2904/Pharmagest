-- Table Fournisseur
CREATE TABLE fournisseur (
    nom VARCHAR(255) PRIMARY KEY,
    adresse TEXT,
    telephone VARCHAR(20),
    email VARCHAR(255),
    pays VARCHAR(100)
);

-- Table Forme
CREATE TABLE forme (
    nom_forme VARCHAR(255) PRIMARY KEY
);

-- Table Famille
CREATE TABLE famille (
    num_famille SERIAL PRIMARY KEY,
    nom_famille VARCHAR(255) NOT NULL
);

-- Table Medicament
CREATE TABLE medicament (
    DCI VARCHAR(255) PRIMARY KEY,
    nom_commercial VARCHAR(255),
    dosage VARCHAR(50),
    prixUnit_vente NUMERIC(10, 2),
    prixUnit_achat NUMERIC(10, 2),
    qte_Stock INTEGER,
    num_famille INT REFERENCES famille(num_famille) ON DELETE CASCADE,
    nom_forme VARCHAR(255) REFERENCES forme(nom_forme) ON DELETE CASCADE,
    fournisseur_habituel VARCHAR(255) REFERENCES fournisseur(nom) ON DELETE SET NULL
);

-- Table Commande_livraison
CREATE TABLE commande_livraison (
    num_commande SERIAL PRIMARY KEY,
    date_commande DATE,
    date_livraison DATE,
    NoBonDeLivraisonFn VARCHAR(50)
);

-- Table ligne_cmd_livraison
CREATE TABLE ligne_cmd_livraison (
    ligne_cmd_livraison_id SERIAL PRIMARY KEY,
    qte_cmd INTEGER,
    qte_livree INTEGER,
    PUCommandee NUMERIC(10, 2),
    num_commande INT REFERENCES commande_livraison(num_commande) ON DELETE CASCADE,
    medicament_DCI VARCHAR(255) REFERENCES medicament(DCI) ON DELETE CASCADE
);

-- Table Utilisateur
CREATE TABLE utilisateur (
    identifiant VARCHAR(255) PRIMARY KEY,
    prenom_per VARCHAR(255),
    nom_per VARCHAR(255),
    date_naissance DATE,
    telephone VARCHAR(20),
    email VARCHAR(255),
    adresse TEXT,
    mot_de_passe TEXT,
    est_superadmin BOOLEAN DEFAULT FALSE
);

-- Table Client
CREATE TABLE client (
    client_id SERIAL PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    civilite VARCHAR(50),
    ddn DATE
);

-- Table Ordonnance
CREATE TABLE ordonnance (
    num_ord SERIAL PRIMARY KEY,
    date_ord DATE,
    nom_medecin VARCHAR(255),
    client_id INT REFERENCES client(client_id) ON DELETE CASCADE
);

-- Table Vente
CREATE TABLE vente (
    num_vente SERIAL PRIMARY KEY,
    date_vente DATE,
    status VARCHAR(50),
    montant NUMERIC(10, 2),
    utilisateur_id VARCHAR(255) REFERENCES utilisateur(identifiant) ON DELETE CASCADE,
    ordonnance_id INT REFERENCES ordonnance(num_ord) ON DELETE SET NULL
);

-- Table ligne_vendu
CREATE TABLE ligne_vendu (
    ligne_vendu_id SERIAL PRIMARY KEY,
    qte_vendue INTEGER,
    prixunit_vente NUMERIC(10, 2),
    num_vente INT REFERENCES vente(num_vente) ON DELETE CASCADE,
    medicament_DCI VARCHAR(255) REFERENCES medicament(DCI) ON DELETE CASCADE
);

--- Forme ---
INSERT INTO forme (nom_forme) VALUES
('Comprimé'),
('Gélule'),
('Solution injectable'),
('Pommade'),
('Sirop');

--- Famille ---
INSERT INTO famille (nom_famille) VALUES
('Analgésiques'),
('Antibiotiques'),
('Antihypertenseurs'),
('Antidiabétiques'),
('Antidépresseurs');

--- Medicaments ---
INSERT INTO medicament (DCI, nom_commercial, dosage, prixUnit_vente, prixUnit_achat, qte_Stock, num_famille, nom_forme, fournisseur_habituel) VALUES
('Paracétamol', 'Doliprane', '500 mg', 3.50, 1.50, 100, 1, 'Comprimé', 'Laboratoire Sanofi'),
('Amoxicilline', 'Clamoxyl', '250 mg', 5.00, 2.00, 50, 2, 'Gélule', 'Laboratoire Pfizer'),
('Lisinopril', 'Zestril', '10 mg', 6.00, 3.00, 30, 3, 'Comprimé', 'Laboratoire Merck'),
('Metformine', 'Glucophage', '500 mg', 8.00, 4.00, 200, 4, 'Comprimé', 'Laboratoire Bristol-Myers'),
('Sertraline', 'Zoloft', '50 mg', 12.00, 6.00, 80, 5, 'Comprimé', 'Laboratoire Pfizer');

--- Fournisseur ---
INSERT INTO fournisseur (nom, adresse, telephone, email, pays) VALUES
('Laboratoire Sanofi', '31 Rue de la République, Paris, France', '01 45 67 89 00', 'contact@sanofi.com', 'France'),
('Laboratoire Pfizer', '23 Boulevard Victor Hugo, Lyon, France', '04 72 34 56 78', 'service@pfizer.fr', 'France'),
('Laboratoire Merck', '55 Avenue de la Science, Lille, France', '03 20 45 67 89', 'info@merck.com', 'France'),
('Laboratoire Bristol-Myers', '45 Rue de la Santé, Marseille, France', '01 23 45 67 00', 'support@bristol-myers.com', 'France'),
('Laboratoire Novartis', '67 Rue du Parc, Toulouse, France', '05 61 23 45 67', 'service@novartis.fr', 'France');

--- Utilisateurs ---
INSERT INTO utilisateur (identifiant, prenom_per, nom_per, date_naissance, telephone, email, adresse, mot_de_passe, est_superadmin) VALUES
('user1', 'Alice', 'Dupont', '1990-05-15', '0123456789', 'alice.dupont@example.com', '10 Rue de Paris, Paris', 'mdp1', FALSE),
('user2', 'Bob', 'Martin', '1985-08-20', '0987654321', 'bob.martin@example.com', '15 Avenue de Lyon, Lyon', 'mdp2', FALSE),
('user3', 'Charlie', 'Durand', '2000-02-10', '0147258369', 'charlie.durand@example.com', '20 Boulevard des Champs, Marseille', 'mdp3', TRUE);
