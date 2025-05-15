-- Disney Hotstar Project

CREATE TABLE Hotstar
(
show_id VARCHAR(6),
type	VARCHAR(10),
title	VARCHAR(150),
director	VARCHAR(210),
casts	VARCHAR(1000),
country	 VARCHAR(150),
date_added	VARCHAR(50),
release_year	INT,
rating	  VARCHAR(11),
duration	VARCHAR(15),
listed_in	VARCHAR(25),
description   VARCHAR(250)

);

-- Count the Number of Movies vs TV Shows

SELECT 
    type,
    COUNT(*)
FROM hotstar
GROUP BY 1;

-- List all movies released in a specific year

SELECT * FROM hotstar WHERE release_year = 2018;

-- Directors with most content 

SELECT
    director,
    COUNT(*) AS total_content
FROM
    hotstar
WHERE
    director != 'Unknown'  -- Exclude unknown directors
GROUP BY
    director
ORDER BY
    total_content DESC
LIMIT 10;

-- Top 10 Countries with most Content

SELECT country, COUNT(*) AS content_count
FROM hotstar
GROUP BY country
ORDER BY content_count DESC
LIMIT 10;

-- Identify the Longest Movie

SELECT 
    *
FROM hotstar
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;


-- Select all Contents where Director = Robert Vince

SELECT *
FROM (
    SELECT 
        *,
        UNNEST(STRING_TO_ARRAY(director, ',')) AS director_name
    FROM hotstar
) AS t
WHERE director_name = 'Robert Vince';

-- All Tv Shows with more than 3 seasons

SELECT *
FROM hotstar
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;

-- Count the No of items in each genres

  SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
    COUNT(*) AS total_content
FROM hotstar
GROUP BY 1;

-- Find each year and the average numbers of content release in United Kingdom on hotstar.

SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        COUNT(show_id)::numeric /
        (SELECT COUNT(show_id) FROM hotstar WHERE country = 'United Kingdom')::numeric * 100, 2
    ) AS avg_release
FROM hotstar
WHERE country = 'United Kingdom'
GROUP BY country, release_year
ORDER BY avg_release DESC
LIMIT 10;

-- Content without a director

SELECT * 
FROM hotstar
WHERE director IS NULL;

-- Find How Many Movies Actor 'Tom Hanks' Appeared in the Last 20 Years

SELECT * 
FROM hotstar
WHERE casts LIKE '%Tom Hanks%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 20;

-- Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in United States

 SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*)
FROM hotstar
WHERE country = 'United States'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;
