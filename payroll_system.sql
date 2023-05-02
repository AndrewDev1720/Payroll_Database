create table department (
	id int primary key identity(1,1),
	department_name varchar(100)
);

create table position (
	id int primary key identity(1,1),
	position_name varchar(50),
	department_id int,
	foreign key (department_id) references department(id)
);

create table employee (
	id int primary key identity(1,1),
	email varchar(50) unique,
	firstname varchar(50),
	lastname varchar(50),
	dateofbirth date,
	age int DEFAULT 0
);

create table employee_position(
	employee_id int,
	position_id int,
	salary int,
	foreign key (employee_id) references employee(id),
	foreign key (position_id) references position(id)
);

create table payroll(
	id int primary key identity (1,1),
	employee_id int,
	payroll_amount int,
	start_date date,
	end_date date,
	foreign key (employee_id) references employee(id)
);




drop table employee_position;
drop table payroll;
drop table position;
drop table employee;
drop table department;

INSERT INTO department VALUES ('UTech');
INSERT INTO department VALUES ('Student Success');

INSERT INTO position VALUES ('Front Desk', 1);
INSERT INTO position VALUES ('Mentor', 2);

INSERT INTO EMPLOYEE VALUES ('hieudangk@gmail.com', 'Dang', 'Hieu', '2002-10-24');
INSERT INTO EMPLOYEE VALUES ('qat3@case.edu', 'Tran', 'Quan', '2022-7-25');

INSERT INTO employee (email, firstname, lastname, dateofbirth) VALUES ('hieudangk@gmail.com', 'Hieu', 'Dang', '2002-10-24');
INSERT INTO employee (email, firstname, lastname, dateofbirth) VALUES ('hieudangk2@gmail.com', 'Hieu', 'Dang', '2002-10-24');
INSERT INTO employee (email, firstname, lastname, dateofbirth) VALUES ('hieudangk3@gmail.com', 'Hieu', 'Dang', '2002-10-24');
INSERT INTO employee (email, firstname, lastname, dateofbirth) VALUES ('qat3@case.edu', 'Tran', 'Quan', '2022-7-25');

INSERT INTO employee_position VALUES (1, 1, 10000)
INSERT INTO employee_position VALUES (1, 2, 15000)
INSERT INTO employee_position VALUES (11, 3, 15000)

INSERT INTO payroll VALUES (1, (SELECT SUM(salary) AS total_salary FROM employee_position WHERE employee_id = 1 GROUP BY employee_id), '2023-4-16' , '2023-5-16')

CREATE PROCEDURE SelectAllEmployees()
AS
BEGIN
    SELECT * FROM Employees
END

CREATE TRIGGER trg_calculate_age
ON employee
AFTER INSERT
AS 
BEGIN
    DECLARE @dob DATE;
    SELECT @dob = dateofbirth FROM inserted;
    DECLARE @age INT;
    SET @age = DATEDIFF(year, @dob, GETDATE()) - (CASE WHEN (MONTH(@dob) > MONTH(GETDATE())) OR (MONTH(@dob) = MONTH(GETDATE()) AND DAY(@dob) > DAY(GETDATE())) THEN 1 ELSE 0 END);
    UPDATE employee SET age = @age WHERE id = (SELECT id FROM inserted);
END;


Select * from employee where firstname = 'Hieu'and lastname = 'Dang'
select * from department;
select * from employee;
select * from position;
select * from employee_position;
select * from payroll;

delete from employee where id = 3;
delete from payroll where id = 2;

CREATE PROCEDURE generatePayRollForEmployee (@employee_id INT, @date_start date, @date_end date)
AS
BEGIN
    INSERT INTO payroll VALUES (@employee_id, (SELECT SUM(salary) AS total_salary FROM employee_position WHERE employee_id = @employee_id GROUP BY employee_id), @date_start , @date_end)
END

EXEC generatePayRollForEmployee 11,'2023-4-16', '2023-5-16';

CREATE PROCEDURE generatePayRollForEmployee (@employee_id INT, @date_start date, @date_end date)
AS
BEGIN
    INSERT INTO payroll VALUES (@employee_id, (SELECT SUM(salary) AS total_salary FROM employee_position WHERE employee_id = @employee_id GROUP BY employee_id), @date_start , @date_end)
END

EXEC generatePayRollForEmployee 11,'2023-4-16', '2023-5-16';

CREATE PROCEDURE generatePayrollForAllEmployees (@date_start date, @date_end date)
AS
BEGIN
    INSERT INTO payroll (employee_id, payroll_amount, start_date, end_date)
    SELECT employee_id, SUM(salary), @date_start, @date_end
    FROM employee_position
    GROUP BY employee_id
END

EXEC generatePayrollForAllEmployee2 @date_start = '2023-4-16', @date_end = '2023-4-15'

CREATE PROCEDURE generatePayrollForAllEmployees2 (@date_start date, @date_end date)
AS
BEGIN
    IF @date_end < @date_start
    BEGIN
        RAISERROR('End date cannot be earlier than start date', 16, 1)
        RETURN
    END

    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO payroll (employee_id, payroll_amount, start_date, end_date)
        SELECT employee_id, SUM(salary), @date_start, @date_end
        FROM employee_position
        GROUP BY employee_id

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        RAISERROR('An error occurred while inserting data into the payroll table', 16, 1)
    END CATCH
END

DROP PROCEDURE  generatePayRollForEmployee
DROP PROCEDURE  generatePayrollForAllEmployee2

CREATE PROCEDURE getAllEmployeeFromPosition (@date_start date, @date_end date)
AS
BEGIN
    INSERT INTO payroll (employee_id, payroll_amount, start_date, end_date)
    SELECT employee_id, SUM(salary), @date_start, @date_end

    FROM employee_position
    GROUP BY employee_id
END

select position.position_name, employee.email, employee.firstname, employee.lastname, employee_position.salary from employee inner join employee_position on employee.id = employee_position.employee_id
					   inner join position on position.id = employee_position.position_id
					   where position.position_name = 'Mentor'