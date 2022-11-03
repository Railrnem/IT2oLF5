/* Auswahl aller Zutaten eines Rezeptes nach Rezeptname */
SELECT r.REZEPTNAME, z.BEZEICHNUNG, rz.MENGE 
FROM krautundrueben.ZUTAT       AS z
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON z.ZUTATENNR = rz.ZUTATENNR
INNER JOIN krautundrueben.REZEPT      AS r  ON rz.REZEPTNR = r.REZEPTNR
WHERE r.REZEPTNAME = 'Kartoffelsuppe Vegan';

/* Auswahl aller Rezepte einer bestimmten Ernährungskategorie */
SELECT * FROM krautundrueben.REZEPT 
WHERE Ernaehrungskategorien = 'Vegan';

/* Auswahl aller Rezepte, die eine gewisse Zutat enthalten */
SELECT r.REZEPTNR, r.REZEPTNAME, r.Ernaehrungskategorien, r.Unvertraeglichkeiten FROM krautundrueben.REZEPT AS r
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON r.REZEPTNR = rz.REZEPTNR
INNER JOIN krautundrueben.ZUTAT AS z ON rz.ZUTATENNR = z.ZUTATENNR
WHERE z.BEZEICHNUNG = 'Tomate'; 

/* Berechnung der durchschnittlichen Nährwerte aller Bestellungen eines Kunden */
SELECT avg(KALORIEN),avg(KOHLENHYDRATE),avg(PROTEIN) FROM krautundrueben.ZUTAT AS z
INNER JOIN krautundrueben.BESTELLUNGZUTAT AS bz ON bz.ZUTATENNR = z.ZUTATENNR
INNER JOIN krautundrueben.BESTELLUNG AS b ON bz.BESTELLNR = b.BESTELLNR
INNER JOIN krautundrueben.KUNDE AS k ON k.KUNDENNR = b.KUNDENNR
WHERE k.NACHNAME = "Maurer";    

/* Auswahl aller Zutaten, die bisher keinem Rezept zugeordnet sind */
SELECT * FROM krautundrueben.ZUTAT AS z
WHERE z.ZUTATENNR NOT IN (SELECT ZUTATENNR FROM krautundrueben.REZEPTZUTAT);

/* Auswahl aller Rezepte, die eine bestimmte Kalorienmenge nicht überschreiten */
SELECT r.REZEPTNR, r.REZEPTNAME, r.Ernaehrungskategorien, r.Unvertraeglichkeiten, sum(z.KALORIEN) FROM krautundrueben.REZEPT AS r
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON r.REZEPTNR = rz.REZEPTNR
INNER JOIN krautundrueben.ZUTAT AS z ON rz.ZUTATENNR = z.ZUTATENNR
GROUP BY r.REZEPTNAME
HAVING sum(z.KALORIEN) <= 500;

/* Auswahl aller Rezepte, die weniger als fünf Zutaten enthalten */
SELECT rz.REZEPTNR, r.REZEPTNAME, r.Ernaehrungskategorien, r.Unvertraeglichkeiten, sum(rz.MENGE)  FROM krautundrueben.REZEPT AS r
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON r.REZEPTNR = rz.REZEPTNR
GROUP BY rz.REZEPTNR
HAVING sum(rz.MENGE) < 7;


/* Auswahl aller Rezepte, die weniger als fünf Zutaten enthalten und eine bestimmte Ernährungskategorie erfüllen */
SELECT rz.REZEPTNR, r.REZEPTNAME, r.Ernaehrungskategorien, r.Unvertraeglichkeiten, sum(rz.MENGE)  FROM krautundrueben.REZEPT AS r
INNER JOIN krautundrueben.REZEPTZUTAT AS rz ON r.REZEPTNR = rz.REZEPTNR
GROUP BY rz.REZEPTNR
HAVING sum(rz.MENGE) < 7 AND r.Ernaehrungskategorien = 'Vegan';
