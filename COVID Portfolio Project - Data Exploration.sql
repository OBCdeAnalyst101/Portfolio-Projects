
/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/
 --Covid19  World information between 2020-02-28 and 2021-04-30 

  
 Select *
 from PortfolioProject..CovidDeaths
 Where continent is not null
 order by 3,4

  Select *
 from PortfolioProject..CovidVaccinations
 Where continent is not null
 order by 3,4




 -- Selecting Data to be used for the project

 Select Location, date, total_cases, new_cases, total_deaths, population
 from PortfolioProject..CovidDeaths
 Where continent is not null
 order by 1,2




 -- Looking at the Total cases vs Total Deaths
 -- Shows the likelihood of dying if you contract covid in your country

 Select Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage 
 from PortfolioProject..CovidDeaths
 where location like '%Nigeria%' and continent is not null
 order by 1,2




 -- Looking at Total cases vs Population
 -- Shows what percentage of population got Covid

 Select Location, date,  population, total_cases,(total_cases/population) * 100 as PopulationPercentage
 from PortfolioProject..CovidDeaths
  where location like '%Nigeria%' and continent is not null
 order by 1,2




 -- Looking at Countries with hightest infection rate compared to population

 Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)) * 100 as PercentagePopulationInfected
 from PortfolioProject..CovidDeaths
  --where location like '%Nigeria%'
  Where continent is not null
 group by location, population
 order by PercentagePopulationInfected desc




 -- Showing countries with highest Death count per population

 Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount 
 from PortfolioProject..CovidDeaths
  --where location like '%Nigeria%'
  Where continent is not null
 group by location
 order by TotalDeathCount  desc




-- Let break things down by Continent
-- Showing the Continent with the highest death Count

 Select location, MAX(cast(total_deaths as int)) as TotalDeathCount 
 from PortfolioProject..CovidDeaths
  --where location like '%Nigeria%'
  Where continent is  null
 group by location
 order by TotalDeathCount  desc

 Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount 
 from PortfolioProject..CovidDeaths
  --where location like '%Nigeria%'
  Where continent is not null
 group by continent
 order by TotalDeathCount  desc



 -- GLOBAL NUMBERS 
 -- showing the total number of covid infection cases and total number of deaths globally
 
 Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/ SUM(new_cases) * 100 as DeathPercentageOverTotalCases
 from PortfolioProject..CovidDeaths
 where continent is not null
 order by 1,2





-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths as d
Join PortfolioProject..CovidVaccinations as v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 
order by 2,3





-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths as d
Join PortfolioProject..CovidVaccinations as v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac






-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths as d
Join PortfolioProject..CovidVaccinations as v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated






-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

--select *
--from PercentPopulationVaccinated



--Creating View to Visualize Total cases Vs Total Death

Create View DeathPercentage as
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage 
 from PortfolioProject..CovidDeaths
 where location like '%Nigeria%' and continent is not null
 --order by 1,2



 --Creating View to Visualize Total cases vs Population

 Create View PopulationPercentage as
 Select Location, date,  population, total_cases,(total_cases/population) * 100 as PopulationPercentage
 from PortfolioProject..CovidDeaths
  where location like '%Nigeria%' and continent is not null




  --Creating View to Visualize Countries with highest infection rate compared to population

  Create View PercentagePopulationInfected as
   Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)) * 100 as PercentagePopulationInfected
 from PortfolioProject..CovidDeaths
 Where continent is not null
 group by location, population




 --Creating View to Visualize Countries with highest Death count per population

 Create View TotalDeathCount as
 Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount 
 from PortfolioProject..CovidDeaths
 Where continent is not null
 group by location




 --Creating View to Visualize percentage of total cases over total number of deaths globally

 Create View DeathPercentageOverTotalCases as
 Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/ SUM(new_cases) * 100 as DeathPercentageOverTotalCases
 from PortfolioProject..CovidDeaths
 where continent is not null