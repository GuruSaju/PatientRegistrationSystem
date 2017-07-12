use `patientmonitor`;

UPDATE person 
SET
City="Danda"
WHERE
PersonId=10124;

Drop Trigger PersTrigger2;

DELIMITER //

CREATE TRIGGER person_au AFTER UPDATE ON person
    FOR EACH ROW
    BEGIN
	
  INSERT INTO personauditlog
(PersonId,
FirstName,
MiddleName,
LastName,
AddressLine1,
AddressLine2,
ZIPCode,
DateOfBirth,
PhoneNo,
SSN,
City,
State,
PrimCareDrId,
Deletion,
Timestamp)
VALUES
(OLD.PersonId,
OLD.FirstName,
OLD.MiddleName,
OLD.LastName,
OLD.AddressLine1,
OLD.AddressLine2,
OLD.ZIPCode,
OLD.DateOfBirth,
OLD.PhoneNo,
OLD.SSN,
OLD.City,
OLD.State,
OLD.PrimCareDrId,0,
now());
END;//



