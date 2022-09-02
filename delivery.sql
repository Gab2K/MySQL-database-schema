CREATE DATABASE delivery_company;

/* employee table */
CREATE TABLE drivers
(
    driver_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(15) NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
	postcode VARCHAR(10)
);

ALTER TABLE drivers AUTO_INCREMENT=10; 
INSERT INTO drivers (first_name, last_name, phone_number, postcode) VALUES
('Chloe', 'Holy', '01289-902530', 'LN4 2FZ'),
('Michael', 'Ziol', '07981-656596', 'LN2 1SL'),
('Edward',	'Charis',	'07755-336083',	'LN10 6QA'),
('Rachel',	'Vazquez',	'01913-133416',	'LN1 1WD'),
('Ryan',	'Reed',	'07549-261218',	'LN6 9HQ'),
('Bobby',	'Gallagher',	'07557-181379','LN6 9FH'),
('Aaron',	'Karate',	'07107-194912',	'LN4 2FZ'),
('Matas',	'Blackwell',	'7666-015015',	'LN13 9HJ'),
('Edward',	'Smith',	'01671-323910',	'LN11 8LW'),
('Edward',	'Charis',	'01544-165691',	'LN6 7AY');


/* vehicle table */
CREATE TABLE vehicles
(
    vehicle_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    manufacturer VARCHAR(25),
    number_plate VARCHAR(8) NOT NULL UNIQUE
);

ALTER TABLE vehicles AUTO_INCREMENT=100; 
INSERT INTO vehicles (manufacturer, number_plate) VALUES
('Ford Transit', 'MER 50N'),
('Ford Transit', 'DOV 80P'),
('Volkswagen Transporter', 'FP77 CMM'),
('Citroen Berlingo', 'AL34 DY0'),
('Ford Transit Custom', 'MA19 ABC');


/*shifts table*/
CREATE TABLE shifts
(
    shift VARCHAR(9) PRIMARY KEY NOT NULL,
    shift_start TIME,
    shift_end TIME
);
INSERT INTO shifts VALUES
('Morning', '8:00:00', '11:55:00'),
('Afternoon', '12:00:00', '16:00:00');


/*date shift table*/
CREATE TABLE weekly_shift
(
    date_shift_id VARCHAR(3) PRIMARY KEY,
    date_year DATE,
    shift VARCHAR(9),
    FOREIGN KEY(shift) REFERENCES shifts(shift) ON DELETE SET NULL 
);

INSERT INTO weekly_shift VALUES
('1M', '2016-09-01', 'Morning'),
('1A', '2016-09-01', 'Afternoon'),
('2M', '2016-09-02', 'Morning'),
('2A', '2016-09-02', 'Afternoon'),
('3M', '2016-09-03', 'Morning'),
('3A', '2016-09-03', 'Afternoon'),
('4M', '2016-09-04', 'Morning'),
('4A', '2016-09-04', 'Afternoon'),
('5M', '2016-09-05', 'Morning'),
('5A', '2016-09-05', 'Afternoon'),
('6M', '2016-09-06', 'Morning'),
('6A', '2016-09-06', 'Afternoon'),
('7M', '2016-09-07', 'Morning'),
('7A', '2016-09-07', 'Afternoon');


/* weekly_shift_ */
CREATE TABLE shift_ID
(
    date_shift_id VARCHAR(3),
    driver_id INT,
    vehicle_id INT,
    PRIMARY KEY (date_shift_id, driver_id),
    FOREIGN KEY (date_shift_id) REFERENCES weekly_shift(date_shift_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE SET NULL 
);
INSERT INTO shift_ID VALUES
('1M', 11, 100),
('1M', 12, 104),
('1A', 17, 100),
('2M', 15, 101),
('2A', 15, 101),
('2A', 10, 103),
('3M', 17, 102),
('3A', 14, 102),
('3A', 11 ,101),
('4M', 11, 102),
('4A', 13, 103),
('5M', 11, 100),
('5M', 10, 104),
('5A', 17, 100),
('6M', 15, 101),
('6A', 12, 103),
('7M', 19, 100),
('7A', 13, 104);



/* parcel table */
CREATE TABLE parcels
(
    parcel_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    address VARCHAR(30),
    client VARCHAR(15)
);
    
INSERT INTO parcels (address, client) VALUES
('Bath', 'Myron'),
('Lincoln',	'Antony'),
('Manchester',	'Fern'),
('Lincoln',	'Erin'),
('Lincoln',	'Helena'),
('Lincoln',	'Jacklyn'),
('Peterborough',	'Andy'),
('Bath',	'Myron'),
('Nottingham',	'Dominic'),
('Manchester',	'Santiago'),
('Peterborough',	'Dominic'),
('Nottingham', 	'Mike'),
('Bath',	'Myron'),
('Peterborough',	'Andy'),
('North Hykeham', 'William'),
('Hykeham',	'Adam');


/* Create location tracking table */
CREATE TABLE location_track
(
    date_check DATE,
	time_check TIME,
    vehicle_ID INT,
    location VARCHAR(20),
    parcel_id INT,
    delivered_status BIT DEFAULT NULL,
    PRIMARY KEY (time_check, date_check, vehicle_ID),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
    FOREIGN KEY (parcel_id) REFERENCES parcels(parcel_id) ON DELETE SET NULL 
);

INSERT INTO location_track VALUES


('2016-09-01', '9:00:00', 100, 'Lincoln', 1, 0),
('2016-09-01', '10:00:00', 104, 'Lincoln', 2, 1),
('2016-09-01', '13:00:00', 100, 'Manchester', 3, 1),

('2016-09-02', '11:00:00', 101, 'Lincoln', 4, 1),
('2016-09-02', '14:00:00', 103, 'Lincoln', 5, 1),
('2016-09-02', '15:00:00', 101, 'Lincoln', 6, 1),

('2016-09-03',  '08:30:00', 102, 'Peterborough', 7, 0),
('2016-09-03', '13:00:00', 102, 'Bath', 8, 1),
('2016-09-03', '14:30:00', 101, 'Lincoln', 9, 1),

('2016-09-04', '10:00:00', 102, 'Manchester', 10, 0),
('2016-09-04', '14:00:00', 103, 'Peterborough', 11, 1),

('2016-09-05', '08:30:00', 100, 'Nottingham', 12, 1),
('2016-09-05', '11:00:00', 104, 'Bath', 13, 1),
('2016-09-05', '15:00:00', 100, 'Peterborough', 14, 1),

('2016-09-06', '09:00:00', 101, 'Peterborough', 7, 1),
('2016-09-06', '12:30:00', 103, 'Manchester', 10, 1),

('2016-09-07', '11:00:00', 100, 'North Hykeham', 15, 1),
('2016-09-07', '15:30:00', 104, 'Hykeham', 16, 1);


/*Procedures */

DELIMITER //

/* Show all drivers */
SELECT CONCAT (first_name, ' ', last_name) AS Name FROM drivers
ORDER BY first_name, last_name//



/* All drivers who have driven only during morning hours */
SELECT CONCAT (drivers.first_name, ' ', drivers.last_name) AS Name, weekly_shift.date_year, weekly_shift.shift
FROM drivers
JOIN shift_id
ON drivers.driver_id = shift_id.driver_id
JOIN weekly_shift
ON weekly_shift.date_shift_id = shift_id.date_shift_id
WHERE weekly_shift.shift = 'Morning'
ORDER BY weekly_shift.date_year, drivers.first_name, drivers.last_name//


/*Location of any vehicle and its driver at any hour during the working day
Takes date, time and vehicle_id as inputs
Example function call: call anyVehicleLocation('2016-09-01', '9:00:00', 100)*/
CREATE PROCEDURE anyVehicleLocation(IN date_check date, time_check time, vehicle int)
BEGIN 
SELECT location_track.date_check, location_track.time_check, location_track.vehicle_ID, CONCAT (drivers.first_name, ' ', drivers.last_name) AS driver_name, location_track.location
FROM weekly_shift
JOIN shift_id
ON weekly_shift.date_shift_id = shift_id.date_shift_id
JOIN drivers
ON drivers.driver_id = shift_id.driver_id
JOIN shifts
ON shifts.shift = weekly_shift.shift
JOIN location_track
ON (location_track.date_check = weekly_shift.date_year) AND (location_track.vehicle_ID = shift_id.vehicle_id)
WHERE location_track.date_check = date_check AND location_track.time_check = time_check AND location_track.vehicle_ID = vehicle AND location_track.time_check BETWEEN shifts.shift_start AND shifts.shift_end
ORDER BY location_track.date_check, location_track.time_check;
END//

/*Number of parcels delivered by any specific driver during a day’s work
Takes date and driver_id as inputs
Example call: call numberOfParcels('2016-09-01', 12)*/
CREATE PROCEDURE numberOfParcels(IN date_check date, driver int)
BEGIN
SELECT location_track.date_check, CONCAT (drivers.first_name, ' ', drivers.last_name) AS driver_name, location_track.delivered_status AS parcels_delivered
FROM weekly_shift
JOIN shift_id
ON weekly_shift.date_shift_id = shift_id.date_shift_id
JOIN drivers
ON drivers.driver_id = shift_id.driver_id
JOIN shifts
ON shifts.shift = weekly_shift.shift
JOIN location_track
ON (location_track.date_check = weekly_shift.date_year) AND (location_track.vehicle_ID = shift_id.vehicle_id)
WHERE location_track.date_check = date_check AND drivers.driver_id = driver AND location_track.time_check BETWEEN shifts.shift_start AND shifts.shift_end
ORDER BY location_track.date_check, drivers.first_name;
END//

DELIMITER ;