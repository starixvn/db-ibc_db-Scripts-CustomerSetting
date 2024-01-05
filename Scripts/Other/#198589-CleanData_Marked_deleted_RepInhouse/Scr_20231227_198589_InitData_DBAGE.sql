/*<info serverAlias="DBAGE-bodb02 "></info>*/
/*
	Created: 20231227@Eden
	Task : Init data RepInfo_CleanData for some tables [#198589]
	DB:  DBAGE-bodb02
*/
USE bodb02
GO

DELETE FROM RepInfo_CleanData

INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','ProfilePicture','RepUpdateTime','ImageId'

SELECT * FROM RepInfo_CleanData WITH(NOLOCK)
--EXEC Task_Repl_CleanDeletedData
