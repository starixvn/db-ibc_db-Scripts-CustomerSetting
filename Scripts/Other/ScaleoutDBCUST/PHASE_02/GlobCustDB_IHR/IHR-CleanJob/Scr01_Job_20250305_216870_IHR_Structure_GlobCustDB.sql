/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250305
	Task: in-house - Clean job [Redmine:#216870] 
	DB:	DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

CREATE TABLE [dbo].[RepInfo_CleanData](
	DatabaseName VARCHAR(100) NOT NULL,
	TableName VARCHAR(100) NOT NULL,
	Version_Key VARCHAR(100) NOT NULL,
	Unique_Key	VARCHAR(100) NOT NULL,
	CleanFromDate	DATETIME NULL
 CONSTRAINT [PK_RepInfo_CleanData] PRIMARY KEY CLUSTERED 
(
	DatabaseName ASC,
	TableName ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

--add data
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT CASE WHEN DatabaseName='CustDB' THEN 'GlobCustDB' ELSE DatabaseName END
	, TableName, Version_Key, Unique_Key
FROM CustDB.dbo.RepInfo_CleanData WITH (NOLOCK)
WHERE TableName IN ('Dep_ProductStakeLevelGroup'
					,'DomainManagement'
					,'ProductStakeLevelGroup'
					,'SportBettypeSettingMatrix'
				)
GO