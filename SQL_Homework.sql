Use sakila;

#1a. Display the first and last names of all actors from the table actor.
SELECT 
	first_name,  last_name 
FROM 
		actor;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.

SELECT
	CONCAT(UPPER(first_name), ' ', UPPER(last_name)) as 'Actor Name'
FROM 
	actor;

#2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?

SELECT
	actor_id, first_name, last_name
FROM 
	actor
WHERE 
	first_name = 'JOE';

#2b. Find all actors whose last name contain the letters GEN:

SELECT
	first_name, last_name
FROM 
	actor
WHERE 
	last_name like '%GEN%';
    
#2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:

SELECT
	first_name, last_name
FROM 
	actor
WHERE 
	last_name like '%LI%'
ORDER BY 
	last_name, first_name;
    
#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:

SELECT
	country_id, country
FROM 
	country 
WHERE 
	country in ('Afghanistan', 'Bangladesh', 'China');

#3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.

ALTER TABLE 
	actor
ADD COLUMN 
	middle_name VARCHAR(180);

#3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.

ALTER TABLE 
	actor
ALTER COLUMN 
	middle_name Type bytea USING middle_name::bytea;