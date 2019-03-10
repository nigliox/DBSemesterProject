-- logging logic and functions
-- create proc to add log entries and call the update proc updateDeviceLogFK
DROP PROCEDURE IF EXISTS writeLog;
DELIMITER //
create procedure writeLog
(
	IN fk_idDevice int,
	IN logMsg VARCHAR(254),
    IN severity TINYINT(4),
    IN checked TINYINT(4),
    IN logCol VARCHAR(45),
    IN loggingTime DATETIME,
    IN zeit DATETIME
)
BEGIN
	INSERT INTO log (logMsg, severity, loggingTime, checked, zeit, LogCol,fk_idDevice)
    VALUES(logMsg, severity, loggingTime, checked, zeit, LogCol,fk_idDevice);
    
    
END //
DELIMITER ;
call writeLog((select idDevice from device LIMIT 1),"Test LOG",1,1,"Kei Ahnig",NOW(),NOW());


select * from log;