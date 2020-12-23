/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20201216
	Task: Insert Game Group for Max Game [RM:#147232]
	DB: DBCUST/CUSTDB
*/
DECLARE  @GameGroupID SMALLINT = 19
		,@betType SMALLINT  =  5401 
		,@sportType SMALLINT  = 237


DELETE psd
FROM dbo.GameGroup psd WITH(ROWLOCK)
WHERE 	psd.GameGroupID = @GameGroupID 
	AND RefSportType = @sportType 
	AND RefBetType  = @betType 		

INSERT INTO [GameGroup]([GameGroupID],[RefSportType],[RefBetType],[GroupName],[IsDeposit])
VALUES(@GameGroupID,@sportType,@betType,'Level 1',0)
