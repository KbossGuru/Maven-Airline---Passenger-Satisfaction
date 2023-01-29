SELECT *
FROM Maven.dbo.airline_passenger_satisfaction;

--DATA CLEANING
--Fix the datatypes of the columns
ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN Age INT;

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Flight Distance] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Arrival Delay] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Departure and Arrival Time Convenience] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Ease of Online Booking] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Check-in Service] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Online Boarding] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Gate Location] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [On-board Service] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Seat Comfort] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Leg Room Service] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Cleanliness] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Food and Drink] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [In-flight Service] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [In-flight Wifi Service] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [In-flight Entertainment] FLOAT(2);

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	ALTER COLUMN [Baggage Handling] FLOAT(2);

--Delete the columns for passenger Id and Arrival Delay
ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	DROP COLUMN ID ;

ALTER TABLE Maven.dbo.airline_passenger_satisfaction
	DROP COLUMN [Arrival Delay];

--change the economy plus entries to economy in the class column
UPDATE Maven.dbo.airline_passenger_satisfaction
SET Class = 'Economy'
WHERE Class = 'Economy Plus';

--seperate the entries in the Departure delay column to delayed and not delayed
UPDATE Maven.dbo.airline_passenger_satisfaction
SET [Departure Delay] = 'delayed'
WHERE [Departure Delay] != '0';

UPDATE Maven.dbo.airline_passenger_satisfaction
SET [Departure Delay] = 'not delayed'
WHERE [Departure Delay] = '0';

--DATA ANALYSIS
--Find the number and percentage of satisfied passengers 
WITH CTE(Satisfaction, Total) AS (
	SELECT Satisfaction , COUNT(*) AS Total
	FROM Maven.dbo.airline_passenger_satisfaction
	GROUP BY Satisfaction
)
SELECT Satisfaction, Total, (Total * 100/ (SELECT SUM(Total) FROM CTE)) AS Percentage_Satisfied
FROM CTE
WHERE Satisfaction = 'Satisfied'
GROUP BY Satisfaction, Total;

--find the number and percentage of cusomers that are returning 
WITH TE(Customer_type, Total) AS (
	SELECT [Customer Type] , COUNT(*) AS Total
	FROM Maven.dbo.airline_passenger_satisfaction
	GROUP BY [Customer Type]
)
SELECT Customer_type, Total, (Total * 100/ (SELECT SUM(Total) FROM TE)) AS Percentage_of_customer_type
FROM TE
GROUP BY Customer_type, Total;

--find the percentage of passengers by Gender
WITH TE(Gender, Total) AS (
	SELECT [Gender] , COUNT(*) AS Total
	FROM Maven.dbo.airline_passenger_satisfaction
	GROUP BY [Gender]
)
SELECT Gender, Total, (Total * 100/ (SELECT SUM(Total) FROM TE)) AS Percentage_of_Gender
FROM TE
GROUP BY Gender, Total;

--find the percentage of passengers by Type of travel
WITH TE(Travel_Type, Total) AS (
	SELECT [Type of Travel] , COUNT(*) AS Total
	FROM Maven.dbo.airline_passenger_satisfaction
	GROUP BY [Type of Travel]
)
SELECT Travel_Type, Total, (Total * 100/ (SELECT SUM(Total) FROM TE)) AS Percentage_of_Travel_Type
FROM TE
GROUP BY Travel_Type, Total;

--Find the percentage of passengers by Class
WITH TE(Class, Total) AS (
	SELECT [Class] , COUNT(*) AS Total
	FROM Maven.dbo.airline_passenger_satisfaction
	GROUP BY [Class]
)
SELECT Class, Total, (Total * 100/ (SELECT SUM(Total) FROM TE)) AS Percentage_of_Class
FROM TE
GROUP BY Class, Total;

--Find the Percentage of passengers that were delayed
WITH TE(Departure_Delay, Total) AS (
	SELECT [Departure Delay] , COUNT(*) AS Total
	FROM Maven.dbo.airline_passenger_satisfaction
	GROUP BY [Departure Delay]
)
SELECT Departure_Delay, Total, (Total * 100/ (SELECT SUM(Total) FROM TE)) AS Percentage_of_Class
FROM TE
GROUP BY Departure_Delay, Total;

--Find the average ratings of the satisfaction  metrics
SELECT  AVG([Departure and Arrival Time Convenience]) AS Time_convinience, 
	AVG([Ease of Online Booking]) AS Ease_of_Bookng, AVG([Check-in Service]) AS Check_in_service,
	AVG([Online Boarding]) AS Onliine_Boarding, AVG([Gate Location]) AS Gate_Location,
	AVG([On-board Service]) AS Onboard_Services, AVG([Seat Comfort]) AS Seat_Comfort,
	AVG([Leg Room Service]) AS Leg_Room_Services, AVG(Cleanliness) AS Cleanliness,
	AVG([Food and Drink]) AS Food_and_Drinks, AVG([In-flight Service]) AS Inflight_Services,
	AVG([In-flight Wifi Service]) AS Wifi, AVG([In-flight Entertainment]) AS Entertaiment,
	AVG([Baggage Handling]) AS Baggage_Handling
FROM Maven.dbo.airline_passenger_satisfaction;
