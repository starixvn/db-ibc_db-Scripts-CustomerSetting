/*
	Created: 20200318@Elodie
	Task: Insert ProductSettingSystemDisplay for Saba.club
	DB: DBCUST/CustDB
*/
DECLARE @ProductID TINYINT = 42

DELETE FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 42

INSERT INTO dbo.ProductSettingSystemDisplay
        ( SystemID ,
          ProductID ,
          SettingType ,
          DisplayMode
        )
SELECT 5,@ProductID,13,3
UNION ALL 
SELECT 5,@ProductID,1,3
UNION ALL 
SELECT 5,@ProductID,6,3
UNION ALL
SELECT 9,@ProductID,13,3
UNION ALL 
SELECT 9,@ProductID,1,3
UNION ALL 
SELECT 9,@ProductID,6,3
UNION ALL
SELECT 6,@ProductID,13,3
UNION ALL
SELECT 7,@ProductID,13,3
UNION ALL
SELECT 8,@ProductID,13,3