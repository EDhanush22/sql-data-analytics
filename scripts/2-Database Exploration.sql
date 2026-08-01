-- Explore All Objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES
-- The above lists metadata about every table in the current database

-- Explore All Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'