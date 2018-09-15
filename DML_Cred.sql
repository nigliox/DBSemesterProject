USE inventarisierungslösung;
set @nik = (SELECT idKunde FROM kunde WHERE kunde.name = 'Nik');
set @marina = (SELECT idKunde FROM kunde WHERE kunde.name = 'Marina');
set @Flo = (SELECT idKunde FROM kunde WHERE kunde.name = 'Flo');
set @Fer = (SELECT idKunde FROM kunde WHERE kunde.name = 'Fer');



#Kunde hinzufuegen
INSERT INTO kunde (name) VALUES ( "Nik");
INSERT INTO kunde (name) VALUES ( "Marina" );
INSERT INTO kunde (name) VALUES ( "Flo");
INSERT INTO kunde (name) VALUES ( "Fer");

#Adresse hinzufuegen
INSERT INTO adresse (strasse, hausnummer,plz,ort,land) 
VALUES ("DieseStrasse",13,9430,"St. Margrethen","Schweiz");

INSERT INTO adresse (strasse, hausnummer,plz,ort,land) 
VALUES ("IhreStrasse",99,9000,"St. Gallen","Schweiz");

INSERT INTO adresse (strasse, hausnummer,plz,ort,land) 
VALUES ("SeineStrasse",334,9001,"St. Gallen","Schweiz");

INSERT INTO adresse (strasse, hausnummer,plz,ort,land) 
VALUES ("Strasse",22,9443,"Widnau","Schweiz");

#Adresse zuweisen Kunde

INSERT INTO kunden_adresse (fk_idKunde,fk_idAdresse)
VALUES ((SELECT idKunde FROM kunde WHERE kunde.name = @kunde), (SELECT idAdresse FROM adresse WHERE idAdresse = 1));

INSERT INTO kunden_adresse (fk_idKunde,fk_idAdresse)
VALUES ((SELECT idKunde FROM kunde WHERE kunde.name = 'Marina'), (SELECT idAdresse FROM adresse WHERE idAdresse = 2));

INSERT INTO kunden_adresse (fk_idKunde,fk_idAdresse)
VALUES ((SELECT idKunde FROM kunde WHERE kunde.name = 'Flo'), (SELECT idAdresse FROM adresse WHERE idAdresse = 3));

INSERT INTO kunden_adresse (fk_idKunde,fk_idAdresse)
VALUES ((SELECT idKunde FROM kunde WHERE kunde.name = 'Fer'), (SELECT idAdresse FROM adresse WHERE idAdresse = 4));

SELECT * FROM kunden_adresse;
#POD hinzuefuegen

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)

VALUES
('Europa',@nik,'TestPod','test.ch','8.8.8.8','84.102.99.100');

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)

VALUES
('Europa',@Marina,'TestPod2','test1.ch','8.8.8.9','84.102.99.101');

SELECT * FROM pod;