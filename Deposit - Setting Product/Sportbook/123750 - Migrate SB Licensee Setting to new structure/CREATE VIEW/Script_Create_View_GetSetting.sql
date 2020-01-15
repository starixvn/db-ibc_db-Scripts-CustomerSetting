DROP VIEW VW_DSB_CustPTSetting_Agent 
DROP VIEW VW_DSB_CustPTSetting_Member 
DROP VIEW VW_DSB_CustDiscount_Agent 
DROP VIEW VW_DSB_CustDiscount_Member
DROP VIEW VW_DSB_CustGroupDiscount_Member
DROP VIEW VW_DSB_CustPTGroupSetting_Member
GO
CREATE VIEW [dbo].VW_DSB_CustPTSetting_Member 
/*
	Created: 20191212@Eden
	Task:  - [Redmine: 107131]
	DB: DBCust/custdb - DBACC/bodbo2
*/
AS
SELECT a.Custid,b.*
FROM DSB_CustPTSetting_Member a WITH(NOLOCK)
	CROSS APPLY dbo.[f_DSB_GetPT_Member] (a.custID) b
GO

CREATE VIEW [dbo].VW_DSB_CustPTSetting_Agent 
/*
	Created: 20191212@Eden
	Task:  - [Redmine: 107131]
	DB: DBCust/custdb - DBACC/bodbo2
*/
AS
SELECT a.Custid,b.*
FROM DSB_CustPTSetting_Agent a WITH(NOLOCK)
	CROSS APPLY dbo.[f_DSB_GetPT_Agent] (a.custID) b
GO


CREATE VIEW [dbo].VW_DSB_CustPTGroupSetting_Member
/*
	Created: 20191212@Eden
	Task:  - [Redmine: 107131]
	DB: DBCust/custdb - DBACC/bodbo2
*/
AS
SELECT a.AgentID,b.*
FROM DSB_CustPTGroupSetting_Member a WITH(NOLOCK)
	CROSS APPLY dbo.[f_DSB_GetPTGroup_Member] (a.AgentID) b
GO


CREATE VIEW [dbo].VW_DSB_CustDiscount_Member
/*
	Created: 20191212@Eden
	Task:  - [Redmine: 107131]
	DB: DBCust/custdb - DBACC/bodbo2
*/
AS
SELECT a.Custid,b.*
FROM DSB_CustDiscount_Member a WITH(NOLOCK)
	CROSS APPLY dbo.[f_DSB_GetDiscount_Member] (a.custID) b
GO

CREATE VIEW [dbo].VW_DSB_CustDiscount_Agent
/*
	Created: 20191212@Eden
	Task:  - [Redmine: 107131]
	DB: DBCust/custdb - DBACC/bodbo2
*/
AS
SELECT a.Custid,b.*
FROM DSB_CustDiscount_Agent a WITH(NOLOCK)
	CROSS APPLY dbo.[f_DSB_GetDiscount_Agent] (a.custID) b
GO


CREATE VIEW [dbo].VW_DSB_CustGroupDiscount_Member
/*
	Created: 20191212@Eden
	Task:  - [Redmine: 107131]
	DB: DBCust/custdb - DBACC/bodbo2
*/
AS
SELECT a.AgentID,b.*
FROM DSB_CustGroupDiscount_Member a WITH(NOLOCK)
	CROSS APPLY dbo.[f_DSB_GetDiscountGroup_Member] (a.AgentId) b
GO