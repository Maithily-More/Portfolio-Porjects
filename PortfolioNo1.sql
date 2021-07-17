/* 

COVID-19 DATA EXPLORATION
Skills used : Joins, Aggregate functions, Tables

*/

Select *
From PortfolioProject..CovidDeaths
order by 3,4


--Select data that we are going to be starting with

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

-- Looking at total cases vs total deaths
 --Shows likelihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from PortfolioProject..CovidDeaths
where location like '%India%'
order by 1,2

--looking at total cases Vs population
--showing the percentage of population affected by covid in india
select location, date, total_cases, population,(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
where location like '%India%'
order by 1,2

--Looking at countries with highest infected rate compared to population 

select location, date, MAX(total_cases) as HighestInfected, population, MAX((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%India%'
Group by Location, date, population 
order by PercentPopulationInfected desc

--Looking at countreis with highest death count per population

select location, max(total_deaths) as TotalDeathCounts 
from PortfolioProject..CovidDeaths
--where location like '%India%'
Group by Location
order by TotalDeathCounts desc

--LET US BREAK THINGS DOWN BY CONTINENT

select continent, max(cast(total_deaths as int)) as TotalDeathCounts 
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not NULL
Group by continent
order by TotalDeathCounts desc

select location, max(cast(total_deaths as int)) as TotalDeathCounts 
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is NULL
Group by location
order by TotalDeathCounts desc

--Advance things in SQL (showing continent with highest death count)

select continent, max(total_deaths) as HighestDeathContinent
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by HighestDeathContinent desc


--GLOBAL NUMBERS

select date, SUM(new_cases), SUM(cast(new_deaths as int)) --total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not NULL
Group by date
order by 1,2

select SUM(new_cases) as totalcases, SUM(cast(new_deaths as int)) as totaldeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Deathpercentage
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not NULL
--Group by date
order by 1,2
	




--COVID VACCINES DB

select *
from PortfolioProject..Covidvaccine

--JOIN TWO TABLES

select *
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..Covidvaccine vac
	on dea.location = vac.location
	and dea.date = vac.date

--looking at total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..Covidvaccine vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not NULL
order by 1,2,3

