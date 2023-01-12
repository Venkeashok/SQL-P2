#1.Import the csv file to a table in the database.

create database icc;

use icc;
select * from icc_table;



#2.Remove the column 'Player Profile' from the table.

alter table icc_table drop column `player profile`;

#3.Extract the country name and player names from the given data 
#and store it in seperate columns for further usage.


with q3 as(SELECT substr(player,position( "(" in substr(player,4))+2) as Country_name,
 replace(player,substr(player,position( "(" in substr(player,4))+2),' ') as Player_name from icc_table)
 select * from q3;
#4.From the column 'Span' extract the start_year and end_year and 
#store them in seperate columns for further usage.


with q4 as(select substr(span,1,4) as start_year,substr(span,6) as end_year from icc_table)
select * from q4;



#5.The column 'HS' has the highest score scored by the player so far in any given match. 
#The column also has details if the player had completed the match in a NOT OUT status. 
#Extract the data and store the highest runs and the NOT OUT status in different columns.


select hs as Highest_Runs,
case when hs like '%*' then 'Not Out'
end as 'Status'
from icc_table where hs like '%*';


#6.Using the data given, considering the players who were active in the year of 2019, 
#create a set of batting order of best 6 players using the selection criteria of those
# who have a good average score across all matches for India.


select * from icc_table;

select * from
(select player,avg,case when 
2019 between substr(span,1,4) and substr(span,-4) then 'Active in 2019'
end as ReqStatus
from icc_table) t where player like '%India%' and reqstatus like 'Active in 2019' order by avg desc limit 6;

#7.Using the data given, considering the players who were active in the year of 2019, 
#create a set of batting order of best 6 players using the selection criteria of those 
#who have highest number of 100s across all matches for India.



select * from
(select *,case when 
2019 between substr(span,1,4) and substr(span,-4) then 'Active in 2019'
end as ReqStatus
from icc_table) t where player like '%India%' and reqstatus  is not null;

select * from
(select player,span,`100`,case when 
2019 between substr(span,1,4) and substr(span,-4) then 'Active in 2019'
end as ReqStatus
from icc_table) t where player like '%India%' and reqstatus like 'Active in 2019' order by '100' desc limit 6;


#8.Using the data given, considering the players who were active in the year of 2019, 
#create a set of batting order of best 6 players using 2 selection criterias of your own for India.



select * from icc_table;

select * from
(select player,span,avg,`100`,case when 
2019 between substr(span,1,4) and substr(span,-4) then 'Active in 2019'
end as ReqStatus
from icc_table) t where player like '%India%' and reqstatus like 'Active in 2019' and `100`>3 order by avg desc limit 6;


#9.Create a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given, 
#considering the players who were active in the year of 2019,
# create a set of batting order of best 6 players using the selection criteria of those
# who have a good average score across all matches for South Africa.



create view `Batting_Order_GoodAvgScorers_SA`  as
(select * from
(select player,substr(span,1,4),substr(span,-4),avg,case when 
2019 between substr(span,1,4) and substr(span,-4) then '2019'
end as Year_
from icc_table) t where player like '%India%' and Year_ like '2019' order by avg desc limit 6);
select * from Batting_Order_GoodAvgScorers_SA;

#10.Create a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, 
#considering the players who were active in the year of 2019, create a set of batting order of best 6 players 
#using the selection criteria of those who have highest number of 100s across all matches for South Africa.



create view `Batting_Order_HighestCenturyScorers_SA`  as
(select * from
(select player,`100`,case when 
2019 between substr(span,1,4) and substr(span,-4) then '2019'
end as Year_
from icc_table) t where Year_ is not null and player like '%SA)'
order by '100' desc limit 6);
select * from Batting_Order_GoodAvgScorers_SA;
