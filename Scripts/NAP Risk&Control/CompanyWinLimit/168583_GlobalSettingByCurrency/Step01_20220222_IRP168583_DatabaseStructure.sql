/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20220222
	Task: add structure to support Global setting by currency
	DB: DBCUST/CustDB
*/

ALTER TABLE Winlimit_ProductGlobalSetting ADD Currency INT
GO

UPDATE Winlimit_ProductGlobalSetting
SET currency = 0 
GO

ALTER TABLE Winlimit_ProductGlobalSetting ALTER COLUMN Currency INT NOT NULL
GO

ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting] DROP CONSTRAINT [PK_Winlimit_ProductGlobalSetting]
GO

ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting] ADD  CONSTRAINT [PK_Winlimit_ProductGlobalSetting] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[BetTypeID] ASC,
	[GroupID] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [WinlimitSetting_Tables]
GO

INSERT INTO [dbo].[Winlimit_ProductGlobalSetting]
           ([ProductID]
           ,[BetTypeID]
           ,[GroupID]
           ,[GroupName]
           ,[Level1]
           ,[Level2]
           ,[Level3]
           ,[Level101]
           ,[Level102]
           ,[blockedTransferLvl3]
           ,[Currency])
SELECT [ProductID]
	   ,[BetTypeID]
	   ,[GroupID]
	   ,[GroupName]
	   ,5000 as [Level1]
	   ,30000 as [Level2]
	   ,75000 as [Level3]
	   ,[Level101]
	   ,[Level102]
	   ,[blockedTransferLvl3]
	   ,t.[Currency]
FROM Winlimit_ProductGlobalSetting cs WITH(NOLOCK)
	CROSS APPLY (SELECT 51 currency
				UNION SELECT 13
				)t
WHERE (ProductID = 6 AND GroupName = 'RNG Casino - Normal Games')
	OR (ProductID = 32 AND GroupName = 'PP - Normal Games')
	OR (ProductID = 36 AND GroupName = 'SG - Normal Games')
	OR (ProductID = 42 AND GroupName = 'Saba.games - Normal Games')
	OR (ProductID = 66 AND GroupName = 'Vgaming - Normal Games')
	OR (ProductID = 22 AND GroupName = 'Macau Games')
	OR (ProductID = 34 AND GroupName = 'Arcadia Gaming')
	OR (ProductID = 38 AND GroupName = 'Virtual Games ')
	OR (ProductID = 50 AND GroupName = 'Funky Games')
	OR (ProductID = 55 AND GroupName = 'PG Soft')
	OR (ProductID = 56 AND GroupName = 'Joker')
	OR (ProductID = 60 AND GroupName = 'MaxGame')
	OR (ProductID = 61 AND GroupName = 'Habanero')
	OR (ProductID = 62 AND GroupName = 'CG')
	OR (ProductID = 67 AND GroupName = 'AdvantPlay')
	OR (ProductID = 68 AND GroupName = 'AdvantPlay Mini')
	
	
	
	