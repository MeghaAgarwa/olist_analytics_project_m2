\echo Creating schemas...

\i sql/01_create_schemas.sql

\echo Creating raw tables...

\i sql/02_create_raw_tables.sql

\echo Creating indexes...

\i sql/03_truncate.sql

\echo Database setup complete.