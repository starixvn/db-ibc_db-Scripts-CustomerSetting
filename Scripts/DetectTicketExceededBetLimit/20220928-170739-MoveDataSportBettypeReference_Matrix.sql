/*<info serverAlias="DBCUST-CustDB, DBTP-bodb02, DBACC-bodb02"></info>*/

/*
	Created: 20220928@Tacy
	Task: Move data from Sport_Bettype_Reference to SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBCUST-CustDB, DBTP-bodb02, DBACC-bodb02
*/
DECLARE @Batch_size INT;

SET @Batch_size=5000;

CREATE TABLE #tmpRefSetting (
		SportType	smallint,
		BetType		int,
		isLicensee	bit,
		isLive		bit default 0,
		Site		varchar(50),
		IsFinshed	bit default 0,
		PRIMARY KEY CLUSTERED ( BetType ASC,
								SportType ASC,
								isLicensee ASC,
								Site ASC)
		)

CREATE TABLE #tmpRefSetting_Batch (
		SportType	smallint,
		BetType		int,
		isLicensee	bit,
		isLive		bit,
		Site		varchar(50),
		PRIMARY KEY CLUSTERED ( BetType ASC,
								SportType ASC,
								isLicensee ASC,
								Site ASC)
		)

--CREDIT:
INSERT INTO #tmpRefSetting (SportType, BetType, isLicensee, Site)
SELECT DISTINCT a.SportType, a.BetType, a.isLicensee, Site
FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference a WITH (NOLOCK)
WHERE NOT EXISTS (SELECT 1 FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting b WITH (NOLOCK)
				  WHERE a.SportType=b.SportType
					AND a.BetType=b.BetType
					AND a.isLicensee=b.isLicensee
					AND a.Site=b.Site
				)
	AND a.isLicensee=0

--DEPOSIT:
INSERT INTO #tmpRefSetting (SportType, BetType, isLicensee, Site)
SELECT DISTINCT a.SportType, a.BetType, a.isLicensee, Site
FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference a WITH (NOLOCK)
	INNER JOIN Dep_ProductSettingDetail psd WITH (NOLOCK) ON psd.SportType=a.SporttypeRef AND psd.BetType=a.BettypeRef
WHERE NOT EXISTS (SELECT 1 FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting b WITH (NOLOCK)
				  WHERE a.SportType=b.SportType
					AND a.BetType=b.BetType
					AND a.isLicensee=b.isLicensee
					AND a.Site=b.Site
				)
	AND a.isLicensee=1

select count(1)
from #tmpRefSetting

select [Bettype], [Sporttype], [isLicensee], [BettypeRef], [SporttypeRef], [isActive], [Site], [RefTableName]
from dbtxn.bodb02.dbo.Sport_Bettype_Reference with (nolock)
where Sporttype=1
order by bettype

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpRefSetting_Batch

	UPDATE TOP (@Batch_size) T
	SET IsFinshed=1
	OUTPUT inserted.SportType, inserted.BetType, inserted.isLicensee, inserted.isLive, inserted.Site 
		INTO #tmpRefSetting_Batch(SportType, BetType, isLicensee, isLive, Site)
	FROM #tmpRefSetting T WITH(NOLOCK)
	WHERE IsFinshed=0

	IF @@ROWCOUNT=0
		BREAK;

	INSERT INTO SportBettypeSettingMatrix (SportType, BetType, isLicensee, isLive, Site)
	SELECT SportType, BetType, isLicensee, isLive, Site
	FROM #tmpRefSetting_Batch

	UPDATE rm
	SET 
		rm.isActive=1,
		rm.SportTypeRefPT=ref.SporttypeRef,
		rm.BetTypeRefPT=ref.BettypeRef,
		rm.TablePT=rs1.TablePT,
		rm.SportTypeRefComm=ref.SporttypeRef,
		rm.BetTypeRefComm=ref.BettypeRef,
		rm.TableComm=rs2.TableComm,
		rm.SportTypeRefBetSetting=ref.SporttypeRef,
		rm.BetTypeRefBetSetting=ref.BettypeRef,
		rm.TableBetSetting=rs3.TableBetSetting
	FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #tmpRefSetting_Batch tmp 
			ON tmp.SportType=rm.SportType
			AND tmp.BetType=rm.BetType
			AND tmp.isLicensee=rm.isLicensee
			AND tmp.Site=rm.Site
		INNER JOIN dbtxn.bodb02.dbo.Sport_Bettype_Reference ref WITH (NOLOCK)
			ON ref.SportType=rm.SportType
			AND ref.BetType=rm.BetType
			AND ref.isLicensee=rm.isLicensee
			AND ref.Site=rm.Site
		LEFT JOIN dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting rs1 WITH (NOLOCK)
			ON rs1.SportTypeRefPT=ref.BettypeRef AND rs1.BetTypeRefPT=ref.SporttypeRef
			AND rs1.isLicensee=ref.isLicensee
		LEFT JOIN dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting rs2 WITH (NOLOCK)
			ON rs2.SportTypeRefComm=ref.BettypeRef AND rs2.BetTypeRefComm=ref.SporttypeRef
			AND rs2.isLicensee=ref.isLicensee
		LEFT JOIN dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting rs3 WITH (NOLOCK)
			ON rs3.SportTypeRefBetSetting=ref.BettypeRef AND rs3.BetTypeRefBetSetting=ref.SporttypeRef
			AND rs3.isLicensee=ref.isLicensee

	WAITFOR DELAY '00:00:0.002'
END