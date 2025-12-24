SELECT 
    c.Code,
    c.Name,
    c.Continent,
    c.Population,
    c.GNP,
    round((c.GNP / c.Population),3) AS gnp_per_capita,
    (c.GNP - COALESCE(c.GNPOld, c.GNP)) AS gnp_delta,
    (SELECT SUM(Population) FROM City WHERE CountryCode = c.Code) / c.Population AS urbanization_rate,
    CASE 
        WHEN c.LifeExpectancy > (SELECT AVG(LifeExpectancy) FROM Country WHERE LifeExpectancy IS NOT NULL) THEN 1 
        ELSE 0 
    END AS target_high_life
FROM Country c
WHERE 
  c.LifeExpectancy IS NOT NULL 
  AND c.Population >= 1000000 
AND Round((c.GNP / c.Population),3) > 0; -- gnp_per_capita higher than 0
