use inventariseriungslösung;
-- create user scripts
-- create all required user

#ToDo Flo Benutzerberechitgungen setzen wie in der Aufgabenstellung deklariert. 

create user 'boss' identified by 'password';
create user 'abteilungsleiter' identified by 'password';
create user 'sachbearbeiter' identified by 'password';
create user 'logger' identified by 'password';
create user 'monitoring' identified by 'password';

-- grant permissions for created user
grant all privileges on inventarisierungslösung.* to 'boss' with grant option;

show grants for'boss';

grant insert on inventarisierungslösung.pod to 'abteilungsleiter' with grant option;
grant insert on inventarisierungslösung.location to 'abteilungsleiter' with grant option;
grant select on inventarisierungslösung.location to 'abteilungsleiter' with grant option;


show grants for 'abteilungsleiter';