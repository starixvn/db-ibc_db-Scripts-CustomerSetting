/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20231010@Tacy
	Task: In-House [RedmineID: #194332]
	DB: DBCUST-CustDB,DBACC-bodb02,DBTP-bodb02
*/
--Drop PK: PK_Dep_ProductStakeLevelGroup
ALTER TABLE Dep_ProductStakeLevelGroup DROP CONSTRAINT PK_Dep_ProductStakeLevelGroup
GO

ALTER TABLE Dep_ProductStakeLevelGroup ADD [SiteID] INT NULL
GO

--Default value:
ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_SiteID]  DEFAULT ((0)) FOR [SiteID]
GO

--Create PK
ALTER TABLE Dep_ProductStakeLevelGroup
ADD CONSTRAINT [PK_Dep_ProductStakeLevelGroup]
PRIMARY KEY CLUSTERED (
	[Sporttype] ASC,
	[GameGroupID] ASC,
	[LicenseeGroupID] ASC,
	[SiteID] ASC
)
GO