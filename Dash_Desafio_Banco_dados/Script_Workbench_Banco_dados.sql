create schema if not exists azure_company;
use azure_company;
select * from information_schema.table_constraints
	where constraint_schema = 'azure_company';

-- criando tabelas
CREATE TABLE employee(
	Fname varchar(15) not null,
    Minit char,
    Lname varchar(15) not null,
    Ssn char(9) not null, 
    Bdate date,
    Address varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salary_employee check (Salary> 2000.0),
    constraint pk_employee primary key (Ssn)
);

alter table employee 
	add constraint fk_employee 
	foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;
    
    alter table employee modify Dno int not null default 1;
    
desc employee;
select * FROM employee;