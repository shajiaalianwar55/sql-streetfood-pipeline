import pyodbc

# Step 1: Connect to SQL Server
conn = pyodbc.connect(
    'DRIVER={SQL Server};'
    'SERVER=localhost\\SQLEXPRESS;' # or whatever instance you actually use
    'DATABASE=task1;'               # the Database that contains your table
    'Trusted_Connection=yes;'
)
cursor = conn.cursor()

# Step 2: Define your SQL queries
queries = [

    # View 1: SalesByCuisine
    """
    CREATE OR ALTER VIEW SalesByCuisine AS
    SELECT DishName, SUM(TypicalPrice_USD) AS TotalSales
    FROM dbo.global_street_food_cleaned
    GROUP BY DishName;
    """,

    # View 2: DishesByPriceRange
    """
    CREATE OR ALTER VIEW DishesByPriceRange AS
    SELECT 
        DishName,
        MAX(TypicalPrice_USD) AS MaxPrice,
        MIN(TypicalPrice_USD) AS MinPrice,
        MAX(TypicalPrice_USD) - MIN(TypicalPrice_USD) AS PriceRange
    FROM dbo.global_street_food_cleaned
    GROUP BY DishName
    HAVING MAX(TypicalPrice_USD) - MIN(TypicalPrice_USD) > 2;
    """,

    # Drop & Create Clustered Index
    "IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'IX_Clustered_RegionCity') DROP INDEX IX_Clustered_RegionCity ON dbo.global_street_food_cleaned;",
    "CREATE CLUSTERED INDEX IX_Clustered_RegionCity ON dbo.global_street_food_cleaned (Region_City);",

    # Drop & Create Non-Clustered Index
    "IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'IX_NonClustered_Vegetarian') DROP INDEX IX_NonClustered_Vegetarian ON dbo.global_street_food_cleaned;",
    "CREATE NONCLUSTERED INDEX IX_NonClustered_Vegetarian ON dbo.global_street_food_cleaned (Vegetarian);",

    # View 3: Regional_StreetFood_Analysis
    """
    CREATE OR ALTER VIEW Regional_StreetFood_Analysis AS
    SELECT
        g.Region_City,
        g.Country,
        COUNT(*) AS DishCount,
        AVG(TypicalPrice_USD) AS AvgPrice,
        SUM(TypicalPrice_USD) AS TotalSales,
        v.VegetarianRatio
    FROM dbo.global_street_food_cleaned g
    JOIN (
        SELECT 
            Region_City,
            CAST(SUM(CAST(Vegetarian AS INT)) AS FLOAT) / COUNT(*) AS VegetarianRatio
        FROM dbo.global_street_food_cleaned
        GROUP BY Region_City
    ) v ON g.Region_City = v.Region_City
    GROUP BY g.Region_City, g.Country, v.VegetarianRatio;
    """
]

# Step 3: Run all the queries
for q in queries:
    try:
        cursor.execute(q)
        print(" Executed:", q.strip().split('\n')[0])
    except Exception as e:
        print(" Error running query:", q.strip().split('\n')[0])
        print("   →", e)

# Step 4: Commit and close
conn.commit()
cursor.close()
conn.close()

print("\n All SQL tasks completed!")
