create database mysqlLearning;
use mysqlLearning;
create table student (
	id int auto_increment,
    name varchar(40),
    address varchar(50),
    percentage float,
    email varchar(50),
    phone bigint,
    primary key (id)
);
insert into student values(
6,'gyanesh', 'Ballia',83.3,'gyaneshmishra2@gmail.com',8266850772),
(2,'ramesh', 'varansi',82.3,'rameshmishra2@gmail.com',827770772),
(3,'kamlesh', 'hazipur',86.3,'kamleshmishra@gmail.com',8999850772),
(4,'akshay', 'Ballia',84.3,'akshaymishra2@gmail.com',8777850772
);
select * from student;

-------------------------------------------------------------------------
-- IN parameter example in stored procedures
 DELIMITER //

 CREATE PROCEDURE getByCity(IN givenCity varchar(30))
	BEGIN
	select * from student where address = givenCity;
	END //
DELIMITER ;
drop procedure getByCity;
call getByCity('Ballia');
-------------------------------------------------------------------------
-- OUT parameter example
 DELIMITER //

 CREATE PROCEDURE countByCity(IN givenCity varchar(30) , out totalCount int)
	BEGIN
	select count(*) into totalCount from student where address = givenCity;
	END //
DELIMITER ; 
drop procedure countByCity;
call countByCity('Ballia', @countStudentByCity);
select @countStudentByCity as studentFromBallia;
--------------------------------------------------------------------------------
-- INOUT parameter example
 DELIMITER //
 CREATE PROCEDURE returnIncreasedValue(inout val int )
	BEGIN
	set val = val + 4;	
    END //
DELIMITER ; 
drop procedure returnNameByCity;
set @value = 5;
call returnIncreasedValue(@value);
select @value as newValue;
-- ====================================================================================
-- functions example
 DELIMITER //
create function square4(num1 int)
returns int deterministic
begin
declare result int;
set result = num1 * num1 ;
return result;
 end //
 DELIMITER ;
set @val1 = 2;

-- =====================================================================================
-- triggers example
 DELIMITER //
 Create Trigger before_insert_student   
BEFORE INSERT ON student FOR EACH ROW  
BEGIN  
IF NEW.percentage < 33 THEN SET NEW.percentage = 40;  
END IF;  
END //
 DELIMITER ;
insert into student values(7,'manesh', 'Ballia',32,'efishra2@gmail.com',8244850772);
-- =========================================================================================--
-- views example
CREATE VIEW Boys AS    
SELECT name , address     
FROM student where id > 3; 

SELECT * FROM Boys;

-- ============================================================================================
-- inner join example
create table bookAlloted (
	book_id int primary key ,
    name varchar(40),
    alloted_id int,
    foreign key(alloted_id)references student(id)
    );
insert into bookAlloted value(101,'the secret',1),(103,'the freedom',3),(201,'the book',3);
select student.name , student.email,student.address,bookAlloted.name,bookAlloted.book_id
from student
inner join bookAlloted
on student.id = bookAlloted.alloted_id;

-- ============================================================================================
-- left join example
select student.name , student.email,student.address,bookAlloted.name,bookAlloted.book_id
from student
left join bookAlloted
on student.id = bookAlloted.alloted_id;

-- ============================================================================================
-- right join example
select student.name , student.email,student.address,bookAlloted.name,bookAlloted.book_id
from student
right join bookAlloted
on student.id = bookAlloted.alloted_id;
