/*<info serverAlias="DBTXN-CustDB "></info>*/
/*
	Created: 20231227@Eden
	Task : Init data RepInfo_CleanData for some tables [#198589]
	DB:  DBTXN-CustDB(Include sitedb)
*/
USE custdb
GO

DELETE FROM RepInfo_CleanData

INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','SportBettypeSettingMatrix','RepUpdateTime','BetType,SportType,isLicensee,isLive,Site'

SELECT * FROM RepInfo_CleanData WITH(NOLOCK)
--EXEC Task_Repl_CleanDeletedData