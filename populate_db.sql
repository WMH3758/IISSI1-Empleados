--
-- Autor: David Ruiz
-- Fecha: Octubre de 2026
-- Descripción: Script para la carga inicial de datos de Empleados
-- Se incluye en: iissi1/teoria/t10 y t11 (los resultados de las slides salen de estos datos)
--

USE employees_db;

-- #region p_populate
DELIMITER //
CREATE OR REPLACE PROCEDURE p_populate()
BEGIN
	-- Desactiva las FK para poder borrar: la tabla de empleados tiene una FK a sí misma
	SET FOREIGN_KEY_CHECKS = 0;
	DELETE FROM employees;
	DELETE FROM departments;
	SET FOREIGN_KEY_CHECKS = 1;
	INSERT INTO departments (department_id, name_dep, city) VALUES
		(1, 'Arte', 'Cádiz'),
		(2, 'Historia', NULL),
		(3, 'Informática', 'Sevilla')
	;
	INSERT INTO employees (employee_id, department_id, boss_id, name_emp, salary, start_date, end_date, fee) VALUES
		(1, 1, NULL, 'Pedro', 2300.00, '2017-09-15', NULL, 0.2),
		(2, 1, NULL, 'Jose', 2500.00, '2018-08-15', NULL, 0.5),
		(3, 2, NULL, 'Lola', 2300.00, '2018-08-15', NULL, 0.3),
		(4, 1, 1, 'Luis', 1300.00, '2018-08-15', '2018-11-15', 0),
		(5, 1, 1, 'Ana', 1300.00, '2018-08-15', '2018-11-15', 0),
		(6, 1, 1, 'Daniel', 1500.00, '2020-09-15', NULL, 0.2),
		(7, NULL, NULL, 'Eva', 1200.00, '2021-05-01', NULL, 0.1)
	;
END //
DELIMITER ;
-- #endregion

CALL p_populate();