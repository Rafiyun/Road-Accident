select TOP 10 *
from [accident data]

SELECT Year(Accident_Date)AS Years
from [accident data]

ALTER TABLE [accident data]
add Years nvarchar(50)

UPDATE [accident data]
set Years = Year(Accident_Date)

-- Total Accidents by Year

select 
DATEPART(YEAR, Accident_Date) as Year,
count(Accident_Severity) AS Total_Accident
from [accident data]
GROUP BY DATEPART(YEAR, Accident_Date)
ORDER BY DATEPART(YEAR, Accident_Date) asc

-- Total Casualties by Year

select 
DATEPART(YEAR, Accident_Date) as Year,
sum(Number_of_Casualties) AS Total_Casualties
from [accident data]
GROUP BY DATEPART(YEAR, Accident_Date)
ORDER BY DATEPART(YEAR, Accident_Date) asc

-- Total Fatal Casualties by Year

select 
	DATEPART(YEAR, Accident_Date) as Year,
	--count(Accident_Severity) AS Fatal_Accident,
	sum(Number_of_Casualties) AS Total_Fatal_Casualties
from [accident data]
where Accident_Severity = 'Fatal'
GROUP BY DATEPART(YEAR, Accident_Date)
ORDER BY DATEPART(YEAR, Accident_Date) asc

-- Total Serious Casualties by Year

select 
	DATEPART(YEAR, Accident_Date) as Year,
	--count(Accident_Severity) AS Fatal_Accident,
	sum(Number_of_Casualties) AS Total_Serious_Casualties
from [accident data]
where Accident_Severity = 'Serious'
GROUP BY DATEPART(YEAR, Accident_Date)
ORDER BY DATEPART(YEAR, Accident_Date) asc

-- Total Slight Casualties by Year

select 
	DATEPART(YEAR, Accident_Date) as Year,
	--count(Accident_Severity) AS Fatal_Accident,
	sum(Number_of_Casualties) AS Total_Slight_Casualties
from [accident data]
where Accident_Severity = 'Slight'
GROUP BY DATEPART(YEAR, Accident_Date)
ORDER BY DATEPART(YEAR, Accident_Date) asc

-- Serious Casualties by Road Surface

SELECT 
	distinct Road_Type,
	DATEPART(YEAR, Accident_Date) as Year,
	sum(Number_of_Casualties) AS Serious_Casualties_Road_Surface_Conditions
from [accident data]
where Accident_Severity = 'Serious'
GROUP BY DATEPART(YEAR, Accident_Date), Road_Type
ORDER BY DATEPART(YEAR, Accident_Date) desc, sum(Number_of_Casualties) desc

-- Serious Casualties by Weater Conditions as a percentage in 2022

SELECT 
	distinct Weather_Conditions,
	sum(Number_of_Casualties) AS Serious_Casualties_Weater_Conditions,
	CAST(sum(Number_of_Casualties) * 100 / (select sum(Number_of_Casualties) from [accident data] where Accident_Severity = 'Serious' AND Years = '2022') AS decimal(10,2)) AS Percentage
from [accident data]
where Accident_Severity = 'Serious' AND Years = '2022'
GROUP BY Weather_Conditions
ORDER BY Weather_Conditions desc

-- Serious Casualties by Road Surface as a percentage in 2022

SELECT 
	distinct Road_Surface_Conditions,
	sum(Number_of_Casualties) AS Serious_Casualties_Weater_Conditions,
	CAST(sum(Number_of_Casualties) * 100 / (select sum(Number_of_Casualties) from [accident data] where Accident_Severity = 'Serious' AND Years = '2022') AS decimal(10,2)) AS Percentage
from [accident data]
where Accident_Severity = 'Serious' AND Years = '2022'
GROUP BY Road_Surface_Conditions
ORDER BY Road_Surface_Conditions desc


