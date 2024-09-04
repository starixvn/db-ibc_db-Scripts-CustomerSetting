/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240904@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM]  Customer Class -  Integrate for Sport CC - Saba Sport [209775]
*/

--===================================================================================
UPDATE a SET a.SportType = CASE WHEN a.SportType = 145 THEN 9901
								WHEN a.SportType = 912 THEN 9902
								ELSE a.SportType END
FROM CustomerClassSetting a WITH(ROWLOCK, UPDLOCK) WHERE custid =48318157
GO
