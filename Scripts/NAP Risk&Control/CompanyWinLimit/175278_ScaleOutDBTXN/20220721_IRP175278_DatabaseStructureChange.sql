/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220721@Johnson
	Task: database structure change for scale out DBTXN for CWL [#RedmineID:#167819]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE WinLimit_CustWinlostGame(
	CustId INT NOT NULL, 
	WinlostDate SMALLDATETIME, 
	BetType SMALLINT,
	Winlost MONEY,
	CONSTRAINT [PK_WinLimit_CustWinlostGame] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[BetType] ASC,		
		[WinlostDate] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [WinlimitSetting_Tables]
) ON [WinlimitSetting_Tables] 
