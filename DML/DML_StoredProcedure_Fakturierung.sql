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
    SET @offenerRechnungsbetrag = (SELECT SUM(rechnungsbetrag) FROM Rechnung WHERE offen = TRUE);
    IF @offenerRechnungsbetrag < 0 THEN
		UPDATE Rechnung
			SET rechnungsbetrag = rechnungsbetrag + @offenerRechnungsbetrag
            WHERE idRechnung = aktuelleRechnung;
	END IF;
    
END//
DELIMITER ;

CALL PodBill(1);