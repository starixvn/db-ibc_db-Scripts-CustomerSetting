/*<info serverAlias="DBAGE-bodb02,DBBOF-bodb02,DBTXN-CustDB"></info>*/

/*
	Created: 20230803@Tacy
	Task: Copy data SportBettypeSettingMatrix from DBCust to DB05x
	Database: DBAGE-bodb02,DBBOF-bodb02,DBTXN-CustDB
*/
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
FROM dbcust.custdb.dbo.SportBettypeSettingMatrix a WITH (NOLOCK)


--Insert into SportBettypeSettingMatrix - DB05x
WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpRefSetting_batch

	DELETE TOP (3000) T
	OUTPUT deleted.Sporttype, deleted.Bettype, deleted.isLive, deleted.isLicensee, deleted.Site
		INTO #tmpRefSetting_batch(SportType, BetType, isLive, isLicensee, Site)
	FROM #tmpRefSetting t 

	IF @@ROWCOUNT=0
		BREAK;

	INSERT INTO SportBettypeSettingMatrix([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans], [SporttypeRefWinlossLimit], [BettypeRefWinlossLimit], [RealProductId])
	SELECT a.[SportType], a.[BetType], a.[isLicensee], a.[isLive], a.[Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans], [SporttypeRefWinlossLimit], [BettypeRefWinlossLimit], [RealProductId]
	FROM dbcust.custdb.dbo.SportBettypeSettingMatrix a WITH (NOLOCK)
	INNER JOIN #tmpRefSetting_batch b ON a.SportType=b.SportType
									AND a.BetType=b.BetType
									AND a.isLicensee=b.isLicensee
									AND a.isLive=b.isLive
									AND a.Site=b.Site

	WAITFOR DELAY '00:00:0.001'
END

DROP TABLE #tmpRefSetting, #tmpRefSetting_batch
GO