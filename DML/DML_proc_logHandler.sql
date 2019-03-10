-- logging logic and functions
-- create proc for updating fk_idLog foreign key on device table device
DROP PROCEDURE IF EXISTS updateDeviceLogFK;
DELIMITER //
create procedure updateDeviceLogFK
(
	IN idDeviceIN int,
    IN iDLog int
)
BEGIN
	UPDATE device
    SET fk_idLog = iDLog
    WHERE idDevice = idDeviceIN;

END //

DELIMITER ;

-- create proc to add log entries and call the update proc updateDeviceLogFK
DROP PROCEDURE IF EXISTS writeLog;
DELIMITER //
create procedure writeLog
(
	IN idDevice int,
	IN logMsg VARCHAR(254),
    IN severity TINYINT(4),
    IN checked TINYINT(4),
    IN logCol VARCHAR(45),
    IN loggingTime DATETIME,
    IN zeit DATETIME
)
BEGIN
	INSERT INTO log (logMsg, severity, loggingTime, checked, zeit, LogCol,idDevice)
    VALUES(logMsg, severity, loggingTime, checked, zeit, LogCol,idDevice);
    
	call updateDeviceLogFK(idDevice, (last_insert_id()+1));
    
END //
DELIMITER ;
call writeLog((select idDevice from device LIMIT 1),"Test LOG",1,1,"Kei Ahnig",NOW(),NOW());