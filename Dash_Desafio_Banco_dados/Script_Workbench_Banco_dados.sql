create schema if not exists azure_company;
use azure_company;
select * from information_schema.table_constraints
	where constraint_schema = 'azure_company';