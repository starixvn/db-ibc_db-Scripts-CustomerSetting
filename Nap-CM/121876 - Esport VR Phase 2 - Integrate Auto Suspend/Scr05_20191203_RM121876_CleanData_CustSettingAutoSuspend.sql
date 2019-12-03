/*
	Created: 20191203@Eden
	Task: Clean temporate data (test data) for CustSettingAutoSuspend table (New table)
	RM: #121876
	DB: DBCUST/CustDB
*/

DELETE CustSettingAutoSuspend WITH(UPDLOCK,ROWLOCK)