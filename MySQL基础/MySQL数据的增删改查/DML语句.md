#### 简介
DML全称为Data Maripulation Language，表示**数据操作语言**，主要体现于数据的增删改查操作，因此DML仅仅包括INSERT，UPDATE和DELETE语句

##### INSERT语句
```
-- 需要注意，VALUSE后的字段值必须与表名后的字段名一一对应
INSERT INTO 表名(字段名1，字段名2，....，字段名n) VALUES(字段值1，字段值2，...，字段值n);

-- 需要注意，VALUSE后的字段值必须与创建表时的字段顺序保持一一对应
INTSERT INTO 表名 VALUSE(字段值1，字段值2，...，字段值n);

-- 一次性插入多条数据
INSERT INTO 表名 (字段名1，字段名2，...，字段名n) VALUSE(字段值1，字段值2，...，字段值n),(字段值1，字段值2，...，字段值n), ...,(字段值1，字段值2，...，字段值n);
INSERT INTO 表名 VALUSE(字段值1，字段值2，...，字段值n)，(字段值1，字段值2，...，字段值n)...，(字段值1，字段值2，...，字段值n);
```

	示例：向课程表中插入数据
```
INSERT INTO course (`number`,name,score,`time`) VALUES (1,'JAVA基础',4,40);
INSERT INTO course VALUES (2,'数据库',3,20);
INSERT INTO course ('number',score,name,`time`) VALUES (1,5,'数据结构',40);

-- 可一次插入多条数据
INSERT INTO course (`number`,name,score,`time`) VALUES (4,'Spring',4,5),(5,'Spring MVC',2,5);
INSERT INTO course VALUES (6,'SSM',2,3),(7,'Spring BOOT',2,3);
```

##### UPDATE语句
```
UPDATE 表名 SET 字段名1=字段值1[,字段名2=字段值2,...,字段名n=字段值n] [WHERE 修改条件];
```
###### WHERE条件子句
在SQL中条件的表示通常是用关系运算符来表示，比如>,<,=,>=,!=来表示，除此之外，SQL中还可以使用SQL专用的关键字来表示条件。在DQL中语句中会详细解释
SQL中条件之间的衔接通常是用逻辑运算符来表示，通常用**AND**表示逻辑与(&&)，**OR**表示逻辑或(||)
```
WHERE time > 20 && time < 40; <=>等价 WHERE time >20 AND time < 40;
```

	示例：将数据库的学分修改为3，学时更改为5
```
UPDATE course SET score=3,`time`=5 WHERE name='数据库';
```

##### DELETE语句
```
DELETE FROM 表名 WHERE 删除条件;
```

	示例：删除课程表中课程编号为1的数据
```
DELETE FROM course WHERE `number`=1;
```

##### TRUNCATE语句
```
-- 清空表中数据
TRUNCATE [TABLE] 表名;
```

	示例：清空课程表数据
```
TRUNCATE course;
```
##### DELETE和TRUNCATE语句的区别
1，DELETE语句根据条件删除表中数据，而TRUNCATE语句则是将表中数据全部清空；如果DELETE语句要删除表中使用数据，那么在效率上低于TRUNCATE语句
2，如果表中有自增长列，TRUNCATE语句会重置自增长的计数器，但DELETE语句不会
3，TRUNCATE语句执行后，数据无法恢复，而DELETE语句执行后，可以使用事务回滚进行恢复