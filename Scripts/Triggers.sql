ALTER TABLE PersonAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

ALTER TABLE DiagnosisAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

ALTER TABLE MedicalConditionAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

ALTER TABLE MedicationAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

ALTER TABLE PrescriptionAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

ALTER TABLE AppointmentAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

ALTER TABLE DoctorAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

ALTER TABLE NurseAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

-- Create triggers for table Person
DELIMITER $$
CREATE TRIGGER PersTrigger1 AFTER INSERT
 ON Person
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
(NEW.PersonId,
NEW.FirstName,
NEW.MiddleName,
NEW.LastName,
NEW.AddressLine1,
NEW.AddressLine2,
NEW.ZIPCode,
NEW.DateOfBirth,
NEW.PhoneNo,
NEW.SSN,
NEW.City,
NEW.State,
NEW.PrimCareDrId,0,
now());
END;$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER PersTrigger2 AFTER UPDATE
 ON Person
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
(NEW.PersonId,
NEW.FirstName,
NEW.MiddleName,
NEW.LastName,
NEW.AddressLine1,
NEW.AddressLine2,
NEW.ZIPCode,
NEW.DateOfBirth,
NEW.PhoneNo,
NEW.SSN,
NEW.City,
NEW.State,
NEW.PrimCareDrId,0,
now());
END;$$
DELIMITER ;

-- Create triggers for table Doctor
DELIMITER $$
CREATE TRIGGER DrTrigger1 AFTER INSERT
 ON Doctor
 FOR EACH ROW
BEGIN
    INSERT INTO doctorauditlog
(
  DPersonId,
  StateMedicalLicenseNo,
  HighestMedicalDegreeEarned,
  Timestamp,
  Deletion,
  PersonId
)
VALUES
(
  NEW.PersonId,
  NEW.StateMedicalLicenseNo,
  NEW.HighestMedicalDegreeEarned,
  now(),
  0,
  1
);
END; $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER DrTrigger2 AFTER UPDATE
 ON Doctor
 FOR EACH ROW
BEGIN
    INSERT INTO doctorauditlog
(
  DPersonId,
  StateMedicalLicenseNo,
  HighestMedicalDegreeEarned,
  Timestamp,
  Deletion,
  PersonId
)
VALUES
(
  NEW.PersonId,
  NEW.StateMedicalLicenseNo,
  NEW.HighestMedicalDegreeEarned,
  now(),
  0,
  1
);
END; $$
DELIMITER ;

-- Create triggers for table Nurse
DELIMITER $$
CREATE TRIGGER NurTrigger1 AFTER INSERT
 ON Nurse
 FOR EACH ROW
BEGIN
INSERT INTO nurseauditlog
(
  StateNursingLicenseNo,
  Timestamp,
  Deletion,
  PersonNId,
  PersonId
)
VALUES
(
NEW.StateNursingLicenseNo,
now(),
0,
NEW.PersonId,
1
);
END; $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER NurTrigger2 AFTER UPDATE
 ON Nurse
 FOR EACH ROW
BEGIN
INSERT INTO nurseauditlog
(
  StateNursingLicenseNo,
  Timestamp,
  Deletion,
  PersonNId,
  PersonId
)
VALUES
(
NEW.StateNursingLicenseNo,
now(),
0,
NEW.PersonId,
1
);
END; $$
DELIMITER ;

-- Create triggers for table Medication
DELIMITER $$
CREATE TRIGGER MedTrigger1 AFTER INSERT
 ON Medication
 FOR EACH ROW
BEGIN
    INSERT INTO medicationauditlog
(
  MedicationStrength,
  MedicationId,
  ISDN,
  MedicationName,
  Timestamp,
  Deletion,
  PersonId
)
VALUES
(
NEW.MedicationStrength,
  NEW.MedicationId,
  NEW.ISDN,
  NEW.MedicationName,
  now(),
  0,
  1
);
END; $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER MedTrigger2 AFTER UPDATE
 ON Medication
 FOR EACH ROW
BEGIN
    INSERT INTO medicationauditlog
(
  MedicationStrength,
  MedicationId,
  ISDN,
  MedicationName,
  Timestamp,
  Deletion,
  PersonId
)
VALUES
(
NEW.MedicationStrength,
  NEW.MedicationId,
  NEW.ISDN,
  NEW.MedicationName,
  now(),
  0,
  1
);
END; $$
DELIMITER ;

-- Create triggers for table Prescription
DELIMITER $$
CREATE TRIGGER RxTrigger1 AFTER INSERT
 ON Prescription
 FOR EACH ROW
BEGIN
    INSERT INTO prescriptionauditlog
(
  PrescriptionId,
  PrescriptionNo,
  DatePrescribed,
  Quantity,
  Frequency,
  PerTimeFrame,
  Timestamp,
  Deletion,
  PersonId

)
VALUES
(
  NEW.PrescriptionId,
  NEW.PrescriptionNo,
  NEW.DatePrescribed,
  NEW.Quantity,
  NEW.Frequency,
  NEW.PerTimeFrame,
  now(),
  0,
  NEW.PersonId
);
END; $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER RxTrigger2 AFTER UPDATE
 ON Prescription
 FOR EACH ROW
BEGIN
    INSERT INTO prescriptionauditlog
(
  PrescriptionId,
  PrescriptionNo,
  DatePrescribed,
  Quantity,
  Frequency,
  PerTimeFrame,
  Timestamp,
  Deletion,
  PersonId

)
VALUES
(
  NEW.PrescriptionId,
  NEW.PrescriptionNo,
  NEW.DatePrescribed,
  NEW.Quantity,
  NEW.Frequency,
  NEW.PerTimeFrame,
  now(),
  0,
  NEW.PersonId
);
END; $$
DELIMITER ;


-- Create triggers for table Appointment
DELIMITER $$
CREATE TRIGGER ApptTrigger1 AFTER INSERT
 ON Appointment
 FOR EACH ROW
BEGIN
     INSERT INTO appointmentauditlog
(
  AppointmentId,
  AppointmentDateTime,
  BodyTemperature,
  Weight,
  Height,
  SystolicBloodPressure,
  DiastolicBloodPressure,
  Timestamp,
  Deletion,
  PersonId
)
VALUES
(
  NEW.AppointmentId,
  NEW.AppointmentDateTime,
  NEW.BodyTemperature,
  NEW.Weight,
  NEW.Height,
  NEW.SystolicBloodPressure,
  NEW.DiastolicBloodPressure,
  now(),
  0,
  NEW.PersonId
);
END; $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER ApptTrigger2 AFTER UPDATE
 ON Appointment
 FOR EACH ROW
BEGIN
    INSERT INTO appointmentauditlog
(
  AppointmentId,
  AppointmentDateTime,
  BodyTemperature,
  Weight,
  Height,
  SystolicBloodPressure,
  DiastolicBloodPressure,
  Timestamp,
  Deletion,
  PersonId
)
VALUES
(
  NEW.AppointmentId,
  NEW.AppointmentDateTime,
  NEW.BodyTemperature,
  NEW.Weight,
  NEW.Height,
  NEW.SystolicBloodPressure,
  NEW.DiastolicBloodPressure,
  now(),
  0,
  NEW.PersonId
);
END; $$
DELIMITER ;
-- Create triggers for table MedicalCondition
DELIMITER $$
CREATE TRIGGER MedCondTrigger1 AFTER INSERT
 ON MedicalCondition
 FOR EACH ROW
BEGIN
    INSERT INTO medicalconditionauditlog
(
  PersonId,
  MedicalConditionId,
  MedicalConditionName,
  Timestamp,
  Deletion
)
VALUES
(
  1,
  NEW.MedicalConditionId,
  NEW.MedicalConditionName,
  now(),
  0
);
END; $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER MedCondTrigger2 AFTER UPDATE
 ON MedicalCondition
 FOR EACH ROW
BEGIN
    INSERT INTO medicalconditionauditlog
(
  PersonId,
  MedicalConditionId,
  MedicalConditionName,
  Timestamp,
  Deletion
)
VALUES
(
  1,
  NEW.MedicalConditionId,
  NEW.MedicalConditionName,
  now(),
  0
);
END; $$
DELIMITER ;

-- Create triggers for table Diagnosis
DELIMITER $$
CREATE TRIGGER DiagTrigger1 AFTER INSERT
 ON Diagnosis
 FOR EACH ROW
BEGIN
    INSERT INTO diagnosisauditlog
(
  DiagnosisDate,
  PersonId,
  DiagnosisId,
  Notes,
  Timestamp,
  Deletion
)
VALUES
(
  NEW.DiagnosisDate,
  NEW.PersonId,
  NEW.DiagnosisId,
  NEW.Notes,
  now(),
  0
);
END; $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER DiagTrigger2 AFTER UPDATE
 ON Diagnosis
 FOR EACH ROW
BEGIN
    INSERT INTO diagnosisauditlog
(
  DiagnosisDate,
  PersonId,
  DiagnosisId,
  Notes,
  Timestamp,
  Deletion
)
VALUES
(
  NEW.DiagnosisDate,
  NEW.PersonId,
  NEW.DiagnosisId,
  NEW.Notes,
  now(),
  0
);
END; $$
DELIMITER ;

