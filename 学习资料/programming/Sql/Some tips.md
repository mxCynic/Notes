
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
