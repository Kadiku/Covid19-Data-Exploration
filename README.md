# COVID-19 Data Exploration (January 2020 - April 2021)

## Table of Contents
- [Project Overview](#project-overview)
- [Data Source](#data-source)
- [Features](#features)
- [Tools](#tools-used)
- [Data Cleaning/Preparation](#data-cleaningpreparation)
- [How to Use](#how-to-use)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Results/Findings](#results-findings)
- [Files in Repo](#files-in-repo)
- [Installation](#installation)

---

## Project Overview
This project explores COVID-19 data from January 2020 to April 2021. The analysis includes case trends, death rates, infection rates, and vaccination progress globally, regionally, and specifically for Nigeria. Advanced SQL techniques such as CTEs, temp tables, joins, and window functions were used to derive insights.

---

## Data Source
The datasets were sourced from the AlextheAnalyst public github repository, including:  
- COVID-19 Deaths excel file  
- COVID-19 Vaccination excel file  

---

## Features
- Explores COVID-19 cases and deaths globally and regionally.  
- Analyzes infection and death rates in relation to population.  
- Tracks vaccination progress across countries and continents.  
- Provides breakdowns by location, population, and vaccination percentages.  
- Creates reusable views for visualizations.  

---

## Tools Used
- **SQL** for querying and data manipulation.  
- **MySQL Workbench** for database management.  
- **GitHub** for version control.  

---

## Data Cleaning/Preparation
In the initial data preparation phase,i performed the follwoing tasks:
- Converted the excel files to csv files for easier importation
- Filtered out rows with null values in the `continent` column and some more.  
- Standardized and ensured data consistency across tables.  
- Handled blank and zero values by converting them to `NULL`.  
- Calculated key metrics like infection and death rates.  
- Ensured proper indexing and grouping for efficient query performance.  

---

## How to Use
1. Import the `coviddeaths.csv` and `covidvaccinations.csv` datasets into your MySQL database.  
2. Use the provided SQL scripts to analyze the data.  
3. Adjust the queries to focus on specific locations or metrics of your choice.  
4. Visualize the insights using tools like Power BI or Tableau.

---

## Exploratory Data Analysis
EDA involved exploring the datasets to answers questions, such as:

- What is the percentage of deaths among the total cases in Nigeria?  
- How do total cases and total deaths compare globally and regionally?
- What are the total vaccinations administered globally?
- What is the rolling count of vaccinations for each country over time?
- What percentage of the population is vaccinated in Nigeria?
- Which countries have the highest vaccination rates?

---

## Data Analysis

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



---

## Results-Findings
- 1.2495% of the total infected Nigerian population died, highlighting the severity of the infection's impact on public health. 
- The total number of cases is 150,574,977, with 3,180,206 total deaths, resulting in a death rate of 2.112%.
- A total of 233,100 vaccinations have been administered in Nigeria, representing 0.1131% of the total population. 
- A total of 3,359,424,626 vaccinations have been administered globally.

---

## Files in Repo
- **`CovidDeaths.csv`**: Contains the data for COVID-19 deaths.  
- **`CovidVaccinations.csv`**: Contains the data for COVID-19 vaccinations.
- **`Data importation.sql`**: Contains SQL queries for importing the csv files into MySQL workbench.  
- **`Covid Dataset(April 2021) Exploration.sql`**: Contains SQL queries for analyzing both COVID-19 deaths and COVID-19 vaccinations.
- **`README.md`**: This file, explaining the project.  

---

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/Kadiku/Covid19-Data-Exploration.git
