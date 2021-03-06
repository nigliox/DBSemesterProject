USE inventarisierungslösung;

#Kunde hinzufuegen
INSERT INTO kunde (name) VALUES ("Nik");
INSERT INTO kunde (name, maxbetrag) VALUES ("Marina",5000);
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


#PoD hinzufuegen

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)
VALUES
('Europa',@nik_kunde,'TestPod','test.ch','8.8.8.8','84.102.99.100');

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)
VALUES
('Europa',@Marina_kunde,'TestPod2','test1.ch','8.8.8.9','84.102.99.101');

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)
VALUES
('Europa',@Flo_kunde,'TestPod3','test3.ch','8.8.8.8','84.102.100.101');


INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)
VALUES
('Europa',@Fer_kunde,'TestPod4','test4.ch','8.8.8.9','84.102.99.101');

INSERT INTO pod
(timezone, fk_idKunde,name,domain,nameserver,sntpAddress)
VALUES
('Europa',@Marina_kunde,'TestPod5','test5.ch','8.8.8.9','84.102.99.101');

# Location hinzufuegen

INSERT INTO location
(locationname,fk_idAdresse,fk_idPod)
VALUES
('NikGmbH',@AdresseNik,1);

INSERT INTO location
(locationname,fk_idAdresse,fk_idPod)
VALUES
('MarinaGmbh',@AdresseMarina,2);

INSERT INTO location
(locationname,fk_idAdresse,fk_idPod)
VALUES
('FloGmbh',@AdresseFlo,3);

INSERT INTO location
(locationname,fk_idAdresse,fk_idPod)
VALUES
('FerGmbh',@AdresseFer,4);

INSERT INTO location
(locationname,fk_idAdresse,fk_idPod)
VALUES
('Wil',@AdresseMarina,5);


#Device Typ
INSERT INTO Device_Typ (devicetype, beschreibung,anzahlPorts, isVirtual, fk_idLieferant, preis) 
VALUE ('Router', 'WLAN-Router Xtra Fast', 5, 0, 1, 199);

INSERT INTO Device_Typ (devicetype, beschreibung,anzahlPorts, isVirtual, fk_idLieferant, preis) 
VALUE ('Router', 'WLAN-Router Netgear', 5, 0, 1, 129);

INSERT INTO Device_Typ (devicetype, beschreibung,anzahlPorts, isVirtual, fk_idLieferant, preis) 
VALUE ('Router', 'WLAN-Router Cisco', 5, 0, 1, 199);

INSERT INTO Device_Typ (devicetype, beschreibung,anzahlPorts, isVirtual, fk_idLieferant, preis) 
VALUE ('Switch', 'Switch 8 Ports',8, 0, 1, 99);

INSERT INTO Device_Typ (devicetype, beschreibung,anzahlPorts, isVirtual, fk_idLieferant, preis) 
VALUE ('Switch', 'Switch 10 Ports',10, 0, 1, 109);

INSERT INTO Device_Typ (devicetype, beschreibung,anzahlPorts, isVirtual, fk_idLieferant, preis) 
VALUE ('Switch', 'Switch 52 Ports',52, 0, 1, 799);

#Device
INSERT INTO device (fk_idLocation, serienummer,hostname,fk_idDeviceType,isActive)
VALUES (1,"DFDSKSKGF","xtraFast",1,1);

INSERT INTO device (fk_idLocation, serienummer,hostname,fk_idDeviceType,isActive)
VALUES (1,"77889999s","newSwitch",4,1);

INSERT INTO device (fk_idLocation, serienummer,hostname,fk_idDeviceType,isActive)
VALUES (2,"7899s","router",1,1);

INSERT INTO device (fk_idLocation, serienummer,hostname,fk_idDeviceType,isActive)
VALUES (2,"778833399s","newSwi",4,1);

INSERT INTO device (fk_idLocation, serienummer,hostname,fk_idDeviceType,isActive)
VALUES (3,"99109s","help",4,1);

INSERT INTO device (fk_idLocation, serienummer,hostname,fk_idDeviceType,isActive)
VALUES (3,"1111s","default",5,1);


INSERT INTO device (fk_idLocation, serienummer,hostname,fk_idDeviceType,isActive)
VALUES (4,"2222s","BigSwitch",6,1);



#Netzwerkinterface hinzufuegen

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH1',1,1,2,'4h:89:78:98','1000','Lan',1);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH2',1,1,2,'4h:89:78:98','1000','Lan',2);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH3',1,1,2,'4h:89:78:98','1000','Lan',3);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH1',2,1,2,'4h:89:78:98','1000','Lan',1);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH2',2,1,2,'4h:89:78:98','1000','Lan',2);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH3',2,1,2,'4h:89:78:98','1000','Lan',3);


INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH4',2,1,2,'4h:89:78:98','1000','Lan',4);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH1',3,1,2,'4h:89:78:98','1000','Lan',1);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH4',3,1,2,'4h:89:78:98','1000','Lan',1);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH1',4,1,2,'4h:89:78:98','1000','Lan',1);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH2',4,1,2,'4h:89:78:98','1000','Lan',2);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH1',5,2,2,'4h:89:88:98','1000','Lan',1);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH2',5,2,2,'4h:89:88:98','1000','Lan',2);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH3',5,2,2,'4h:89:88:98','1000','Lan',3);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH4',5,2,2,'4h:89:88:98','1000','Lan',4);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH5',5,2,2,'4h:89:88:98','1000','Lan',5);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH6',5,2,2,'4h:89:88:98','1000','Lan',6);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH7',5,2,2,'4h:89:88:98','1000','Lan',7);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH8',5,2,2,'4h:89:88:98','1000','Lan',8);


INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH1',7,2,2,'4h:89:88:98','1000','Lan',1);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH2',7,2,2,'4h:89:88:98','1000','Lan',2);

INSERT INTO netzwerkinterface
(interfaceName, fk_idDevice, isFullDuplex,isVirtual,physicalAdressMac,bandwithMbit,medium, portNr)
VALUES
('ETH3',7,2,2,'4h:89:88:98','1000','Lan',3);

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

#SNMP Community hinzufuegen

INSERT INTO snmp_community
(name) VALUE ('DBCommunity');

#Administrative Credentials hinzufuegen

INSERT INTO administrative_credentials
(benutzer,passwort)
VALUES 
('admin','Hallo2018!!');

#Admin_Cred_SNMP hinzufuegen
INSERT INTO admin_cred_snmp
(fk_admin_cred,fk_snmp)
VALUES
(1,1);

#Netzwerkinterface_vlan hinzufuegen Hilfstabell

INSERT INTO netzwerkinterface_vlan
(fk_idNetzwerkinterface,fk_idVlan)
VALUES
(1,1);

# Device_Admin hinzufuegen Hilfstabell

INSERT INTO device_admin
(fk_idDevice,fk_idAdmin_Cred_SNMP)
VALUES
(1,1);


#Rechnung hinzufügen

INSERT INTO Rechnung (referenz, fk_idPOD, fk_idAdresse, rechnungsdatum)
VALUES ("Ersatz Infrastruktur", 1, @AdresseNik, '2018-08-01');

INSERT INTO Rechnung (referenz, fk_idPOD, fk_idAdresse, rechnungsdatum)
VALUES ("Ersatz Infrastruktur", 2, @AdresseMarina, '2018-08-02');

INSERT INTO Rechnung (referenz, fk_idPOD, fk_idAdresse, rechnungsdatum)
VALUES ("Ersatz Infrastruktur", 3, @AdresseFlo, '2018-08-03');


#Rechnungspositionen hinzufügen
INSERT INTO Rechnungsposition(beschreibung, preis, fk_idNetzwerkinterface, fk_idDevice, fk_idLocation)
VALUES ('Ersatzgerät', 3000, 1, 1,1);

INSERT INTO Rechnungsposition(beschreibung, preis, fk_idNetzwerkinterface, fk_idDevice, fk_idLocation)
VALUES ('Rückgabe Ersatzgerät', 2000, 1, 1,1);

INSERT INTO Rechnungsposition(beschreibung, preis, fk_idNetzwerkinterface, fk_idDevice, fk_idLocation)
VALUES ('Neues Gerät', 1500, 1, 1,1);

INSERT INTO Rechnungsposition(beschreibung, preis, fk_idNetzwerkinterface, fk_idDevice, fk_idLocation)
VALUES ('Ersatzgerät', 1000, 2, 2,2);

INSERT INTO Rechnungsposition(beschreibung, preis, fk_idNetzwerkinterface, fk_idDevice, fk_idLocation)
VALUES ('Rückgabe Ersatzgerät', 1500, 2, 2,2);

INSERT INTO Rechnungsposition(fk_idRechnung, beschreibung, preis, fk_idLocation)
VALUES (2, 'Dienstleistung', 1000,2);

INSERT INTO Rechnungsposition(fk_idRechnung, beschreibung, preis, fk_idLocation)
VALUES (3, 'Dienstleistung', 2000,3);

#Zahlung hinzufügen

INSERT INTO zahlung (fk_idkunde, betrag, zahlungsdatum)
VALUES (@Nik_kunde, 1000, '2018-09-01');

INSERT INTO zahlung (fk_idkunde, betrag, zahlungsdatum)
VALUES (@marina_kunde, 2000, '2018-09-02');

INSERT INTO zahlung (fk_idkunde, betrag, zahlungsdatum)
VALUES (@Flo_kunde, 3000, '2018-09-03');


#Zahlung mit Rechnung verbinden
INSERT INTO Rechnung_Zahlung (fk_idZahlung, fk_idRechnung)
VALUES (1,1);

INSERT INTO Rechnung_Zahlung (fk_idZahlung, fk_idRechnung)
VALUES (2,2);

INSERT INTO Rechnung_Zahlung (fk_idZahlung, fk_idRechnung)
VALUES (3,3);




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

# Log hinzufuegen

INSERT INTO log
(logMsg, severity,LoggingTime,checked,zeit,fk_idDevice)
VALUES
('Error: Wrong Credentials',1,timestamp(now()),0,TIME(now()),1);

INSERT INTO log
(logMsg, severity,LoggingTime,checked,zeit,fk_idDevice)
VALUES
('Error: PowerSupply',1,timestamp(now()),0,TIME(now()),2);

INSERT INTO log
(logMsg, severity,LoggingTime,checked,zeit,fk_idDevice)
VALUES
('Error: Hirn Defekt',1,timestamp(now()),0,TIME(now()),3);

INSERT INTO log
(logMsg, severity,LoggingTime,checked,zeit,fk_idDevice)
VALUES
('Error: Update ',1,timestamp(now()),1,TIME(now()),3);
