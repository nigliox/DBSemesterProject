#Stored Procedure für manuelle Abrechnung
DROP PROCEDURE IF EXISTS PodBill;

DELIMITER //
CREATE PROCEDURE PodBill(
	IN idPoD INT
)
BEGIN
	DECLARE erledigt BOOLEAN DEFAULT FALSE;
    DECLARE aktuelleID INT;
    DECLARE abzurechnenderPoD INT;
    DECLARE adresseID INT;
    DECLARE aktuelleRechnung INT;
    DECLARE offenerRechnungsbetrag DECIMAL;
    
    #Alle Rechnungspositionen, welche zum einer Location des gesuchten PODs gehören in Cursor deklarieren.
    DECLARE position CURSOR FOR
		SELECT idRechnungsposition
        FROM rechnungsposition
			WHERE fk_idLocation = (SELECT idLocation FROM Location WHERE fk_idPoD = idPoD) AND (fk_idRechnung IS NULL)
	;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET erledigt = TRUE;
	
    SET abzurechnenderPoD = idPoD;
    #AdresseID für abzurechnenden PoD ausfindig machen
    SET adresseID = (SELECT fk_idAdresse
		FROM Kunden_Adresse
			WHERE fk_idKunde = (SELECT fk_idKunde FROM PoD WHERE idPoD = abzurechnenderPoD LIMIT 1));
            
    OPEN position;
    #Wenn Cursor nicht leer, erstelle eine Rechnung
    INSERT INTO Rechnung (referenz, fk_idPOD, fk_idAdresse, rechnungsdatum)
			VALUES (CONCAT("Abrechung ",monthname(CURRENT_DATE())), abzurechnenderPoD, adresseID, current_date());
	    
	SET aktuelleRechnung = last_insert_id();
    
    #Iteriere alle gefundenen Rechnungspositionen durch.
    Proc: LOOP
		FETCH position INTO aktuelleID;
        
		#Falls keine Position oder keine weiteren mehr vorhanden, Loop beenden.
        IF erledigt THEN
			IF (SELECT rechnungsbetrag FROM Rechnung WHERE idRechnung = aktuelleRechnung) = 0 THEN
				DELETE FROM Rechnung WHERE idRechnung = aktuelleRechnung;
			END IF;
			LEAVE proc;
		END IF;
        #Füge die Rechnungsnummer zu allen Rechnungspositionen hinzu.
        UPDATE Rechnungsposition
			SET fk_idRechnung = aktuelleRechnung
            WHERE idRechnungsposition = aktuelleID;
		#Addiere Rechnungsposition zu Rechnungstotal dazu.
		UPDATE Rechnung
			SET rechnungsbetrag = rechnungsbetrag + (SELECT preis FROM rechnungsposition WHERE idRechnungsposition = aktuelleID)
            WHERE idRechnung = aktuelleRechnung;
	END LOOP Proc;
    CLOSE position;
        
	#Berücksichtige Guthaben (falls Summe aller offenen Rechnungen negativ)
    SET offenerRechnungsbetrag = (SELECT SUM(rechnungsbetrag) FROM Rechnung WHERE fk_idAdresse = adresseID AND offen = TRUE AND idRechnung < aktuelleRechnung);
    IF offenerRechnungsbetrag < 0 THEN
		INSERT INTO Rechnungsposition (fk_idRechnung, beschreibung, preis, fk_idLocation)
			VALUES (aktuelleRechnung, 'Guthaben aus vorherigen Abrechnungen', offenerRechnungsbetrag, (SELECT idLocation FROM location WHERE fK_idPOD = abzurechnenderPOD));
		UPDATE Rechnung
			SET rechnungsbetrag = rechnungsbetrag + offenerRechnungsbetrag
            WHERE idRechnung = aktuelleRechnung;
		UPDATE Rechnung
			SET offen = false
            WHERE fk_idAdresse = adresseID AND offen = true AND idRechnung < aktuelleRechnung;
	END IF;
    
END//
DELIMITER ;

#Stored Procedure für automatische Abrechnung
DROP PROCEDURE IF EXISTS PodBillauto;

DELIMITER //
CREATE PROCEDURE PodBillauto(
	
)
BEGIN
	DECLARE erledigt BOOLEAN DEFAULT FALSE;
    DECLARE aktuelleID INT;
    DECLARE abzurechnenderPOD INT;
    DECLARE adresseID INT;
    DECLARE aktuelleRechnung INT;
    DECLARE aktuellerPOD INT;
    DECLARE aktuelleLocation INT;
    DECLARE aktuellerKunde INT;
    DECLARE unverrechnetePositionen DECIMAL;
    DECLARE offenerRechnungsbetrag DECIMAL ;
      
    #Alle Rechnungspositionen, welche zum einer Location des gesuchten PODs gehören in Cursor deklarieren.
    DECLARE position CURSOR FOR
		SELECT idRechnungsposition
        FROM rechnungsposition
			WHERE fk_idRechnung IS NULL
	;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET erledigt = TRUE;    
            
    OPEN position;
    
    SET abzurechnenderPOD = 0;
 
    #Iteriere alle gefundenen Rechnungspositionen durch.
    Proc: LOOP
		FETCH position INTO aktuelleID;
        
        #Falls keine Positionen mehr vorhanden, Loop beenden
        IF erledigt THEN
			LEAVE proc;
		END IF;
              
			SET aktuellerPOD = (SELECT fk_idPOD FROM location WHERE idLocation = (SELECT fk_idLocation FROM Rechnungsposition WHERE idRechnungsposition = aktuelleID));
			#Weitere abzurechnende Position für vorherige Location vorhanden?
            IF aktuellerPOD != abzurechnenderPOD THEN
				 
                #aktuellen POD abrechnen
                SET abzurechnenderPOD = aktuellerPOD;
                #Aktueller Kunde
                SET aktuellerKunde = (SELECT fk_idKunde FROM pod WHERE idPOD = abzurechnenderPOD);
                #Aktuelle Location
                SET aktuelleLocation = (SELECT fk_idLocation FROM rechnungsposition WHERE idRechnungsposition = aktuelleID);
                #Variable für offene Posten dieses PODs
                SET unverrechnetePositionen = (SELECT SUM(preis) FROM rechnungsposition WHERE fk_idRechnung IS NULL AND fk_idLocation =
					aktuelleLocation);
                    
                #Wenn offener Betrag > maxbetrag ODER am 28. ist offener Betrag > 1000 ODER Position ist älter als 3 Monate, dann erstelle Rechnung
                IF (unverrechnetePositionen > (SELECT maxbetrag FROM kunde WHERE idKunde = aktuellerKunde))
					OR ((dayofmonth(current_date()) > 14 AND unverrechnetePositionen > 1000))
                    OR (Datediff((SELECT leistungsdatum FROM rechnungsposition WHERE fk_idLocation = aktuelleLocation), current_date()) > 90)
				THEN
					#AdresseID für abzurechnenden PoD ausfindig machen
					SET adresseID = (SELECT fk_idAdresse FROM Kunden_Adresse
						WHERE fk_idKunde = aktuellerKunde LIMIT 1);
					
					#Erstelle eine Rechnung
					INSERT INTO Rechnung (referenz, fk_idPOD, fk_idAdresse, rechnungsdatum)
						VALUES (CONCAT("Abrechung ",monthname(CURRENT_DATE())), abzurechnenderPOD, adresseID, current_date());
					SET aktuelleRechnung = last_insert_id();
				ELSE IF unverrechnetePositionen < 0 THEN ITERATE proc;
				ELSE
					ITERATE proc;
				END IF;
			END IF;
            
		END IF;
        
		#Füge die Rechnungsnummer zu allen Rechnungspositionen hinzu.
		UPDATE Rechnungsposition
			SET fk_idRechnung = aktuelleRechnung
			WHERE idRechnungsposition = aktuelleID;
		#Addiere Rechnungsposition zu Rechnungstotal dazu.
		UPDATE Rechnung
			SET rechnungsbetrag = (rechnungsbetrag + (SELECT preis FROM rechnungsposition WHERE idRechnungsposition = aktuelleID))
			WHERE idRechnung = aktuelleRechnung;
                
            
		#Berücksichtige Guthaben (falls Summe aller offenen Rechnungen negativ)
		SET offenerRechnungsbetrag = (SELECT SUM(rechnungsbetrag) FROM Rechnung WHERE fk_idAdresse = adresseID AND offen = TRUE AND idRechnung < aktuelleRechnung);
		IF offenerRechnungsbetrag < 0 THEN
			UPDATE Rechnung
			SET rechnungsbetrag = rechnungsbetrag + offenerRechnungsbetrag
			WHERE idRechnung = aktuelleRechnung;
            
            UPDATE Rechnung
            SET offen = false WHERE fk_idAdresse = adresseID AND offen = true AND idRechnung < aktuelleRechnung;
		END IF;
			  
            
	END LOOP Proc;
    CLOSE position;
        

    
END//
DELIMITER ;

SET GLOBAL event_scheduler = ON;

#Event: Löst täglich die Stored Procedure PodBillauto für die automatische Rechnungsstellung aus.
CREATE EVENT event_fakturierung_taeglich
	ON SCHEDULE EVERY 1 DAY
    DO
		CALL PodBillauto();

