USE inventarisierungslösung;

#LokaleSets Kunde

set @nik = (SELECT idKunde FROM kunde WHERE kunde.name = 'Nik');
set @marina = (SELECT idKunde FROM kunde WHERE kunde.name = 'Marina');
set @Flo = (SELECT idKunde FROM kunde WHERE kunde.name = 'Flo');
set @Fer = (SELECT idKunde FROM kunde WHERE kunde.name = 'Fer');

#LokaleSets Adresse
set @AdresseNik = (SELECT idAdresse FROM Adresse INNER JOIN kunde ON adresse.idAdresse = kunde.idKunde WHERE kunde.name = 'Nik');
set @AdresseMarina = (SELECT idAdresse FROM Adresse INNER JOIN kunde ON adresse.idAdresse = kunde.idKunde WHERE kunde.name = 'Marina');
set @AdresseFlo = (SELECT idAdresse FROM Adresse INNER JOIN kunde ON adresse.idAdresse = kunde.idKunde WHERE kunde.name = 'Flo');
set @AdresseFer = (SELECT idAdresse FROM Adresse INNER JOIN kunde ON adresse.idAdresse = kunde.idKunde WHERE kunde.name = 'Fer');



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

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)

VALUES
('Europa',@Flo,'TestPod3','test3.ch','8.8.8.8','84.102.100.101');

SELECT * FROM pod;

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)

VALUES
('Europa',@Fer,'TestPod4','test4.ch','8.8.8.9','84.102.99.101');



#Location hinzufuegen

