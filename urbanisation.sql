CREATE VIEW world.urbanisation AS

SELECT 
    c.code, 
    c.name AS CountryName, 
    c.IndepYear, 
    c.Population AS CountryPopulation, 
    c.GNP,
    COALESCE(c.GNPOld, 0) AS GNPOld,
    ROUND((c.GNP / c.Population), 3) AS gnp_per_capita,
    (c.GNP - COALESCE(c.GNPOld, 0)) AS gnp_delta, 
    city.Name AS CapitalName,
    city.Population AS CapitalPopulation,
    (SELECT SUM(Population) FROM City WHERE CountryCode = c.Code) / c.Population AS urbanization_rate,
    CASE 
        WHEN c.LifeExpectancy > (SELECT AVG(LifeExpectancy) FROM Country WHERE LifeExpectancy IS NOT NULL) THEN 1 
        ELSE 0 
    END AS target_high_life
FROM country AS c
LEFT JOIN city ON c.Capital = city.ID
WHERE c.IndepYear IS NOT NULL
  AND c.Population > 1000000
  AND ROUND((c.GNP / c.Population), 3) > 0;