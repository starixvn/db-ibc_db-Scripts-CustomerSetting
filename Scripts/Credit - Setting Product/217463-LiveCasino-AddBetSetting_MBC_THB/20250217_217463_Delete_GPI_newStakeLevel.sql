/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20250217
	Task: Delete GPI - new stakelevel [redmine: #217463]
	DB: DBCust/CustDB
*/ 
USE CustDB
GO

IF @@SERVERNAME = 'SITDBCUST'
BEGIN
	DELETE FROM StakeLevel WITH (ROWLOCK)
	WHERE StakeLevelID=7351 
END
ELSE
BEGIN
	DELETE FROM StakeLevel WITH (ROWLOCK)
	WHERE StakeLevelID=2788 
END
GO