-----------------##################PROJET PORTFOLIO DATA ANALYST >>>ANALYSE DES VENTES ONLINES RETAIL######################--------------------
--#####################################################################################################################

----DESCRIPTION : Une ligne correspond à une référence d'article au sein d'une commande et c'est la colonne Quantity qui détermine la quantité

--------------------------------<<<<<<<<<<<<<<<<<<<<<<<VERIFICATION ID CLIENT>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>------------------------------------
SELECT 
    COUNT(*) AS Total_Lignes,
    COUNT(CustomerID) AS Lignes_Avec_ID,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS Lignes_Sans_ID 
FROM ventes; 
-------réponse : 541909	541909	0

------vérification-----------

SELECT COUNT(*) 
FROM ventes 
WHERE CustomerID = '' OR CustomerID IS NULL;

------réponse :135 080
------sur 541 909 lignes  135 080 lignes sont sans ID CLIENT

-----------------------------------<<<<<<<<<<<<<<<<<<<<VERIFICATION QUANTITE>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------
select *
from ventes
where Quantity < 0;
-- resulat: il y a 10 624 lignes qui ne sont pas des ventes


select *
from  ventes
where InvoiceNo  like  'C%' ;
--resultat  : parmis les 10 624 lignes,  9 288  lignes sont des retours.


select  *
from ventes
where  Quantity < 0 and UnitPrice = 0;
-- Résultat : 1 336 lignes. Ce sont les pertes/ajustements de stock.
-- Constat : Ces 1 336 lignes n'ont pas d'identifiant client (CustomerID = '').

select *
from ventes
where Quantity > 0 and UnitPrice = 0;
-- Résultat : 1 179 > Ce sont certainement des cadeaux / opérations promotionnelles.


SELECT InvoiceNo, StockCode, Description, Quantity, InvoiceDate, CustomerID, COUNT(*)
FROM ventes
GROUP BY InvoiceNo, StockCode, Description, Quantity, InvoiceDate, CustomerID
HAVING COUNT(*) > 1;
--resulat 4991  groupe de lignes qui sont des copies conformes.

SELECT COUNT(*)
FROM (SELECT DISTINCT * FROM ventes);

--resultat : 536 641


SELECT COUNT(*) 
FROM ventes
WHERE UnitPrice > 0;

-- résultat : 539 392
------------------------------------------------<<<<<<<<<<<<<<<VENTES>>>>>>>>>>>>>>>>>>>>>>>----------------------

select COUNT(DISTINCT CustomerID) 
from ventes;
--réponse : 4373
--j'ai dénombré 4 373 clients uniques via la commande COUNT(DISTINCT). 
--Cependant, mon analyse approfondie a révélé que 135 080 lignes contenaient des chaînes de caractères vides ('') pour l'ID Client.
-- SQL comptant ce groupe 'NULL' comme une entité unique, 
--j'ai corrigé le tir pour identifier le nombre réel de clients actifs, qui est de 4 372."

---vérification-------
select COUNT(DISTINCT CustomerID) 
from ventes
WHERE CustomerID = '' OR CustomerID IS NULL;
--résultat : 1 donc par conséquent le nombre de client est de 4 372.


----------------------------------------------------<<<<<<<<<<CREATION TABLE>>>>>>>>>>>>>>>--------------------------------------------
CREATE TABLE ventes_propre AS
SELECT * FROM ventes
WHERE UnitPrice > 0;


select count(*)
from  (select distinct InvoiceNo,StockCode ,Description,Quantity ,InvoiceDate,UnitPrice, CustomerID,Country    
from ventes_propre ) as sous_requete ;
-- resultat  534 129
----------------------------------------------------<<<<<<<<<<<<<<<<QUANTITE>>>>>>>>>>>>>>>>>>>>>----------------------------------

--QUESTION 1: Quel est le volume total d'articles vendus ?


select sum (Quantity)
from ventes_propre
where Quantity > 0;
--resultat : 5 588 376 Volume des ventes brutes, sans les retours

select sum (Quantity)
from ventes_propre; 
--resultat :5 310 802 Volume net global, après déduction des retours


--le nombre de retour
SELECT ABS(SUM(Quantity)) AS total_articles_retournes
FROM ventes_propre
WHERE Quantity < 0;
--Resultat : 277 574 articles retourné 




--QUESTION 2: Quel est le chiffre d'affaire total ?

-- Chiffre d'Affaires Brut (Uniquement les ventes)
SELECT SUM(Quantity * UnitPrice) AS ca_brut
FROM ventes_propre
WHERE Quantity > 0;
-- Résultat : 10 666 684,54 £

-- Chiffre d'Affaires Net (Ventes moins la valeur des retours)
SELECT SUM(Quantity * UnitPrice) AS ca_net
FROM ventes_propre;
-- Résultat : 9 769 872,05 £

-- CONCLUSION ANALYTIQUE :
-- L'impact financier des retours s'élève à 896 812,49 £, ce qui pèse lourdement sur la performance globale.

-------------------------------CREATION TABLE PROPRE SANS DOUBLON-------------------------------

CREATE TABLE ventes_finales AS
SELECT DISTINCT InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country    
FROM ventes_propre;

----vérification 
SELECT 
    COUNT(*) AS total_lignes,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS nb_lignes_null,
    SUM(CASE WHEN CustomerID = '' THEN 1 ELSE 0 END) AS nb_lignes_vides
FROM ventes_finales;
-- résulat : 534129	0	132565

----------------------------------######################################---------------------------
select *
from ventes_finales; 
---résulat : 534 129 lignes

--Quel est le volume d'articles vendus ? 

select  sum (Quantity)
from ventes_finales
WHERE Quantity > 0;
-- réponse : 5 572 420  articles  expédiés sans retour.

select  sum (Quantity)
from ventes_finales;
--réponse : 5 296 860 articles vendus 



--Quel est le volume de retour global de l'entreprise ?

select sum (Quantity)
from ventes_finales
where InvoiceNo LIKE 'C%';
--réponse : - 275 560 articles retournés



--------------quel est le chiffre d'affaire ?

select sum (Quantity *  UnitPrice)
from ventes_finales;
--resultat : 9 748 131.074 £ CA sans doublons 

------------ quel est le chiffre United Kingdom ?

SELECT SUM(Quantity * UnitPrice) 
FROM ventes_finales 
WHERE Country = 'United Kingdom';
--resulat : 8 189 252.304

----------------quel est le nombre de commande ?
SELECT COUNT(DISTINCT InvoiceNo) AS nb_commandes_uniques
FROM ventes_finales;

--résultat : 23 796 COMMANDES


----------------Nombre réel de commandes d'achat unique

SELECT COUNT(DISTINCT InvoiceNo) AS nb_commandes_achats
FROM ventes_finales 
WHERE InvoiceNo NOT LIKE 'C%';
-- réponse : 19960


------------------Combien de client fidèle ?
SELECT CustomerID,
       COUNT(DISTINCT InvoiceNo) AS nb_commandes
FROM ventes_finales
WHERE CustomerID != ''
GROUP BY CustomerID
HAVING nb_commandes > 1;

--réponse : 3 059 clients fidèles


--------------------combien de client non fidèle ?
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS nb_commandes
FROM ventes_finales
WHERE CustomerID != ''
GROUP BY CustomerID
HAVING nb_commandes = 1;

--réponse : 1312 clients non fidèles



---------------Quel est le nombre de client ?
select COUNT(DISTINCT CustomerID) 
from ventes_finales
WHERE CustomerID != '';
--réponse : 4 371

----------------- Classement des clients par CA décroissant (hors ID vide)
select CustomerID ,
    sum (Quantity *UnitPrice) AS CA,
    count (distinct InvoiceNo) as nb_commande
from ventes_pfinales
where CustomerID !=''
group by CustomerID
order by CA desc; 



-------------Nombre de pays
select  COUNTRY 
from ventes_finales
GROUP BY country;
--resultat : 38  

--------Top 5 pays 

select country ,sum( Quantity * UnitPrice)  as CA
from ventes_finales
where country != 'United Kingdom'
GROUP BY country
order by CA  desc 
limit 5;   
----résultat : 
--Netherlands	284661.54
--EIRE	262993.38
--Germany	221509.47
--France	197317.11
--Australia	137009.77




------ Panier moyen = CA net (retours inclus) / nombre de commandes d'achat réelles (hors factures C%)

select round (sum (Quantity*UnitPrice) /(count(distinct( case when InvoiceNo not like 'C%' then InvoiceNo END ))))
from ventes_finales; 

-- Résultat : le panier moyen est de  488£



---TOP 10 des articles les plus rentables


SELECT 
    StockCode, 
    MAX(Description)as Description, 
    SUM(Quantity) AS total_quantite, 
    SUM(Quantity * UnitPrice) AS total_par_article
FROM ventes_finales
WHERE StockCode NOT GLOB '[A-Za-z]*'
GROUP BY StockCode
ORDER BY total_par_article DESC
LIMIT 10;


----Vérification anomalie : la ref 85123A a deux noms différents


SELECT stockcode, description, sum (quantity * unitPrice) as CA_calculé
from ventes_finales
where stockcode = '85123A'
group by stockcode , description;
--résulat : 85123A	WHITE HANGING HEART T-LIGHT HOLDER	97838.45

select stockcode, description, (count (quantity))
from ventes_finales
where stockcode = '85123A' 
group by stockcode , description;
--resultat 85123A	CREAM HANGING HEART T-LIGHT HOLDER	9
--85123A	WHITE HANGING HEART T-LIGHT HOLDER	2286
--la ref 85123A a deux noms différents ce qui fausse le résultat



---Top  5 pays des CA les plus élévés
select country, sum (quantity * unitprice) as CA
from ventes_finales
where country !='United Kingdom'
group by country
order by CA desc
limit 5 ;


----Tendance mensuelle

SELECT 
    strftime('%Y-%m', InvoiceDate) AS mois,
    count (DISTINCT (invoiceNo)) as nombre_de_commande 
FROM ventes_finales
GROUP BY mois
ORDER BY mois ASC;
