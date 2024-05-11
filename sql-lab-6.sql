-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT TITLE, LENGTH, RANK() OVER(ORDER BY LENGTH DESC) AS RANKING
FROM SAKILA.FILM
WHERE LENGTH <>' ' ;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
SELECT TITLE, LENGTH, RATING, RANK() OVER(PARTITION BY RATING ORDER BY LENGTH DESC) AS RANKING
FROM SAKILA.FILM
WHERE LENGTH <>' ' ;

-- How many films are there for each of the categories in the category table?
--  Hint: Use appropriate join between the tables "category" and "film_category".

SELECT CAT.NAME, FCAT.CATEGORY_ID, count(f.film_id) AS n_films
FROM SAKILA.CATEGORY CAT
LEFT JOIN SAKILA.FILM_CATEGORY FCAT
ON CAT.CATEGORY_ID = FCAT.CATEGORY_ID
left join sakila.film f
on f.film_id = fcat.film_id
GROUP BY 1,2
ORDER BY 3 desc
;

-- Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT A.FIRST_NAME, A.LAST_NAME, A.ACTOR_ID, COUNT(FA.FILM_ID) AS FILME_PER_ACTOR
FROM SAKILA.ACTOR A
LEFT JOIN SAKILA.FILM_ACTOR FA
ON A.ACTOR_ID = FA.ACTOR_ID
GROUP BY 1,2,3
ORDER BY 4 DESC;

-- -- Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT C.FIRST_NAME, C.LAST_NAME, COUNT(R.RENTAL_ID) AS BEST_CUSTOMER
FROM SAKILA.CUSTOMER C
LEFT JOIN SAKILA.RENTAL R
ON C.CUSTOMER_ID = R.CUSTOMER_ID
GROUP BY 1,2
ORDER BY 3 DESC
;

-- BONUS
SELECT F.TITLE, F.FILM_ID, I.FILM_ID, COUNT(R.RENTAL_ID) AS BEST_MOVIE
FROM SAKILA.FILM F
LEFT JOIN SAKILA.INVENTORY I
ON F.FILM_ID = I.FILM_ID
INNER JOIN SAKILA.RENTAL R
ON I.INVENTORY_ID = R.INVENTORY_ID
GROUP BY 1,2,3
ORDER BY 4 DESC;
;