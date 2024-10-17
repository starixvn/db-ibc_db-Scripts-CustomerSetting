/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240924@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Customer Class - Allow licensees to bypass any restrict rules [188589]
*/
-- Disable Parlay data
--===================================================================================
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassPolicySel;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassRuleDel;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassRuleEnable;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassRuleIns;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassRuleSearch;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassRuleSel;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassSetting;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassSportGet;
GO
