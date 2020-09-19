--  выводим список рекомендованных квартир выбранному пользователю по его городу и по параметрам квартир,которые у него в избранном.



DELIMITER //
DROP PROCEDURE IF EXISTS estate_offers//
CREATE PROCEDURE estate_offers (IN user_id BIGINT)
BEGIN
	SELECT advertisement.id FROM advertisement WHERE estate_id IN (
		SELECT estate.id FROM estate WHERE quantity_of_rooms = (
		SELECT quantity_of_rooms FROM estate WHERE id = (
		SELECT id FROM advertisement WHERE id = (
		SELECT advertisement_id FROM favourite WHERE favourite.user_id = user_id ))))
	
	AND estate_id IN (
	
	
	SELECT estate.id FROM estate WHERE adress_id IN (
		SELECT adress.id FROM adress WHERE adress.city = (
		SELECT profiles.hometown FROM profiles WHERE profiles.user_id = user_id)));
END//

DELIMITER ;

CALL estate_offers ('3');
