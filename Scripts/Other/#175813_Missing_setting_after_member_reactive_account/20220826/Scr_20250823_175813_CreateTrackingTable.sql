  /*<info serverAlias="DBCUST-CustDB,DBACC-bodb02"></info>*/
/*
    Created: Eden@20220823
    Task: Create temp table Temp_TrackingReactiveFailed to tracking reactive issue [#175813]
    DB: DBCUST/CustDB, DB061/bodb02, DB06/bodb02
*/ 
--DROP TABLE [Temp_TrackingReactiveFailed]
CREATE TABLE [dbo].[Temp_TrackingReactiveFailed](
	[CustID] [int] ,
	[SPName] [VARCHAR](100) NULL,
	[Desc] [VARCHAR](100)
)