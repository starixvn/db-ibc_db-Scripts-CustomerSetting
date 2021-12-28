/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Insert ProductSettingSystemDisplay for Saba Casino [#164280]
	DB: DBCUST/CustDB
*/
DECLARE @ProductID TINYINT = 6

DELETE FROM dbo.ProductSettingSystemDisplay WITH(ROWLOCK,UPDLOCK) WHERE ProductID = 6

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