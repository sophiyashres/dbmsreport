--patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Email VARCHAR(100)
);

--Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    Date DATE,
    Doctor VARCHAR(100),
    Reason TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);
--Medical_History table
CREATE TABLE Medical_History (
    HistoryID INT PRIMARY KEY,
    PatientID INT,
    Diagnosis TEXT,
    Treatment TEXT,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);
--insert patients table
INSERT INTO Patients (PatientID, Name, Age, Gender, Email)
VALUES (1, 'John Doe', 30, 'Male', 'johndoe@example.com');
--insert Appointments table
INSERT INTO Appointments (AppointmentID, PatientID, Date, Doctor, Reason)
VALUES (101, 1, '2024-01-01', 'Dr. Smith', 'Routine Checkup');

-- insert Medical_history table
INSERT INTO Medical_History (HistoryID, PatientID, Diagnosis, Treatment, Notes)
VALUES (201, 1, 'Flu', 'Rest and medication', 'Recovered in 3 days');

--Query Execution:
--Update Patient Email
UPDATE Patients
SET Email = 'newemail@example.com'
WHERE PatientID = 1;


--Delete Appointment
DELETE FROM Appointments
WHERE AppointmentID = 105;


--Relational Algebra Operations:
--Selection (σ):
SELECT * FROM Patients
WHERE Age > 30;

--Projection (π):
SELECT Name, Email FROM Patients;


--Joins:
--leftjoin
SELECT *
FROM Patients
LEFT JOIN Appointments
ON Patients.PatientID = Appointments.PatientID;

--Right Join
SELECT *
FROM Patients
RIGHT JOIN Appointments
ON Patients.PatientID = Appointments.PatientID;

--Inner Join
SELECT *
FROM Patients
INNER JOIN Medical_History
ON Patients.PatientID = Medical_History.PatientID;


--Cartesian Product:
SELECT *
FROM Patients, Appointments;


--Set Operations:
--UNION
SELECT Name FROM Patients WHERE Gender = 'Male'
UNION
SELECT Name FROM Patients WHERE Age < 30;

--INTERSECTION
SELECT Name FROM Patients WHERE Gender = 'Male'
INTERSECT
SELECT Name FROM Patients WHERE Age < 30;

--SET DIFFERENCE (EXCEPT)
SELECT Name FROM Patients
EXCEPT
SELECT Name FROM Patients WHERE Age < 30;


--NORMALIZATION FORMS
--Unnormalized Table UNF
CREATE TABLE UnnormalizedTable (
    PatientID INT,
    Name VARCHAR(50),
    Appointments VARCHAR(100),
    Diagnosis VARCHAR(100)
);
--insertion

INSERT INTO UnnormalizedTable (PatientID, Name, Appointments, Diagnosis)
VALUES 
(1, 'Alice Smith', '101,102', 'Flu'),
    (1, 'Bob Johnson', '103', 'Allergies');


--First Normal Form (1NF)
CREATE TABLE Patients_1NF (
    PatientID INT,
    Name VARCHAR(50),
    AppointmentID INT,
    Diagnosis VARCHAR(50)
);
--insertion
INSERT INTO Patients_1NF (PatientID, Name, AppointmentID, Diagnosis)
VALUES 
    (1, 'Alice Smith', 101, 'Flu'),
    (1, 'Alice Smith', 102, 'Cold'),
    (1, 'Bob Johnson', 103, 'Cold');



--Second Normal Form (2NF)
--patienttable

CREATE TABLE Patients_2NF (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(50)
);
--appointmentstable
 CREATE TABLE Appointments_2NF(
    AppointmentID int PRIMARY KEY,
    PatientID int,
    Diagnosis VARCHAR(50),
    FOREIGN KEY (PatientID ) REFERENCES Patients_2NF(PatientID)
 );
 --INSERT data into patients
 INSERT INTO Patients_2NF(PatientID,Name)
 VALUES
 (1,'Alice Smith'),
 (2,'Bob Johnson');
 --insert data into appointments

 INSERT INTO Appointments_2NF (AppointmentID,PatientID,Diagnosis)
 VALUES
 (101,1,'Flu'),
 (102,2,'cold'),
 (103,3,'allergies');


 --Third Normal Form (3NF) 
 CREATE TABLE Doctors_3NF (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50)
);
--Add DoctorID to Appointments Table
ALTER TABLE Appointments_2NF 
ADD DoctorID INT;

--Insert Data into Doctors Table
INSERT INTO Doctors_3NF (DoctorID, Name, Email)
VALUES 
    (1, 'Dr. Adams', 'adams@hospital.com'),
    (2, 'Dr. Blake', 'blake@hospital.com');
--Update Appointments with DoctorID
--For AppointmentID = 101

UPDATE Appointments_2NF 
SET DoctorID = 1 
WHERE AppointmentID = 101;

--For AppointmentID IN (102, 103):
UPDATE Appointments_2NF 
SET DoctorID = 2 
WHERE AppointmentID IN (102, 103);

--BCNF Queries
CREATE TABLE DoctorBCNF (
    DoctorName VARCHAR(50) PRIMARY KEY,
    DoctorEmail VARCHAR(50),
    Department VARCHAR(50)
);

CREATE TABLE PatientBCNF (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(50),
    DoctorName VARCHAR(50),
    FOREIGN KEY (DoctorName) REFERENCES DoctorBCNF(DoctorName)
);

INSERT INTO DoctorBCNF (DoctorName, DoctorEmail, Department)
VALUES
    ('Dr. Adams', 'adams@hospital.com', 'Cardiology'),
    ('Dr. Blake', 'blake@hospital.com', 'Neurology');

INSERT INTO PatientBCNF (PatientID, Name, DoctorName)
VALUES
    (1, 'Alice Smith', 'Dr. Adams'),
    (2, 'Bob Johnson', 'Dr. Blake');


--Stored Procedures:
-- Create Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,       -- Primary key to uniquely identify a patient
    Name VARCHAR(50),                -- Name of the patient
    Age INT,                         -- Age of the patient
    Gender VARCHAR(10),              -- Gender of the patient
    Email VARCHAR(50)                -- Email address of the patient
);

-- Insert Data into Patients using a stored procedure
DELIMITER //
CREATE PROCEDURE InsertPatientData()
BEGIN
    INSERT INTO Patients (PatientID, Name, Age, Gender, Email)
    VALUES
        (1, 'Alice Smith', 34, 'Female', 'alice@example.com'), -- Alice Smith's data
        (2, 'Bob Johnson', 28, 'Male', 'bob@example.com');     -- Bob Johnson's data
END //
DELIMITER ;

-- Execute the stored procedure to insert patient data
CALL InsertPatientData();

-- Create Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,        -- Primary key to uniquely identify a doctor
    Name VARCHAR(50),                -- Name of the doctor
    Email VARCHAR(50)                -- Email address of the doctor
);

-- Insert Data into Doctors using a stored procedure
DELIMITER //
CREATE PROCEDURE InsertDoctorData()
BEGIN
    INSERT INTO Doctors (DoctorID, Name, Email)
    VALUES
        (1, 'Dr. Adams', 'adams@hospital.com'), -- Dr. Adams' data
        (2, 'Dr. Blake', 'blake@hospital.com'); -- Dr. Blake's data
END //
DELIMITER ;

-- Execute the stored procedure to insert doctor data
CALL InsertDoctorData();


--Transaction Management:
--Commit
UPDATE Patients
SET Age = 31
WHERE PatientID = 1;
COMMIT;

--rollback
DELETE FROM Medical_History
WHERE HistoryID = 201;
ROLLBACK;



