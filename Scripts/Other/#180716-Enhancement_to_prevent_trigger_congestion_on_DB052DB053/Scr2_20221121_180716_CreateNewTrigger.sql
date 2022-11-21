/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Create new triggers  [#180716] 
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
IF EXISTS(select top 1 1 from sys.objects where name = 'Dep_WLMonitored_Player_insert_delete' AND Type = 'TR')
BEGIN
	DROP Trigger Dep_WLMonitored_Player_insert_delete
END
GO
CREATE TRIGGER [dbo].[Dep_WLMonitored_Player_insert_delete] ON [dbo].Dep_WLMonitored_Player
AFTER DELETE,INSERT
AS
/*  
	Created by: 20221121@Eden
	Task: Trigger for updating Custinfo table  
	DB: DBCUST/CUSTDB

	Revisions:   
	- 20221121@Eden: Enhance run time of trigger to capture data for Pending table [#180716]
*/
BEGIN
	SET NOCOUNT ON

	INSERT INTO dbo.[CustWLMonitored_Setting_Pending] (
			CustID,
			recommend,
			IsDeleted
		)
	SELECT t.CustID, ci.recommend, 1 AS IsDeleted
	FROM [DELETED] t
		INNER JOIN custinfo ci WITH(NOLOCK)
			ON t.CustID = ci.custid
	UNION ALL 
	SELECT t.CustID, ci.recommend, 0 AS IsDeleted
	FROM inserted t
		INNER JOIN custinfo ci WITH(NOLOCK)
			ON t.CustID = ci.custid
END
GO
-----------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
IF EXISTS(select top 1 1 from sys.objects where name = 'WLMonitored_Player_insert_delete' AND Type = 'TR')
BEGIN
	DROP Trigger WLMonitored_Player_insert_delete
END
GO
CREATE TRIGGER [dbo].[WLMonitored_Player_insert_delete] ON [dbo].WLMonitored_Player
AFTER DELETE,INSERT
AS
/*  
	Created by: 20221121@Eden
	Task: Trigger for updating Custinfo table  
	DB: DBCUST/CUSTDB

	Revisions:   
	- 20221121@Eden: Enhance run time of trigger to capture data for Pending table [#180716]
*/
BEGIN
	SET NOCOUNT ON

	INSERT INTO dbo.[CustWLMonitored_Setting_Pending] (
			CustID,
			recommend,
			IsDeleted
		)
	SELECT t.CustID, t.AgentID, 1 AS IsDeleted
	FROM [DELETED] t
	UNION ALL 
	SELECT t.CustID, t.AgentID, 0 AS IsDeleted
	FROM inserted t
END
    
GO
-----------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
IF EXISTS(select top 1 1 from sys.objects where name = 'WLMonitored_Global_insert_delete' AND Type = 'TR')
BEGIN
	DROP Trigger WLMonitored_Global_insert_delete
END
GO
CREATE TRIGGER [dbo].[WLMonitored_Global_insert_delete] ON [dbo].WLMonitored_Global
AFTER DELETE,INSERT
AS
/*  
	Created by: 20221121@Eden
	Task: Trigger for updating Custinfo table  
	DB: DBCUST/CUSTDB

	Revisions:   
	- 20221121@Eden: Enhance run time of trigger to capture data for Pending table [#180716]
*/
BEGIN
	SET NOCOUNT ON

	INSERT INTO dbo.[CustWLMonitored_Setting_Pending] (
			CustID,
			recommend,
			IsDeleted
		)
	SELECT 0, t.AgentID, 1 AS IsDeleted
	FROM [DELETED] t
	UNION ALL 
	SELECT 0, t.AgentID, 0 AS IsDeleted
	FROM inserted t
END
    
GO