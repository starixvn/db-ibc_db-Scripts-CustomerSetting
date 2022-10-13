/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20221012@Eden
	Task: rename unsused columns on Custinfo tables - ROLLBACK [#179014]
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/
EXEC sp_rename 'custinfo.DEL_maxpermatch','maxpermatch', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxPerMatch1MP','MaxPerMatch1MP', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch2','maxpermatch2', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch3','maxpermatch3', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch5','maxpermatch5', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch8','maxpermatch8', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch10','maxpermatch10', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch11','maxpermatch11', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch12','maxpermatch12', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch99','maxpermatch99', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxPerMatch99MP','MaxPerMatch99MP', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch161','maxpermatch161', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxPerBall161','MaxPerBall161', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch164','maxpermatch164', 'COLUMN'

EXEC sp_rename 'custinfo.DEL_HideGoldDeluxe','HideGoldDeluxe', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableGoldDeluxe','DisableGoldDeluxe', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableCasino','DisableCasino', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_SyncCasino','SyncCasino', 'COLUMN'
