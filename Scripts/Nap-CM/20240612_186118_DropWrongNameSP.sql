/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240904@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM]  Customer Class -  Integrate for Sport CC - Saba Sport [209775]
*/

--===================================================================================
DROP PROCEDURE IF EXISTS dbo.NAP_CM_CustomerClassSpreadDel;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_CM_CustomerClassSpreadEnable;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_CM_CustomerClassSpreadIns;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_CM_CustomerClassSpreadSel;
GO
DROP PROCEDURE IF EXISTS dbo.NAP_CM_CustomerClassSpreadUpd;
GO