/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial ProductStakeLevelGroup - UUS Currency [#198960] 
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/
	IF EXISTS (SELECT 1 FROM ProductStakeLevelGroup WITH (NOLOCK) WHERE Sporttype IN (171,224,245) AND GameGroupID = 1 AND CreditGroupID = 6)
	BEGIN
		UPDATE  p
		SET 
			P.isDeleted = 1,
			P.RepUpdateTime = SYSDATETIME ()
		FROM ProductStakeLevelGroup p  WITH (ROWLOCK) WHERE Sporttype IN (171,224,245) AND GameGroupID = 1 AND CreditGroupID = 6
	END
