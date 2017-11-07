/*
	Created : 20171107@Johnson	
	Task: Offer AllbetComm for licensees	
	DB: DBTP/bodb02 
	
*/

USE bodb02
GO

CREATE TRIGGER [dbo].[Dep_CustDiscountSetting_Member_update] ON [dbo].Dep_CustDiscountSetting_Member AFTER UPDATE
AS
/*
	Created by: 20171107@Johnson
	Task: Trigger for updating [Dep_CustDiscountSetting_Member_History] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[Dep_CustDiscountSetting_Member_History] 
	(
	   [CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount]		
	)
	SELECT
		[CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount] 
	FROM [DELETED]
END

GO


CREATE TRIGGER [dbo].[Dep_CustDiscountGroupSetting_Member_update] ON [dbo].Dep_CustDiscountGroupSetting_Member AFTER UPDATE
AS
/*
	Created by: 20171107@Johnson
	Task: Trigger for updating [Dep_CustDiscountSetting_Member_History] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[Dep_CustDiscountGroupSetting_Member_History] 
	(
	   [AgentID]
	   ,[SportType]
	   ,[BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount]		
	)
	SELECT
		[AgentID]
	   ,[SportType]
	   ,[BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount] 
	FROM [DELETED]
END
GO