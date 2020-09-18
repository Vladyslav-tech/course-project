-- при попытке добавить больше одного объявления пользователю,который НЕ риелтор - выбросить ошибку 

DELIMITER //

DROP TRIGGER IF EXISTS check_amount_of_advertisement_for_users_insert//
CREATE TRIGGER check_amount_of_advertisement_for_users_insert BEFORE INSERT ON advertisement 
FOR EACH ROW
BEGIN
    IF (NEW.user_id IN (select profiles.user_id
    	FROM profiles
    	WHERE rieltor = 0)
    AND NEW.user_id IN (select user_id
		FROM advertisement
		GROUP BY user_id 
		HAVING count(user_id ) > '1'
		ORDER BY user_id ))
    THEN
	SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Only a realtor can have more than one advertisement';
	END IF;
END//

DROP TRIGGER IF EXISTS check_amount_of_advertisement_for_users_update//
CREATE TRIGGER check_amount_of_advertisement_for_users_update BEFORE UPDATE ON advertisement 
FOR EACH ROW
BEGIN
    IF (NEW.user_id IN (select profiles.user_id
    	FROM profiles
    	WHERE rieltor = 0)
    AND NEW.user_id IN (select user_id
		FROM advertisement
		GROUP BY user_id 
		HAVING count(user_id ) > '1'
		ORDER BY user_id ))
    THEN
	SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Only a realtor can have more than one advertisement';
	END IF;
END//


DELIMITER ;