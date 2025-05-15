# Disney Hotstar
![Hotstar Logo](https://github.com/adityanairrr/Disney-Hotstar-SQL-Project/blob/main/Disney%2BHotstar.jpg)

## Overview
This project involves a comprehensive analysis of Disney Hotstar's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, Business problems and Solutions.

## Datasets
The Data of this Project is sourced from Kaggle:

- **Dataset Link:** [Content Datasets](https://www.kaggle.com/datasets/shivamb/disney-movies-and-tv-shows)

## Schema
  
  ```sql
  DROP TABLE IF EXISTS hotstar;
CREATE TABLE hotstar
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)

```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows
```sql
SELECT 
    type,
    COUNT(*)
FROM hotstar
GROUP BY 1;
```

### 2. List of all movies released in a specific year
```sql
SELECT * FROM hotstar WHERE release_year = 2018;
```

### 3. List of Directors with most content 
```sql
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
```

### 4. List of Top 10 Countries with most Content
```sql
SELECT country, COUNT(*) AS content_count
FROM hotstar
GROUP BY country
ORDER BY content_count DESC
LIMIT 10;
```

### 5. Identify the Longest Movie
```sql
SELECT 
    *
FROM hotstar
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;
```

### 6. Select all Contents where Director = Robert Vince
```sql
SELECT *
FROM (
    SELECT 
        *,
        UNNEST(STRING_TO_ARRAY(director, ',')) AS director_name
    FROM hotstar
) AS t
WHERE director_name = 'Robert Vince';
```

### 7. List of all Tv Shows with more than 3 seasons
```sql
SELECT *
FROM hotstar
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;
```

### 8. Count the No of items in each genres
```sql
  SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
    COUNT(*) AS total_content
FROM hotstar
GROUP BY 1;
```

### 9. Find each year and the average numbers of content release in United Kingdom on hotstar.
```sql
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
```

### 10. List of Contents without a director
```sql
SELECT * 
FROM hotstar
WHERE director IS NULL;
```

### 11. Find How Many Movies Actor 'Tom Hanks' Appeared in the Last 20 Years
```sql
SELECT * 
FROM hotstar
WHERE casts LIKE '%Tom Hanks%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 20;
```

### 12. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in United States
```sql
 SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*)
FROM hotstar
WHERE country = 'United States'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;
```

## Author - Aditya Nair
This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

## Connect with Me 

**:[Connect](www.linkedin.com/in/aditya-nair-489201245)**
