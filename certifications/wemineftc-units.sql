-- Insert all the permutations of hash units and their conversions {{{
-- Hash base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES 
	('Hash', NULL, 0, NULL, NULL, NULL),
	('Kilohash', 'kHash', 1, 'Hash', '/', '1000'),
	('Megahash', 'MHash', 1, 'Hash', '/', '1000000'),
	('Gigahash', 'GHash', 1, 'Hash', '/', '1000000000');

-- Kilohash base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Hash', NULL, 1, 'Kilohash', '*', '1000'),
	('Kilohash', 'kHash', 0, NULL, NULL, NULL),
	('Megahash', 'MHash', 1, 'Kilohash', '/', '1000'),
	('Gigahash', 'GHash', 1, 'Kilohash', '/', '1000000');

-- Megahash base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Hash', NULL, 1, 'Megahash', '*', '1000000'),
	('Kilohash', 'kHash', 1, 'Megahash', '*', '1000'),
	('Megahash', 'MHash', 0, NULL, NULL, NULL),
	('Gigahash', 'GHash', 1, 'Megahash', '/', '1000000');

-- Gigahash base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Hash', NULL, 1, 'Gigahash', '*', '1000000000'),
	('Kilohash', 'kHash', 1, 'Gigahash', '*', '1000000'),
	('Megahash', 'MHash', 1, 'Gigahash', '*', '1000'),
	('Gigahash', 'GHash', 0, NULL, NULL, NULL);
-- }}}

-- Insert all the permutations of FTC units and their conversions {{{
-- FTC base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Feathercoin', 'FTC', 0, NULL, NULL, NULL),
	('Millifeathercoin', 'mFTC', 1, 'Feathercoin', '*', '1000'),
	('Microfeathercoin', 'μFTC', 1, 'Feathercoin', '*', '1000000');

-- mFTC base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Millifeathercoin', 'mFTC', 0, NULL, NULL, NULL),
	('Feathercoin', 'FTC', 1, 'Millifeathercoin', '/', '1000'),
	('Microfeathercoin', 'μFTC', 1, 'Millifeathercoin', '*', '1000');

-- μFTC base
INSERT IGNORE INTO unitinfo (name, abbreviation, conversion, conversion_base, conversion_operation, conversion_value) VALUES
	('Microfeathercoin', 'μFTC', 0, NULL, NULL, NULL),
	('Feathercoin', 'FTC', 1, 'Microfeathercoin', '/', '1000000'),
	('Millifeathercoin', 'mFTC', 1, 'Microfeathercoin', '/', '1000');
-- }}}
