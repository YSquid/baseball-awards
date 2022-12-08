--Heaviest Hitters *Winner - 2009 Chicago White Sox
SELECT
	AVG(people.weight),
	batting.yearid,
	teams.name
FROM
	people
	INNER JOIN batting ON people.playerid = batting.playerid
	INNER JOIN teams ON batting.teamid = teams.teamid
GROUP BY
	batting.yearid,
	teams.name
ORDER BY
	AVG(people.weight) DESC;

-- Shortest Sluggers *Winner - 1872 Middletown Mansfields
SELECT
	AVG(people.height),
	batting.yearid,
	teams.name
FROM
	people
	INNER JOIN batting ON people.playerid = batting.playerid
	INNER JOIN teams ON batting.teamid = teams.teamid
GROUP BY
	batting.yearid,
	teams.name
ORDER BY
	AVG(people.height) ASC;

--Biggest Spenders *Winner - 2013 New York Yankees
SELECT
	SUM(salary),
	teams.name,
	salaries.yearid
FROM
	salaries
	LEFT JOIN teams ON teams.teamid = salaries.teamid
	AND teams.yearid = salaries.yearid
GROUP BY
	teams.name,
	salaries.yearid
ORDER BY
	SUM(salary) DESC;

--Bang for their buck 2010 *Winner - 2010 San Diego Padres
SELECT
	SUM(salary) AS total_salary,
	teams.name,
	salaries.yearid,
	teams.w AS wins,
	ROUND(SUM(salary) / teams.w) AS dollar_per_win
FROM
	salaries
	LEFT JOIN teams ON teams.teamid = salaries.teamid
	AND teams.yearid = salaries.yearid
WHERE
	teams.yearid = 2010
GROUP BY
	teams.name,
	teams.w,
	salaries.yearid
ORDER BY
	SUM(salary) / teams.w ASC;

--Priciest Starter *Winner - Cliff Lee 2014
SELECT
	pitching.g,
	pitching.yearid,
	pitching.playerid,
	salaries.salary,
	salaries.yearid,
	ROUND(salaries.salary / pitching.g) AS salary_per_start,
	people.namefirst,
	people.namelast
FROM
	salaries
	INNER JOIN pitching ON pitching.playerid = salaries.playerid
	AND pitching.yearid = salaries.yearid
	AND pitching.teamid = salaries.teamid
	INNER JOIN people ON pitching.playerid = people.playerid
WHERE
	pitching.playerid IS NOT NULL
	AND pitching.g > 9
ORDER BY
	ROUND(salaries.salary / pitching.g) DESC;

--Bean Machine (min 100 batters faced) *Winner Alberto Castillo @ 5.79% 
SELECT
	people.namefirst,
	people.namelast,
	SUM(pitching.hbp) AS batters_hit,
	SUM(pitching.bfp) AS batters_faced,
	pitching.playerid,
	(
		CAST (SUM(pitching.hbp) AS float) / CAST (SUM(pitching.bfp) AS float)
	) * 100 AS percent_hit
FROM
	pitching
	JOIN people ON pitching.playerid = people.playerid
WHERE
	pitching.hbp IS NOT NULL
	AND pitching.bfp > 100
GROUP BY
	pitching.playerid,
	people.namefirst,
	people.namelast
ORDER BY
	6 DESC;

--CANADIAN ACE (min 25 games) *Winner Joaquin Benoit. 0.38 on 25 games
SELECT
	pitching.playerid,
	people.namefirst,
	people.namelast,
	SUM(pitching.g) AS career_games,
	AVG(pitching.era) AS career_avg_era,
	pitching.teamid,
	teams.name,
	teams.park,
	parks.country
FROM
	pitching
	JOIN teams ON pitching.teamid = teams.teamid
	AND pitching.yearid = teams.yearid
	JOIN people ON pitching.playerid = people.playerid
	JOIN parks ON teams.park = parks.parkname
WHERE
	parks.country = 'CA'
GROUP BY
	pitching.playerid,
	people.namefirst,
	people.namelast,
	pitching.teamid,
	teams.name,
	teams.park,
	parks.country
HAVING
	SUM(pitching.g) > 24
ORDER BY
	5 ASC;

--Highest earner since 1985 *Winner Alex Rodriguez @ $398,416,252

SELECT
	SUM(salaries.salary),
	salaries.playerid,
	people.namefirst,
	people.namelast
FROM salaries
JOIN people
ON salaries.playerid = people.playerid
GROUP BY
	salaries.playerid
ORDER BY
	1
	DESC;