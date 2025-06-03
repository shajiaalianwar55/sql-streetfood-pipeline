SELECT* FROM dbo.global_street_food_cleaned                    --CHECKING FOR NULL VALUES
WHERE 
DishName IS NULL OR
Country IS NULL OR
Region_City IS NULL OR
Ingredients IS NULL OR
Description IS NULL OR
CookingMethod IS NULL OR
TypicalPrice_USD IS NULL OR
Vegetarian IS NULL;

SELECT*                                                        -- CHECKING IF VALUES GO BELOW 0
FROM dbo.global_street_food_cleaned
WHERE TypicalPrice_USD<0;

SELECT DISTINCT Vegetarian FROM dbo.global_street_food_cleaned; -- CHECKING FOR UNEXPECTED VALUES

SELECT* , COUNT(*) AS DuplicateCount                            -- CHECKING FOR DUPLICATES
FROM dbo.global_street_food_cleaned 
GROUP BY DishName,Country,Region_City,Ingredients,Description,CookingMethod,TypicalPrice_USD,Vegetarian
HAVING COUNT(*)>1;