/*
	Created: 20200116@Elodie
	Task: Create view
	DB: DBCust.CustDB, DB06.bodb02
*/

CREATE VIEW [dbo].[vw_CS_CustDiscount_Agent]
AS
	SELECT a.Custid,b.*
	FROM CS_CustDiscount_Agent a WITH(NOLOCK)
		CROSS APPLY dbo.[f_CS_GetDiscount_Agent] (a.custID) b
GO
GRANT SELECT ON [vw_CS_CustDiscount_Agent] TO vnteam
GO

CREATE VIEW [dbo].[vw_CS_CustGroupDiscount_Member]
AS
	SELECT a.AgentId,b.*
	FROM CS_CustGroupDiscount_Member a WITH(NOLOCK)
		CROSS APPLY dbo.[f_CS_GetGroupDiscount_Member] (a.AgentId) b
GO
GRANT SELECT ON [vw_CS_CustGroupDiscount_Member] TO vnteam
GO

CREATE VIEW [dbo].[vw_CS_CustDiscount_Member]
AS
	SELECT a.CustId,b.*
	FROM CS_CustDiscount_Member a WITH(NOLOCK)
		CROSS APPLY dbo.[f_CS_GetDiscount_Member] (a.CustId) b
GO
GRANT SELECT ON [vw_CS_CustDiscount_Member] TO vnteam
GO

CREATE VIEW [dbo].[vw_CS_CustPTSetting_Agent]
AS
	SELECT a.CustId,b.*
	FROM CS_CustPTSetting_Agent a WITH(NOLOCK)
		CROSS APPLY dbo.[f_CS_GetPT_Agent] (a.CustId) b
GO
GRANT SELECT ON [vw_CS_CustPTSetting_Agent] TO vnteam
GO

CREATE VIEW [dbo].[vw_CS_CustPTGroupSetting_Member]
AS
	SELECT a.AgentId,b.*
	FROM CS_CustPTGroupSetting_Member a WITH(NOLOCK)
		CROSS APPLY dbo.[f_CS_GetPTGroup_Member] (a.AgentId) b
GO
GRANT SELECT ON [vw_CS_CustPTGroupSetting_Member] TO vnteam
GO

