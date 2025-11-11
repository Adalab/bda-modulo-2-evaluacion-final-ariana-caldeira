
USE sakila;

-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 1: nombres de * las películas sin que aparezcan duplicados
SELECT DISTINCT title
	FROM film;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 2: nombres de * las películas que tengan una clasificación de "PG-13"
SELECT title
	FROM film
    WHERE rating = 'PG-13';
    
    
-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 3: título y descripción de todas las películas que contengan la palabra "amazing" en su descripción
SELECT title, description 
	FROM film
    WHERE description LIKE '%amazing%';


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 4: título de * las películas que tengan una duración mayor a 120 minutos
SELECT title
	FROM film
    WHERE length > 120;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 5: nombres de * los actores
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 6: nombre y apellido de los actores que tengan "Gibson" en su apellido
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE last_name LIKE '%Gibson%'; -- si queremos que contenga la palabra 'Gibson'
    
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE last_name = 'Gibson'; -- si queremos que el apellido sea solamente 'Gibson'


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 7: nombres de los actores que tengan un actor_id entre 10 y 20
SELECT actor_id, first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE actor_id >= 10 AND actor_id <= 20;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 8: título de las películas que su clasificación no sea ni "R" ni "PG-13"
SELECT title, rating
	FROM film
    WHERE rating NOT IN('R', 'PG-13');


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 9: cantidad total de películas en cada clasificación y muestra la clasificación junto con el recuento.
SELECT rating, COUNT(title)
	FROM film
    GROUP BY rating;  -- usamos group by para agruparlas por las categorias del rating


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 10: cantidad de películas alquiladas por cada cliente y muestra el ID nombre y apellido junto con la cantidad
-- customer: customer_id, first_name, last_name
-- rental: rental_id, customer_id
SELECT c.customer_id AS ID, c.first_name AS Nombre, c.last_name AS Apellido, COUNT(r.rental_id) AS Total_Rents
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
SELECT c.name AS Categoria, COUNT(r.rental_id) AS Total_Rents
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
-- film: film_id, title, length, rating
SELECT rating AS Clasificación, AVG(length) AS Duración_promedio
	FROM film
    GROUP BY rating;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 13: nombre de los actores que aparecen en la película con title "Indian Love"
-- actor: first_name, last_name
-- film_actor: actor_id, film_id
-- film: film_id, title
SELECT a.first_name AS Nombre, a.last_name AS Apellido
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	INNER JOIN film AS f
		ON fa.film_id = f.film_id
	WHERE f.title = "Indian Love";


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 14: * las películas que contengan la palabra "dog" o "cat" en su descripció
SELECT title
	FROM film
    WHERE description LIKE '%dog%' OR description LIKE '%cat%';
    
    
-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 15: Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
-- actor: actor_id, first;name, last_name
-- film_actor: actor_id, film_id
SELECT a.first_name, a.last_name, fa.film_id
	FROM actor AS a
    LEFT JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	WHERE fa.film_id IS NULL;  -- no hay ningun actor que no aparezca en las películas de la tabla film_actor
    
    
-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 16: * las películas que fueron lanzadas entre el año 2005 y 2010
SELECT title AS Película, release_year AS Año
    FROM film
    WHERE release_year >= 2005 AND release_year <= 2010;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 17: * las películas que son de la misma categoría que "Family"
-- film: film_id, title
-- film_category: film_id, catgeory_id
-- category: category_id, name
SELECT f.title AS Película, c.name AS Categoría
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	WHERE c.name = "Family";
    

-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 18: nombre y apellido de los actores que aparecen en más de 10 películas
-- actor: actor_id, first_name, last_name
-- film_actor: actor_id, film_id
SELECT a.first_name AS Nombre, a.last_name AS Apellido
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	GROUP BY a.first_name, a.last_name
	HAVING COUNT(fa.film_id) > 10;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 19: todas las películas que son "R" y tienen una duración mayor a 2h en la tabla film.
-- 2h = 120 minutos
-- películas que son "R" asumo que se refiere al rating
SELECT title AS Película, rating, length AS Duración
	FROM film
    WHERE rating = "R" AND length > 120;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 20: categorías de películas con promedio de duración superior a 120 minutos y muestra la categoría junto con el promedio de duración.
-- category: category_id, name
-- film_category: category_id, film_id
-- film: film_id, length
SELECT c.name AS Categoría, AVG(f.length) AS Duración_promedio
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
	GROUP BY c.name
	HAVING AVG(f.length) > 120;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 21: nombre y apellido de los actores que han actuado al menos en 5 películas
-- actor: actor_id, first_name, last_name
-- film_actor: actor_id, film_id
SELECT a.first_name AS Nombre, a.last_name AS Apellido, COUNT(fa.film_id) AS Total_Películas
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	GROUP BY a.first_name, a.last_name
	HAVING COUNT(fa.film_id) >= 5;


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 22: películas alquilas por más de 5 días. Usa una subconsulta para encontrar los rental_ids con más de 5 días
-- rental: rental_id, rental_date, return_date, inventory_id
-- inventory: inventory_id, film_id
-- film: film_id, title
SELECT rental_id
	FROM rental
	WHERE DATEDIFF(return_date, rental_date) > 5;

SELECT DISTINCT f.title            -- usé distinct porque los nombres de las pelis me salian repetidos
	FROM film AS f
    INNER JOIN inventory AS i
		ON f.film_id = i.film_id
	INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id
	WHERE r.rental_id IN (SELECT rental_id
								FROM rental
								WHERE DATEDIFF(return_date, rental_date) > 5);


-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 23: nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror"
-- Usa una subconsulta para encontrar los actores que han actuado en esa categoría y luego exclúyelos de la lista de actores
-- actor: first_name, last_name
-- film_actor: actor_id, film_id
-- film_category: film_id, category_id
-- category: category_id, name

SELECT a.actor_id     -- esta es la subconsulta
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	INNER JOIN film_category AS fc
		ON fa.film_id = fc.film_id
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
        WHERE c.name = 'Horror';

SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE actor_id NOT IN (SELECT a.actor_id
								FROM actor AS a
								INNER JOIN film_actor AS fa
									ON a.actor_id = fa.actor_id
								INNER JOIN film_category AS fc
									ON fa.film_id = fc.film_id
								INNER JOIN category AS c
									ON fc.category_id = c.category_id
									WHERE c.name = 'Horror');
                                    

-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 24: películas que son comedias y tienen duración superior a 180 minutos
-- film: film_id, title, length
-- film_category: film_id, category_id
-- category: category_id, name
SELECT f.title AS Película, f.length AS Duración, c.name AS Categoría
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	WHERE c.name = 'Comedy' AND f.length > 180;
    

-- -- -- -- -- -- -- -- -- -- -- -- --
# EJERCICIO 24: Encuentra todos los actores que han actuado juntos en al menos una película.
-- La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.
