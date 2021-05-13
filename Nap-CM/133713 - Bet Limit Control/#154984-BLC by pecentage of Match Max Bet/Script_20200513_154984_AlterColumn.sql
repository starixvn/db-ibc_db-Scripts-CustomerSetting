/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210513@Eden
	Task: ADD new column Mode to BetLimitControlCustSetting table [RM#136423]
	DB: DBCUST/CustDB
*/

USE CUSTDB
GO
ALTER TABLE dbo.BetLimitControlCustSetting ADD Mode TINYINT NULL CONSTRAINT DF_BetLimitControlCustSetting_Mode DEFAULT (1) 
GO

--> Update default value
WHILE 1 = 1
BEGIN
	UPDATE TOP (5000) BetLimitControlCustSetting WITH(ROWLOCK,UPDLOCK)
	SET Mode = 1 
	WHERE Mode IS NULL
	
	IF @@ROWCOUNT < 5000
		BREAK

	WAITFOR DELAY '00:00:00.010'
END
GO

--> Set column is not null
ALTER TABLE dbo.BetLimitControlCustSetting ALTER COLUMN Mode TINYINT NOT NULL
GO

----INSERT INTO  DBACC.bodb02.dbo.BetLimitControlCustSetting(
----CustID
----,BetLimitTypeID
----,MaxBet
----,MaxPerMatch
----,Mode
----)
----SELECT s.CustID,s.BetLimitTypeID,s.MaxBet,s.MaxPerMatch,s.mode
----FROM BetLimitControlCustSetting s
---- LEFT JOIN DBACC.bodb02.dbo.BetLimitControlCustSetting d on s.CustID = d.custid and s.BetLimitTypeID = d.BetLimitTypeID
---- where d.CustID is null

--select * from BetLimitControlCustSetting
--select * from DBACC.bodb02.dbo.BetLimitControlCustSetting