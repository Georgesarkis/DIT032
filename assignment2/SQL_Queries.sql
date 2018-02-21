//SQL1
SELECT name FROM island WHERE type = 'coral' or type = 'atoll';

//SQL2
SELECT name,province,country,population FROM city where latitude > 66.33;

//SQL3 //WRONG 
SELECT encompasses.country FROM isMember JOIN encompasses ON isMember.country = encompasses.country  WHERE encompasses.continent ='Europe' AND isMember.organization !='EU';

//SQL4
SELECT country FROM language WHERE name = 'English' AND percentage > 50;

//SQL5
WITH deepLake AS (SELECT name FROM lake WHERE depth > 1000),
	deepSea AS (SELECT name FROM sea WHERE depth > 1000)
	, all_together AS (SELECT * FROM deepLake,deepSea)
SELECT geo_lake.province FROM geo_lake  WHERE geo_lake.lake= all_togerher.name JOIN geo_sea ON geo_lake.country = geo_sea.country AND geo_sea.sea = all_together.name;

--SQL6
WITH year2001 AS ( SELECT country, population AS population2001 FROM countrypops WHERE year = 2001 ),
	year2011 AS ( SELECT country, population AS population2011 FROM countrypops WHERE year = 2011 )
SELECT year2001.country, (population2011 - population2001) FROM year2001,year2011 WHERE year2001.country = year2011.country;

--SQL6
WITH year01 AS (SELECT country,countrypops.population AS pop01 FROM countrypops WHERE year = 2001),
	year11 AS (SELECT country,countrypops.population AS pop11 FROM countrypops WHERE year = 2011)
SELECT year01.country, (pop11-pop01) AS population FROM year01,year11 WHERE year01.country = year11.country;	

--SQL7
SELECT AVG(economy.gdp),isMember.organization FROM country 	JOIN economy ON economy.country = country.code
															JOIN isMember ON isMember.country = country.code
															GROUP BY isMember.organization;

--SQL8
--SOLUTION 1:
WITH geo_lake1 AS(SELECT lake AS lake1 , country AS country1 , province AS province1 FROM geo_lake),
	geo_lake2 AS (SELECT lake AS lake2 , country AS country2 , province AS province2 FROM geo_lake)
SELECT DISTINCT geo_lake1.lake1 FROM geo_lake2 JOIN geo_lake1 ON lake1 = lake2 WHERE country1 <> country2;	
--SOLUTION 2:
SELECT DISTINCT geo_lake.lake FROM geo_lake JOIN geo_lake AS geo_lake2 ON geo_lake.lake = geo_lake2.lake WHERE geo_lake.country <> geo_lake2.country;


--SQL9
--WORKS BUT SHOUD BE WITHOUT WITH
WITH lakeCount AS (SELECT DISTINCT geo_lake.country,count(lake)AS lake_count from geo_lake GROUP BY country),
	riverCount AS (SELECT DISTINCT geo_river.country,count(river)AS river_count from geo_river GROUP BY country)
SELECT * from lakeCount FULL OUTER JOIN riverCount ON lakeCount.country = riverCount.country;
--DOESNT WORK
SELECT * FROM ((SELECT DISTINCT geo_lake.country,count(lake)AS lake_count from geo_lake GROUP BY country) AS lakeCount FULL OUTER JOIN (SELECT DISTINCT geo_river.country,count(river)AS river_count from geo_river GROUP BY country) AS riverCount ON riverCount.country =lakeCount.country ) WHERE lakeCount.country = riverCount.country;

--SQL10
--SOLUTION 1:
WITH sweMountain AS (SELECT name, elevation FROM geo_mountain 
														JOIN mountain ON mountain.name = geo_mountain.mountain 
														WHERE country = 'S')
SELECT name,elevation FROM sweMountain EXCEPT (SELECT sweMountain1.name,sweMountain1.elevation FROM sweMountain AS sweMountain1 
																								JOIN sweMountain AS sweMountain2 ON sweMountain1.name = sweMountain2.name 
																								WHERE sweMountain1.elevation < sweMountain2.elevation);
--SOLUTION 2:
SELECT DISTINCT name, MAX(elevation) AS maxEl FROM mountain 
														JOIN geo_mountain ON mountain.name = geo_mountain.mountain 
														WHERE geo_mountain.country = 'S' GROUP BY name;

--SQL11
--DOESNT WORK
WITH 	myairport1 AS (SELECT iatacode, latitude AS x1 FROM airport WHERE latitude = ABS(latitude - 66.33)),
		myairport2 AS (SELECT iatacode AS iatacode2 , x1 AS x2 FROM myairport1)
(SELECT iatacode 	FROM airport) EXCEPT (
											SELECT iatacode FROM myairport1
											JOIN myairport2 ON myairport1.iatacode = myairport2.iatacode2
											WHERE myairport1.x1 > myairport2.x2
											);
											
SELECT DISTINCT iatacode FROM airport EXCEPT( 
										SELECT airport1.iatacode FROM (SELECT iatacode, latitude AS x1 
																						FROM airport 
																						WHERE latitude = ABS(latitude - 66.33) )AS airport1
														JOIN (SELECT iatacode AS iatacode2, latitude AS x2 
																						FROM airport 
																						WHERE latitude = ABS(latitude - 66.33) )AS airport2
														ON airport1.iatacode = airport2.iatacode2 WHERE airport1.x1 > airport2.x2); 
																									
								



--SQL12
SELECT country.code, COUNT(country.name) AS number  FROM country
												JOIN borders ON country.code = borders.country1 
												OR country.code = borders.country2
												WHERE borders.length > 100
												GROUP BY country.code;								
																
--SQL13
SELECT DISTINCT country.name FROM country
								JOIN borders ON country.code = borders.country1 
								OR country.code = borders.country2
								WHERE borders.length > 100;
								--GROUP BY country.name;

--SQL14 NOT DONE












WITH rich AS (SELECT MAX(GDP / population) AS richnes,economy.country,continent FROM economy 	JOIN countrypops ON economy.country = countrypops.country
																					JOIN encompasses ON encompasses.country = economy.country
																					GROUP BY economy.country;)
SELECT richnes 











SELECT AVG(GDP / population) AS richnes FROM economy 	JOIN countrypops ON economy.country = countrypops.country
																					JOIN encompasses ON encompasses.country = economy.country
																					GROUP BY continent;










SELECT DISTINCT  temp.continent, countrypops.country FROM countrypops JOIN (SELECT   MAX(countrypops.population / economy.GDP) AS rich , countrypops.country , encompasses.continent
																																	FROM countrypops
																																	JOIN economy ON economy.country = countrypops.country
																																	JOIN encompasses ON encompasses.country = countrypops.country
																																	GROUP BY encompasses.continent , countrypops.country) AS temp
																																	ON countrypops.country = temp.country;
SELECT country FROM countrypops WHERE country IN (SELECT MAX(countrypops.population / economy.GDP) AS rich
																					FROM countrypops
																					JOIN economy ON economy.country = countrypops.country
																					JOIN encompasses ON encompasses.country = countrypops.country
																					GROUP BY encompasses.continent);
																					
																					
SELECT MAX(countrypops.populaiton / economy.GDP) AS rich FROM countrypops JOIN economy ON countrypops.country = economy.country;
SELECT encompasses.country,encompasses.continent FROM encompasses JOIN (SELECT MAX(countrypops.population / economy.GDP) AS rich,countrypops.country FROM countrypops 
																													JOIN economy ON countrypops.country = economy.country GROUP BY countrypops.country) AS rich1 
																	ON encompasses.country = rich1.country GROUP BY encompasses.continent,encompasses.country;


SELECT countrypops.country FROM countrypops
											JOIN economy ON economy.country = countrypops.country
											JOIN encompasses ON encompasses.country = countrypops.country


SELECT countrypops.country,encompasses.continent, MAX(countrypops.population / economy.GDP) AS rich
											FROM countrypops
											JOIN economy ON economy.country = countrypops.country
											JOIN encompasses ON encompasses.country = countrypops.country
											GROUP BY encompasses.continent;

SELECT countrypops.country ,MAX(countrypops.population / economy.GDP)
											FROM countrypops
											JOIN economy ON economy.country = countrypops.country
											JOIN encompasses ON encompasses.country = countrypops.country
											GROUP BY encompasses.continent;
											
											
											WHERE encompasses.country = countrypops.country
SELECT encompasses FROM country;

--SQL15
WITH america AS (SELECT encompasses.country,language.name AS language FROM encompasses 
							JOIN language ON language.country = encompasses.country 
							WHERE encompasses.continent = 'America' AND language.name <> 'English'),							
	africa 	AS	(SELECT language.name AS language FROM encompasses
							JOIN language ON language.country = encompasses.country 
							WHERE language.percentage > 80 AND encompasses.continent = 'Africa')																	
SELECT 	country FROM america,africa WHERE america.language = africa.language;
