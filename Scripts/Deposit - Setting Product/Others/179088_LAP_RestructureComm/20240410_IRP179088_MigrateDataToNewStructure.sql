/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20240410@Johnson
	Task: LAP -Migrate data for new structure Player Commission
	DB: DBCUST/bodb_Licensee
*/

INSERT INTO LicenseeCustDiscount(LicenseeID,CustID,GroupDiscountID)
SELECT LicenseeID,CustID,GroupCommID
from LicenseeCustComm (NOLOCK)
where custid = 1411402

SET IDENTITY_INSERT [LicenseeGroupDiscount] ON
GO

INSERT INTO [dbo].[LicenseeGroupDiscount]
           ([GroupDiscountID],
		   [LicenseeID]
           ,[GroupName]
           ,[IsActive]
           ,[color]
           ,[IsDefault])
SELECT  ID
	,[LicenseeID]
   ,[GroupName]
   ,[IsActive]
   ,[color]
   ,[IsDefault]
FROM LicenseeGroupComm WITH(NOLOCK)

SET IDENTITY_INSERT [LicenseeGroupDiscount] OFF
GO

DECLARE @tblSettingDCS TABLE (Col VARCHAR(20),Sporttype INT, Bettype INT)

INSERT INTO @tblSettingDCS (Col,sporttype,Bettype)
VALUES ('MacauComm', 212,4001)
	, ('PPComm',248,4101)
	-- phase 2
	,('SexyGamingComm',243,3101)
	,('SpadeGamingComm' ,247,4301)
	,('LotteryComm' ,220,1021)
	,('VSComm' ,9908,1201)
	,('TableGameComm' ,222,4901)
	-- Phase 3
	,('VirtualGamesComm',245,4601)
	,('ArcadiaGamingComm',165,1901)
	,('SabaclubComm',200,1611)
	,('SAGamingComm',244,3001)
	,('PGSoftComm',232,6001)
	,('AllbetComm',211,2401)
	--Saba Casino
	,('RNGComm',208,2101)
	--> phase 4
	,('WMCasinoComm',233,3401)
	,('BigGamingComm',239,3501)
	,('JokerComm',234,6401)
	,('HabaneroComm',238,7001)
	,('VGamingComm',171,3801)				
	-- Phase 4.2
	,('CGComm',167,7301)
	,('AdvantComm',172,7701)
	,('AdvantMiniComm',174,7801)
	
	,('MaxGameComm',237,5401)
	,('FGGComm',176,8201)
	,('JiliComm',158,5100)

	,('YeeBetComm',159,3151)
	,('MgRNGComm',155,8400)

	--
	,('SBComm',1,1)
	,('SBComm',1,4)
	,('SBComm',1,5)
	,('SBComm',2,2)
	,('ParlayComm',1,9)
	,('NGComm',161,81)
	,('KenoComm',202,1501)
	

;WITH tmp AS (
	SELECT *
	FROM
	(
	SELECT id,  MacauComm,PPComm, SexyGamingComm, SpadeGamingComm, LotteryComm, VSComm, TableGameComm, VirtualGamesComm, ArcadiaGamingComm,
		SabaclubComm, SAGamingComm, PGSoftComm, AllbetComm, RNGComm, WMCasinoComm, BigGamingComm, JokerComm
		, HabaneroComm, VGamingComm, CGComm, AdvantComm, AdvantMiniComm, MaxGameComm, FGGComm, JiliComm, YeeBetComm, MgRNGComm,
		SBComm, Parlaycomm, NGComm, KenoComm
	FROM LicenseeGroupComm
	WHERE id = 1) t
	UNPIVOT (
		Discount for col IN ( MacauComm,PPComm, SexyGamingComm, SpadeGamingComm, LotteryComm, VSComm, TableGameComm, VirtualGamesComm, ArcadiaGamingComm,
			SabaclubComm, SAGamingComm, PGSoftComm, AllbetComm, RNGComm, WMCasinoComm, BigGamingComm, JokerComm
			,HabaneroComm, VGamingComm, CGComm, AdvantComm, AdvantMiniComm, MaxGameComm, FGGComm, JiliComm, YeeBetComm, MgRNGComm,
			SBComm, Parlaycomm, NGComm, KenoComm)
	) as unpvt
)
INSERT INTO LicenseeGroupDiscountDetail (GroupDiscountID,Licenseeid,SportType,BetType,Discount) 
SELECT id,Licenseeid,SportType,BetType,Discount
FROM tmp
INNER JOIN @tblSettingDCS t on tmp.col = t.Col
	