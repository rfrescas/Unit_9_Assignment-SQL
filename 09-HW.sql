USE sakila;

-- 1a.
SELECT first_name, last_name FROM actor;

-- 1b.
SELECT concat(first_name, " ", last_name) AS "Actor Name" FROM actor;

-- 2a.
SELECT * FROM actor WHERE first_name = "Joe";

-- 2b.
SELECT * FROM actor WHERE last_name LIKE "%GEN%";

-- 2c.
SELECT last_name, first_name FROM actor WHERE last_name LIKE "%LI%";

-- 2d.
SELECT country_id, country FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3a.
ALTER TABLE actor
ADD description BLOB AFTER last_name;

-- 3b.
ALTER TABLE actor
DROP description;

-- 4a.
SELECT last_name, COUNT(last_name) AS total_count
FROM actor
GROUP BY last_name;

-- 4b.
SELECT last_name, COUNT(last_name) AS total_count
FROM actor
GROUP BY last_name
HAVING total_count > 1;

-- 4c.
UPDATE actor
SET first_name = "HARPO"
WHERE actor_id = 172;

-- 4d.
SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

-- 5a.
SHOW CREATE TABLE address;

-- 6a.
SELECT * FROM staff LIMIT 10;
SELECT * FROM address LIMIT 10;
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address
ON staff.address_id = address.address_id;

-- 6b.
SELECT * FROM staff LIMIT 10;
SELECT * FROM payment LIMIT 100;
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS "Total August Amount"
FROM payment
INNER JOIN staff
ON staff.staff_id = payment.staff_id
WHERE payment.payment_date >= '2005-08-01' and payment.payment_date < '2005-09-01'
GROUP BY staff.staff_id;

-- 6c.
SELECT * FROM film LIMIT 10;
SELECT * FROM film_actor LIMIT 10;
SELECT film.title, COUNT(film_actor.actor_id) AS "Total Actors"
FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY film.film_id;

-- 6d.
SELECT * FROM inventory WHERE film_id = 439;
SELECT * FROM film WHERE title = "Hunchback Impossible";
SELECT film.title, COUNT(inventory.inventory_id) AS "Total Copies"
FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE film.title = "Hunchback Impossible"
GROUP BY film.film_id;

-- 6e.
SELECT * FROM payment LIMIT 100;
SELECT * FROM customer LIMIT 100;
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS "Total Amount Paid"
FROM payment
INNER JOIN customer
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY last_name ASC;

-- 7a.
SELECT * FROM film LIMIT 10;
SELECT * FROM language LIMIT 10;
SELECT title
FROM film
WHERE language_id IN
	(
    SELECT language_id
    FROM language
    WHERE name = "English"
    )
    AND title LIKE "K%" OR title LIKE "O%";

-- 7b.
SELECT * FROM film LIMIT 10;
SELECT * FROM actor LIMIT 10;
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (
   SELECT film_id
   FROM film
   WHERE title = 'Alone Trip'
  )
);

-- 7c.
SELECT * FROM customer LIMIT 10;
SELECT * FROM address LIMIT 10;
SELECT * FROM city LIMIT 10;
SELECT * FROM country LIMIT 10;
SELECT first_name, last_name, email
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = "Canada"
GROUP BY customer.customer_id;

-- 7d.
SELECT * FROM film LIMIT 10;
SELECT * FROM category LIMIT 10;
SELECT * FROM film_category lIMIT 10;
SELECT title AS "Family Films"
FROM film
WHERE film_id IN
	(
    SELECT film_id
    FROM film_category
    WHERE category_id IN
		(
		SELECT category_id
		FROM category
		WHERE name = "Family"
		)
    );

-- 7e.
SELECT * FROM film LIMIT 10;
SELECT * FROM inventory LIMIT 10;
SELECT * FROM rental LIMIT 10;
SELECT film.title, COUNT(rental.rental_id) AS "Number of times rented"
FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY 2 DESC;

-- 7f.
SELECT * FROM store LIMIT 10;
SELECT * FROM staff LIMIT 10;
SELECT * FROM payment LIMIT 10;
SELECT store.store_id, SUM(payment.amount) AS "Total Business in dollars"
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 7g.
SELECT * FROM store LIMIT 10;
SELECT * FROM address LIMIT 10;
SELECT * FROM city LIMIT 10;
SELECT * FROM country LIMIT 10;
SELECT store.store_id, city.city, country.country
FROM store
INNER JOIN address
ON store.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id;

-- 7h.
SELECT * FROM category LIMIT 10;
SELECT * FROM film_category LIMIT 10;
SELECT * FROM inventory LIMIT 10;
SELECT * FROM payment LIMIT 10;
SELECT * FROM rental LIMIT 10;
SELECT category.name, SUM(payment.amount) AS "Total Revenue"
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN inventory
ON film_category.film_id = inventory.film_id
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.category_id
ORDER BY 2 DESC LIMIT 5;

-- 8a.
CREATE VIEW top_5_profit AS
SELECT category.name, SUM(payment.amount) AS "Total Revenue"
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN inventory
ON film_category.film_id = inventory.film_id
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.category_id
ORDER BY 2 DESC LIMIT 5;

-- 8b.
SELECT * from top_5_profit;

-- 8c.
DROP VIEW top_5_profit;

