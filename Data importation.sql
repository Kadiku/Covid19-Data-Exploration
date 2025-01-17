-- Creatiing the Database
CREATE DATABASE IF NOT EXISTS Portfolioproject;
USE Portfolioproject;


-- Creating the CovidDeaths and CovidVaccinations tables
CREATE TABLE IF NOT EXISTS CovidDeaths(
    iso_code VARCHAR(10) NOT NULL,                  -- Country ISO code, typically a short string
    continent VARCHAR(50),                 -- Continent name, short string
    location VARCHAR(100) NOT NULL,                 -- Location name, short string
    date varchar(20) NOT NULL,                             -- Date in 'YYYY-MM-DD' format
    population BIGINT,                     -- Population, a large integer
    total_cases BIGINT,                    -- Total number of cases, large integer
    new_cases BIGINT,                      -- Number of new cases, large integer
    new_cases_smoothed FLOAT,              -- Smoothed number of new cases, decimal
    total_deaths BIGINT,                   -- Total number of deaths, large integer
    new_deaths BIGINT,                     -- Number of new deaths, large integer
    new_deaths_smoothed FLOAT,             -- Smoothed number of new deaths, decimal
    total_cases_per_million FLOAT,         -- Total cases per million, decimal
    new_cases_per_million FLOAT,           -- New cases per million, decimal
    new_cases_smoothed_per_million FLOAT,  -- Smoothed new cases per million, decimal
    total_deaths_per_million FLOAT,        -- Total deaths per million, decimal
    new_deaths_per_million FLOAT,          -- New deaths per million, decimal
    new_deaths_smoothed_per_million FLOAT, -- Smoothed new deaths per million, decimal
    reproduction_rate FLOAT,               -- Reproduction rate, decimal
    icu_patients BIGINT,                   -- Number of ICU patients, large integer
    icu_patients_per_million FLOAT,        -- ICU patients per million, decimal
    hosp_patients BIGINT,                  -- Number of hospitalized patients, large integer
    hosp_patients_per_million FLOAT,       -- Hospitalized patients per million, decimal
    weekly_icu_admissions BIGINT,          -- Weekly ICU admissions, large integer
    weekly_icu_admissions_per_million FLOAT, -- Weekly ICU admissions per million, decimal
    weekly_hosp_admissions FLOAT,         -- Weekly hospital admissions, large integer
    weekly_hosp_admissions_per_million FLOAT
    
)

ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS CovidVaccinations (
    iso_code VARCHAR(10) NOT NULL,                    -- Country ISO code, typically a short string
    continent VARCHAR(50),                   -- Continent name, short string
    location VARCHAR(100) NOT NULL,                   -- Location name, short string
    date varchar(20) NOT NULL,                               -- Date in 'YYYY-MM-DD' format
    new_tests BIGINT,                        -- Number of new tests conducted, large integer
    total_tests BIGINT,                      -- Total number of tests conducted, large integer
    total_tests_per_thousand FLOAT,          -- Total tests per thousand people, decimal
    new_tests_per_thousand FLOAT,            -- New tests per thousand people, decimal
    new_tests_smoothed FLOAT,                -- Smoothed number of new tests, decimal
    new_tests_smoothed_per_thousand FLOAT,   -- Smoothed new tests per thousand people, decimal
    positive_rate FLOAT,                     -- Positive test rate, decimal
    tests_per_case FLOAT,                    -- Number of tests per confirmed case, decimal
    tests_units VARCHAR(50),                 -- Units used for tests (e.g., people tested, tests performed), short string
    total_vaccinations BIGINT,               -- Total number of vaccinations administered, large integer
    people_vaccinated BIGINT,                -- Number of people vaccinated, large integer
    people_fully_vaccinated BIGINT,          -- Number of people fully vaccinated, large integer
    new_vaccinations BIGINT,                 -- Number of new vaccinations administered, large integer
    new_vaccinations_smoothed FLOAT,         -- Smoothed number of new vaccinations, decimal
    total_vaccinations_per_hundred FLOAT,    -- Total vaccinations per hundred people, decimal
    people_vaccinated_per_hundred FLOAT,     -- People vaccinated per hundred, decimal
    people_fully_vaccinated_per_hundred FLOAT, -- People fully vaccinated per hundred, decimal
    new_vaccinations_smoothed_per_million FLOAT, -- Smoothed new vaccinations per million people, decimal
    stringency_index FLOAT,                  -- Stringency index (measures the strictness of lockdown policies), decimal
    population_density FLOAT,                -- Population density (people per square km), decimal
    median_age FLOAT,                        -- Median age of the population, decimal
    aged_65_older FLOAT,                     -- Percentage of the population aged 65 and older, decimal
    aged_70_older FLOAT,                     -- Percentage of the population aged 70 and older, decimal
    gdp_per_capita FLOAT,                    -- GDP per capita, decimal
    extreme_poverty FLOAT,                   -- Percentage of the population in extreme poverty, decimal
    cardiovasc_death_rate FLOAT,             -- Cardiovascular death rate per 100,000 people, decimal
    diabetes_prevalence FLOAT,               -- Diabetes prevalence (percentage of the population), decimal
    female_smokers FLOAT,                    -- Percentage of female smokers, decimal
    male_smokers FLOAT,                      -- Percentage of male smokers, decimal
    handwashing_facilities FLOAT,            -- Percentage of people with access to handwashing facilities, decimal
    hospital_beds_per_thousand FLOAT,        -- Number of hospital beds per thousand people, decimal
    life_expectancy FLOAT,                   -- Life expectancy at birth, decimal
    human_development_index FLOAT           -- Human Development Index, decimal
    
   
    
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;

-- Importing the CSV files
LOAD DATA INFILE 'C:/Users/ABDUL/Documents/Projects/SQL Data Exploration(Covid)/CovidVaccinations - CovidVaccinations.csv'
INTO TABLE portfolioproject.covidvaccinations
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/ABDUL/Documents/Projects/SQL Data Exploration(Covid)/CovidDeaths - CovidDeaths.csv'
INTO TABLE portfolioproject.coviddeaths
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(   
    iso_code,
    continent,
    location,
    date,
    population,
    total_cases,
    new_cases,
    new_cases_smoothed,
    total_deaths,
    new_deaths,
    new_deaths_smoothed,
    total_cases_per_million,
    new_cases_per_million,
    new_cases_smoothed_per_million,
    total_deaths_per_million,
    new_deaths_per_million,
    new_deaths_smoothed_per_million,
    reproduction_rate,
    icu_patients,
    icu_patients_per_million,
    hosp_patients,
    hosp_patients_per_million,
    weekly_icu_admissions,
    weekly_icu_admissions_per_million,
    weekly_hosp_admissions,
    weekly_hosp_admissions_per_million
);

-- Formatting the data
UPDATE portfolioproject.coviddeaths
SET new_cases_smoothed = NULL
WHERE new_cases_smoothed = '';

UPDATE portfolioproject.coviddeaths
SET new_deaths_smoothed = NULL
WHERE new_deaths_smoothed = '';

UPDATE portfolioproject.coviddeaths
SET new_cases_smoothed_per_million = NULL
WHERE new_cases_smoothed_per_million = '';

UPDATE portfolioproject.coviddeaths
SET new_deaths_smoothed_per_million = NULL
WHERE new_deaths_smoothed_per_million = '';

UPDATE portfolioproject.coviddeaths
SET reproduction_rate = NULL
WHERE reproduction_rate = '';

UPDATE portfolioproject.coviddeaths
SET icu_patients = NULL
WHERE icu_patients = '';

UPDATE portfolioproject.coviddeaths
SET icu_patients_per_million = NULL
WHERE icu_patients_per_million = '';

UPDATE portfolioproject.coviddeaths
SET hosp_patients = NULL
WHERE hosp_patients = '';

UPDATE portfolioproject.coviddeaths
SET hosp_patients_per_million = NULL
WHERE hosp_patients_per_million = '';

UPDATE portfolioproject.coviddeaths
SET weekly_icu_admissions = NULL
WHERE weekly_icu_admissions = '';

UPDATE portfolioproject.coviddeaths
SET weekly_icu_admissions_per_million = NULL
WHERE weekly_icu_admissions_per_million = '';

UPDATE portfolioproject.coviddeaths
SET weekly_hosp_admissions = NULL
WHERE weekly_hosp_admissions = '';

UPDATE portfolioproject.coviddeaths
SET weekly_hosp_admissions_per_million = NULL
WHERE weekly_hosp_admissions_per_million = '';

UPDATE portfolioproject.coviddeaths
SET new_cases_smoothed = NULL
WHERE new_cases_smoothed = '';

UPDATE portfolioproject.coviddeaths
SET continent = NULL
WHERE continent = '';

DESCRIBE portfolioproject.coviddeaths;

SHOW VARIABLES LIKE 'local_infile';

SHOW VARIABLES LIKE 'secure_file_priv';

DROP TABLE coviddeaths;
DROP TABLE covidvaccinations;

SELECT COUNT(*) AS row_count
FROM portfolioproject.coviddeaths;

SELECT COUNT(*) AS row_count
FROM portfolioproject.covidvaccinations;

DELETE FROM portfolioproject.coviddeaths;






