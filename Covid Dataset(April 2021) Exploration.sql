-- Covid 19 Data Exploration from January 2020-April 2021
-- Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views.

SELECT *
FROM portfolioproject.coviddeaths
WHERE continent is not null
ORDER BY 3,4;

SELECT *
FROM portfolioproject.covidvaccinations
ORDER BY 3,4;

-- Selecting the data i am using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM portfolioproject.coviddeaths
ORDER BY 1,2;

-- Comparing the Total cases and the Total Deaths in NIgeria

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Percentage_of_deaths
FROM portfolioproject.coviddeaths
WHERE continent is not null
ORDER BY 1,2;

-- Comparing the Total cases and the Population in Nigeria

SELECT location, date, total_cases, population, (total_cases/population)*100 AS Percentage_of_infected_population
FROM portfolioproject.coviddeaths
WHERE location = 'Nigeria' AND continent is not null
ORDER BY 1,2;

-- Looking at Countries and their infection rate compared to population

SELECT location, MAX(total_cases) AS Max_Infection_count, population, MAX((total_cases/population))*100 AS Percentage_of_infected_population
FROM portfolioproject.coviddeaths
-- WHERE location = 'Nigeria'
WHERE continent is not null
GROUP BY location, population
ORDER BY Percentage_of_infected_population DESC;

-- Looking at Countries and Continents with Highest death rates compared to population

SELECT location, MAX(total_deaths) AS Max_death_count, population, MAX((total_deaths/population))*100 AS Percentage_of_dead_population
FROM portfolioproject.coviddeaths
-- WHERE location = 'Nigeria'
WHERE continent is not null
GROUP BY location, population
ORDER BY Percentage_of_dead_population DESC;

-- Breaking it down by continents

SELECT continent, MAX(total_deaths) AS Max_death_count, MAX(total_cases) AS Max_cases_count
FROM portfolioproject.coviddeaths
-- WHERE location = 'Nigeria'
WHERE continent is not null
GROUP BY continent
ORDER BY Max_death_count DESC;

-- Death Percentsge of total population infected

SELECT  SUM(new_cases) AS Total_cases, SUM(new_deaths) AS Total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS Percentage_of_deaths
FROM portfolioproject.coviddeaths
-- WHERE location = 'Nigeria' 
WHERE continent  is not null
-- GROUP BY date
ORDER BY 1,2;

-- GOING INTO THE COVID VACCINATIONS TABLE

SELECT SUM(new_vaccinations) as Total_Vaccinations
FROM portfolioproject.covidvaccinations
WHERE continent is NOT NULL; 

-- Looking at total population and vaccinations

SELECT Death.continent, Death.location, Death.date, Death.population, Vaccinations.new_vaccinations,
SUM(Vaccinations.new_vaccinations) OVER (PARTITION BY Death.location ORDER BY Death.location,Death.date) AS Rolling_count_of_vaccinations
-- ,(MAX(Rolling_count_of_vaccinations)/Death.population) * 100 AS Percentage
FROM portfolioproject.coviddeaths Death
JOIN portfolioproject.covidvaccinations Vaccinations
ON Death.location = Vaccinations.location
AND Death.date = Vaccinations.date
WHERE Death.continent IS NOT NULL
ORDER BY 2,3;

-- Using CTEs

With PopvsVac( continent, location, date, population, new_vaccinations, Rolling_count_of_vaccinations )	
AS
(
SELECT Death.continent, Death.location, Death.date, Death.population, Vaccinations.new_vaccinations,
SUM(Vaccinations.new_vaccinations) OVER (PARTITION BY Death.location ORDER BY Death.location,Death.date) AS Rolling_count_of_vaccinations
-- ,(Rolling_count_of_vaccinations/Death.population) * 100 AS Percentage
FROM portfolioproject.coviddeaths Death
JOIN portfolioproject.covidvaccinations Vaccinations
ON Death.location = Vaccinations.location
AND Death.date = Vaccinations.date
WHERE Death.continent IS NOT NULL
ORDER BY 2,3
)
SELECT *, (Rolling_count_of_vaccinations/population) * 100 AS Percentage
FROM PopvsVac
WHERE location = 'Nigeria';

-- USING TEMP TABLES
 DROP TABLE IF EXISTS percentagepeoplevaccinated;
 CREATE TABLE PercentagePeopleVaccinated(
 Continent varchar(50),
 Location varchar(100),
 Date varchar(20),
 Population BIGINT,
 New_vaccinations BIGINT,
 Rolling_count_of_vaccinations BIGINT 
 );
 
INSERT INTO PercentagePeopleVaccinated
SELECT Death.continent, Death.location, Death.date, Death.population, Vaccinations.new_vaccinations,
SUM(Vaccinations.new_vaccinations) OVER (PARTITION BY Death.location ORDER BY Death.location,Death.date) AS Rolling_count_of_vaccinations
-- ,(Rolling_count_of_vaccinations/Death.population) * 100 AS Percentage
FROM portfolioproject.coviddeaths Death
JOIN portfolioproject.covidvaccinations Vaccinations
ON Death.location = Vaccinations.location
AND Death.date = Vaccinations.date
WHERE Death.continent IS NOT NULL
ORDER BY 2,3
;
SELECT *, (Rolling_count_of_vaccinations/population) * 100 AS Percentage
FROM PercentagePeopleVaccinated
WHERE location = 'Nigeria';

-- Creating Views to store data for later visualization

CREATE VIEW PercentagePeopleVaccinated AS
SELECT Death.continent, Death.location, Death.date, Death.population, Vaccinations.new_vaccinations,
SUM(Vaccinations.new_vaccinations) OVER (PARTITION BY Death.location ORDER BY Death.location,Death.date) AS Rolling_count_of_vaccinations
-- ,(Rolling_count_of_vaccinations/Death.population) * 100 AS Percentage
FROM portfolioproject.coviddeaths Death
JOIN portfolioproject.covidvaccinations Vaccinations
ON Death.location = Vaccinations.location
AND Death.date = Vaccinations.date
WHERE Death.continent IS NOT NULL
ORDER BY 2,3




















































































































































