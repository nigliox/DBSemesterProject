use inventarisierungslösung;
-- create user scripts
-- create all required user

# 'boss'@'%'
# 'abteilungsleiter'@'%'
# 'sachbearbeiter'@'%'
# 'logger'@'%'
# 'monitoring'@'%'

drop USER IF EXISTS'boss'@'%';
drop USER IF EXISTS'abteilungsleiter'@'%';
drop USER IF EXISTS'sachbearbeiter'@'%';
drop USER IF EXISTS'logger'@'%';
drop USER IF EXISTS'monitoring'@'%';


create user 'boss'@'%' identified by 'password';
create user 'abteilungsleiter'@'%' identified by 'password'; 
create user 'sachbearbeiter'@'%' identified by 'password'; 
create user 'logger'@'%' identified by 'password';
create user 'monitoring'@'%' identified by 'password';

-- grant permissions for created user boss he can do everything
grant SELECT on inventarisierungslösung.* to 'boss'@'%' with grant option;


-- show grant options users
show grants for 'boss';
show grants for 'abteilungsleiter';
show grants for 'sachbearbeiter';
show grants for 'logger';
show grants for 'monitoring';


-- grant permissions for admin_cred_snmp

GRANT SELECT 
on inventarisierungslösung.admin_cred_snmp 
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.admin_cred_snmp 
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for administrative_credentials

GRANT SELECT 
on inventarisierungslösung.administrative_credentials
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.administrative_credentials
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for adresse

GRANT SELECT 
on inventarisierungslösung.adresse
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.adresse
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for device

GRANT SELECT 
on inventarisierungslösung.device
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.device
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for device_admin

GRANT SELECT 
on inventarisierungslösung.device_admin
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.device_admin
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for device_typ

GRANT SELECT 
on inventarisierungslösung.device_typ
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.device_typ
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for hersteller

GRANT SELECT 
on inventarisierungslösung.hersteller
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.hersteller
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for kunde

GRANT SELECT 
on inventarisierungslösung.kunde
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.kunde
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for kunden_adresse

GRANT SELECT 
on inventarisierungslösung.kunden_adresse
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.kunden_adresse
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for lieferant

GRANT SELECT 
on inventarisierungslösung.lieferant
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.lieferant
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for lieferant_hersteller

GRANT SELECT 
on inventarisierungslösung.lieferant_hersteller
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.lieferant_hersteller
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for location

GRANT SELECT 
on inventarisierungslösung.location
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.location
TO 'abteilungsleiter'@'%';

-- grant permissions for log

GRANT SELECT 
on inventarisierungslösung.log
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%','monitoring'@'%';

GRANT UPDATE
on inventarisierungslösung.log
TO 'monitoring'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.log
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%','logger'@'%';

-- grant permissions for netzwerkinterface

GRANT SELECT 
on inventarisierungslösung.netzwerkinterface
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.netzwerkinterface
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for netzwerkinterface_vlan

GRANT SELECT 
on inventarisierungslösung.netzwerkinterface_vlan
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.netzwerkinterface_vlan
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for person

GRANT SELECT 
on inventarisierungslösung.person
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.person
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for pod

GRANT SELECT 
on inventarisierungslösung.pod
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.pod
TO 'abteilungsleiter'@'%';

-- grant permissions for pod_kontaktperson

GRANT SELECT 
on inventarisierungslösung.pod_kontaktperson
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.pod_kontaktperson
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for rechnung

GRANT SELECT 
on inventarisierungslösung.rechnung
TO 'boss'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.rechnung
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for rechnung_zahlung

GRANT SELECT 
on inventarisierungslösung.rechnung_zahlung
TO 'boss'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.rechnung_zahlung
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for rechnungsposition

GRANT SELECT 
on inventarisierungslösung.rechnungsposition
TO 'boss'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.rechnungsposition
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for snmp_community

GRANT SELECT 
on inventarisierungslösung.snmp_community
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.snmp_community
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';


-- grant permissions for vlan

GRANT SELECT 
on inventarisierungslösung.vlan
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.vlan
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';

-- grant permissions for zahlung

GRANT SELECT 
on inventarisierungslösung.zahlung
TO 'boss'@'%';

GRANT INSERT,UPDATE
on inventarisierungslösung.zahlung
TO 'abteilungsleiter'@'%','sachbearbeiter'@'%';














