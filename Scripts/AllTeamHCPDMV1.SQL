/*
Created: 3/30/2015
Modified: 4/3/2015
Model: AllTeam PDM
Database: MySQL 5.5
*/

-- Create tables section -------------------------------------------------

-- Table Person

CREATE TABLE Person
(
  PersonId Bigint NOT NULL,
  FirstName Varchar(30) NOT NULL,
  MiddleName Varchar(30),
  LastName Varchar(30) NOT NULL,
  SSN Char(9),
  AddressLine1 Varchar(30) NOT NULL,
  AddressLine2 Varchar(30),
  City Varchar(30) NOT NULL,
  State Char(2) NOT NULL,
  ZIPCode Char(9) NOT NULL,
  DateOfBirth Date NOT NULL,
  PhoneNo Varchar(30),
  PrimCareDrId Bigint
)
;

ALTER TABLE Person ADD PRIMARY KEY (PersonId)
;

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

-- Table Doctor

CREATE TABLE Doctor
(
  PersonId Bigint NOT NULL,
  StateMedicalLicenseNo Varchar(30) NOT NULL,
  HighestMedicalDegreeEarned Varchar(30) NOT NULL
)
;

ALTER TABLE Doctor ADD PRIMARY KEY (PersonId)
;

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

-- Table Nurse

CREATE TABLE Nurse
(
  PersonId Bigint NOT NULL,
  StateNursingLicenseNo Varchar(30) NOT NULL
)
;

ALTER TABLE Nurse ADD PRIMARY KEY (PersonId)
;

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


-- Table Other

CREATE TABLE Other
(
  PersonId Bigint NOT NULL
)
;

ALTER TABLE Other ADD PRIMARY KEY (PersonId)
;

-- Create triggers for table Other

CREATE TRIGGER OthTrigger1 AFTER INSERT
 ON Other
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER OthTrigger2 AFTER UPDATE
 ON Other
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table Organization

CREATE TABLE Organization
(
  OrganizationId Bigint NOT NULL,
  OrganizationName Varchar(50) NOT NULL,
  AddressLine1 Varchar(50) NOT NULL,
  AddressLine2 Varchar(50),
  City Varchar(50) NOT NULL,
  State Varchar(50) NOT NULL,
  ZipCode Bigint NOT NULL,
  PhoneNumber Varchar(30),
  TypeId Bigint NOT NULL
)
;

ALTER TABLE Organization ADD PRIMARY KEY (OrganizationId)
;

-- Create triggers for table Organization

CREATE TRIGGER OrgTrigger1 AFTER INSERT
 ON Organization
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER OrgTrigger2 AFTER UPDATE
 ON Organization
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table LivingWillParticipant

CREATE TABLE LivingWillParticipant
(
  LivingWillParticipantId Bigint NOT NULL,
  Priority Enum('1','2','3','4') NOT NULL,
  WillAuthorId Bigint NOT NULL,
  RefPersonId Bigint NOT NULL
)
;

ALTER TABLE LivingWillParticipant ADD PRIMARY KEY (LivingWillParticipantId)
;

-- Create triggers for table LivingWillParticipant

CREATE TRIGGER LWPartTrigger1 AFTER INSERT
 ON LivingWillParticipant
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER LWPartTrigger2 AFTER UPDATE
 ON LivingWillParticipant
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table InsuranceCoverage

CREATE TABLE InsuranceCoverage
(
  InsuranceCoverageId Bigint NOT NULL,
  InsuranceIdNo Bigint NOT NULL,
  CoverageStartDate Date NOT NULL,
  CoverageEndDate Date NOT NULL,
  OrganizationId Bigint NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE InsuranceCoverage ADD PRIMARY KEY (InsuranceCoverageId)
;

CREATE INDEX IX_Relationship2 ON InsuranceCoverage (PersonId)
;

-- Create triggers for table InsuranceCoverage

CREATE TRIGGER InsCovTrigger1 AFTER INSERT
 ON InsuranceCoverage
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER InsCovTrigger2 AFTER UPDATE
 ON InsuranceCoverage
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table PharmacyDesignation

CREATE TABLE PharmacyDesignation
(
  PharmacyDesignationId Bigint NOT NULL,
  Priority Enum('1','2') NOT NULL,
  PersonId Bigint NOT NULL,
  OrganizationId Bigint NOT NULL
)
;

ALTER TABLE PharmacyDesignation ADD PRIMARY KEY (PharmacyDesignationId)
;

-- Create triggers for table PharmacyDesignation

CREATE TRIGGER RxDesTrigger1 AFTER INSERT
 ON PharmacyDesignation
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER RxDesTrigger2 AFTER UPDATE
 ON PharmacyDesignation
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table Medication

CREATE TABLE Medication
(
  MedicationId Bigint NOT NULL,
  ISDN Bigint NOT NULL,
  MedicationName Varchar(50) NOT NULL,
  MedicationStrength Bigint NOT NULL
)
;

ALTER TABLE Medication ADD PRIMARY KEY (MedicationId)
;

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


-- Table Prescription

CREATE TABLE Prescription
(
  PrescriptionId Bigint NOT NULL,
  PrescriptionNo Bigint NOT NULL,
  DatePrescribed Date NOT NULL,
  Quantity Bigint NOT NULL,
  Frequency Bigint NOT NULL,
  PerTimeFrame Bigint NOT NULL,
  MedicationId Bigint NOT NULL,
  PersonId Bigint NOT NULL,
  OrganizationId Bigint NOT NULL
)
;

ALTER TABLE Prescription ADD PRIMARY KEY (PrescriptionId)
;

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


-- Table DoctorAvailability

CREATE TABLE DoctorAvailability
(
  AvailabilityId Bigint NOT NULL,
  DayOfWeek Char(3) NOT NULL,
  FromTIme Bigint NOT NULL,
  ToTime Bigint NOT NULL,
  CurrentlyEmployed Bool NOT NULL,
  OrganizationId Bigint NOT NULL,
  DoctorId Bigint
)
;

ALTER TABLE DoctorAvailability ADD PRIMARY KEY (AvailabilityId)
;

CREATE INDEX IX_Relationship1 ON DoctorAvailability (DoctorId)
;

-- Create triggers for table DoctorAvailability

CREATE TRIGGER DocAvailTrigger1 AFTER INSERT
 ON DoctorAvailability
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER DocAvailTrigger2 AFTER UPDATE
 ON DoctorAvailability
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table Appointment

CREATE TABLE Appointment
(
  AppointmentId Bigint NOT NULL,
  AppointmentDateTime Datetime NOT NULL,
  BodyTemperature Decimal(4,1) NOT NULL,
  Weight Bigint NOT NULL,
  Height Bigint NOT NULL,
  SystolicBloodPressure Bigint NOT NULL,
  DiastolicBloodPressure Bigint NOT NULL,
  PersonId Bigint NOT NULL,
  OrganizationId Bigint NOT NULL,
  NurseId Bigint,
  DoctorId Bigint
)
;

ALTER TABLE Appointment ADD PRIMARY KEY (AppointmentId)
;

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


-- Table Affiliation

CREATE TABLE Affiliation
(
  AffiliationId Bigint NOT NULL,
  StartDate Date NOT NULL,
  PositionName Varchar(50) NOT NULL,
  EndDate Date,
  IsCurrent Bool NOT NULL,
  OrganizationId Bigint NOT NULL,
  DoctorId Bigint
)
;

ALTER TABLE Affiliation ADD PRIMARY KEY (AffiliationId)
;

-- Create triggers for table Affiliation

CREATE TRIGGER AffTrigger1 AFTER INSERT
 ON Affiliation
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER AffTrigger2 AFTER UPDATE
 ON Affiliation
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table MedicalSpecialtyType

CREATE TABLE MedicalSpecialtyType
(
  SpecialtyId Bigint NOT NULL,
  SpecialtyName Varchar(50) NOT NULL
)
;

ALTER TABLE MedicalSpecialtyType ADD PRIMARY KEY (SpecialtyId)
;

-- Create triggers for table MedicalSpecialtyType

CREATE TRIGGER MedSpecTrigger1 AFTER INSERT
 ON MedicalSpecialtyType
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER MedSpecTrigger2 AFTER UPDATE
 ON MedicalSpecialtyType
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table AssociatedSpecialty

CREATE TABLE AssociatedSpecialty
(
  AssociatedSpecialtyId Bigint NOT NULL,
  SpecialtyId Bigint NOT NULL,
  PersonId Bigint
)
;

ALTER TABLE AssociatedSpecialty ADD PRIMARY KEY (AssociatedSpecialtyId)
;

-- Create triggers for table AssociatedSpecialty

CREATE TRIGGER ASpecTrigger1 AFTER INSERT
 ON AssociatedSpecialty
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER ASpecTrigger2 AFTER UPDATE
 ON AssociatedSpecialty
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table MedicalCondition

CREATE TABLE MedicalCondition
(
  MedicalConditionId Bigint NOT NULL,
  MedicalConditionName Varchar(50) NOT NULL
)
;

ALTER TABLE MedicalCondition ADD PRIMARY KEY (MedicalConditionId)
;

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


-- Table Diagnosis

CREATE TABLE Diagnosis
(
  DiagnosisId Bigint NOT NULL,
  Notes Longtext,
  DiagnosisDate Date NOT NULL,
  PersonId Bigint NOT NULL,
  MedicalConditionId Bigint NOT NULL
)
;

ALTER TABLE Diagnosis ADD PRIMARY KEY (DiagnosisId)
;

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


-- Table Permission

CREATE TABLE Permission
(
  PermissionId Bigint NOT NULL,
  PermissionLevel Bigint NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE Permission ADD PRIMARY KEY (PermissionId)
;

-- Create triggers for table Permission

CREATE TRIGGER PermTrigger1 AFTER INSERT
 ON Permission
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER PermTrigger2 AFTER UPDATE
 ON Permission
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table OrganizationType

CREATE TABLE OrganizationType
(
  TypeId Bigint NOT NULL,
  OrganizationType Varchar(30) NOT NULL
)
;

ALTER TABLE OrganizationType ADD PRIMARY KEY (TypeId)
;

-- Create triggers for table OrganizationType

CREATE TRIGGER OTTrigger1 AFTER INSERT
 ON OrganizationType
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

CREATE TRIGGER OTTrigger2 AFTER UPDATE
 ON OrganizationType
 FOR EACH ROW
BEGIN
    /*trigger_body*/
END
;

-- Table PersonAuditLog

CREATE TABLE PersonAuditLog
(
  PersonId Bigint NOT NULL,
  FirstName Varchar(30) NOT NULL,
  MiddleName Varchar(30),
  LastName Varchar(30) NOT NULL,
  AddressLine1 Varchar(30) NOT NULL,
  AddressLine2 Varchar(30),
  ZIPCode Char(9) NOT NULL,
  DateOfBirth Date NOT NULL,
  PhoneNo Varchar(30),
  LogIdNo Bigint NOT NULL,
  SSN Char(9),
  City Varchar(30) NOT NULL,
  State Char(2) NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL default 0,
  PrimCareDrId Bigint NOT NULL
)
;

ALTER TABLE PersonAuditLog ADD PRIMARY KEY (LogIdNo)
;
ALTER TABLE PersonAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

-- Table DiagnosisAuditLog

CREATE TABLE DiagnosisAuditLog
(
  DiagnosisDate Date NOT NULL,
  LogIdNo Bigint NOT NULL ,
  PersonId Bigint NOT NULL,
  DiagnosisId Bigint NOT NULL,
  Notes Longtext,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL
)
;

ALTER TABLE DiagnosisAuditLog ADD PRIMARY KEY (LogIdNo)
;
ALTER TABLE DiagnosisAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

-- Table LivingWillAuditLog

CREATE TABLE LivingWillAuditLog
(
  PersonId Bigint NOT NULL,
  LogIdNo Bigint NOT NULL,
  LivingWillParticipantId Bigint NOT NULL,
  Priority Bigint NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL
)
;

ALTER TABLE LivingWillAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table MedicalConditionAuditLog

CREATE TABLE MedicalConditionAuditLog
(
  PersonId Bigint NOT NULL,
  LogIdNo Bigint NOT NULL,
  MedicalConditionId Bigint NOT NULL,
  MedicalConditionName Varchar(50) NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL
)
;

ALTER TABLE MedicalConditionAuditLog ADD PRIMARY KEY (LogIdNo)
;
ALTER TABLE MedicalConditionAuditLog MODIFY COLUMN LogIdNo INT auto_increment;
-- Table PermissionAuditLog

CREATE TABLE PermissionAuditLog
(
  LogIdNo Bigint NOT NULL,
  PermissionId Bigint NOT NULL,
  PermissionLevel Bigint NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE PermissionAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table InsuranceCoverageAuditLog

CREATE TABLE InsuranceCoverageAuditLog
(
  LogIdNo Bigint NOT NULL,
  CoverageStartDate Date NOT NULL,
  CoverageEndDate Date NOT NULL,
  InsuranceCoverageId Bigint NOT NULL,
  InsuranceIdNo Bigint NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE InsuranceCoverageAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table OrganizationAuditLog

CREATE TABLE OrganizationAuditLog
(
  LogIdNo Bigint NOT NULL,
  OrganizationName Varchar(50) NOT NULL,
  AddressLine1 Varchar(50) NOT NULL,
  AddressLine2 Varchar(50),
  ZipCode Bigint NOT NULL,
  PhoneNumber Varchar(30),
  OrganizationId Bigint NOT NULL,
  City Varchar(50) NOT NULL,
  State Varchar(50) NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE OrganizationAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table OrganizationTypeAuditLog

CREATE TABLE OrganizationTypeAuditLog
(
  TypeId Bigint NOT NULL,
  OrganizationType Varchar(30) NOT NULL,
  PersonId Bigint NOT NULL,
  LogIdNo Bigint NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL
)
;

ALTER TABLE OrganizationTypeAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table PharmacyDesignationAuditLog

CREATE TABLE PharmacyDesignationAuditLog
(
  PharmacyDesignationId Bigint NOT NULL,
  LogIdNo Bigint NOT NULL,
  Priority Bigint NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE PharmacyDesignationAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table MedicationAuditLog

CREATE TABLE MedicationAuditLog
(
  MedicationStrength Bigint NOT NULL,
  LogIdNo Bigint NOT NULL,
  MedicationId Bigint NOT NULL,
  ISDN Bigint NOT NULL,
  MedicationName Varchar(50) NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE MedicationAuditLog ADD PRIMARY KEY (LogIdNo)
;
ALTER TABLE MedicationAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

-- Table PrescriptionAuditLog

CREATE TABLE PrescriptionAuditLog
(
  LogIdNo Bigint NOT NULL,
  PrescriptionId Bigint NOT NULL,
  PrescriptionNo Bigint NOT NULL,
  DatePrescribed Date NOT NULL,
  Quantity Bigint NOT NULL,
  Frequency Bigint NOT NULL,
  PerTimeFrame Bigint NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE PrescriptionAuditLog ADD PRIMARY KEY (LogIdNo)
;
ALTER TABLE PrescriptionAuditLog MODIFY COLUMN LogIdNo INT auto_increment;
-- Table AppointmentAuditLog

CREATE TABLE AppointmentAuditLog
(
  LogIdNo Bigint NOT NULL,
  AppointmentId Bigint NOT NULL,
  AppointmentDateTime Datetime NOT NULL,
  BodyTemperature Decimal(4,1) NOT NULL,
  Weight Bigint NOT NULL,
  Height Bigint NOT NULL,
  SystolicBloodPressure Bigint NOT NULL,
  DiastolicBloodPressure Bigint NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE AppointmentAuditLog ADD PRIMARY KEY (LogIdNo)
;
ALTER TABLE AppointmentAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

-- Table DoctorAvailabilityAuditLog

CREATE TABLE DoctorAvailabilityAuditLog
(
  LogIdNo Bigint NOT NULL,
  AvailabilityId Bigint NOT NULL,
  DayOfWeek Char(3) NOT NULL,
  FromTIme Bigint NOT NULL,
  ToTime Bigint NOT NULL,
  CurrentlyEmployed Bool NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE DoctorAvailabilityAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table AffiliationAuditLog

CREATE TABLE AffiliationAuditLog
(
  AffiliationId Bigint NOT NULL,
  StartDate Date NOT NULL,
  PositionName Varchar(50) NOT NULL,
  EndDate Date,
  IsCurrent Bool NOT NULL,
  LogIdNo Bigint NOT NULL,
  Timestamp Timestamp NOT NULL,
  PersonId Bigint NOT NULL,
  Deletion Bool NOT NULL
)
;

ALTER TABLE AffiliationAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table AssociatedSpecialtyAuditLog

CREATE TABLE AssociatedSpecialtyAuditLog
(
  AssociatedSpecialtyId Bigint NOT NULL,
  LogIdNo Bigint NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE AssociatedSpecialtyAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table MedicalSpecialtyAuditLog

CREATE TABLE MedicalSpecialtyAuditLog
(
  LogIdNo Bigint NOT NULL,
  PersonId Bigint NOT NULL,
  SpecialtyId Bigint NOT NULL,
  SpecialtyName Varchar(50) NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL
)
;

ALTER TABLE MedicalSpecialtyAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table OtherAuditLog

CREATE TABLE OtherAuditLog
(
  LogIdNo Bigint NOT NULL,
  PersonId Bigint NOT NULL,
  OPersonId Bigint,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL
)
;

ALTER TABLE OtherAuditLog ADD PRIMARY KEY (LogIdNo)
;

-- Table DoctorAuditLog

CREATE TABLE DoctorAuditLog
(
  DPersonId Bigint NOT NULL,
  LogIdNo Bigint NOT NULL,
  StateMedicalLicenseNo Varchar(30) NOT NULL,
  HighestMedicalDegreeEarned Varchar(30) NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE DoctorAuditLog ADD PRIMARY KEY (LogIdNo)
;
ALTER TABLE DoctorAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

-- Table NurseAuditLog

CREATE TABLE NurseAuditLog
(
  LogIdNo Bigint NOT NULL,
  StateNursingLicenseNo Varchar(30) NOT NULL,
  Timestamp Timestamp NOT NULL,
  Deletion Bool NOT NULL,
  PersonNId Bigint,
  PersonId Bigint NOT NULL
)
;

ALTER TABLE NurseAuditLog ADD PRIMARY KEY (LogIdNo)
;
ALTER TABLE NurseAuditLog MODIFY COLUMN LogIdNo INT auto_increment;

-- Create relationships section ------------------------------------------------- 

ALTER TABLE Person ADD CONSTRAINT prim_cared_for_by_prim_dr_for FOREIGN KEY (PrimCareDrId) REFERENCES Doctor (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE LivingWillParticipant ADD CONSTRAINT for_patient_in FOREIGN KEY (WillAuthorId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE LivingWillParticipant ADD CONSTRAINT by_decision_maker_in FOREIGN KEY (RefPersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE PharmacyDesignation ADD CONSTRAINT by_patient_in FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Prescription ADD CONSTRAINT about_medication_in FOREIGN KEY (MedicationId) REFERENCES Medication (MedicationId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Prescription ADD CONSTRAINT presc_for_patient_in FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Appointment ADD CONSTRAINT for_patient_in2 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Affiliation ADD CONSTRAINT of_physician_in FOREIGN KEY (DoctorId) REFERENCES Doctor (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE AssociatedSpecialty ADD CONSTRAINT trained_in_held_by FOREIGN KEY (PersonId) REFERENCES Doctor (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE AssociatedSpecialty ADD CONSTRAINT subfld_within_classfer_of FOREIGN KEY (SpecialtyId) REFERENCES MedicalSpecialtyType (SpecialtyId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Appointment ADD CONSTRAINT with_physician_in FOREIGN KEY (DoctorId) REFERENCES Doctor (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Appointment ADD CONSTRAINT also_seen_by_nurse_in FOREIGN KEY (NurseId) REFERENCES Nurse (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Diagnosis ADD CONSTRAINT for_diagnosed_with FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Diagnosis ADD CONSTRAINT of_condition_in FOREIGN KEY (MedicalConditionId) REFERENCES MedicalCondition (MedicalConditionId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE InsuranceCoverage ADD CONSTRAINT by_insurer_in FOREIGN KEY (OrganizationId) REFERENCES Organization (OrganizationId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE PharmacyDesignation ADD CONSTRAINT about_pharmacy_in FOREIGN KEY (OrganizationId) REFERENCES Organization (OrganizationId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Affiliation ADD CONSTRAINT with_site_of FOREIGN KEY (OrganizationId) REFERENCES Organization (OrganizationId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE DoctorAvailability ADD CONSTRAINT at_site_for FOREIGN KEY (OrganizationId) REFERENCES Organization (OrganizationId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Appointment ADD CONSTRAINT at_site_of2 FOREIGN KEY (OrganizationId) REFERENCES Organization (OrganizationId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Prescription ADD CONSTRAINT filled_by_fill FOREIGN KEY (OrganizationId) REFERENCES Organization (OrganizationId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Doctor ADD CONSTRAINT may_be_is FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Nurse ADD CONSTRAINT may_be_is2 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Other ADD CONSTRAINT may_be_is3 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Permission ADD CONSTRAINT is_may_be FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE Organization ADD CONSTRAINT classifier_of_classified_by FOREIGN KEY (TypeId) REFERENCES OrganizationType (TypeId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE PersonAuditLog ADD CONSTRAINT mod_of_mod_by FOREIGN KEY (PrimCareDrId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE AffiliationAuditLog ADD CONSTRAINT mod_of_mod_by2 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE DoctorAvailabilityAuditLog ADD CONSTRAINT mod_of_mod_by3 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE AppointmentAuditLog ADD CONSTRAINT mod_of_mod_by4 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE DoctorAuditLog ADD CONSTRAINT mod_of_mod_by5 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE LivingWillAuditLog ADD CONSTRAINT mod_of_mod_by6 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE OrganizationAuditLog ADD CONSTRAINT mod_of_mod_by10 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE OrganizationTypeAuditLog ADD CONSTRAINT mod_of_mod_by8 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE InsuranceCoverageAuditLog ADD CONSTRAINT mod_of_mod_by9 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE MedicationAuditLog ADD CONSTRAINT mod_of_mod_by15 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE AssociatedSpecialtyAuditLog ADD CONSTRAINT mod_of_mod_by14 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE PrescriptionAuditLog ADD CONSTRAINT mod_of_mod_by13 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE PharmacyDesignationAuditLog ADD CONSTRAINT mod_of_mod_by12 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE PermissionAuditLog ADD CONSTRAINT mod_of_mod_by11 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE MedicalSpecialtyAuditLog ADD CONSTRAINT mod_of_mod_by19 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE OtherAuditLog ADD CONSTRAINT mod_of_mod_by18 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE NurseAuditLog ADD CONSTRAINT mod_of_mod_by17 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE DiagnosisAuditLog ADD CONSTRAINT mod_of_mod_by7 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE MedicalConditionAuditLog ADD CONSTRAINT mod_of_mod_by16 FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE DoctorAvailability ADD CONSTRAINT of_doctor_in FOREIGN KEY (DoctorId) REFERENCES Doctor (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE InsuranceCoverage ADD CONSTRAINT for_insured_in FOREIGN KEY (PersonId) REFERENCES Person (PersonId) ON DELETE NO ACTION ON UPDATE NO ACTION
;


