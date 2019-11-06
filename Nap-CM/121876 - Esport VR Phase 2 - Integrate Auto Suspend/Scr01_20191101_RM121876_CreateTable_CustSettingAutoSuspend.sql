/*
	Created: 20191101@Eden
	Task: Create table CustSettingAutoSuspend
	RM: #121876
	DB: DBCUST/CustDB and all replications
*/
CREATE TABLE dbo.CustSettingAutoSuspend(
	CustID INT NOT NULL,
	AutoSuspendLive VARBINARY(20) NOT NULL,
	AutoSuspendNonLive VARBINARY(20) NOT NULL,
	CONSTRAINT [PK_CustSettingAutoSuspend_CustID] PRIMARY KEY CLUSTERED (CustID ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON virtualrate_table
) ON virtualrate_table
