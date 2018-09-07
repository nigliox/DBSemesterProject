CREATE DATABASE IF NOT EXISTS Inventarisierungslösung;

USE Inventarisierungslösung;

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

CREATE TABLE Kunde
(
	idKunde INT AUTO_INCREMENT
    ,name VARCHAR(45) NOT NULL
    ,PRIMARY KEY (idKunde)
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

CREATE TABLE Person
(
	idPerson INT NOT NULL AUTO_INCREMENT
    ,vorname VARCHAR(45)
    ,nachname VARCHAR(45)
    ,mobil VARCHAR(45)
    ,mail VARCHAR(45)
    ,PRIMARY KEY (idPerson)
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

CREATE TABLE Location
(
	idLocation INT NOT NULL AUTO_INCREMENT
    ,locationName VARCHAR(45)
    ,fk_idAdresse INT NOT NULL
    ,fk_idPOD INT NOT NULL
    ,PRIMARY KEY (idLocation)
    ,FOREIGN KEY (fk_idAdresse)
    REFERENCES Adresse (id_Adresse)
    ON UPDATE CASCADE
    ,FOREIGN KEY (fk_idPOD)
    REFERENCES POD (id_POD)
    ON UPDATE CASCADE
);

