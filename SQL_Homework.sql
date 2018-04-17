Use sakila;

#####1a. Display the first and last names of all actors from the table actor.
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
Modify COLUMN 
	middle_name blob;
    
#3c. Now delete the middle_name column.

ALTER TABLE actor DROP COLUMN middle_name;

#4a. List the last names of actors, as well as how many actors have that last name.

SELECT 
	last_name, COUNT(last_name) AS actors_with_this_lastname
FROM 
	actor
GROUP BY 
	last_name
ORDER BY 
	COUNT(last_name) DESC;

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT 
	last_name, COUNT(last_name) AS actors_with_lastname
FROM 
	actor
GROUP BY 
	last_name
HAVING 
	COUNT(last_name) >= 2 
ORDER BY 
	COUNT(last_name) DESC;

#4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.

UPDATE 
	actor
SET 
	first_name  = 'HARPO'
WHERE 
	first_name = 'GROUCHO' and last_name = 'WILLIAMS';
    
#4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)

UPDATE 
	actor
SET first_name  = 
( 
	CASE WHEN first_name = 'HARPO' THEN 'GROUCHO'
	ELSE 'MUCHO GROUCHO'
    END
)     
WHERE 
	actor_id = 172;
    
#6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:

SELECT
	s.first_name,
	s.last_name,
	a.address
FROM 
	staff s
INNER JOIN 
	address a
	ON s.address_id = a.address_id;

#6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.

SELECT
	s.first_name,
	s.last_name,
	SUM(p.amount) as Total_Amt
FROM 
	staff s
INNER JOIN payment p 
	ON s.staff_id = p.staff_id
WHERE
	EXTRACT(month FROM payment_date) = 8 AND 
    EXTRACT(year FROM payment_date) = 2005
GROUP BY 
	s.first_name, s.last_name;
    
#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

SELECT
	f.film_id, f.title, COUNT(fa.actor_id) as Number_of_Actors
FROM 
	film f
INNER JOIN film_actor fa
	ON f.film_id = fa.film_id
GROUP BY 
	f.film_id,f.title
ORDER BY
	film_id;

