-- create proc to add log entries and call the update proc updateDeviceLogFK
DROP PROCEDURE IF EXISTS LogMessageAdd;
DELIMITER //
create procedure LogMessageAdd
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
END //
DELIMITER ;
call writeLog((select idDevice from device LIMIT 1),"Test LOG",1,0,"Kei Ahnig",NOW(),NOW());


-- create store proc to clear checked/marked log monitoring tool entries
DELIMITER //
CREATE PROCEDURE proc01
(
	IN id int
)
BEGIN
	UPDATE log
	SET checked = 1
	WHERE idLog = id;
END //
DELIMITER ;
<<<<<<< HEAD
call proc01(2);
=======



>>>>>>> ed0bf4967083db61652d2bf29402bfebabe8217d
