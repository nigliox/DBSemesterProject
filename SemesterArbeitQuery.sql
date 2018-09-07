CREATE DATABASE IF NOT EXISTS Inventarisierungslösung;

USE Inventarisierungslösung;

CREATE TABLE Kunde
(
	idKunde INT AUTO_INCREMENT
    ,name VARCHAR(45) NOT NULL
    ,PRIMARY KEY (idKunde)
);

CREATE TABLE Adresse 
(
	idAdresse INT NOT NULL AUTO_INCREMENT
    ,strasse VARCHAR(45)
    ,hausnummer VARCHAR(45)
    ,plz VARCHAR(45)
    ,ort VARCHAR(45)
    ,land VARCHAR(45)
    ,PRIMARY KEY (idAdresse)
    
);

CREATE TABLE Kunden_Adresse
(
	fk_idKunde INT NOT NULL
    ,fk_idAdresse INT NOT NULL
    ,FOREIGN KEY (fk_idKunde)
		REFERENCES Kunde (idKunde)
        ON UPDATE CASCADE
    ,FOREIGN KEY (fk_idAdresse)
		REFERENCES Adresse (idAdresse)
        ON UPDATE CASCADE
);

CREATE TABLE PoD
(
	idPOD INT NOT NULL auto_increment
    ,timezone VARCHAR(45)
    ,fk_idKunde INT NOT NULL
    ,name VARCHAR(45)
    ,domain VARCHAR(45)
    ,nameserver VARCHAR(45)
    ,sntpAddress VARCHAR(45)
    ,PRIMARY KEY(idPOD)
    ,FOREIGN KEY (fk_idKunde)
    REFERENCES Kunde (idKunde)
    ON UPDATE CASCADE
);

CREATE TABLE Location
(
	idLocation INT NOT NULL AUTO_INCREMENT
    ,locationName VARCHAR(45)
    ,fk_idAdresse INT NOT NULL
    ,fk_idPOD INT NOT NULL
    ,PRIMARY KEY (idLocation)
    ,FOREIGN KEY (fk_idAdresse)
    REFERENCES Adresse (idAdresse)
    ON UPDATE CASCADE
    ,FOREIGN KEY (fk_idPOD)
    REFERENCES PoD (idPOD)
    ON UPDATE CASCADE
);

CREATE TABLE Hersteller 
(
	idHersteller INT NOT NULL AUTO_INCREMENT 
    ,name VARCHAR(45)
    ,PRIMARY KEY (idHersteller)
);

CREATE TABLE Device_Typ
(
	idDevice_Typ INT NOT NULL AUTO_INCREMENT
    ,fk_idLieferant INT NOT NULL
    ,deviceType VARCHAR(45)
    ,deviceDescription VARCHAR(45)
    ,isVirtual TINYINT(4)
    ,price DECIMAL
    ,PRIMARY KEY (idDevice_Typ)
    ,FOREIGN KEY (fk_idLieferant)
    REFERENCES Lieferant (idLieferant)
    ON UPDATE CASCADE
);

CREATE TABLE Device
( 
	idDevice INT NOT NULL AUTO_INCREMENT
    ,fk_idLocation INT NOT NULL
    ,fk_idDeviceType INT NOT NULL
    ,serienummer VARCHAR(45)
    ,hostname VARCHAR(45)
    ,isActive TINYINT(4)
    ,PRIMARY KEY (idDevice)
    ,FOREIGN KEY(fk_idLocation)
    REFERENCES Location (idLocation)
    ON UPDATE CASCADE
    ,FOREIGN KEY (fk_idDeviceType)
    REFERENCES Device_Typ (idDevice_Typ)
    ON UPDATE CASCADE
);

CREATE TABLE Log
(
	idLog INT NOT NULL AUTO_INCREMENT
	,fk_idDevice INT NOT NULL
    ,logMsg VARCHAR(45)
    ,severity TINYINT(4)
    ,loggingTime DATETIME
    ,checked TINYINT(4)
    ,zeit TIMESTAMP(1)
    ,LogCol VARCHAR(45)
	,PRIMARY KEY (idLog)
    ,FOREIGN KEY (fk_idDevice)
    REFERENCES Device (idDevice)
    ON UPDATE CASCADE
);

CREATE TABLE Administrative_Credentials
(
	idAdministrative_Credentials INT NOT NULL AUTO_INCREMENT
    ,benutzer VARCHAR(45)
    ,passwort VARCHAR(45)
    ,PRIMARY KEY (idAdministrative_Credentials)
    
);

CREATE TABLE Zahlung
(
	idZahlung INT AUTO_INCREMENT
    ,fk_idKunde INT NOT NULL
    ,betrag DECIMAL(4,0) NOT NULL
    ,zahlungsdatum DATE NOT NULL
    ,PRIMARY KEY (idZahlung)
    ,FOREIGN KEY (fk_idKunde)
		REFERENCES Kunde (idKunde)
        ON UPDATE CASCADE
);

CREATE TABLE Person
(
	idPerson INT NOT NULL AUTO_INCREMENT
    ,vorname VARCHAR(45)
    ,nachname VARCHAR(45)
    ,mobil VARCHAR(45)
    ,mail VARCHAR(45)
    ,PRIMARY KEY (idPerson)
);

CREATE TABLE PoD_Kontaktperson
(
	fk_idPoD_Kontaktperson INT NOT NULL
    ,fk_idPerson INT NOT NULL
    ,priority TINYINT(4)
    ,FOREIGN KEY (fk_idPod_Kontaktperson)
    REFERENCES POD (idPOD)
    ON UPDATE CASCADE
    ,FOREIGN KEY (fk_idPerson)
    REFERENCES Person (idPerson)
    ON UPDATE CASCADE
);

CREATE TABLE VLan
( 
	idVLan INT NOT NULL AUTO_INCREMENT
    ,locationName VARCHAR(45)
    ,fk_idAddress INT NOT NULL
    ,fk_idPOD INT NOT NULL
    ,PRIMARY KEY (idVLan)
    ,FOREIGN KEY (fk_idAddress)
    REFERENCES Adresse (idAdresse)
    ON UPDATE CASCADE
    ,FOREIGN KEY (fk_idPOD)
    REFERENCES POD (idPOD)
    ON UPDATE CASCADE
);

CREATE TABLE Netzwerkinterface 
(
	idNetzwerkinterface INT NOT NULL AUTO_INCREMENT
    ,fk_idDevice INT NOT NULL
    ,interfaceName VARCHAR(45)
    ,isFullDuplex TINYINT(4)
    ,isVirtual TINYINT(4)
    ,physicalAdressMac VARCHAR(45)
    ,bandwithMbit INT
    ,medium VARCHAR(45)
    ,portNr INT
    ,PRIMARY KEY (idNetzwerkinterface)
    ,FOREIGN KEY (fk_idDevice)
    REFERENCES Device (idDevice)
    ON UPDATE CASCADE
    
);

CREATE TABLE Netzwerkinterface_vlan
(	
	fk_idNetzwerkinterface INT NOT NULL
    ,fk_idVLan INT NOT NULL
    ,FOREIGN KEY (fk_idNetzwerkinterface)
    REFERENCES Netzwerkinterface (idNetzwerkinterface)
    ON UPDATE CASCADE
    ,FOREIGN KEY (fk_idVLan)
    REFERENCES VLan (idVLan)
    ON UPDATE CASCADE
    
);

CREATE TABLE SNMP_Comunity
(
	idSNMP_Comunity INT NOT NULL AUTO_INCREMENT
    ,name VARCHAR(45)
    ,PRIMARY KEY (idSNMP_Comunity)
);

CREATE TABLE Admin_Cred_SNMP
(
	idAdmin_Cred_SNMP INT NOT NULL AUTO_INCREMENT
    ,fk_Admin_Cred INT NOT NULL
    ,fk_SNMP INT NOT NULL
    ,PRIMARY KEY (idAdmin_Cred_SNMP)
    ,FOREIGN KEY (fk_Admin_Cred)
    REFERENCES Administrative_Credentials (idAdministrative_Credentials)
    ON UPDATE CASCADE
    ,FOREIGN KEY (fk_SNMP)
    REFERENCES SNMP_Communitiy (idSNMP_Comunitiy)
    ON UPDATE CASCADE
);

CREATE TABLE Rechnung
(
	idRechnung INT AUTO_INCREMENT
    ,referenz VARCHAR(45)
    ,fk_idPOD INT NOT NULL
    ,fk_idAdresse INT NOT NULL
    ,rechnungsdatum DATE NOT NULL
    ,PRIMARY KEY (idRechnung)
    ,FOREIGN KEY (fk_idPOD)
		REFERENCES POD(idPOD)
        ON UPDATE CASCADE
	,FOREIGN KEY (fk_idAdresse)
		REFERENCES Adressse(idAdresse)
        ON UPDATE CASCADE
);

CREATE TABLE Rechnungsposition
(
	idRechnungsposition INT AUTO_INCREMENT
    ,fk_idRechnung INT NOT NULL
    ,beschreibung VARCHAR(45) NOT NULL
    ,preis DECIMAL(4,0) NOT NULL
    ,fk_idNetzwerkinterface INT
    ,fk_idDevice INT
    ,fk_idLocation INT NOT NULL
    ,PRIMARY KEY (idRechnungsposition)
    ,FOREIGN KEY (fk_idRechnung)
		REFERENCES Rechnung (idRechnung)
        ON UPDATE CASCADE
	,FOREIGN KEY (fk_idNetzwerkinterface)
		REFERENCES Netzwerkinterface (idNetzwerkinterface)
        ON UPDATE CASCADE
	,FOREIGN KEY (fk_idDevice)
		REFERENCES Device (idDevice)
        ON UPDATE CASCADE
	,FOREIGN KEY (fk_idLocation)
		REFERENCES Location (idLocation)
        ON UPDATE CASCADE
);


CREATE TABLE Rechnung_Zahlung
(
	fk_idZahlung INT NOT NULL
    ,fk_idRechnung INT NOT NULL
    ,FOREIGN KEY (fk_idZahlung)
		REFERENCES Zahlung (idZahlung)
        ON UPDATE CASCADE
	,FOREIGN KEY (fk_idRechnung)
		REFERENCES Rechnung (idRechnung)
        ON UPDATE CASCADE
);

CREATE TABLE Lieferant 
(	
	idLieferant INT NOT NULL AUTO_INCREMENT
    , name VARCHAR(45)
    ,fk_idAdresse INT NOT NULL
    ,PRIMARY KEY (idLieferant)
    ,FOREIGN KEY (fk_idAdresse)
    REFERENCES Adresse (idAdresse)
    ON UPDATE CASCADE
);

CREATE TABLE Lieferant_Hersteller
(
	fk_idLieferant INT NOT NULL
    ,fk_idHersteller INT NOT NULL
    ,FOREIGN KEY (fk_idLieferant)
    REFERENCES Lieferant (idLieferant)
    ON UPDATE CASCADE
    ,FOREIGN KEY (fk_idHersteller)
    REFERENCES Hersteller (idHersteller)
    ON UPDATE CASCADE
    
);

CREATE TABLE Device_Admin
(
	fk_idDevice INT NOT NULL
    ,fk_idAdmin_Cred_SNMP INT NOT NULL
    ,FOREIGN KEY (fk_idDevice)
    REFERENCES Device (idDevice)
    ON UPDATE CASCADE
    ,FOREIGN KEY (fk_idAdmin_Cred_SNMP)
    REFERENCES Admin_Cred_SNMP (idAdmin_Cred_SNMP)
    ON UPDATE CASCADE
);



INSERT INTO kunde
(idKunde,name)
VALUES
(kunde.idKunde,"hallo");

SELECT* FROM kunde;

DELETE FROM kunde
WHERE idKunde = 2;






























