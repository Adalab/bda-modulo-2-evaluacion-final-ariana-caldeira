
USE sakila;

-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 1: nombres de * las películas sin que aparezcan duplicados
SELECT DISTINCT title
	FROM film;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 2: nombres de * las películas que tengan una clasificación de "PG-13"
SELECT title
	FROM film
    WHERE rating = "PG-13";
    
    
-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 3: título y descripción de todas las películas que contengan la palabra "amazing" en su descripción
SELECT title, description 
	FROM film
    WHERE description LIKE "%amazing%";


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 4: título de * las películas que tengan una duración mayor a 120 minutos
SELECT title
	FROM film
    WHERE length > 120;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 5: nombres de * los actores
SELECT first_name AS Nombre
	FROM actor;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 6: nombre y apellido de los actores que tengan "Gibson" en su apellido
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE last_name LIKE "%Gibson%"; -- si queremos que contenga la palabra 'Gibson'
    
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE last_name = "Gibson"; -- si queremos que el apellido sea solamente 'Gibson'


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 7: nombres de los actores que tengan un actor_id entre 10 y 20
SELECT first_name AS Nombre
	FROM actor
    WHERE actor_id >= 10 AND actor_id <= 20;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 8: título de las películas que su clasificación no sea ni "R" ni "PG-13"
SELECT title, rating
	FROM film
    WHERE rating NOT IN("R", "PG-13");


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 9: cantidad total de películas en cada clasificación y muestra la clasificación junto con el recuento.
SELECT rating, COUNT(title)
	FROM film
    GROUP BY rating;  -- usamos group by para agruparlas por las categorias del rating


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 10: cantidad de películas alquiladas por cada cliente y muestra el ID nombre y apellido junto con la cantidad
-- customer: customer_id, first_name, last_name
-- rental: rental_id, customer_id
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS Total_Rents
	FROM customer AS c
    INNER JOIN rental AS r
    WHERE c.customer_id = r.customer_id
    GROUP BY c.customer_id;
    

-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 11: cantidad de películas alquiladas por por categoría y muestra el nombre de la categoría y el recuento de alquileres
-- rental: rental_id, inventory_id
-- inventory: inventory_id, film_id
-- film_category: film_id, category_id
-- category: category_id, name
SELECT c.name, COUNT(r.rental_id) AS Total_Rents
	FROM rental AS r
    INNER JOIN inventory AS i
		ON r.inventory_id = i.inventory_id
	INNER JOIN film_category AS fc
		ON i.film_id = fc.film_id
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	GROUP BY c.name;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 12: promedio duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio
-- film: film_id, title, length
-- film_category: film_id, category_id
-- category: category_id, name
SELECT rating, COUNT(title)
	FROM film
    GROUP BY rating; 







    
    
    