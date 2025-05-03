CREATE database HospitalDB2;
USE HospitalDB2;

CREATE table Patient (
patient_id int primary key auto_increment,
full_name varchar(50) not null,
gender varchar(10),
date_of_birth date,
address varchar(100),
egk_number varchar(50) unique, 		-- each patient has different healthcard
insurance_type varchar(50),
emergency_contact varchar(50)
);

insert into Patient (full_name, gender, date_of_birth, address, egk_number, insurance_type, emergency_contact)
values
('Tom Sever', 'M', '1990-03-15', 'Berlin', 'EGK12345', 'Private', 'Can Sever'),
('John Easy', 'M', '1985-01-02', 'Munich', 'EGK67890', 'Public', 'Braun Easy'),
('Sarah Müller', 'F', '1975-07-19', 'Hamburg', 'EGK67849', 'Public', 'Esly Müller'),
('Olga Pankow', 'F', '1985-07-07', 'Berlin', 'EGK67899', 'Public', 'Zahn Pankow'),
('Mia Kaya', 'F', '1979-12-01', 'Hamburg', 'EGK54321', 'Private', 'Sally Kaya');

select * from Patient;

create table MedicalStaff (
staff_id int primary key auto_increment,
full_name varchar(100) not null,
speciality varchar(50),
roles varchar(20),
working_schedule_id int
);

insert into MedicalStaff (full_name, speciality, role, working_schedule_id)
values
('Dr. Jackson Funny', 'Cardiology', 'Doctor', null),
('Dr. Micheal Sun', 'Neurology', 'Doctor', null),
('Dr. Alonso Mett', 'Psychology', 'Doctor', null),
('Dr. Jacky Soul', 'Internal', 'Doctor', null),
('Dr. Sara Dash', 'Surgery', 'Doctor', null);

select * from MedicalStaff;

ALTER TABLE MedicalStaff ADD department_id INT;

select * from MedicalStaff;

create table Department (
department_id int primary key auto_increment,
department_name varchar(50),
department_location varchar(50)
);

insert into Department (department_name, department_location) 
values 
('cardiology', 'Block A - 1. Floor'),
('neurology', 'Block A - 2. Floor'),
('phycology', 'Block C - 4. Floor'),
('surgery', 'Block A - Ground Floor');

select * from Department;

create table Appointment (
appointment_id int primary key auto_increment,
doctor_id int,
patient_id int,
date_time datetime,
appointment_type varchar(50),
foreign key (doctor_id) references MedicalStaff(staff_id),
foreign key (patient_id) references Patient(patient_id)
);

insert into Appointment (doctor_id, patient_id, date_time, appointment_type)
values
(1, 1, '2025-05-01 10:00:00', 'First Visit'),
(2, 2, '2025-05-02 14:30:00', 'Follow-up'),
(3, 3, '2025-05-03 09:00:00', 'Consultation'),
(4, 4, '2025-05-04 16:00:00', 'Control'),
(5, 5, '2025-05-01 10:00:00', 'First Visit');

select * from Appointment;

select 
	a.appointment_id,
    d.full_name AS doctor_name,
    p.full_name AS patient_name,
    a.date_time
from
	Appointment a
join
	MedicalStaff d on a.doctor_id = d.staff_id
join
	Patient p on a.patient_id = p.patient_id
order by
	a.date_time;

UPDATE MedicalStaff
SET department_id = CASE full_name
    WHEN 'Dr. Jackson Funny' THEN 1
    WHEN 'Dr. Micheal Sun' THEN 2
    WHEN 'Dr. Alonso Mett' THEN 3
    WHEN 'Dr. Jacky Soul' THEN 4
    WHEN 'Dr. Sara Dash' THEN 5
    ELSE department_id
END
WHERE full_name IN (
    'Dr. Jackson Funny',
    'Dr. Micheal Sun',
    'Dr. Alonso Mett',
    'Dr. Jacky Soul',
    'Dr. Sara Dash'
);

SET SQL_SAFE_UPDATES = 0;

select * from Department;

select
	a.appointment_id,
    p.patient_id,
    d.full_name AS doctor_name,
    p.full_name AS patient_name,
	dep.department_name,
    a.appointment_type,
    a.date_time
from 
	Appointment a
join
	Patient p ON a.patient_id = p.patient_id
join 
	MedicalStaff d ON a.doctor_id = d.staff_id
join
	Department dep ON d.department_id = dep.department_id
order by
	p.full_name, a.date_time;
    






















