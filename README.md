

  # 📊 Analyse Performance & Pilotage Stratégique E-Commerce (2010 - 2011)


Ce projet vise à répondre à une question business concrète : **Comment optimiser les performances commerciales et la stratégie de réapprovisionnement d'une entreprise de retail ?

OBJECTIF : 

> Isoler l'impact des retours produits** sur la rentabilité réelle.
> Cartographier la performance internationale** pour orienter les futurs investissements marketing.
> Segmenter la base client (Fidèles vs Occasionnels) pour aider l'équipe marketing à bâtir des campagnes ciblées.

 
SOURCE DES DONNEES : 
> Source : Jeu de données réel issu de Kaggle (Online Retail Dataset).
> Périmètre :** Transactions mondiales enregistrées entre décembre 2010 et décembre 2011.
> Volume initial : +541 000 lignes brutes.
> Échantillon :** Un aperçu de 100 lignes est disponible dans le dossier `/data` pour illustrer la structure de la table.


Pipeline Technique & Rigueur du Nettoyage (SQL)

Le traitement et le contrôle qualité des données ont été entièrement réalisés sous SQL. 80% du travail a consisté à assainir le dataset pour sécuriser les décisions :


Résultats Clés & Insights Business: 

> Chiffre d'Affaires Net Global :** **9 748 131,07 £** (après déduction stricte des retours).
> Volume de commandes d'achat uniques :** **19 960** (excluant les transactions d'annulations).
> Hégémonie du marché domestique :** Le Royaume-Uni concentre l'essentiel de l'activité, tandis que le Top 5 Europe (Pays-Bas, Allemagne, France...) dessine les relais de croissance.
> Santé de la base client :** Forte dynamique de réachat avec **3 059 clients fidèles** (> 1 commande) contre **1 312 clients ponctuels** (1 seule commande).

Visualisation & Pilotage Interactif (Tableau)
Le tableau de bord interactif a été conçu pour permettre aux managers de piloter l'activité de manière autonome. 

👉 Cliquez sur l'image ci-dessous pour explorer et filtrer le dashboard en temps réel sur Tableau Public 

[![Aperçu du Tableau de Bord](Tableau de bord e-commerce.png)](https://public.tableau.com/views/ecommercetermin/TABLEAUDEBORDSURECOMMERCE?:language=fr-FR&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


Recommandations Stratégiques :

Sur la base de ces résultats, trois actions concrètes sont recommandées :
> Sécurisation des Stocks (Achats) :** Anticiper le pic d'activité majeur constaté au Q4 (août à novembre) en sécurisant les stocks du Top 10 produits dès le Q3 pour éviter les ruptures de stock.
> Campagne de Rétention (Marketing) :** Cibler spécifiquement les 1 312 clients ponctuels avec une offre de relance pour augmenter le taux de réachat.
> Audit des Retours (Supply Chain) :** Investiguer les causes des -275 560 articles retournés (défauts produits ? retards de livraison ?) pour réduire ce manque à gagner.

 Structure du Dépôt: 

> `/data` : Échantillon représentatif (100 lignes) au format CSV.
> `/sql` : Scripts complets et documentés de création de table (`ventes_finales`) et d'extraction des KPI.
> `/visuals` : Fichier source de l'analyse `.twbx` pour Tableau.
