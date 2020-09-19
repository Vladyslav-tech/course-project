-- вывод рекомендованных объявлений выбранного пользователя по его городу и количеству комнат в его избранном

DELIMITER // 

DROP PROCEDURE IF EXISTS estate_offers_2//
CREATE PROCEDURE estate_offers_2 (IN user_id BIGINT)
BEGIN
	SELECT *
FROM (SELECT advertisement.id, estate_id , quantity_of_rooms,adress_id ,adress.city, profiles.hometown 
	FROM advertisement
	JOIN estate ON advertisement.estate_id = estate.id  
	JOIN adress ON adress.id = estate.adress_id 
	JOIN profiles ON adress.city = profiles.hometown
	WHERE profiles.user_id = user_id
	GROUP BY advertisement.id
	ORDER BY advertisement.id) as all_of
WHERE quantity_of_rooms = (
			SELECT * FROM 
			(SELECT quantity_of_rooms 
	   		FROM estate
	   		JOIN advertisement ON advertisement.estate_id = estate.id 
	   		JOIN favourite ON advertisement.id = favourite.advertisement_id 
	   		WHERE advertisement.user_id = user_id) AS all_of )
;
END//

DELIMITER ;

CALL estate_offers_2 ('3'); 