
-- función f_num_subordinates
DELIMITER //
CREATE OR REPLACE FUNCTION f_num_subordinates(p_employee_id INT) RETURNS INT
BEGIN 
	RETURN (
		SELECT COUNT(*) AS number_subordinates
		FROM employees e
		WHERE e.boss_id=p_employee_id AND e.end_date IS NULL 
	);
END //
DELIMITER ;

CALL p_populate();
SELECT f_num_subordinates(1);
 

-- procedimiento p_end_contract
-- DELIMITER //
-- 
-- CREATE OR REPLACE PROCEDURE p_end_contract(
-- 	p_employee_id INT,
-- 	p_end_date DATE
-- )
-- BEGIN 
-- 	DECLARE v_final_date INT;
-- 	DECLARE v_boss_id INT;
-- 	
-- 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
-- 	BEGIN
-- 		ROLLBACK; -- deshacemos los cambios
-- 		RESIGNAL;
-- 	END;
-- 	
-- 	START TRANSACTION;
	
	-- comprobamos que el empleado exista
	
