
DROP INDEX IX_Clustered_RegionCity ON dbo.global_street_food_cleaned; -- DROP TO AVOID ERROR
CREATE CLUSTERED INDEX IX_Clustered_RegionCity                        -- CLUSTERED INDEX CREATION
ON dbo.global_street_food_cleaned (Region_City);

DROP INDEX IX_NonClustered_Vegetarian ON dbo.global_street_food_cleaned; -- DROP TO AVOID ERROR
CREATE NONCLUSTERED INDEX IX_NonClustered_Vegetarian                     -- NONCLUSTERED INDEX CREATION
ON dbo.global_street_food_cleaned (Vegetarian);

