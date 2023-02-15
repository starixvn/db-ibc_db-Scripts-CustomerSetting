/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20221012@Eden
	Task: rename unsused columns on Custinfo tables [#179014]
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/
GO 
EXEC sp_rename 'custinfo.maxpermatch','DEL_maxpermatch', 'COLUMN'
EXEC sp_rename 'custinfo.MaxPerMatch1MP','DEL_MaxPerMatch1MP', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch2','DEL_maxpermatch2', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch3','DEL_maxpermatch3', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch5','DEL_maxpermatch5', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch8','DEL_maxpermatch8', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch10','DEL_maxpermatch10', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch11','DEL_maxpermatch11', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch12','DEL_maxpermatch12', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch99','DEL_maxpermatch99', 'COLUMN'
EXEC sp_rename 'custinfo.MaxPerMatch99MP','DEL_MaxPerMatch99MP', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch161','DEL_maxpermatch161', 'COLUMN'
EXEC sp_rename 'custinfo.MaxPerBall161','DEL_MaxPerBall161', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch164','DEL_maxpermatch164', 'COLUMN'

EXEC sp_rename 'custinfo.HideGoldDeluxe','DEL_HideGoldDeluxe', 'COLUMN'
EXEC sp_rename 'custinfo.DisableGoldDeluxe','DEL_DisableGoldDeluxe', 'COLUMN'
EXEC sp_rename 'custinfo.DisableCasino','DEL_DisableCasino', 'COLUMN'
EXEC sp_rename 'custinfo.SyncCasino','DEL_SyncCasino', 'COLUMN'

