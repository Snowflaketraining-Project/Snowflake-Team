create database Genufy;
create schema Cricket;

--create table name cricketplayers

CREATE or replace TABLE CricketPlayers (
    PlayerID INT PRIMARY KEY,
    PlayerName VARCHAR(50),
    Country VARCHAR(30),
    Role VARCHAR(20),         -- Batsman / Bowler / All-rounder / Wicketkeeper
    Matches INT,
    Runs INT,
    Wickets INT,
    BattingAverage DECIMAL(5,2),
    BowlingAverage DECIMAL(5,2)
);

--insert records for cricketplayers

INSERT INTO CricketPlayers VALUES
(1, 'Virat Kohli', 'India', 'Batsman', 275, 13000, 4, 57.3, NULL),
(2, 'Rohit Sharma', 'India', 'Batsman', 250, 10500, 8, 49.4, NULL),
(3, 'Jasprit Bumrah', 'India', 'Bowler', 140, 350, 200, 12.4, 21.5),
(4, 'MS Dhoni', 'India', 'Wicketkeeper', 350, 10700, 1, 50.6, NULL),
(5, 'Ben Stokes', 'England', 'All-rounder', 165, 6000, 150, 38.7, 29.5),
(6, 'Joe Root', 'England', 'Batsman', 180, 9500, 20, 50.1, NULL),
(7, 'James Anderson', 'England', 'Bowler', 180, 1000, 650, 9.8, 26.4),
(8, 'Kane Williamson', 'New Zealand', 'Batsman', 160, 8000, 30, 52.2, NULL),
(9, 'Trent Boult', 'New Zealand', 'Bowler', 150, 500, 300, 8.2, 27.0),
(10, 'Babar Azam', 'Pakistan', 'Batsman', 120, 6000, 5, 56.5, NULL),
(11, 'Shaheen Afridi', 'Pakistan', 'Bowler', 75, 250, 150, 7.4, 24.1),
(12, 'David Warner', 'Australia', 'Batsman', 190, 6500, 15, 45.8, NULL),
(13, 'Pat Cummins', 'Australia', 'Bowler', 120, 700, 250, 9.1, 23.7),
(14, 'Steve Smith', 'Australia', 'Batsman', 155, 7800, 30, 54.7, NULL),
(15, 'Glenn Maxwell', 'Australia', 'All-rounder', 140, 3500, 50, 36.2, 32.0),
(16, 'Shakib Al Hasan', 'Bangladesh', 'All-rounder', 220, 7000, 250, 38.3, 30.5),
(17, 'Tamim Iqbal', 'Bangladesh', 'Batsman', 230, 7800, 3, 36.8, NULL),
(18, 'Rashid Khan', 'Afghanistan', 'Bowler', 90, 450, 180, 12.8, 18.9),
(19, 'Chris Gayle', 'West Indies', 'Batsman', 300, 10400, 20, 38.1, NULL),
(20, 'Andre Russell', 'West Indies', 'All-rounder', 150, 3200, 120, 30.5, 27.8);


--1. Write a query to display all records from the CricketPlayers table.

select * from cricketplayers

--2. Write a query to display PlayerName, Country, and Role for all players.

select Playername, country, role from  cricketplayers;

--3. Write a query to show all players who belong to the country "India".

select * from cricketplayers where country = 'India';

--4. Write a query to list players who have scored more than 6000 runs.

select * from cricketplayers where runs>=6000;

--5. Write a query to display all bowlers from the table.

select * from cricketplayers where role = 'Bowler'

--6. Write a query to list all players sorted by Runs in descending order.

select * from cricketplayers order by runs desc;

--7. Write a query to show the top 3 batsmen with the highest BattingAverage.

select battingaverage, role, playername from cricketplayers where role = 'Batsman' limit 3

--8. Write a query to find all players who have taken at least 100 wickets.

select * from cricketplayers where wickets > 100;

--9. Write a query to count how many players are from each country.

select count(playerid), country from cricketplayers group by country;

--10. Write a query to list players whose Country is either "India" or "Pakistan".

select * from cricketplayers where country='India' or country = 'Pakistan';

--11. Write a query to display players whose BattingAverage is between 40 and 55.

select * from cricketplayers where battingaverage between 40 and 55;

--12. Write a query to show all players who have played more than 150 matches.

select playername, matches from cricketplayers where matches > 150;


--13. Write a query to calculate the average number of runs scored by bowlers.

select avg(runs),role from cricketplayers where role = 'Bowler' group by role;

--14. Write a query to group players by Role and count how many players are in each role.

select count(playername), role from cricketplayers group by role ;

--15. Write a query to list all players whose names start with the letter 'R'.

select * from cricketplayers where playername like 'R%';

--16. Write a query to show the player with the maximum number of wickets.

select playername, wickets from cricketplayers order by wickets desc limit 1;

--17. Write a query to show the player with the minimum BowlingAverage.

select playername, bowlingaverage from cricketplayers order by bowlingaverage asc limit 1;
select * from cricketplayers

--18. Write a query to find all players who have NULL in the BowlingAverage column.

select * from cricketplayers where bowlingaverage is null;

--19. Write a query to add a new column named StrikeRate to the table.

alter table cricketplayers add StrikeRate int;

--20. Write a query to update the number of matches for a specific player.

update cricketplayers set  playerid = 1 where playername = 'Virat Kohli';
select * from cricketplayers

--21. Write a query to delete a player record based on PlayerID.

delete from cricketplayers where playerid = 20;

--22. Write a query to display the total runs scored by all players from "Australia".

select sum(runs),country from cricketplayers where country = 'Australia' group by country;

--23. Write a query to list players who have both more than 3000 runs AND more than 50 wickets.

select * from cricketplayers where runs > 3000 and wickets >50;

--24. Write a query to display players in ascending order of PlayerName.

select * from cricketplayers order by playername asc;

--25. Write a query to show the top 5 players with the highest number of matches played.

select top 5  matches, playername from cricketplayers order by matches desc;
select matches, playername from cricketplayers order by matches desc limit 5;








