/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200511@Eden
	Task: Create table VRSettingReference [RM#132517]
	DB: DBCUST/CustDB and CustDB_CustSetting Publication
*/
USE [CustDB]
GO
--DROP TABLE [dbo].[VRSettingReference]

CREATE TABLE dbo.VRSettingReference(
	SportType     INT NOT NULL, 
	LeagueGroupID INT NOT NULL, 
	BetType       INT NOT NULL, 
	RefLevelID    INT NOT NULL
CONSTRAINT [PK_VRSettingReference] PRIMARY KEY CLUSTERED 
(	
	SportType ASC,
	LeagueGroupID ASC,
	BetType ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON virtualrate_table
) ON virtualrate_table
GO

INSERT INTO VRSettingReference (SportType,LeagueGroupID,BetType,RefLevelID)
SELECT 43,19,9087,79 -- refLevelID of CS:GO --> MoneyLine
GO