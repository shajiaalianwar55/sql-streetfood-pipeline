Go                                                               -- NEW BATCH
CREATE OR ALTER VIEW SalesByCuisine AS                           -- VIEW CREATION
SELECT DishName, 
SUM(TypicalPrice_USD) AS TotalSales
FROM dbo.global_street_food_cleaned
GROUP BY DishName;

Go
SELECT * FROM SalesByCuisine                                    --VIEW 

Go
CREATE OR ALTER VIEW DishesByPriceRange AS                          --FILTERING DISHES BY PRICE RANGE
SELECT 
    DishName,
    MAX(TypicalPrice_USD) AS MaxPrice,
    MIN(TypicalPrice_USD) AS MinPrice,
    MAX(TypicalPrice_USD) - MIN(TypicalPrice_USD) AS PriceRange
FROM dbo.global_street_food_cleaned
GROUP BY DishName
HAVING MAX(TypicalPrice_USD) - MIN(TypicalPrice_USD) > 2;

Go
SELECT*
FROM DishesByPriceRange;

Go

CREATE OR ALTER VIEW Regional_StreetFood_Analysis AS
SELECT
    g.Region_City,
    g.Country,
    COUNT(*) AS DishCount,
    AVG(TypicalPrice_USD) AS AvgPrice,
    SUM(TypicalPrice_USD) AS TotalSales
FROM dbo.global_street_food_cleaned g
JOIN (                                                       --DERIVED TABLE FOR REGIONAL ANALYSIS
SELECT 
Region_City,
CAST(SUM(CAST(Vegetarian AS INT)) AS FLOAT)/ COUNT(*) AS VegetarianRatio
FROM dbo.global_street_food_cleaned
GROUP BY Region_City)
v ON g.Region_City = v.Region_City
GROUP BY g.Region_City, g.Country, v.VegetarianRatio;

Go
SELECT*
FROM Regional_StreetFood_Analysis;