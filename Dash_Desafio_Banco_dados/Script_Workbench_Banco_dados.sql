create schema if not exists azure_company;
use azure_company;
select * from information_schema.table_constraints
	where constraint_schema = 'azure_company';

-- criando tabela employee
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


-- criando tabela departament
create table departament(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9) not null,
    Mgr_start_date date, 
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique(Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

-- criando tabela dept_locations
create table dept_locations(
	Dnumber int not null,
	Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber)
);

-- criando tabela project and works_on and dependent
create table project(
	Pname varchar(15) not null,
	Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project foreign key (Dnum) references departament(Dnumber)
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
);

create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);

show tables;
desc employee;
select * FROM employee;

-- Deve seguir a ordem para inserir:
-- Dessa forma, os supervisores estarão sempre inseridos antes dos subordinados, evitando o erro de integridade referencial.
-- 1 inserindo dados sem supervisor employee
INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) 
VALUES ('James', 'E', 'Borg', '888665555', '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, NULL, 1);

-- 2 inserindo dados com supervisor employee
INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) 
VALUES ('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, '888665555', 5);

-- 3 inserindo dados com supervisor employee
INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) 
VALUES ('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000, '888665555', 4);

-- 4 inserindo dados com supervisor employee
INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) 
VALUES 
('John', 'B', 'Smith', '123456789', '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, '333445555', 5),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975-Fire-Oak-Humble-TX', 'M', 38000, '333445555', 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631-Rice-Houston-TX', 'F', 25000, '333445555', 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, '987654321', 4),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000, '987654321', 4);





