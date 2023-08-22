/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20230803
	Task: init data fo new columns [Redmine:#189389] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

CREATE TABLE #tmpRefSetting (
		SportType	smallint,
		BetType		int,
		isLicensee	bit,
		isLive		bit,
		Site		varchar(50),
		PRIMARY KEY CLUSTERED ( [BetType] ASC,
								[SportType] ASC,
								[isLicensee] ASC,
								[isLive] ASC,
								[Site] ASC)
		)

CREATE TABLE #tmpRefSetting_batch (
		SportType	smallint,
		BetType		int,
		isLicensee	bit,
		isLive		bit,
		Site		varchar(50),
		PRIMARY KEY CLUSTERED ( [BetType] ASC,
								[SportType] ASC,
								[isLicensee] ASC,
								[isLive] ASC,
								[Site] ASC)
		)

--get all ref setting:
INSERT INTO #tmpRefSetting (SportType, BetType, isLive, isLicensee, Site)
SELECT a.SportType, a.BetType, a.isLive, a.isLicensee, Site
FROM SportBettypeSettingMatrix a WITH (NOLOCK)

--update
WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpRefSetting_batch

	DELETE TOP (3000) T
	OUTPUT deleted.Sporttype, deleted.Bettype, deleted.isLive, deleted.isLicensee, deleted.Site
		INTO #tmpRefSetting_batch(SportType, BetType, isLive, isLicensee, Site)
	FROM #tmpRefSetting t 

	IF @@ROWCOUNT=0
		BREAK;

	UPDATE a
	SET a.[RepUpdateTime]=sysdatetime(),
		a.[isDeleted]=0
	FROM SportBettypeSettingMatrix a WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpRefSetting_batch b ON a.SportType=b.SportType
									AND a.BetType=b.BetType
									AND a.isLicensee=b.isLicensee
									AND a.isLive=b.isLive
									AND a.Site=b.Site

	WAITFOR DELAY '00:00:0.001'
END

DROP TABLE #tmpRefSetting, #tmpRefSetting_batch
GO