# Get all pairs of actors that worked together.
SELECT F1.actor_id, F2.actor_id, F1.film_id
FROM film_actor F1
INNER JOIN film_actor F2 ON F2.actor_id<>F1.actor_id and F2.film_id=F1.film_id;

SELECT concat(A.last_name,'_', A.first_name) as actor, sub1.actor, F.title
FROM film_actor F_A
INNER JOIN actor A ON A.actor_id=F_A.actor_id
INNER JOIN film F on F.film_id=F_A.film_id
INNER JOIN (
			SELECT concat(A.last_name,'_', A.first_name) as actor
            , F_A_2.actor_id as act_ID, F_A_2.film_id as film_id
			FROM film_actor F_A_2
			INNER JOIN actor A ON A.actor_id=F_A_2.actor_id) sub1 
            ON sub1.act_ID<>F_A.actor_id and sub1.film_id=F_A.film_id;


# Get all pairs of customers that have rented the same film more than 3 times.
SELECT R.customer_id,sub1.second_customer, I.film_id as film_id, count(I.film_id) as number_of_rents
FROM rental R
INNER JOIN inventory I ON I.inventory_id=R.inventory_id
INNER JOIN(
		   SELECT R2.customer_id as second_customer, I2.film_id as film_2_id, count(I2.film_id) as number_of_rents2
		   FROM rental R2
           INNER JOIN inventory I2 ON I2.inventory_id=R2.inventory_id
           group by R2.customer_id, I2.film_id
           HAVING count(I2.film_id)>1) sub1
           ON sub1.film_2_id=film_id and sub1.second_customer<>customer_id
group by R.customer_id,sub1.second_customer, I.film_id
HAVING count(I.film_id)>1;



# Get all possible pairs of actors and films.
SELECT * FROM FILM CROSS JOIN actor;