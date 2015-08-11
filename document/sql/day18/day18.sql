-- **************** day18 ************* --
create database day18 default character set utf8;
show create database day18;
drop database day18;
use day18;
show tables;
-- 创建管理员
create table admin(
  id int primary key auto_increment,
  userName varchar(20),
  pwd varchar(20)
);

insert into admin(userName,pwd) values('hunk','123456');
insert into admin(userName,pwd) values('tom','8881');

select * from admin;

-- 创建部门表
create table dept(
  id int primary key auto_increment,
  deptName varchar(20)
);

-- 创建员工表
create table employee(
  empId int primary key auto_increment,
  empName varchar(20),
  deptId int ,
  constraint employee_dept_fk foreign key(deptId) references dept(id)
);

select * from dept;
select * from employee;
select e.empId,e.empName,d.deptName from employee e left outer join dept d on e.deptId=d.id;


-- 创建银行账号表
create table account(
  id int primary key auto_increment,
  accountName varchar(20),
  money float
);
-- 添加数据
insert into account(accountName, money) values('张三',880000),('李四',990000);

select * from account ;


-- 查看事务隔离级别
select @@tx_isolation;

-- 设置事务隔离级别
set session transaction isolation level repeatable read;


-- 创建保存大文本表
create table test(
  id int primary key auto_increment,
  context longtext ,
  img longblob
);

select * from test;
select * from test where context is not null;


