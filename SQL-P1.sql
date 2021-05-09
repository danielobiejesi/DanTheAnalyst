-- Data Exploration of World Covid-19 Statistics 
-- Date: May 2021
-- COVID  % Fatality 
SELECT 
	location,date,total_cases,total_deaths,
    (total_deaths/total_cases)*100 as '% Fatality'
FROM Portfolio1.coviddeaths
ORDER by 1,2 ;

-- % of Population infected with COVID-19 in Nigeria
SELECT 
	location,date,(total_cases),population,
    (total_cases/population)*100 as '% Infected'
FROM Portfolio1.coviddeaths
Where location = 'Nigeria'
ORDER by total_cases desc ;

-- Countries with Highest Number of Deaths
SELECT 
	location,MAX(CAST(total_deaths as UNSIGNED)) as TotalDeathCount
FROM 
	Portfolio1.coviddeaths
GROUP by location
Order by TotalDeathCount desc;

-- Countries with Highest infection rates per population
SELECT 
	location,((MAX(CAST(total_cases as UNSIGNED)))/population) as inf_rate
FROM 
	Portfolio1.coviddeaths
GROUP by location,population
Order by inf_rate desc;

-- Continent with Highest Number of infections
SELECT 
	continent,MAX(CAST(total_cases as UNSIGNED)) as TotalDeathCount
FROM 
	Portfolio1.coviddeaths
GROUP by continent
Order by TotalDeathCount desc;

-- Global Numbers
SELECT 
	sum(new_cases) as 'total_c',sum(cast(new_deaths as SIGNED)) as 'total_d',
	sum(cast(new_deaths as SIGNED))/sum(new_cases) as 'Death % '
FROM Portfolio1.coviddeaths
ORDER by 1,2 ;

-- using UNSIGNED to make blank spaces into '0' will cause issue with negative numbers 
-- Total Population vs vaccination 
SELECT 
    dea.location,max(dea.population), Max(SUM(cast(vac.new_vaccinations as SIGNED))) OVER (partition by dea.location)
FROM Portfolio1.coviddeaths as dea
Join Portfolio1.covidvaccinations as vac
	on dea.location = vac.location 
    and dea.date = vac.date
Group by dea.location



