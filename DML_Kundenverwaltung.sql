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

#Adresse Lieferant hinzufuegen

INSERT INTO adresse (strasse, hausnummer,plz,ort,land) 
VALUES ("BlindvorWutStrasse",22,9443,"Widnau","Schweiz");


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

#Person hinzufuegen

INSERT INTO Person
(vorname, nachname, mobil, mail)
VALUES
('Fernando','Maniglio','+4178753890','mail@mail.ch');

INSERT INTO Person
(vorname, nachname, mobil, mail)
VALUES
('Marina','Scherrer','+4178753890','mail@mail.ch');

INSERT INTO Person
(vorname, nachname, mobil, mail)
VALUES
('Besnik','Istrefi','+4178753890','mail@mail.ch');

INSERT INTO Person
(vorname, nachname, mobil, mail)
VALUES
('Florian','Gämperli','+4178753890','mail@mail.ch');

# Pod_Kontaktpersonen hinzufuegen

INSERT INTO pod_kontaktperson
(fk_idPoD,fk_idPerson,priority)
VALUES
(1,3,10);

INSERT INTO pod_kontaktperson
(fk_idPoD,fk_idPerson,priority)
VALUES
(2,2,10);

INSERT INTO pod_kontaktperson
(fk_idPoD,fk_idPerson,priority)
VALUES
(3,4,10);

INSERT INTO pod_kontaktperson
(fk_idPoD,fk_idPerson,priority)
VALUES
(4,1,10);

#VLan hinzufuegen

INSERT INTO vlan
(bezeichnung,net_address,subnetmask,standard_gateway,fk_idLocation)
VALUES
('vlan22','172.100.1.2','255.255.0.0','172.100.1.1',1);

INSERT INTO vlan
(bezeichnung,net_address,subnetmask,standard_gateway,fk_idLocation)
VALUES
('vlan24','175.100.1.2','255.250.0.0','175.100.1.1',2);

INSERT INTO vlan
(bezeichnung,net_address,subnetmask,standard_gateway,fk_idLocation)
VALUES
('vlan24','173.100.1.2','255.250.0.0','173.100.1.1',3);

INSERT INTO vlan
(bezeichnung,net_address,subnetmask,standard_gateway,fk_idLocation)
VALUES
('vlan25','178.100.1.2','255.250.0.0','185.100.1.1',4);


# Lieferant hinzufuegen

INSERT INTO lieferant
(name,fk_idAdresse)
VALUES
('Alltron AG',5);

# Hersteller hinzufuegen
INSERT INTO hersteller
(name)
VALUE
('BenQ');

# Lieferant_Hersteller hinzufuegen

INSERT INTO lieferant_hersteller
(fk_idLieferant,fk_idHersteller)
VALUES
(1,1);



