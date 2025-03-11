/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20250211@Tacy
	Task: Scale Out DBCUST - Setup InHouse replication on Dist
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250211@Tacy: Created [RedmineID: #216870]
*/
USE ReplCustDB
GO

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix)
SELECT 2,'ProfilePicture',0,'RepUpdateTime',0,'imageid','Repl_GetProfilePicture','Repl_PutProfilePicture_Dist',1000,10,60000
GO