-- подсчитаем сколько объявлений от каждого застройщика

DROP VIEW IF EXISTS tbl_1;
CREATE VIEW tbl_1 AS
SELECT count(advertisement.id) as count_of_advertisements, developers.name
	FROM advertisement
	JOIN developers ON advertisement.estate_id IN (
		SELECT id FROM estate 
		WHERE developers_id = developers.id)
	GROUP BY developers.name
	ORDER BY count_of_advertisements;


-- у какого юзера больше всего объявлений в избранном

DROP VIEW IF EXISTS tbl_2;
CREATE VIEW tbl_2 AS
SELECT favourite.user_id,users.lastname,users.firstname,COUNT(favourite.advertisement_id) as 'amount_of_favourite'
	FROM favourite
	JOIN users ON favourite.user_id = users.id 
	GROUP BY users.id
	ORDER BY COUNT(advertisement_id) DESC
	LIMIT 1;
	



		
	
	