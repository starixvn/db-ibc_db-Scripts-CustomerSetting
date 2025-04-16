/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20241004@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]
*/

--===================================================================================
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassSpreadDel;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassSpreadEnable;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassSpreadIns;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassSpreadSel;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_LM_CustomerClassSpreadUpd;
GO