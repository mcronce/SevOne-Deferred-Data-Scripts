-- Dollars base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES 
	('Dollars', 'USD', 0, '', '', ''),
	('Cents', '', 1, 'Dollars', '*', '100');

-- Cents base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Dollars', 'USD', 1, 'Cents', '/', '100'),
	('Cents', '', 0, '', '', '');

