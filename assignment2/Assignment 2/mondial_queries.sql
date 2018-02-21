--SQL1
SELECT name FROM island WHERE type = 'coral' or type = 'atoll';

--SQL2
SELECT name,province,country,population FROM city where latitude > 66.33;

--SQL3
SELECT country FROM encompasses WHERE encompasses.continent = 'Europe' EXCEPT SELECT country FROM isMember WHERE isMember.organization = 'EU';

--SQL4
SELECT country.name FROM language  JOIN country ON country.code = language.country WHERE language.name = 'English' AND percentage > 50;

--SQL5
WITH deepLake AS (SELECT DISTINCT * FROM lake WHERE depth > 1000),
	deepSea AS (SELECT DISTINCT * FROM sea WHERE depth > 1000)
(SELECT geo_lake.province FROM geo_lake JOIN deepLake ON deepLake.name = geo_lake.lake) UNION (SELECT geo_sea.province FROM geo_sea JOIN deepSea ON deepSea.name = geo_sea.sea);

--SQL6
WITH year2001 AS ( SELECT country, population AS population2001 FROM countrypops WHERE year = 2001 ),
	year2011 AS ( SELECT country, population AS population2011 FROM countrypops WHERE year = 2011 )
SELECT year2001.country, (population2011 - population2001) FROM year2001,year2011 WHERE year2001.country = year2011.country;

--SQL6
WITH year01 AS (SELECT country,countrypops.population AS pop01 FROM countrypops WHERE year = 2001),
	year11 AS (SELECT country,countrypops.population AS pop11 FROM countrypops WHERE year = 2011)
SELECT year01.country, (pop11-pop01) AS population FROM year01,year11 WHERE year01.country = year11.country;	

--SQL7
SELECT organization, AVG(gdp) FROM country JOIN isMember ON isMember.country = country.code JOIN economy ON economy.country = country.code GROUP BY organization;

--SQL8
--WITHOUT DOPLICATE
SELECT DISTINCT geo_lake.lake FROM geo_lake JOIN geo_lake AS geo_lake2 ON geo_lake.lake = geo_lake2.lake WHERE geo_lake.country <> geo_lake2.country;
--WITH DOPLICATE
SELECT geo_lake.lake FROM geo_lake JOIN geo_lake AS geo_lake2 ON geo_lake.lake = geo_lake2.lake WHERE geo_lake.country <> geo_lake2.country;

--SQL9
SELECT country.name, num_lakes, num_river FROM country  RIGHT JOIN (
																(SELECT country AS countryLake, COUNT(lake) AS num_lakes FROM geo_lake GROUP BY country) AS lakeCount
																FULL OUTER JOIN 
																(SELECT country AS countryRiver, COUNT(river) AS num_river FROM geo_river GROUP BY country) AS riverCount
																ON countryLake = countryRiver
																) AS waterCount ON countryLake = country.code AND countryRiver = country.code;

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
SELECT country.code, COUNT(country.code) AS number  FROM country
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

--SQL14
WITH avg_count AS (SELECT economy.country AS country , AVG(gdp/population) AS richnes FROM countrypops JOIN economy ON economy.country = countrypops.country GROUP BY economy.country)
SELECT continent, MAX(richnes) FROM encompasses JOIN avg_count ON avg_count.country = encompasses.country GROUP BY continent;

--SQL15
WITH america AS (SELECT encompasses.country,language.name AS language FROM encompasses 
							JOIN language ON language.country = encompasses.country 
							WHERE encompasses.continent = 'America' AND language.name <> 'English'),							
	africa 	AS	(SELECT language.name AS language FROM encompasses
							JOIN language ON language.country = encompasses.country 
							WHERE language.percentage > 80 AND encompasses.continent = 'Africa')																	
SELECT 	country FROM america,africa WHERE america.language = africa.language;
