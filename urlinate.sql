DELIMITER //

DROP FUNCTION IF EXISTS URLINATE//

CREATE FUNCTION URLINATE(id VARCHAR(100))
	RETURNS VARCHAR(100)
	DETERMINISTIC
	BEGIN
		DECLARE result VARCHAR(100);
		SET result = LOWER(id);
		SET result = REPLACE(result, ' ', '_');
		SET result = REPLACE(result, '/', '-');
		SET result = REPLACE(result, '/', '-');
		SET result = REPLACE(result, '(', '');
		SET result = REPLACE(result, ')', '');
		SET result = REPLACE(result, ',', '');
		SET result = REPLACE(result, '&', 'and');
		SET result = CONCAT(':', result);
		RETURN result;
	END //

DELIMITER ;