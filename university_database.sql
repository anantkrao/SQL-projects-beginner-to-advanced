/*university database*/
/*schema : 
department(dept_name (pk), building, budget)
course(course_id (pk), title, dept_name, credits)
instructor(ID (pk), name, dept_name, salary)
section(course_id (pk), sec_id (pk), semester (pk),year (pk), building, room_number, time-slot-it)
teaches(ID (pk), course_id (pk), sec_id (pk), semester (pk), year)
students(ID (pk), name, dept_name, tot_cred)
takes(ID (pk), course_id (pk), sec_id (pk), semester (pk),year (pk), grade)
advisor(s_id (pk), i_id (pk) )
prereq(course_id (pk), prereq_id (pk)) 
*/
/*****************************************************************************************************/
/*--DEPARTMENT TABLE--*/

create table department(
dept_name varchar2(30),
building varchar2(25),
budget numeric(12,2),
primary key(dept_name));
desc department;

/*--COURSE TABLE--*/

create table course(
course_id varchar2(10),
title varchar2(100),
dept_name varchar2(30),
credits numeric(2,0),
primary key(course_id),
FOREIGN KEY(dept_name) REFERENCES department);
desc course;

/*--INSTRUCTOR TABLE--*/

create table instructor(
ID numeric(4),
name varchar2(255),
dept_name varchar2(30),
salary numeric(8,2),    
primary key(ID),
foreign key(dept_name) references department);
desc instructor;

/*--SECTION TABLE--*/

create table section(
course_id varchar2(10),
sec_id varchar2(10),
semester varchar2(20),
year numeric(5),
building varchar2(255),
room_number numeric(5),
time_slot_id varchar2(2),
primary key(course_id,sec_id,semester,year),
foreign key(course_id) references course);
desc section;

/*--TEACHES TABLE--*/

create table teaches(
ID numeric(5),
course_id varchar2(10),
sec_id varchar2(10),
semester varchar2(20),
year numeric(5),
primary key(ID,course_id,sec_id,semester,year),
foreign key(course_id,sec_id,semester,year) references section,
foreign key(ID) references instructor);
desc teaches;

/*--STUDENT TABLE--*/
create table student(
ID numeric(4),
name varchar2(255),
dept_name varchar2(30),
tot_cred numeric(3),
primary key(ID),
foreign key(dept_name) references department);

/*--ADVISOR TABLE--*/

create table advisor(
s_id numeric(5),
i_id numeric(5),
primary key(s_id,i_id),
foreign key(i_id) references instructor,
foreign key(s_id) references student);

/*--PREREQ TABLE--*/

create table prereq(
course_id varchar2(10),
prereq_id varchar2(10),
primary key(course_id,prereq_id),
foreign key(course_id) references course);

/*TAKES TABLE*/

create table takes(
ID numeric(5),
course_id varchar2(30),
sec_id varchar2(5),
semester varchar2(10),
year numeric(4),
grade varchar2(3),
primary key(ID,course_id,sec_id,semester,year),
foreign key(ID) references student,
foreign key(course_id,sec_id,semester,year) references section);


/*--INSERT VALUES INTO DEPARTMENT TABLE--*/

desc department;
insert all
into department values('physics','homi',85000)
into department values('mathematics','ramanujan',90000)
into department values('music','beethoven',78000)
into department values('history','ashoka empire',28000)
select *from department;

/*--INSERT VALUES INTO COURSE TABLE--*/

desc course;
insert all
into course values('phy-201','mechanical','physics',5)
into course values('mat-301','calculus','mathematics',4)
into course values('mu-401','violin','music',3)
into course values('his-501','british india','history',4)
select *from course;

/*--INSERT VALUES INTO INSTRUCTOR TABLE--*/

desc instructor;
insert all
into instructor values(1212,'einstein','physics',85000)
into instructor values(1332,'gilbert','mathematics',90000)
into instructor values(1342,'mozart','music',67000)
into instructor values(1567,'ojha','history',56000)
select *from instructor;

/*--INSERT VALUES INTO STUDENT TABLE--*/
insert all
into student values(012,'mike elson','physics',5)
into student values(022,'boseman','mathematics',4)
into student values(034,'justin','music',3)
into student values(067,'merie curie','history',4)
select *from student;

/*--INSERT VALUES INTO ADVISOR TABLE--*/

insert all 
into advisor values(012,1212)
into advisor values(022,1332)
into advisor values(034,1342)
into advisor values(067,1567)
select *from advisor;

/*--INSERT INTO PREREQ TABLE--*/
insert into prereq values('cs-101','phy-201');
insert all 
into prereq values('phy-201','mat-301')
into prereq values('mu-401','his-501')
select *from prereq;

/*--INSERT INTO SECTION TABLE--*/
insert all 
into section values('phy-201','b','winter',2023,'einstein',520,'PH')
into section values('mat-301','b','fall',2023,'ramanujan',540,'MA')
into section values('mu-401','d','winter',2023,'beethoven',560,'MU')
into section values('his-501','e','winter',2023,'ashoka empire',580,'HI')
select *from section;

/*--INSERT INTO TAKES TABLE--*/

desc takes;
insert all
into takes values(012,'phy-201','b','winter',2023,'A')
into takes values(022,'mat-301','b','fall',2023,'B')
into takes values(034,'mu-401','d','winter',2023,'B')
into takes values(067,'his-501','e','winter',2023,'A')
select *from takes;

/*--INSERT INTO TEACHES TABLE--*/
desc teaches;
insert all 
into teaches values(1212,'phy-201','b','winter',2023)
into teaches values(1332,'mat-301','b','fall',2023)
into teaches values(1342,'mu-401','d','winter',2023)
into teaches values(1567,'his-501','e','winter',2023)
select *from teaches;
/*--DISPLAY ALL TABLES ONE BY ONE--*/
select *from teaches;
select *from takes; 
select *from advisor;
select *from prereq;
select *from section;
select *from course;
select *from instructor;
select *from department;
select *from student;

/*--QUERIES ON SINGLE RELATION--*/

desc student;
alter table student add country varchar2(100);
select name from student;
select name from instructor;
select salary from instructor;
select distinct credits from course;
select name,salary*2 from instructor;
select name,salary
from instructor 
where dept_name='computer science' and salary > 70000;

/*--QUERIES ON MULTIPLE RELATION--*/

select name , instructor.dept_name,building,budget
from instructor , department
where instructor.dept_name=department.dept_name and department.budget>80000;

/*--QUERIES FOR CARTESIAN PRODUCT--*/

select distinct instructor.ID,student.ID,instructor.name,student.name
from instructor,student,advisor
where s_id = i_id;

/*--natural join of instructor table and teaches table--*/

select name,course_id
from instructor natural join teaches;

/*--who teaches who and what - using instructor , student and course table for getting result--*/
select distinct instructor.name,student.name,title
from instructor,student,course
where instructor.dept_name=student.dept_name and instructor.dept_name=course.dept_name;
