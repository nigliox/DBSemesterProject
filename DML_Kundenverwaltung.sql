USE inventarisierungslösung;

#Kunde hinzufuegen
INSERT INTO kunde (name) VALUES ("Nik");
INSERT INTO kunde (name) VALUES ("Marina");
INSERT INTO kunde (name) VALUES ("Flo");
INSERT INTO kunde (name) VALUES ("Fer");

set @Nik_kunde = (SELECT idKunde FROM kunde WHERE kunde.idKunde = 1);
set @Marina_kunde = (SELECT idKunde FROM kunde WHERE kunde.idKunde = 2);
set @Flo_kunde = (SELECT idKunde FROM kunde WHERE kunde.idKunde = 3);
set @Fer_kunde = (SELECT idKunde FROM kunde WHERE kunde.idKunde = 4);

#Adresse hinzufuegen
INSERT INTO adresse (strasse, hausnummer,plz,ort,land) 
VALUES ("DieseStrasse",13,9430,"St. Margrethen","Schweiz");

INSERT INTO adresse (strasse, hausnummer,plz,ort,land) 
VALUES ("IhreStrasse",99,9000,"St. Gallen","Schweiz");

INSERT INTO adresse (strasse, hausnummer,plz,ort,land) 
VALUES ("SeineStrasse",334,9001,"St. Gallen","Schweiz");

INSERT INTO adresse (strasse, hausnummer,plz,ort,land) 
VALUES ("Strasse",22,9443,"Widnau","Schweiz");

set @AdresseNik = (SELECT idAdresse FROM Adresse INNER JOIN kunde ON adresse.idAdresse = kunde.idKunde WHERE kunde.name = 'Nik');
set @AdresseMarina = (SELECT idAdresse FROM Adresse INNER JOIN kunde ON adresse.idAdresse = kunde.idKunde WHERE kunde.name = 'Marina');
set @AdresseFlo = (SELECT idAdresse FROM Adresse INNER JOIN kunde ON adresse.idAdresse = kunde.idKunde WHERE kunde.name = 'Flo');
set @AdresseFer = (SELECT idAdresse FROM Adresse INNER JOIN kunde ON adresse.idAdresse = kunde.idKunde WHERE kunde.name = 'Fer');

#Adresse zuweisen Kunde
INSERT INTO kunden_adresse (fk_idKunde, fk_idAdresse)
VALUES (@Nik_kunde, @AdresseNik);

INSERT INTO kunden_adresse (fk_idKunde,fk_idAdresse)
VALUES (@marina_kunde, @AdresseMarina);

INSERT INTO kunden_adresse (fk_idKunde,fk_idAdresse)
VALUES (@Flo_kunde, @AdresseFlo);

INSERT INTO kunden_adresse (fk_idKunde,fk_idAdresse)
VALUES (@Fer_kunde, @AdresseFer);



#Platz für POD !!!!

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)

VALUES
('Europa',@nik_kunde,'TestPod','test.ch','8.8.8.8','84.102.99.100');

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)

VALUES
('Europa',@Marina_kunde,'TestPod2','test1.ch','8.8.8.9','84.102.99.101');

SELECT * FROM pod;

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)

VALUES
('Europa',@Flo_kunde,'TestPod3','test3.ch','8.8.8.8','84.102.100.101');


INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)

VALUES
('Europa',@Fer_kunde,'TestPod4','test4.ch','8.8.8.9','84.102.99.101');

# Location hinzufuegen

INSERT INTO location
(locationname,fk_idAdresse,fk_idPod)
VALUES
('Genf',@AdresseNik,1);

INSERT INTO location
(locationname,fk_idAdresse,fk_idPod)
VALUES
('St.Gallen',@AdresseMarina,2);

INSERT INTO location
(locationname,fk_idAdresse,fk_idPod)
VALUES
('Herisau',@AdresseFlo,3);

INSERT INTO location
(locationname,fk_idAdresse,fk_idPod)
VALUES
('Abtiwl',@AdresseFer,4);

SELECT * FROM location;

