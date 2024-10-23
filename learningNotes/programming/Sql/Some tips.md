
## 按id分类，然后选择最早的date
```
select * 
from (
	select *, row_number () over (partition by id order by date) as date_id
	from table
) temp_t 
where date_id = 1;
```
## 找某两列相等的行，占据全部行的比
```
select count(case when col1 = col2 then 1 end) / count(*) as rate
from table
```

## 创建一个临时表

```
# 方法1
with temp as (
	select * 
	from table
)
select * from temp

# 方法2
select * 
from (
	select * 
	from table
	where
) temp g
where 
```

## count时去重
```
# 注意，在这里，distinct后面要跟一个具体的列
count(distinct column)
```

## 寻找仅在某一时间段出现的id
这意味着在这段时间的数量等于总数量
```
select *  
from table 
group by id 
having count(time between "..." and "..." or null) = count(*)
```
## 查询结果不存在时，显示null
```
SELECT COALESCE((
    SELECT *
    FROM table
), NULL) AS result;

```
## 可以判断值等于一个其他表相关的数
```
select *
from table 
where num = (select count(*) from table2)
```

