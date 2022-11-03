/* Auswahl aller Zutaten eines Rezeptes nach Rezeptname */
SELECT r.REZEPTNAME, z.BEZEICHNUNG, rz.MENGE 
FROM krautundrueben.ZUTAT       AS z
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON z.ZUTATENID = rz.ZUTATENID
INNER JOIN krautundrueben.REZEPT      AS r  ON rz.REZEPTID = r.REZEPTID
WHERE r.REZEPTNAME = 'Kartoffelsuppe Vegan';

/* Auswahl aller Rezepte einer bestimmten Ernährungskategorie */
SELECT * FROM krautundrueben.REZEPT AS r
INNER JOIN ERNAERUNGREZEPT AS er ON r.REZEPTID = er.REZEPTID
INNER JOIN ERNAEHRUNGSKATEGORIEN AS e ON e.ERNAEHRUNGSID = er.ERNAEHRUNGSID
WHERE e.BEZEICHNUNG = 'Vegan';

/* Auswahl aller Rezepte, die eine gewisse Zutat enthalten */
SELECT r.REZEPTID, r.REZEPTNAME FROM krautundrueben.REZEPT AS r
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON r.REZEPTID = rz.REZEPTID
INNER JOIN krautundrueben.ZUTAT AS z ON rz.ZUTATENID = z.ZUTATENID
WHERE z.BEZEICHNUNG = 'Tomate'; 

/* Berechnung der durchschnittlichen Nährwerte aller Bestellungen eines Kunden */
SELECT avg(KALORIEN),avg(KOHLENHYDRATE),avg(PROTEIN) FROM krautundrueben.ZUTAT AS z
INNER JOIN krautundrueben.BESTELLUNGZUTAT AS bz ON bz.ZUTATENID = z.ZUTATENID
INNER JOIN krautundrueben.BESTELLUNG AS b ON bz.BESTELLID = b.BESTELLID
INNER JOIN krautundrueben.KUNDE AS k ON k.KUNDENID = b.KUNDENID
WHERE k.NACHNAME = "Maurer";    

/* Auswahl aller Zutaten, die bisher keinem Rezept zugeordnet sind */
SELECT * FROM krautundrueben.ZUTAT AS z
WHERE z.ZUTATENID NOT IN (SELECT ZUTATENID FROM krautundrueben.REZEPTZUTAT);

/* Auswahl aller Rezepte, die eine bestimmte Kalorienmenge nicht überschreiten */
SELECT r.REZEPTID, r.REZEPTNAME, sum(z.KALORIEN) FROM krautundrueben.REZEPT AS r
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON r.REZEPTID = rz.REZEPTID
INNER JOIN krautundrueben.ZUTAT AS z ON rz.ZUTATENID = z.ZUTATENID
GROUP BY r.REZEPTNAME
HAVING sum(z.KALORIEN) <= 500;

/* Auswahl aller Rezepte, die weniger als fünf Zutaten enthalten */
SELECT rz.REZEPTID, r.REZEPTNAME, sum(rz.MENGE)  FROM krautundrueben.REZEPT AS r
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON r.REZEPTID = rz.REZEPTID
GROUP BY rz.REZEPTID
HAVING sum(rz.MENGE) < 7;

/* Auswahl aller Rezepte, die weniger als fünf Zutaten enthalten und eine bestimmte Ernährungskategorie erfüllen */
SELECT rz.REZEPTID, r.REZEPTNAME, e.BEZEICHNUNG, sum(rz.MENGE)  FROM krautundrueben.REZEPT AS r
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON r.REZEPTID = rz.REZEPTID
INNER JOIN ERNAERUNGREZEPT AS er ON r.REZEPTID = er.REZEPTID
INNER JOIN ERNAEHRUNGSKATEGORIEN AS e ON e.ERNAEHRUNGSID = er.ERNAEHRUNGSID
GROUP BY rz.REZEPTID
HAVING sum(rz.MENGE) < 15 AND e.BEZEICHNUNG = 'Vegan';
