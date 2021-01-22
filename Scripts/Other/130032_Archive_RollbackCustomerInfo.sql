/*
	created: Helen@20210122
	DB: DBCUST/CUSTDB - Rollback customer/custinfo for archive issue
	
*/
USE CUSTDB
GO
CREATE TABLE #temp_Customer_old(
	[custid] [int] NOT NULL,
	[firstname] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
	[address] [nvarchar](80) NULL,
	[postal] [nvarchar](50) NULL,
	[city] [nvarchar](50) NULL,
	[state] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[mobilephone] [nvarchar](50) NULL,
	[fax] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[birthday] [smalldatetime] NULL,
	[refcode1] [nvarchar](50) NULL,
	[refcode2] [nvarchar](50) NULL,
	[remark] [nvarchar](50) NULL,
	[creatdate] [smalldatetime] NULL,
	[creator] [int] NOT NULL,
	[username] [varchar](30) NOT NULL,
	[currency] [tinyint] NULL,
	[userpwd] [varchar](40) NULL,
	[lastlogged] [smalldatetime] NULL,
	[pwdexpiry] [datetime] NULL,
	[roleid] [tinyint] NULL,
	[mrecommend] [int] NULL ,
	[recommend] [int] NULL,
	[ugroup] [varchar](3) NULL,
	[logincount] [tinyint] NULL,
	[on_sessionid] [int] NULL,
	[site] [varchar](10) NULL,
	[iplogin] [nvarchar](20) NULL,
	[important] [bit] NULL,
	[srecommend] [int] NULL,
	[username2] [varchar](50) NULL
 )


CREATE TABLE #temp_CustInfo_old(
	[ArchiveDate] [datetime] NULL,
	[username] [nvarchar](50) NULL,
	[custid] [int] NOT NULL,
	[currency] [int] NULL,
	[roleid] [tinyint] NULL,
	[srecommend] [int] NULL,
	[mrecommend] [int] NULL,
	[recommend] [int] NULL,
	[dangercust] [bit] NULL,
	[autosuspend] [bit] NULL,
	[reject] [bit] NULL,
	[credit] [money] NULL,
	[closed] [bit] NULL,
	[MatchLimit] [smallmoney] NOT NULL ,
	[VirtualMultiplier] [smallmoney] NOT NULL ,
	[maxpermatch] [money] NULL,
	[maxpermatch2] [money] NULL,
	[maxpermatch3] [money] NULL,
	[maxpermatch5] [money] NULL,
	[maxpermatch8] [money] NULL,
	[maxpermatch10] [money] NULL,
	[maxpermatch11] [money] NULL,
	[maxpermatch12] [money] NULL,
	[maxpermatch99] [money] NULL,
	[Enabled] [bit] NOT NULL,
	[danger] [tinyint] NOT NULL,
	[DisableCasino] [bit] NOT NULL,
	[SyncCasino] [bit] NOT NULL,
	[danger2] [tinyint] NOT NULL,
	[danger3] [tinyint] NOT NULL,
	[DisableOutright] [bit] NOT NULL,
	[DisableNumber] [bit] NULL,
	[MaxPerMatch161] [money] NULL,
	[MaxPerMatch99MP] [money] NULL,
	[MaxPerBall161] [money] NULL,
	[Abnormal] [tinyint] NULL,
	[DoubleCommLosing] [bit] NULL,
	[autosuspend2] [bit] NULL ,
	[HideKeno] [bit] NULL ,
	[DisableEsports] [bit] NULL,
	[HideGoldDeluxe] [bit] NULL ,
	[DisableGoldDeluxe] [bit] NULL ,
	[DisableMicrogame] [bit] NULL ,
	[DisableSuperLive] [bit] NULL ,
	[DisableColossusBet] [bit] NULL ,
	[HideColossusBet] [bit] NULL ,
	[LockUpd] [bit] NULL ,
	[MaxPerMatch1MP] [money] NULL,
	[BonusWalletFlag] [bit] NULL,
	[maxpermatch164] [money] NULL ,
	[DangerLevel] [int] NULL,
	[CustomerClass] [smallint] NULL 
)
------------------- PREPARATION -------------------------
CREATE TABLE #CustID_tmp (custid INT)
INSERT INTO #CustID_tmp (custid)
VALUES 
-- agent
(4169729),(4586630),(5566973),(8284819),(8284805),(8284791),(4140860),(4205818),(4405120),(8245160),(8245096),(8239855),(5081755),(5151103),(5147975),(5117873),(5361034),(5361030),(8239847),(9281659),(8984053),(5412485),(7757879),(7912508),(10179280),(10052266),(10556002),(7875000),(7870455),(7791662),(10555990),(10555987),(10555977),(8056209),(8035718),(7999423),(10555975),(10555967),(10555962),(7927716),(8565228),(8560144),(10555959),(10484191),(11173448),(8712130),(8656741),(10425414),(10937868),(10927540),(11223208),(10524929),(10524256),(10477639),(11189949),(11895011),(12171459),(10442458),(10609469),(11400409),(12171440),(12169413),(12033822),(11398696),(11980709),(11979945),(12033813),(12321076),(12312730),(11924846),(12065164),(12256219),(12279355),(12672155),(12653347),(12252475),(12252430),(12249431),(12653112),(12747876),(13030991),(12244536),(12552806),(12698443),(13218040),(13623677),(13549087),(13110848),(13349948),(13212466),(13536554),(13881200),(13757218),(14223550),(14492979),(14822243),(13974989),(13960074),(13918438),(14059744),(14057738),(14057727),(15208960),(15593421),(15593385),(14057644),(15165559),(15494326),(15767957),(15714448),(15693446),(15494231),(15487024),(15571375),(15958186),(15862511),(16021487),(15508578),(15508544),(15508511),(16227316),(16227304),(16450040),(16156306),(16129627),(16114965),(16749944),(16695798),(17035173),(16273834),(16168851),(16531424),(16995242),(16889678),(16875140),(16501406),(16501394),(16501366),(16874304),(16819046),(17315961),(16501359),(16344545),(16766851),(17460838),(18477799),(18477796),(16687179),(17028049),(16951515),(18977065),(19394300),(20492415),(16950626),(17606409),(17511404),(21376305),(21322317),(21266653),(17419706),(17651485),(18172287),(21141933),(21627745),(21593869),(18136695),(17882899),(18313927),(21444952),(21424150),(21880645),(18736895),(18676048),(19634431),(22531174),(23036737),(23026369),(19593683),(20229262),(20459850),(23006329),(23006283),(23191830),(20447125),(20357584),(20318211),(23162883),(23616032),(23554240),(20303527),(21020290),(20911695),(21150554),(22157180),(23406996),(23221990),(23454184),(23978360),(23877896),(23792246),(23781828),(23524740),(23511784),(23464501),(24174998),(24709812),(24892959),(26060200),(25965640),(25829168),(24513012),(25135004),(25105535),(27373707),(27903316),(27865325),(28028210),(28283666),(28717024),(27158461),(27120912),(27075392),(28823410),(31946744),(32357432),(32357381),(33012052),(36100765),(27187760),(28035045),(28359088),(37717755),(39230053),(42595038),(28305510),(28603597),(29244380),(32891887),(34092170),(34059220),(34059203),(34059195),(37074899),(37390978),(41832681)
-- master
,(18313830),(4140770),(15493067),(32247548)
--(41510673),(28178870) --M2

INSERT INTO #temp_Customer_old (custid, firstname, lastname, address, postal, city, state, country, phone, mobilephone, fax, email, birthday, refcode1, refcode2, remark, creatdate, creator, username, currency, userpwd, lastlogged, pwdexpiry, roleid, mrecommend, recommend, ugroup, logincount, on_sessionid, site, iplogin, important, srecommend, username2)
SELECT custid, firstname, lastname, address, postal, city, state, country, phone, mobilephone, fax, email, birthday, refcode1, refcode2, remark, creatdate, creator, username, currency, userpwd, lastlogged, pwdexpiry, roleid, mrecommend, recommend, ugroup, logincount, on_sessionid, site, iplogin, important, srecommend, username2
FROM db05.bodb_customer.dbo.Customer_old with (nolock)
WHERE custid in (SELECT custid FROM #CustID_tmp)

INSERT INTO #temp_CustInfo_old (ArchiveDate, username, custid, currency, roleid, srecommend, mrecommend, recommend, dangercust, autosuspend, reject, credit, closed, MatchLimit, VirtualMultiplier, maxpermatch, maxpermatch2, maxpermatch3, maxpermatch5, maxpermatch8, maxpermatch10, maxpermatch11, maxpermatch12, maxpermatch99, Enabled, danger, DisableCasino, SyncCasino, danger2, danger3, DisableOutright, DisableNumber, MaxPerMatch161, MaxPerMatch99MP, MaxPerBall161, Abnormal, DoubleCommLosing, autosuspend2, HideKeno, DisableEsports, HideGoldDeluxe, DisableGoldDeluxe, DisableMicrogame, DisableSuperLive, DisableColossusBet, HideColossusBet, LockUpd, MaxPerMatch1MP, BonusWalletFlag, maxpermatch164, DangerLevel, CustomerClass)
SELECT ArchiveDate, username, custid, currency, roleid, srecommend, mrecommend, recommend, dangercust, autosuspend, reject, credit, closed, MatchLimit, VirtualMultiplier, maxpermatch, maxpermatch2, maxpermatch3, maxpermatch5, maxpermatch8, maxpermatch10, maxpermatch11, maxpermatch12, maxpermatch99, Enabled, danger, DisableCasino, SyncCasino, danger2, danger3, DisableOutright, DisableNumber, MaxPerMatch161, MaxPerMatch99MP, MaxPerBall161, Abnormal, DoubleCommLosing, autosuspend2, HideKeno, DisableEsports, HideGoldDeluxe, DisableGoldDeluxe, DisableMicrogame, DisableSuperLive, DisableColossusBet, HideColossusBet, LockUpd, MaxPerMatch1MP, BonusWalletFlag, maxpermatch164, DangerLevel, CustomerClass
FROM db05.bodb_customer.dbo.custinfo_old with (nolock)
WHERE custid in (SELECT custid FROM #CustID_tmp)

INSERT INTO #temp_CustInfo_old (username, custid, currency, roleid, srecommend, mrecommend, recommend, dangercust, autosuspend, reject, credit, closed, MatchLimit, VirtualMultiplier, maxpermatch, maxpermatch2, maxpermatch3, maxpermatch5, maxpermatch8, maxpermatch10, maxpermatch11, maxpermatch12, maxpermatch99, Enabled, danger, DisableCasino, SyncCasino, danger2, danger3, DisableOutright, DisableNumber, MaxPerMatch161, MaxPerMatch99MP, MaxPerBall161, Abnormal, DoubleCommLosing, autosuspend2, HideKeno, DisableEsports, HideGoldDeluxe, DisableGoldDeluxe, DisableMicrogame, DisableSuperLive, DisableColossusBet, HideColossusBet, LockUpd, MaxPerMatch1MP, BonusWalletFlag, maxpermatch164, DangerLevel, CustomerClass)
SELECT username, custid, currency, roleid, srecommend, mrecommend, recommend, dangercust, autosuspend, reject, credit, closed, MatchLimit, VirtualMultiplier, maxpermatch, maxpermatch2, maxpermatch3, maxpermatch5, maxpermatch8, maxpermatch10, maxpermatch11, maxpermatch12, maxpermatch99, Enabled, danger, DisableCasino, SyncCasino, danger2, danger3, DisableOutright, DisableNumber, MaxPerMatch161, MaxPerMatch99MP, MaxPerBall161, Abnormal, DoubleCommLosing, autosuspend2, HideKeno, DisableEsports, HideGoldDeluxe, DisableGoldDeluxe, DisableMicrogame, DisableSuperLive, DisableColossusBet, HideColossusBet, LockUpd, MaxPerMatch1MP, BonusWalletFlag, maxpermatch164, DangerLevel, CustomerClass
FROM DBSPARE.custDB_Test.custinfo WITH (NOLOCK)
WHERE custid in (SELECT custid FROM #CustID_tmp)
	AND custid NOT IN (SELECT custid FROM #temp_CustInfo_old)

--------- END OF PREPARATION ----------------------
------------------ Step 1 - INSERT CUSTOMER-------------------
SET IDENTITY_INSERT dbo.Customer ON
INSERT INTO Customer (custid, firstname, lastname, address, postal, city, state, country, phone, mobilephone, fax, email, birthday, refcode1, refcode2, remark, creatdate, creator, username, currency, userpwd, lastlogged, pwdexpiry, roleid, mrecommend, recommend, ugroup, logincount, on_sessionid, site, iplogin, important, srecommend, username2)
SELECT custid, firstname, lastname, address, postal, city, state, country, phone, mobilephone, fax, email, birthday, refcode1, refcode2, remark, creatdate, creator, username, currency, userpwd, lastlogged, pwdexpiry, roleid, mrecommend, recommend, ugroup, logincount, on_sessionid, site, iplogin, important, srecommend, username2
FROM #temp_Customer_old
SET IDENTITY_INSERT dbo.Customer OFF

--------------------- step 2- INSERT CustInfo ----------------------
INSERT INTO custinfo (username, custid, currency, roleid, srecommend, mrecommend, recommend, dangercust, autosuspend, reject, credit, closed, MatchLimit, VirtualMultiplier, maxpermatch, maxpermatch2, maxpermatch3, maxpermatch5, maxpermatch8, maxpermatch10, maxpermatch11, maxpermatch12, maxpermatch99
	, Enabled
	, danger, DisableCasino, SyncCasino, danger2, danger3, DisableOutright, MaxPerMatch99MP, DisableNumber, maxpermatch161, MaxPerBall161, Abnormal, DoubleCommLosing, autosuspend2, HideKeno, DisableEsports, HideGoldDeluxe, DisableGoldDeluxe, DisableSuperLive, DisableColossusBet, HideColossusBet, LockUpd, MaxPerMatch1MP, BonusWalletFlag, maxpermatch164,  DangerLevel, CustomerClass)
SELECT username, custid, currency, roleid, srecommend, mrecommend, recommend, dangercust, autosuspend, reject, credit, closed, MatchLimit, VirtualMultiplier, maxpermatch, maxpermatch2, maxpermatch3, maxpermatch5, maxpermatch8, maxpermatch10, maxpermatch11, maxpermatch12, maxpermatch99
	, 0
	, danger, DisableCasino, SyncCasino, danger2, danger3, DisableOutright, MaxPerMatch99MP, DisableNumber, maxpermatch161, MaxPerBall161, Abnormal, DoubleCommLosing, autosuspend2, HideKeno, DisableEsports, HideGoldDeluxe, DisableGoldDeluxe, DisableSuperLive, DisableColossusBet, HideColossusBet, LockUpd, MaxPerMatch1MP, BonusWalletFlag, maxpermatch164,  DangerLevel, CustomerClass
FROM #temp_Custinfo_old
--------------------------
DROP TABLE #CustID_tmp
DROP TABLE #temp_CustInfo_old
DROP TABLE #temp_Customer_old