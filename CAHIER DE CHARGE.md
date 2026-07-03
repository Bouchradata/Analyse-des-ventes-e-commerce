## CAHIER DES CHARGES
# Projet Data Analyst — Portfolio
### Analyse des ventes e-commerce — Online Retail Dataset


### PRESENTATION
>Outil principal	SQLite 
>Dataset	https://www.kaggle.com/datasets/ulrikthygepedersen/online-retail-dataset
>Volume de données	541 910 lignes — 8 colonnes
>Période couverte	Décembre 2010 — Décembre 2011
>Date de début	Mai 2026
>Statut	En cours de réalisation


### Contexte du projet

Ce projet s'inscrit dans une démarche de reconversion professionnelle vers le métier de Data Analyst. Il a pour objectif de démontrer, à travers un cas concret et réaliste, les compétences acquises en analyse de données, en SQL et en restitution des résultats.

Le dataset utilisé est le Online Retail Dataset, disponible sur le site KAGGLE. Il contient les transactions d'un commerce en ligne britannique entre décembre 2010 et décembre 2011. 

 ### Objectifs du projet

Réaliser une analyse complète et structurée du dataset Online Retail en SQL, exploitable dans un portfolio professionnel destiné à des recruteurs dans le domaine de la data.


•	Importer et explorer le dataset dans SQLite
•	Nettoyer les données pour garantir la fiabilité des résultats
•	Répondre à des questions d'analyse métier concrètes via des requêtes SQL
•	Produire des résultats lisibles et interprétables
•	Documenter chaque étape de façon professionnelle

### Présentation du dataset

Descriptiondescolonnes

Colonne	Description	Points de vigilance
InvoiceNo	Numéro de facture / commande	Commence par C = remboursement
StockCode	Code produit unique	
Description	Nom du produit	
Quantity	Quantité commandée	Valeurs négatives = retours clients
InvoiceDate	Date et heure de la commande	Format à gérer dans SQLite
UnitPrice	Prix unitaire en livres sterling	Valeurs à 0 à filtrer
CustomerID	Identifiant client	Tout est bon
Country	Pays du client	

### Questions d'analyse

Sept questions structurées en cinq thématiques constituent le cœur de ce projet. Chaque question correspond à une requête SQL documentée et à un résultat interprété.

### Volume & Revenue
•	Quel est le volume total d'articles vendus ?
•	Quel est le chiffre d'affaires (CA) total réalisé ?

### Géographie
•	Quels pays génèrent le plus de ventes (Top 5) ?

### Commandes
•	Quel est le panier moyen par facture ?
•	Quels sont les 10 produits qui génèrent le plus de revenus ?

### Clients
•	Combien de clients uniques l'entreprise compte-t-elle ?
•	Analyse de la fidélité : quelle est la part des clients récurrents ?

### Tendances temporelles
•	Quels sont les mois les plus performants ?

## Plan de travail


### Étape	Tâche	Compétences SQL mobilisées	Statut

>	Importer le CSV dans SQLite	CREATE TABLE, import CSV	fait
>	Explorer le dataset	SELECT, COUNT, LIMIT, DISTINCT	
>	Nettoyer les données	WHERE, IS NULL, IS NOT NULL, filtre Quantity > 0	
>	Calculer le CA total	SUM, colonnes calculées, AS	
>	Top 10 produits par revenu	GROUP BY, ORDER BY DESC, LIMIT	
>	Top clients par dépense	GROUP BY CustomerID, SUM, ORDER BY	
>	Clients uniques	COUNT(DISTINCT CustomerID)	
>	Top 10 produits en quantité	SUM(Quantity), GROUP BY, ORDER BY	
>	Quantité forte / revenu faible	Colonnes calculées, comparaison	
>	Revenus par pays	GROUP BY Country, SUM, ORDER BY	
>	Ventes par mois	strftime(), GROUP BY, ORDER BY	
>	Mois le plus performant	ORDER BY DESC, LIMIT 1	



•	Un fichier SQLite contenant les données importées et nettoyées
•	Un script SQL documenté avec toutes les requêtes commentées
•	Un rapport de synthèse présentant les résultats et les interprétations
•	Ce cahier des charges mis à jour au fil du projet
