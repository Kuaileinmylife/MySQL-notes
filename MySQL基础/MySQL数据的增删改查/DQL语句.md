#### 简介
DQL全称是Data Query Langyage，表示**数据查询**语言，体现在**数据的查询操作**，DQL包括SELECT语句
##### SELECT语句
```
SELECT ALL/DISTINCT * | 字段名1 AS 别名1[,字段名1 AS 别名1,...,字段名n AS 别名n]FROM 表名 WHERE 查询条件;
```
	解释：
	ALL 表示查询所有满足条件的记录，可以省略
	DISTINCT 表示去掉查询结果中重复的记录
	AS 可以给数据列，数据表取一个别名
	示例：从课程表中查询课程编号小于5的课程名称
```
SELECT name FROM course WHERE number<5;
```
	示例：从课程表中查询课程名称为"JAVA基础"的学分和学时
```
SELECT score,time FROM course WHERE name='JAVA基础';

-- 查询时给列取别名
SELECT score'学分',`time`'学时' FROM course WHERE name='JAVA基础';

-- 表的别名(把表的名称取的别名为c)
SELECT c.name, c.score FROM course c WHERE c.name='JAVA基础';
```

##### 比较操作符

| 操作符           | 语法                  | 说明                                  |
| ------------- | ------------------- | ----------------------------------- |
| IS NULL       | 字段名IS NULL          | 如果字段的值为NULL，则满足条件                   |
| IS NOT NULL   | 字段名IS NOT NULL      | 如果字段的值不为NULL，则满足条件                  |
| BETWEEN...AND | 字段名BETWEEN最小值AND最大值 | 如果字段的值在最小值和最大值之间(能够取到最小值和最大值)，则条件满足 |
| LIKE          | 字段名LIKE'%匹配内容%'     | 如果字段值包含有匹配内容，则条件满足                  |
| IN            | 字段名IN(值1，值2，...)    | 如果字段值在值1，值2，...值n中，则条件满足            |

	示例：从课表查询课程名NULL的课程信息
```
SELECT * FROM course WHERE name NULL;
```
	示例：从课表查询课程名不为NULL的课程信息
```
SELECT * FROM course WHERE name IS NOT NULL;
```
	示例：从课程表查询学分为2~4之间的课程信息
```
SELECT * FROM course WHERE score BETWEEN 2 AND 4;
```
	示例：查询课程名只有3个字符的课程信息
```
SELECT * FROM course WHERE name LIKE '___';
```
	示例：从课程表查询课程名以‘j’开头的课程信息
```
SELECT * FROM course WHERE name LIKE 'j%';
```
	示例：从从课程表查询课程名中含有‘v'的课程信息
```
SELECT * FROM course WHERE name LIKE '%V%';
```
	示例：从课程表查询课程编号为1,3,5的课程信息
```
SELECT * FROM course WHERE `number` IN (1,3,5,10,12);
```

#### 分组
##### 分组查询
```
SELECT ALL/DISTINCT * | 字段名1 AS 别名1[,字段名1 AS 别名1,...,字段名n AS 别名n]FROM 表名 WHERE 查询条件 GROUP BY 字段名1，字段名2,...,字段名n
```
	示例：从学生表查询成绩在80分以上的学生信息并按性别分组
```
SELECT * FROM student WHERE score>80 GROUP BY sex;
```
	示例：从学生表中查询成绩在60~80之间的学生信息并按性别和年龄分组
```
SELECT * FROM student WHERE score BETWEEN 60 AND 80 GROUP BY sex,age;
```

##### 分组查询结果筛选
分组后如果还有筛选条件再用HAVING子句
```
SELECT ALL/DISTINCT * | 字段名1 AS 别名1[,字段名1 AS 别名1,...,字段名n AS 别名n]FROM 表名 WHERE 查询条件 GROUP BY 字段名1，字段名2,...,字段名n HAVING 筛选条件;
```
	示例：从学生表查询年龄在20~30之间的学生信息并按性别分组，找出组内平均分在60分以上的组
```
SELECT * FROM student WHERE age BETWEEN 20 AND 30 CROUP BY sex HAVING AVG(score)>60;
```

#### 排序
```
SELECT ALL/DISTINCT * | 字段名1 AS 别名1[,字段名1 AS 别名1,...,字段名n AS 别名n]FROM 表名 WHERE 查询条件 ORDER BY 字段名1 ASC|DESC，字段名2 ASC|DESC,...,字段名n ASC|DESC;
```
	注意：ASC是升序，DESC是降序
	示例：从学生表查询年龄在18~30)岁之间的学生信息并按成绩高到低排列，如果成绩相同，则按年龄从小到大排列
```
SELECT * FROM student WHERE age BETWEEN 18 AND 30 ORDER BY score DESC, age ASC;
```
	其中ORDER BY必须位于WHERE条件之后

#### 分页
```
SELECT ALL/DISTINCT * | 字段名1 AS 别名1[,字段名1 AS 别名1,...] FROM 表名 WHERE 查询条件 LIMIT 偏移量, 查询条数;
```
	示例：从学生表分页查询成绩及格的学生信息，每页显示3条，查询第2页学生信息
```
SELECT * FROM student WHERE score>=60 LIMIT 0,3; 
-- 第一个参数表示偏移量，也就是跳过的行数
-- 第二个参数表示查询返回的最大行数
SELECT * FROM student WHERE score>=60 LIMIT 3,3;
SELECT * FROM student WHERE score>=60 LIMIT 6,3;
```

如果一个查询中包含分组，排序，分页，那么他们之间必须按照==**分组->排序->分页**==的**先后顺序排列**
#### 聚合函数
· **COUNT()**：统计满足条件的数据总条数
	示例：从学生表中查询成绩在80分以上的人数
```
SELECT COUNT(*) FROM student WHERE score>80;
```
· **SUM()**：只能用于数值类型的字段或者表达式，计算该满足条件的字段值的总和
	示例：从学生表中查询不及格的学生人数和总成绩
```
SELECT COUNT(*), SUM(score) FROM student WHERE score<60;
```
· **AVG()**：只能用于数值类型的字段或者表达式，计算该满足条件的字段值的平均值
	示例：从学生表查询男生，女生，其他类型的学生的评价成绩
```
SELECT sex, AVG(score) FROM student GROUP BY sex;
```
· **MAX()**：只能用于数值类型的字段或者表达式，计算该满足条件的字段值的最大值
	示例：从学生表中查询学生的最大年龄
```
SELECT MAX(age) FROM student;
```
· **MIN()**：只能用于数组类型的字段或者表达式，计算该满足条件的字段值最小值
	示例：从学生表查询学生的最低分
```
SELECT MIN(score) FROM student;
```
