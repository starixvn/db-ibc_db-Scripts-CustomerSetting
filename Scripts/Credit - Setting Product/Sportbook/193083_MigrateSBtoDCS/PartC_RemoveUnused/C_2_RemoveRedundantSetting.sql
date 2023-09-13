/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231213@Helios
	Task: Remove Redundant Setting OF ProductStatusProfile & SportBettypeSettingMatrix [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/

	-- Remove ProductStatusProfile of E-Sports
	DELETE p
	FROM ProductStatusProfile p WITH (ROWLOCK)
	WHERE Sporttype = 43

	-- Remove SportBettypeSettingMatrix of SportsBook
	UPDATE sbsm 
		SET isDeleted = 1 , RepUpdateTime = SYSDATETIME()
	FROM SportBettypeSettingMatrix sbsm WITH (ROWLOCK , UPDLOCK)
	WHERE sbsm.RealProductId = 1