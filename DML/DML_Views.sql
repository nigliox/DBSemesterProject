use inventarisierungslösung;

CREATE VIEW v_UsagePerLocation as

SELECT idLocation,locationName,strasse,hausnummer,plz,ort,land,idDevice,idDevice_Typ,beschreibung, count(idDevice) as belegtePorts, anzahlPorts, (count(idDevice)/anzahlPorts * 100) as usageInPercent

from device d 
INNER JOIN device_typ dt ON d.fk_idDeviceType = dt.idDevice_Typ	
INNER JOIN netzwerkinterface nt ON nt.fk_idDevice = d.idDevice
INNER JOIN location l ON d.fk_idLocation = l.idLocation
INNER JOIN adresse a ON a.idAdresse = l.fk_idAdresse
GROUP BY idDevice;

