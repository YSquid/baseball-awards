--Heaviest Hitters *Winner - 2009 Chicago White Sox
SELECT
	AVG(people.weight),
  batting.yearid,
  teams.name
FROM people
INNER JOIN batting
	ON people.playerid = batting.playerid
INNER JOIN teams
	ON batting.teamid = teams.teamid
GROUP BY batting.yearid, teams.name
ORDER BY AVG(people.weight) DESC;

-- Shortest Sluggers *Winner - 1872 Middletown Mansfields
SELECT
	AVG(people.height),
  batting.yearid,
  teams.name
FROM people
INNER JOIN batting
	ON people.playerid = batting.playerid
INNER JOIN teams
	ON batting.teamid = teams.teamid
GROUP BY batting.yearid, teams.name
ORDER BY AVG(people.height) ASC;

--Biggest Spenders *Winner - 2013 New York Yankees

SELECT 
	SUM(salary), 
	teams.name, 
	salaries.yearid 
FROM salaries
LEFT JOIN teams 
	ON teams.teamid = salaries.teamid 
	AND teams.yearid = salaries.yearid
GROUP BY 
	teams.name, 
	salaries.yearid
ORDER BY
	SUM(salary) 
	DESC;

--Bang for their buck 2010 *Winner - 2010 San Diego Padres

SELECT 
	SUM(salary) AS total_salary,
	teams.name, 
	salaries.yearid,
  teams.w AS wins,
  ROUND(SUM(salary) / teams.w) AS dollar_per_win
FROM salaries
LEFT JOIN teams 
	ON teams.teamid = salaries.teamid 
	AND teams.yearid = salaries.yearid
WHERE teams.yearid = 2010
GROUP BY 
	teams.name, 
  teams.w,
	salaries.yearid
ORDER BY
	SUM(salary) / teams.w
	ASC;


--Priciest Starter *Winner - Cliff Lee 2014

SELECT
    pitching.g,
    pitching.yearid,
    pitching.playerid,
    salaries.salary,
    salaries.yearid,
    ROUND(salaries.salary /  pitching.g) AS salary_per_start,
    people.namefirst,
    people.namelast
FROM salaries
INNER JOIN pitching
    ON pitching.playerid = salaries.playerid
    AND pitching.yearid = salaries.yearid
    AND pitching.teamid =  salaries.teamid
INNER JOIN people
		ON pitching.playerid = people.playerid
WHERE pitching.playerid IS NOT NULL
AND pitching.g > 9
ORDER BY ROUND(salaries.salary /  pitching.g) DESC;


