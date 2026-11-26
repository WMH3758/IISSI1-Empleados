
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

-- procedimiento p_end_contract
DELIMITER //

CREATE OR REPLACE PROCEDURE p_end_contract(
	p_employee_id INT,
	p_end_date DATE
)
BEGIN 
	DECLARE v_end_date DATE;
	DECLARE v_boss_id INT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK; -- deshacemos los cambios
		RESIGNAL;
	END;
	
	START TRANSACTION;
	
	SELECT e.employee_id, e.end_date INTO v_boss_id, v_end_date
	FROM employees e
	WHERE e.employee_id=p_employee_id;
	
	-- verrificamos si el usuario existe en nuestra base de datos
	IF NOT EXISTS(SELECT * FROM employees e WHERE e.employee_id=p_employee_id) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='El usuario no existe';
	END IF;
	
	-- Verificamos si ya ha terminado su contrato
	IF v_end_date IS NOT NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='El usuario ya tiene finalizado su contrato';
	END IF;
	
	-- asignamos fecha de fin a cada empleado
	UPDATE employees e
	SET e.end_date = p_end_date
	WHERE e.employee_id = p_employee_id;
	
	UPDATE employees e
	SET e.boss_id=v_boss_id
	WHERE e.boss_id=p_employee_id AND e.end_date IS NULL;
	
	COMMIT;
END //
DELIMITER ;


CALL p_populate();

SELECT f_num_subordinates(1);

CALL p_end_contract(1, '2026-12-31');

SELECT * FROM employees;
SELECT f_num_subordinates(1);

-- deben dar error
CALL p_end_contract(4, '2026-12-31');
CALL p_end_contract(99, '2026-12-31');

	
