-- Checando as bases

select * 
from covid19..covid_deaths;

select *
from covid19..covid_vaccines;

-- Chance do cidadão com covid vir a obito devido ao vírus, no Brasil

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as PercMorte
From covid19..covid_deaths
Where location = 'Brazil'
and continent is not null
order by 1,2

-- Porcentagem da população infectada por covid no atual dia

Select Location, max(date) as date, max(Population) as Population, max(total_cases) Acumulated_cases,  ROUND((max(total_cases)/max(Population))*100,2) as PercPopInfec
From covid19..covid_deaths
Where Population is not null
and Population <> 0
Group by location
order by location;

--	TOP 10 Países com maiores taxas de infectados comparado a população

Select TOP 10 Location, Population, MAX(total_cases) as MaiTxInfec,  Max((total_cases/population))*100 as PercPopInfec
From covid19..covid_deaths
Where Population is not null
and Population <> 0
Group by Location, Population
order by PercPopInfec desc;

-- Top 20 países com mais mortes

Select TOP 20 Location, MAX(cast(Total_deaths as int)) as NumMorte
From covid19..covid_deaths
Where Population is not null
and Population <> 0
and location not in ('World', 'Upper middle income', 'High income', 'Lower middle income', 'Europe', 'Asia', 'North America', 'South America', 'European Union', 'Africa')
Group by Location
order by NumMorte desc;

-- Continentes com maior número de morte

Select continent, MAX(Total_deaths) as NumMortos
from covid19..covid_deaths
Where continent is not null
Group by continent
order by NumMortos desc;

-- Números globais diários

Select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths
from covid19..covid_deaths
Group by date
order by date;

-- Porcentagem da população que recebeu pelo menos uma dose da vacina no dia atual, em cada país

Select cd.location, max(cd.date) as date, (max(cv.people_vaccinated)/max(cd.Population))*100 as PercPopVac
From covid19..covid_deaths as cd
Join covid19..covid_vaccines as cv
on cd.location = cv.location
and cd.date = cv.date
Where cd.Population is not null
and cd.Population <> 0
Group by cd.location
order by cd.location;

-- Top 10 países com maior porcentagem da população totalmente vacinada

Select TOP 10 cd.location, max(cd.date) as date, (max(cv.people_fully_vaccinated)/max(cd.Population)) as PercTotVac
From covid19..covid_deaths as cd
Join covid19..covid_vaccines as cv
on cd.location = cv.location
and cd.date = cv.date
Where cd.Population is not null
and cd.Population <> 0
Group by cd.location
order by PercTotVac desc; 

-- Porcentagem de totalmente vacinados por continent

Select cd.continent, max(cd.date) as date, (max(cv.people_fully_vaccinated)/max(cd.Population)) as PercTotVac
from covid19..covid_deaths as cd
Join covid19..covid_vaccines as cv
on cd.location = cv.location
and cd.date = cv.date
Where cd.Population is not null
and cd.Population <> 0
and cd.continent is not null
Group by cd.continent
order by PercTotVac desc;




