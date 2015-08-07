

-- **************** day16 ************* --
create database day16 default character set utf8;
show databases;
use day16;
show tables;
show create database day16;
drop database day16;

-- ****************** һ������Լ�� ********************* --
-- 1.1 Ĭ��ֵ
create table student(
  id int,
  name varchar(20),
  address varchar(50) default '�������'  -- Ĭ��ֵ
);

-- ���ֶ�û�в���ֵ��ʱ��mysql�Զ������ֶη���Ĭ��ֵ
insert into student (id,name) values (1,'����');
-- ע�⣺ Ĭ��ֵ���ֶ�����Ϊnull
insert into student(id,name,address) values(2,'����',null),(3,'����','���ݷ�خ');

-- 1.2 �ǿ�
-- ���� gender�ֶα�����ֵ����Ϊnull��
create table student(
  id int,
  name varchar(20),
  gender varchar(2) not null -- �ǿ�
);

-- �ǿ��ֶα��븳ֵ
insert into student (id,name) value(1,'����');
-- �ǿ��ֶβ��ܲ���null
insert into student (id,name,gender) value (1,'����',null);
insert into student (id,name,gender) value (1,'����','��');
drop table student;
select * from student;
desc student;

-- 1.3 Ψһ
create table student(
  id int UNIQUE , -- Ψһ
  name varchar(20)
);

insert into student (id,name) values(1,'zs');
insert into student (id,name) values(1,'lisi');-- (1,'lisi');[23000][1062] Duplicate entry '1' for key 'id'

insert into student (id,name) value(2,'lisi');

select * from student;

-- 1.4 ���� ���ǿ�+Ψһ��
drop table student;

create table student(
  id int primary key,
  name varchar(20)
);

insert into student(id,name)values(1,'����');
insert into student(id,name)values(2,'����');
# insert into student(id,name)values(1,'����'); --  [23000][1062] Duplicate entry '1' for key 'PRIMARY'
# insert into student(name)values('����'); -- [HY000][1364] Field 'id' doesn't have a default value

-- 1.5 ������
drop table student;
create table student(
  id int(4) zerofill primary key AUTO_INCREMENT,
  name varchar(20)
);

-- �����ֶο��Բ���ֵ���Զ�����
insert into student(name) values('����');
insert into student(name) values('����');
insert into student(name) values('����');

select * from student;
-- ����Ӱ��������Լ��
delete from student;
-- ����Ӱ��������
truncate table student;

-- 1.6 ���Լ��
-- Ա����
create table employee(
  id int primary key,
  empName varchar(20),
  deptName varchar(20)
);

insert into employee(id,empName,deptName) values(1,'����','���������');
insert into employee(id,empName,deptName) values(2,'����','���������');
insert into employee(id,empName,deptName) values(3,'����','Ӧ��ά����');

select * from employee;

-- ���Ա�������ŵ����������
insert into employee values(4,'����','���������');

-- �����������ߵ����⣺��������ֶηŵ�һ�Ŷ����ı���
-- �������һ�Ų��ű�
create table dept(
  id int primary key,
  deptName varchar(20)
);

drop table employee;

-- �޸�Ա����
create table employee(
  id int primary key,
  empName varchar(20),
  deptId int, -- �Ѳ������Ƹ�Ϊ����ID
  -- ����һ�����Լ��
  constraint employee_dept_fk foreign key(deptId) references dept(id) on update cascade on delete cascade
  --              �������                    ���                �ο���( �ο��ֶ�)     on cascade update :�����޸�
);

insert into dept(id,deptName) values(1,'���������');
insert into dept(id,deptName) values(2,'Ӧ��ά����');
insert into dept(id,deptName) values(3,'���鲿');


insert into employee value(1,'����',1);
insert into employee value(2,'����',1);
insert into employee value(3,'����',2);
insert into employee value(4,'����',3);

-- ���⣺ �ü�¼ҵ���ϲ��Ϸ���Ա��������һ�������ڵĲ�������
insert into employee values(5,'����',4); -- Υ�����Լ�� [23000][1452] Cannot add or update a child row: a foreign key constraint fails (`day16`.`employee`, CONSTRAINT `employee_dept_fk` FOREIGN KEY (`deptId`) REFERENCES `dept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE)

-- 1�� ���������Լ����������ݵ�˳���������������Ӹ�������
-- 2�� ���������Լ�����޸����ݵ�˳�����޸ĸ������޸���������
-- 3�� ���������Լ����ɾ�����ݵ�˳����ɾ��������ɾ����������
-- �޸Ĳ��ţ�����ֱ���޸�����
update dept set id=4 where id=3;
-- ���޸�Ա����
update employee set deptId=2 where id=4;

-- ɾ������
delete from dept where id=2;

-- ��ɾ��Ա����
delete from employee where deptId=2;
delete * from dept;

select * from dept;
select * from employee;

-- �����޸ģ��޸ģ�
-- ֱ���޸Ĳ���
update dept set id=5 where id=4;

-- ����ɾ��
-- ֱ��ɾ������
delete from dept where id=1;



-- ************* ����������ѯ������ѯ�� *************** --
-- ���󣺲�ѯԱ���������ڲ��š�����ʾԱ���������������ƣ�
-- 2.1 �������Ӳ�ѯ�����Ƽ��������ѿ���������4*4=16����Щ���ظ���¼��
select empName,deptName from employee,dept;

-- ���󣺲�ѯԱ���������ڵĲ��ţ���ʾԱ���������������ƣ�
-- ����ѯ����1��ȷ������Щ��  2��ȷ������Щ�ֶ� 3�������֮����������������ɣ��������������Ǳ�����-1��
-- 2.2 �����ӣ�ֻ�����������Ľ���Ż���ʾ
select empName,deptName        -- 2�� ȷ������Щ�ֶ�
  from employee,dept              -- 1) ȷ������Щ��
  where employee.deptId=dept.id; -- 3�������֮�����ӹ�ϵ

-- �����ӵ���һ��д��
select empName,deptName
  from employee
  inner join dept
  on employee.deptId=dept.id;

-- ʹ�ñ���
select e.empName,d.deptName
  from employee e
  inner join dept d
  on e.deptId=d.id;

insert into dept(id,deptName) values(4,'�ܾ���');

-- ���󣺲�ѯÿ�����ŵ�Ա��
-- Ԥ�ڽ��
 -- ���������  ����
 -- ���������  ����
 -- Ӧ��ά����  ����
 -- ���鲿      ����
 -- �ܾ���      null
-- 2.2 ��[��]���Ӳ�ѯ��ʹ����߱������ȥƥ���ұ߱�����ݣ�����������������Ľ����ʾ�������������������ʾnull
  -- ��ע�⣺�������ӣ���������һ������ʾ��
select d.deptName,e.empName
  from dept d
  left outer join employee e
  on d.id = e.deptId;

-- 2.3 ��[��]���Ӳ�ѯ��ʹ���ұߵı������ȥƥ����߱�����ݣ��������������������Ľ������ʾ�����������������Ľ������ʾnull
  -- ��ע�⣺�������ӣ��ұߵ�����һ���������ʾ����
select d.deptName,e.empName
  from employee e
  right outer join dept d
  on d.id=e.deptId;

-- 2.4 �����Ӳ�ѯ
-- ���󣺲�ѯԱ��������˾
-- Ԥ�ڽ��
  --  ����    null
  --  ����    ����
  --  ����    ����
  --  ����    ����
select e.empName, b.empName
    from employee e
    left outer join employee b
    on e.bossId=b.id;

select * from dept;
select * from employee;
-- �����˾
alter table employee add  bossId int;
update employee set bossId=1 where id=2;
update employee set bossId=2 where id=3;
update employee set bossId=3 where id=4;

-- ********** �����洢���� *********** --
-- ����������
-- �����洢����
delimiter $
create procedure pro_test()
  begin
    -- ����д���sql���
    select * from employee;
  end $

-- ִ�д洢����
call pro_test();

-- 3.1 ���в����Ĵ洢����
-- ������һ��Ա����id����ѯԱ����Ϣ
delimiter $
create procedure pro_findById(in eid int) -- in: �������
begin
  select * from employee where id=eid;
end $

-- ����
call pro_findById(1);

-- 3.2 ������������Ĵ洢����
delimiter $
create procedure pro_testOut(out str varchar(20)) -- out: �������
begin
      -- ��������ֵ
  set str='hello sql procedure';
end $

call pro_testOut(@name);
select @name ;

-- ɾ���洢����
drop procedure pro_testOut;
-- ����
-- ��ν��ܷ��ز�����ֵ����
-- *** mysql�ı��� ******
-- ȫ�ֱ��������ñ�������mysql���ݿ����õı��������е����Ӷ������ã�
       -- �鿴����ȫ�ֱ����� show ariables
       -- �鿴ĳ��ȫ�ֱ����� select @@������
       -- �޸�ȫ�ֱ�����     set ������=��ֵ
       -- character_set_client�� mysql�������Ľ������ݵı���
       -- character_set_result�� mysql��������������ݵı���

-- �Ự������  ֻ�����ڵ�ǰ�ͻ��������ݿ�������˵�һ�������С�����Ͽ����ӣ���ô�Ự����ȫ����ʧ��
      --  ����������� set @������=ֵ
      --  �鿴�Ự������ select @����

-- �ֲ������� �ڴ洢������ʹ�õı����оֲ�������ֻҪ�洢����ִ����ϣ��ֲ������Ͷ�ʧ��

-- 1������һ���Ự����name�� 2��ʹ��name�Ự�������մ洢���̵ķ���ֵ
call pro_testOut(@name);
-- �鿴����
select @name;

-- 3.3 ����������������Ĵ洢����
delimiter $
create procedure pro_testInOut(inout n int) -- inout: �����������
begin
  -- �鿴����
  select n;
  set n=500;
end $

-- ����
set @n=10;
call pro_testInOut(@n);
select @n;

-- 3.4 ���������жϵĴ洢����
-- ����  ����һ�����������1���򷵻ء�����һ�������2�����ء����ڶ��������3�����ء������������������ַ��ء�������󡱡�
delimiter $
create procedure pro_testIf(in num int, out str varchar(20))
begin
  if num=1 THEN
    set str='����һ';
  elseif num=2 then
    set str='���ڶ�';
  elseif num=3 then
    set str='������';
  else
    set str='�������';
  end if;
end $

call pro_testIf(4,@str);
select @str;

-- 3.5 ����ѭ�����ܵĴ洢����
-- ����  ����һ����������͡����磬����100��ͳ��1-100�ĺ�
delimiter $
create procedure pro_testWhile(in num int,out result int)
begin
  -- ����һ���ֲ�����
  declare i int default 1;
  declare vsum int default 0;
  while i<=num do
      set vsum=vsum+i;
      set i=i+1;
  end while;
  set result=vsum;
end $

call pro_testWhile(100,@result);
select @result;

-- 3.6 ʹ�ò�ѯ�Ľ����ֵ��������into��
delimiter $
create procedure pro_findById2(in eid int,out vname varchar(20))
begin
  select empName into vname from employee where id=eid;
end $

call pro_findById2(1,@name);
select @name;

use day15;
select * from student2;

-- ��ϰ�� ��дһ���洢����
  -- ���ѧ����Ӣ��ɼ�ƽ����С�ڵ���70�֣��������һ�㡮
  -- ���ѧ����Ӧ�óɼ�ƽ���ִ���70����С�ڵ���90�֣�����������á�
  -- ���ѧ����Ӣ��ɼ�ƽ���ִ���90�֣����������

delimiter $
create procedure pro_testAvg(out str varchar(20))
begin
  -- ����ֲ�����������ƽ����
  declare savg double;
  -- ����ƽ����
  select avg(english) into savg from student2;
  if savg<=70 then
    set str='һ��';
  elseif savg>70 and savg<=90 then
    set str='����';
  else
    set str='����';
  end if;
end $

call pro_testAvg(@str);
select @str;

use day16;
-- ********************* �ġ������� ***************** --
select * from employee;

-- ��־��
create table test_log(
  id int primary key auto_increment,
  content varchar(100)
);

-- ����  ����Ա�������һ������ʱ��ϣ��mysql�Զ�ͬʱ����־���������
-- ����������
create trigger tri_empAdd after insert on employee for each row -- ��Ա�������һ������ʱ
  insert into test_log(content) values('Ա���������һ������');

-- ��������
insert into employee(id,empName,deptId) values(7,'����˹',1);
insert into employee(id,empName,deptId) values(8,'����˹2',1);

-- �������������޸ģ�
create trigger tri_empUpdate after update on employee for each row -- ��Ա���������һ������
  insert into test_log(content) values ('Ա�����޸���һ������');

-- �޸�
update employee set empName='eric' where id=7;

-- ������������ɾ����
create trigger tri_empDel after delete on employee for each row
  insert into test_log(content) values('Ա����ɾ����һ����¼');

-- ɾ��
delete from employee where id=7;

select * from employee;
select * from test_log;

-- ************* �塢mysqlȨ������ *********** --
-- mysql���ݿ�Ȩ�����⣺root ��ӵ������Ȩ�ޣ����Ը��κ��£�
-- Ȩ���˻���ֻӵ�в���Ȩ�ޣ�CURD�����磬ֻ�ܲ���ĳ�����ݿ��ĳ�ű�
-- ����޸�mysql���û����룿
-- password��md5���ܺ�����������ܣ�
select password('root'); -- *81F5E21E35407D884A6CD4A731AEBFB6AF209E1B

-- mysql���ݿ⣬�û����ñ�user��
use mysql;

select * from user;

-- �޸�����
update user set password=password('123456') where user='root';
update user set password='' where user='root';

-- ����Ȩ���˻�
grant select on day16.employee to 'eric'@'localhost' identified by '123456';
grant delete on day16.employee to 'eric'@'localhost' identified by '123456';


-- ***** ����mysql���ݺͻ�ԭ ****** --
-- ���ݣ�������������  mysqldump -u root -p day17 > C:/back.sql
-- �ָ���������������  mysql -u root -p day17 < C:/back.sql



