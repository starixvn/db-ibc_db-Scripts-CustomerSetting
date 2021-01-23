/*
	created: Helen@20210122
	DB: DBTRANS/BODB02 - fix data for BU record for agent and master for archive issue
	
*/
USE bodb02
GO
CREATE TABLE #bettran_dbbackup2_temp(
	[transid] [bigint] ,
	[custid] [int] NOT NULL,
	[transdate] [datetime] NOT NULL,
	[oddsid] [int] NOT NULL ,
	[hdp1] [smallmoney] NULL ,
	[hdp2] [smallmoney] NULL ,
	[odds] [smallmoney] NULL ,
	[stake] [money] NOT NULL ,
	[status] [nvarchar](10) NULL,
	[winlost] [money] NULL ,
	[awinlost] [money] NULL ,
	[mwinlost] [money] NULL ,
	[playercomm] [money] NULL ,
	[comm] [money] NULL ,
	[acomm] [money] NULL ,
	[apositiontaking] [smallmoney] NULL,
	[mpositiontaking] [smallmoney] NULL ,
	[tpositiontaking] [smallmoney] NULL ,
	[playerdiscount] [decimal](9, 8) NULL,
	[discount] [decimal](9, 8) NULL ,
	[adiscount] [decimal](9, 8) NULL ,
	[livehomescore] [smallint] NULL ,
	[liveawayscore] [smallint] NULL ,
	[liveindicator] [bit] NULL,
	[betteam] [nvarchar](10) NULL,
	[creator] [int] NOT NULL ,
	[refno] [bigint] NOT NULL,
	[comstatus] [nvarchar](20) NULL ,
	[winlostdate] [smalldatetime] NULL,
	[betfrom] [nvarchar](1) NULL ,
	[betcheck] [nvarchar](50) NULL ,
	[checktime] [datetime] NULL,
	[oddsspread] [money] NULL,
	[actualrate] [float] NULL,
	[matchid] [int] NULL,
	[recommend] [int] NOT NULL,
	[mrecommend] [int] NOT NULL,
	[ruben] [tinyint] NULL ,
	[betid] [bigint] NULL,
	[statuswinlost] [tinyint] NULL,
	[modds] [smallmoney] NULL ,
	[bettype] [smallint] NULL,
	[betdaqid] [bigint] NULL,
	--[tstamp] [timestamp] NULL,
	[actual_stake] [money] NULL ,
	[currency] [tinyint] NULL,
	[ip] [nvarchar](15) NULL,
	[transdesc] [nvarchar](1000) NULL,
	[sdiscount] [decimal](9, 8) NULL,
	[scomm] [money] NULL ,
	[spositiontaking] [smallmoney] NULL,
	[swinlost] [money] NULL ,
	[srecommend] [int] NOT NULL,
	[Username] [nvarchar](50) NULL,
	[CurrencyName] [nvarchar](50) NULL,
	[virtualrate] [float] NOT NULL,
	[oddstype] [tinyint] NULL,
	[statusID] [tinyint] NULL,
	[currency2] [tinyint] NULL,
	[balance] [money] NULL,
	[SecAcceptFlag] [bit] NULL,
	[transid2] [bigint] NULL,
	[recommdate] [datetime] NULL,
	[ExtraInfo] [varchar](1000) NULL,
	[WalletType] [tinyint] NULL,
	[BonusID] [int] NULL,
	[RefCode] [bigint] NULL,
	[SettlementTime] [datetime] NULL,
	[epositiontaking] [smallmoney] NULL ,
	[ReasonID] [smallint] NULL,
	[sort] [smallint] NULL,
	[BetSiteID] [int] NULL
)

--------- processing for Master -------------
INSERT INTO #bettran_dbbackup2_temp (transid, custid, transdate, oddsid, hdp1, hdp2, odds, stake, status, winlost, awinlost, mwinlost, playercomm, comm, acomm, apositiontaking, mpositiontaking, tpositiontaking, playerdiscount, discount, adiscount, livehomescore, liveawayscore, liveindicator, betteam, creator, refno, comstatus, winlostdate, betfrom, betcheck, checktime, oddsspread, actualrate, matchid, recommend, mrecommend, ruben, betid, statuswinlost, modds, bettype, betdaqid, actual_stake, currency, ip, transdesc, sdiscount, scomm, spositiontaking, swinlost, srecommend, Username, CurrencyName, virtualrate, oddstype, statusID, currency2, balance, SecAcceptFlag, transid2, recommdate, ExtraInfo, WalletType, BonusID, RefCode, SettlementTime, epositiontaking, ReasonID, sort, BetSiteID)
SELECT transid, custid, transdate, oddsid, hdp1, hdp2, odds, stake, status, winlost, awinlost, mwinlost, playercomm, comm, acomm, apositiontaking, mpositiontaking, tpositiontaking, playerdiscount, discount, adiscount, livehomescore, liveawayscore, liveindicator, betteam, creator, refno, comstatus, winlostdate, betfrom, betcheck, checktime, oddsspread, actualrate, matchid, recommend, mrecommend, ruben, betid, statuswinlost, modds, bettype, betdaqid, actual_stake, currency, ip, transdesc, sdiscount, scomm, spositiontaking, swinlost, srecommend, Username, CurrencyName, virtualrate, oddstype, statusID, currency2, balance, SecAcceptFlag, transid2, recommdate, ExtraInfo, WalletType, BonusID, RefCode, SettlementTime, epositiontaking, ReasonID, sort, BetSiteID
FROM DBNOTI.danieltemp.dbo.bettrans_fixBU_test WITH (NOLOCK)
WHERE transid IN (110950405471,110950402285,110950411943,110950414141,110950416313)

INSERT INTO bettrans (custid
	, transdate, oddsid, hdp1, hdp2, odds, stake, status, winlost, awinlost, mwinlost, playercomm, comm, acomm, apositiontaking, mpositiontaking, tpositiontaking, playerdiscount, discount, adiscount, livehomescore, liveawayscore, liveindicator, betteam, creator, refno, comstatus
	, winlostdate
	, betfrom, betcheck, checktime, oddsspread, actualrate, matchid, recommend, mrecommend, ruben, betid, statuswinlost, modds, bettype, betdaqid, actual_stake, currency, ip, transdesc, sdiscount, scomm, spositiontaking, swinlost, srecommend, Username, CurrencyName, virtualrate, oddstype, statusID, currency2, balance, SecAcceptFlag, transid2, recommdate, ExtraInfo, WalletType, BonusID, RefCode, SettlementTime, epositiontaking, ReasonID, sort, BetSiteID)
SELECT custid
	, '2021-01-15 00:00:00' AS transdate
	, oddsid, hdp1, hdp2, odds, stake, status, winlost, awinlost, mwinlost, playercomm, comm, acomm, apositiontaking, mpositiontaking, tpositiontaking, playerdiscount, discount, adiscount, livehomescore, liveawayscore, liveindicator, betteam, creator, refno, comstatus
	, '2021-01-15 00:00:00' AS winlostdate
	, betfrom, betcheck, checktime, oddsspread, actualrate, matchid, recommend, mrecommend, ruben, betid, statuswinlost, modds, bettype, betdaqid, actual_stake, currency, ip, transdesc, sdiscount, scomm, spositiontaking, swinlost, srecommend, Username, CurrencyName, virtualrate, oddstype, statusID, currency2, balance, SecAcceptFlag, transid2, recommdate, ExtraInfo, WalletType, BonusID, RefCode, SettlementTime, epositiontaking, ReasonID, sort, BetSiteID
FROM #bettran_dbbackup2_temp

--------- processing for Agent -------------
UPDATE b
	SET winlostdate = '2021-01-15 00:00:00'
		,transdate = '2021-01-15 00:00:00'
FROM bettrans b WITH (ROWLOCK)
WHERE transid IN (110891958991,110891960062,110891961665,110891964833,110891964834,110891964835,110891959047,110891959346,110891959441,110891964917,110891964919,110891964928,110891960637,110891960965,110891960976,110891961030,110891961110,110891961111,110891964929,110891965548,110891965589,110891961463,110891963913,110891964123,110891966210,110891966276,110891966675,110891964186,110891964189,110891964259,110891966676,110891966677,110891966678,110891964336,110891964402,110891964466,110891966679,110891966680,110891966681,110891964522,110891965356,110891965371,110891966682,110891966814,110891967190,110891965625,110891965662,110891966455,110891967290,110891967309,110891967557,110891966764,110891966766,110891966825,110891967608,110891968040,110891968194,110891966863,110891967071,110891967471,110891968195,110891968197,110891968324,110891967475,110891967971,110891967975,110891968325,110891968437,110891968442,110891968009,110891968274,110891968527,110891968494,110891968929,110891968975,110891968535,110891968536,110891968540,110891968979,110891969237,110891969488,110891968545,110891968690,110891968878,110891969703,110891969865,110891969899,110891969380,110891969603,110891969709,110891969919,110891970019,110891970186,110891970536,110891971116,110891971491,110891970369,110891970382,110891970421,110891970713,110891970717,110891970719,110891971967,110891972484,110891972485,110891970720,110891971994,110891972172,110891972709,110891972767,110891972800,110891972173,110891972179,110891972520,110891972899,110891973032,110891973257,110891972598,110891972599,110891972600,110891973467,110891973468,110891973671,110891973134,110891973157,110891973170,110891973874,110891973905,110891974088,110891973426,110891973551,110891973611,110891974122,110891974196,110891974205,110891973628,110891973629,110891973630,110891974207,110891974253,110891974348,110891973631,110891973781,110891973845,110891974697,110891975316,110891975317,110891973915,110891974098,110891974153,110891975790,110891976376,110891977064,110891974155,110891974594,110891974667,110891977791,110891977829,110891977872,110891974729,110891975006,110891975073,110891977954,110891978028,110891978061,110891975089,110891975246,110891975429,110891978164,110891978185,110891978664,110891975562,110891975628,110891976676,110891979346,110891979520,110891979527,110891976695,110891976796,110891977087,110891979545,110891979546,110891979834,110891977095,110891977163,110891977183,110891979845,110891979953,110891979992,110891977198,110891977611,110891977703,110891977952,110891978814,110891979663,110891979808,110891980066,110891980161,110891980229,110891980282,110891980288,110891980019,110891980026,110891980054,110891980500,110891980657,110891980954,110891981588,110891981641,110891981730,110891980762,110891981244,110891981265,110891982955,110891983073,110891983095,110891983413,110891983651,110891983710,110891982295,110891982326,110891982361,110891984078,110891986812,110891987333,110891987334,110891987733,110891989961,110891982715,110891983403,110891983584,110891990810,110891992671,110891996913,110891983632,110891983795,110891984593,110891987826,110891989001,110891989033,110891989034,110891989035,110891990301,110891990579,110891996251)

--------------------------------------------
DROP TABLE #bettran_dbbackup2_temp
