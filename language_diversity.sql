/*
This query creates a view that shows one row per country, summarising how languages are spread and identifying the primary official
language in that country. This query also includes 'not available' and null values for further EDA analysis.
*/
CREATE VIEW language_diversity as
SELECT 
    c.Name AS CountryName,
    c.Continent,
    COUNT(cl.Language) AS TotalLanguagesSpoken,
    MAX(CASE WHEN cl.IsOfficial = 'T' THEN cl.Language ELSE NULL END) AS PrimaryOfficialLanguage,
    ROUND(AVG(cl.Percentage), 2) AS AvgLanguageSpread
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
GROUP BY c.Name, c.Continent;