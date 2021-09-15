/*Nicholas Campola
  CPSC 350
  Project 5*/

CREATE TABLE Flight(
	FlightID INTEGER NOT NULL, 
	AircraftID INTEGER, 
	PilotID INTEGER, 
	CoPilotID INTEGER, 
	SourceAirportID INTEGER, 
	DestAirportID INTEGER, 
	Departure TIME,
	Arrival TIME,
	AirlineID INTEGER,
	SourceGate VARCHAR(4),
	DestGate VARCHAR(4),
	PRIMARY KEY(FlightID, AirlineID)
);

CREATE TABLE ScheduleFlight(
	FlightID INTEGER NOT NULL,
    AirlineID INTEGER NOT NULL,
    FlightDay DATE,
    FOREIGN KEY (FlightID, AirlineID) REFERENCES Flight (FlightID, AirlineID)
);

CREATE TABLE Airline(
	AirlineID INTEGER NOT NULL,
	AirlineName VARCHAR(20),
	PRIMARY KEY(AirlineID)
);

CREATE TABLE Aircraft(
	AircraftID INTEGER NOT NULL,
	AircraftTypeID INTEGER, 
	LocationID INTEGER, 
	Status VARCHAR(20),
	YearMade INTEGER,
	TotalMileage INTEGER,
	FuelLevel VARCHAR(15),
	PRIMARY KEY(AircraftID)
);


CREATE TABLE AircraftType(
	AircraftTypeID INTEGER NOT NULL AUTO_INCREMENT, 
	Model VARCHAR(20),
	Make Varchar(20),
	PassengerSize INTEGER,
	MaxAltitude INTEGER,
	NickName VARCHAR(40),
	MinimumRunwayLength INTEGER,
	PRIMARY KEY(AircraftTypeID)
);


CREATE TABLE Pilot(
	PilotID INTEGER NOT NULL AUTO_INCREMENT,
	Address VARCHAR(40),
	PhoneNumber VARCHAR(15),
	PilotName VARCHAR(60),
	Employer VARCHAR(60),
	PRIMARY KEY(PilotID)
);


CREATE TABLE Airports(
	AirportID INTEGER NOT NULL,
	Abbreviation VARCHAR(3),
	AirportName VARCHAR(50),
	City VARCHAR(40),
	AirportState VARCHAR(2),
	PRIMARY KEY(AirportID)
);

CREATE TABLE AircraftTypeCert(
	PilotID INTEGER NOT NULL,
	AircraftTypeID INTEGER NOT NULL
);


CREATE TABLE Journey(
	FlightID INTEGER NOT NULL, 
	AirlineID INTEGER NOT NULL,
	CustomerID INTEGER,
	FOREIGN KEY (FlightID, AirlineID) REFERENCES Flight (FlightID, AirlineID)
);

CREATE TABLE CustomerInfo(
	CustomerID INTEGER NOT NULL AUTO_INCREMENT,
	CustomerName VARCHAR(20),
	Address VARCHAR(40),
	PRIMARY KEY(CustomerID)
);


ALTER TABLE Flight ADD FOREIGN KEY(AircraftID) REFERENCES Aircraft(AircraftID);
ALTER TABLE Flight ADD FOREIGN KEY(PilotID) REFERENCES Pilot(PilotID);
ALTER TABLE Flight ADD FOREIGN KEY(CoPilotID) REFERENCES Pilot(PilotID);
ALTER TABLE Flight ADD FOREIGN KEY(SourceAirportID) REFERENCES Airports(AirportID);
ALTER TABLE Flight ADD FOREIGN KEY(DestAirportID) REFERENCES Airports(AirportID);
ALTER TABLE Flight ADD FOREIGN KEY(AirlineID) REFERENCES Airline(AirlineID);

ALTER TABLE Journey ADD FOREIGN KEY(CustomerID) REFERENCES CustomerInfo(CustomerID);

ALTER TABLE AircraftTypeCert ADD FOREIGN KEY(AircraftTypeID) REFERENCES AircraftType(AircraftTypeID);
ALTER TABLE AircraftTypeCert ADD FOREIGN KEY(PilotID) REFERENCES Pilot(PilotID);

ALTER TABLE Aircraft ADD FOREIGN KEY(LocationID) REFERENCES Airports(AirportID);
ALTER TABLE Aircraft ADD FOREIGN KEY(AircraftTypeID) REFERENCES AircraftType(AircraftTypeID);


/*The Boeing 737 is a mid-sized aircraft that seats 189 passengers, can fly up to 41,000 feet.
The Airbus 320 is a mid-sized aircraft that seats 150 passengers, can fly up to 39,000 feet.
The Boeing 747 is a jumbo aircraft that can seat a whopping 524 passengers, can fly up to 48,000 feet.*/

INSERT INTO AircraftType(AircraftTypeID, Model, PassengerSize, MaxAltitude) 
VALUES  (1, 'Boeing 737', 189, 41000),
		(2, 'Airbus 320', 150, 39000),
		(3, 'Boeing 747', 524, 48000);
		
/*The Cessna 414 ("Chancellor") 
is a small, twin-engine plane that seats up to 8 passengers and can ascend to 30,800 feet.*/

INSERT INTO AircraftType(AircraftTypeID, Model, NickName, PassengerSize, MaxAltitude) 
VALUES  (4, 'Cessna 414', 'Chancellor', 8, 30800);

/*Ben, who lives at 123 Elm Street (540-111-2222), is certified to fly both the 747 and the Airbus.

Eric, at 456 Elm Street (540-333-4444), has been checked out to fly both Boeing aircraft.

Daniel is exclusively a Boeing 737 pilot, and lives at 789 Washington Street (540-555-6666).

Stacy flies the Airbus 320 for United Airlines. She can be reached at 540-777-8888, 
and lives at 555 Skyline Drive.
      
Tyler recently joined the United team, bringing with him years of experience 
flying the Airbus 320, the Boeing 747, and the Boeing 737. 
His housing situation is currently in transition, and thus he is renting a temporary room at Ben's house.
*/

INSERT INTO Pilot(PilotID, PilotName, Address, PhoneNumber) 
VALUES  (1, 'Ben', '123 Elm Street', '540-111-2222'),
		(2, 'Eric', '456 Elm Street', '540-333-4444'),
		(3, 'Daniel', '789 Washington Street', '540-555-6666');

INSERT INTO Pilot(PilotID, PilotName, Address, PhoneNumber, Employer)
VALUES (4, 'Stacy', '555 Skyline Drive', '540-777-8888', 'United Airlines');

INSERT INTO Pilot(PilotID, PilotName, Address, Employer)
VALUES	(5, 'Tyler', '123 Elm Street', 'United Airlines');

INSERT INTO AircraftTypeCert(PilotID, AircraftTypeID)
VALUES	(1, 3),
		(1, 2),
		(2, 1),
		(2, 3),
		(3, 1),
		(4, 2),
		(5, 1),
		(5, 2),
		(5, 3);
		
/*
Reagan National (DCA) is a small regional airport.
Denver International Airport (DEN) and Cleveland-Hopkins International Airport are larger airports.
Ft. Lauderdale Airport (FLL) is in Florida.

Finally, aircraft #1112 is currently parked at John F. Kennedy airport in New York City.
*/

INSERT INTO Airports(AirportID, Abbreviation, AirportName, AirportState)
VALUES	(1, 'DCA', 'Reagan National', 'VA'),
		(2, 'DEN', 'Denver International Airport', 'CO'),
		(3, 'CHI', 'Cleveland-Hopkins International Airport', 'OH'),
		(4, 'FFL', 'Ft. Lauderdale Airport', 'FL'),
		(5, 'JFK', 'John F. Kennedy Airport', 'NY');


/*
A sister aircraft, manufactured in the same year, is also in daily operation; 
its AID is #1112 and has flown 86,000 miles. Its tank is also full at the moment.

Vehicle #2345 is a Boeing 737 aircraft that was produced in 1987, and has flown for 486,000 miles. 
It fuel gauge reads nearly empty as it awaits refueling at Cleveland-Hopkins International.
*/

INSERT INTO Aircraft(AircraftID, YearMade, AircraftTypeID, TotalMileage, FuelLevel, LocationID)
VALUES	(1112, 1999, 2, 86000, 'Full', 5);
		
INSERT INTO Aircraft(AircraftID, YearMade, AircraftTypeID, TotalMileage, FuelLevel, LocationID, Status)
VALUES	(2345, 1987, 1, 486000, 'Empty', 3, 'Refueling');
		
/*
Cameron, Matt, Megh, Kirk, Kim, and Dustin are all frequent fliers who live in a gigantic apartment complex at 127 Pine Boulevard 
and have the same mailing address.
*/

INSERT INTO CustomerInfo(CustomerID, CustomerName, Address)
VALUES	(1, 'Cameron', '127 Pine Boulevard'),
		(2, 'Matt', '127 Pine Boulevard'),
		(3, 'Megh', '127 Pine Boulevard'),
		(4, 'Kirk', '127 Pine Boulevard'),
		(5, 'Kim', '127 Pine Boulevard'),
		(6, 'Dustin', '127 Pine Boulevard'),
		(7, 'Matt', '127 Pine Boulevard'),
		(8, 'Megh', '127 Pine Boulevard'),
		(9, 'Dustin', '127 Pine Boulevard');

INSERT INTO Airline(AirlineID, AirlineName)
VALUES	(1, 'United Airlines'),
		(2, 'Frontier Airlines'),
		(3, 'Continental Airlines');		
		

/*Matt, Dustin, and Megh are currently airborne on United flight 735, which travels daily from Cleveland to Denver, 
scheduled for departure at 10:00pm and landing at 11:49pm. 
Tyler and Ben are the cockpit crew for this flight, flying aircraft #1111 which left gate C-09 and took off on from Cleveland. 
They are on schedule for a timely arrival, and will pull into gate B46 after landing at Denver International Airport.

A 1999 Airbus 320 with AID #1111 has a full tank (6,850 gallons) and 92,000 nautical miles. 
*/
INSERT INTO Aircraft(AircraftID, YearMade, AircraftTypeID, TotalMileage, FuelLevel, Status)
VALUES	(1111, 1999, 2, 92000, 'Full', 'Airborne');

INSERT INTO Flight(FlightID, AircraftID, SourceAirportID, DestAirportID, SourceGate, DestGate, Departure, Arrival, PilotID, CoPilotID, AirlineID)
VALUES (735, 1111, 3, 2, 'C-09', 'B46', '22:00', '23:49', 5, 1, 1);

INSERT INTO Journey(CustomerID, FlightID, AirlineID)
VALUES	(2, 735, 1),
		(3, 735, 1),
		(6, 735, 1);


/*Cameron, in an attempt to escape recurring blizzards, fled Denver for Ft. Lauderdale on Valentine's Day, with a brief layover in D.C. (Reagan)
 to change planes. 
 
 United 484 used the same aircraft that Matt, Dustin, and Megh would fly two days later, 
 only this time with Stacy as pilot and Ben as co-pilot. (This flight departs Denver at 10:37am and arrives in Washington at 3:50pm.) 
 
 As is United policy, Stacy and Ben swapped duties for the second leg of this connection, which is numbered flight #68, 
 leaving D.C. at 5:15pm and landing at 7:22pm. 
 
 The first of these flights left from Denver's gate B12, 
 landed at DCA and pulled into gate 14. After switching planes to aircraft #1112 during the layover, 
 Ben and Stacy left the same gate for a twilight landing in Florida, where they would pull into gate C3 for Cameron's terminal destination.
 */
 
 
INSERT INTO Flight(SourceAirportID, DestAirportID, FlightID, AircraftID, AirlineID, PilotID, CoPilotID, Departure, Arrival, SourceGate, DestGate)
VALUES(2, 1, 484, 1111, 1, 1, 4, '10:37', '15:50', 'B12', '14');

INSERT INTO ScheduleFlight(FlightID, FlightDay, AirlineID)
VALUES(484, '2019-02-14', 1);
 
INSERT INTO Flight(SourceAirportID, DestAirportID, FlightID, AirlineID, PilotID, CoPilotID, Departure, Arrival, AircraftID, SourceGate, DestGate)
VALUES	(1, 4, 68, 1, 4, 1, '17:15', '19:22', 1112, '14', 'C3');

INSERT INTO ScheduleFlight(FlightID, FlightDay, AirlineID)
VALUES(68, '2019-02-14', 1);
 
INSERT INTO Journey(CustomerID, FlightID, AirlineID)
VALUES	(1, 484, 1),
		(2, 484, 1),
		(3, 484, 1),
		(6, 484, 1);


INSERT INTO Journey(CustomerID, FlightID, AirlineID)
VALUES	(1, 68, 1),
		(2, 68, 1),
		(3, 68, 1),
		(6, 68, 1);		


/*In order to exploit a niche target market (for people like Cameron), Frontier Airlines is planning on introducing flight 86, 
  non-stop from Denver to Ft. Lauderdale daily at 9:00am (touching down at 1:50pm.) 
  A start date for this offering has not yet been announced; expectations are that service will begin in the mid- to late spring.
*/

INSERT INTO Flight(FlightID, AircraftID, SourceAirportID, DestAirportID, Departure, Arrival, AirlineID)
VALUES (86, 1111, 2, 4, '9:00', '13:50', 2);


/*Jimmy took Continental #484 from Ft. Lauderdale to Cleveland on Monday, February 12th. 
  This was aboard Boeing 737 #2345, which Daniel and Eric piloted (and co-piloted, respectively) 
  from gate A9 to Cleveland-Hopkins and gate C-10. This flight runs daily from 1:02pm to 4:00pm (including a time change, of course.)*/

INSERT INTO CustomerInfo(CustomerID, CustomerName)
VALUES	(10, 'Jimmy');

INSERT INTO Flight(FlightID, AircraftID, PilotID, CoPilotID, SourceGate, DestGate, SourceAirportID, DestAirportID, Departure, Arrival, AirlineID)
VALUES	(484, 2345, 3, 2, 'A9', 'C-10', 4, 3, '13:02', '16:00', 3);

INSERT INTO ScheduleFlight(FlightID, FlightDay, AirlineID)
VALUES	(484, '2019-02-12', 3);

INSERT INTO Journey(CustomerID, FlightID, AirlineID)
VALUES	(10, 484, 3);		
