/*
	Created By: Winnie
	Created Date: 20191107
	RedmineID: #119713
	DB: DBCUST/CUSTDB	
*/
DELETE 
FROM  ProfileVirtualSetting WITH(ROWLOCK,UPDLOCK)
where sporttype=9 AND seqNo=3
