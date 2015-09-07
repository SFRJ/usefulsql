-- Finds all the columns in those tables that contain the string ESS
-- in the table name and orders them alphabetically
select table_name, column_name
from ALL_TAB_COLS
where table_name like '%ESS%'
and owner != 'MY_SCHEMA'
order by table_name;

-- Same as the previous one but includes more data and excludes the owner SYS
select *
from ALL_TAB_COLS
where table_name like '%ESS%'
and owner != 'SYS';

-- All the constraints for the tables in all schemas in the database
select * 
from all_constraints;

-- All the constraints for the tables in all an specific schema
select * 
from all_constraints
where upper(r_owner) like 'MY_SCHEMA';

-- All the foreign key constraints for the tables in all an specific schema
select * 
from all_constraints
where upper(r_owner) like 'MY_SCHEMA'
and upper(constraint_type) like 'R';

-- This finds the primary key of a table
select upper(constraint_name) from all_constraints
   where constraint_type in ('P', 'U')
   and upper(table_name) like upper(:r_table_name)
   and upper(owner) like 'MY_SCHEMA';
   
-- Using the previous comand as input to the following, allows us to find all of the
-- children of a particular table(Have as FK the PK of their parent)
select table_name, constraint_name, status, owner
from all_constraints
where upper(r_owner) like 'MY_SCHEMA'
and upper(constraint_type) like 'R'
and upper(r_constraint_name) in
 (
   select upper(constraint_name) from all_constraints
   where constraint_type in ('P', 'U')
   and upper(table_name) like upper(:r_table_name)
   and upper(owner) like 'MY_SCHEMA'
 )
order by table_name, constraint_name;

--Find the parents of a table
select * 
  from all_constraints
   where constraint_type in ('P', 'U')
   and upper(owner) like 'MY_SCHEMA'
   and upper(constraint_name) in
   (
    select upper(r_constraint_name)
    from all_constraints
    where upper(table_name) like upper(:r_table_name)
    and upper(constraint_type) like 'R'
   );
   
--Finding tables that contain a word in their name   
SELECT table_name, owner
FROM all_tables
WHERE UPPER(table_name) LIKE '%EXCHANGE%';
