/*
	Created: 20200610@Eden
	Task: Insert Global Setting for BasketBall VR [Redmine: #134978]
	DB: DBCUST/CustDB
*/
USE CustDB

--> Delete Redurant Setting
DELETE v
FROM VRLeagueGroupMapping v WITH(ROWLOCK)
	INNER JOIN VRLeagueGroup vr WITH(NOLOCK) ON vr.GroupID = v.VRLeagueGroupID
WHERE vr.SportType = 2

DELETE FROM VRLeagueGroup WITH(ROWLOCK) WHERE SportType = 2
DELETE FROM VRBettypeGroup WITH(ROWLOCK) WHERE SportType = 2
DELETE FROM VRSettingHierarchy WITH(ROWLOCK) WHERE SportType = 2
DELETE FROM VRSettingReference WITH(ROWLOCK) WHERE SportType = 2
GO
----------------------------BEGIN PROCESS DATA------------------------------------
DECLARE @LeagueGroup_Tbl TABLE ( 
	 RecordID INT IDENTITY(1,1)
	,GroupName Varchar(50)
	,LeagueGroupID INT 
	,VRLeagueGroupID INT
)
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('USA 1')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('3X3 1')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('3X3 2')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('3X3 3')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('AFRICA 5')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('AMERICAS 1')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('AMERICAS 2')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('AMERICAS 3')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('AMERICAS 4')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('AMERICAS 5')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('ASIA 1')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('ASIA 2')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('ASIA 3')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('ASIA 4')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('ASIA 5')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('EUROPE 1')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('EUROPE 2')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('EUROPE 3')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('EUROPE 4')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('EUROPE 5')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('INTERNATIONAL 1')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('INTERNATIONAL 2')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('INTERNATIONAL 3')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('INTERNATIONAL 4')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('INTERNATIONAL 5')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('OTHERS')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('SPECIALS')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('USA 2')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('USA 3')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('USA OTHER')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('VIRTUAL')
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('VIRTUAL GAMER')

DECLARE @MaxVRLeagueGroupID INT
SELECT @MaxVRLeagueGroupID = MAX(GroupID) FROM VRLeagueGroup WITH(NOLOCK)

UPDATE lg1
SET lg1.LeagueGroupID = lg.GroupID
	,lg1.VRLeagueGroupID = @MaxVRLeagueGroupID + lg1.RecordID
FROM @LeagueGroup_Tbl lg1 
	INNER JOIN DBPRO.bodb02.dbo.LeagueGroup lg WITH(NOLOCK) ON lg1.GroupName = lg.GroupName 
WHERE lg.Sporttype IN(0,2)

--> Insert VRBettypeGroup for BB
DECLARE @VRBettypeGroup_Tbl TABLE(
	 GroupID INT
	,GroupName NVARCHAR(200)
	,SportType INT
	)
DECLARE @VRBetTypeGroupID INT
SELECT @VRBetTypeGroupID = MAX(GroupID) FROM VRBettypeGroup WITH(NOLOCK)

INSERT INTO @VRBettypeGroup_Tbl(GroupID,GroupName,SportType) VALUES (@VRBetTypeGroupID + 1,'Handicap',2)
INSERT INTO @VRBettypeGroup_Tbl(GroupID,GroupName,SportType) VALUES (@VRBetTypeGroupID + 2,'Over/Under',2)
INSERT INTO @VRBettypeGroup_Tbl(GroupID,GroupName,SportType) VALUES (@VRBetTypeGroupID + 3,'Odd/Even',2)
INSERT INTO @VRBettypeGroup_Tbl(GroupID,GroupName,SportType) VALUES (@VRBetTypeGroupID + 4,'Moneyline',2)

DECLARE @BettypeRef_Tbl TABLE (
	 VRBettypeGroupID INT
	,BettypeGroup NVARCHAR(200) 
	,Bettype INT
	,Id INT IDENTITY (1,1)
	)
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Handicap',1) --Handicap
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Handicap',7) --1H Handicap
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Handicap',603) --Which Team To Score The Highest Quarter
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Handicap',609) --Quarter X Handicap
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Over/Under',3) --Over/Under
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Over/Under',8) --1H Over/Under
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Over/Under',401) --Home Team Over/Under
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Over/Under',610) --Quarter X Over/Under
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Odd/Even',2) --Odd/Even
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Moneyline',20) --Moneyline
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Moneyline',21) --1H Moneyline
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Moneyline',606) --1H Race To X Points
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Moneyline',612) --Quarter X Moneyline

UPDATE  ref
SET ref.VRBettypeGroupID = btg.GroupID
FROM @BettypeRef_Tbl ref
	INNER JOIN @VRBettypeGroup_Tbl btg ON ref.BettypeGroup = btg.GroupName

DECLARE  @VRSettingHierarchy_Tbl TABLE(
	[LevelID] [int]  ,
	[SportType] [int] DEFAULT 2,
	[VRLeagueGroupID] [smallint] ,
	[VRBetTypeGroupID] [smallint] ,
	[BetType] [int] ,
	[ParentLevelID] [int] ,
	[SortOrder] [smallint]  ,
	[BitmapOrderAutoSuspend] [smallint] ,
	[VRAutoSuspendThresholdNonLive] [smallmoney] default 1 ,
	[VRAutoSuspendThresholdLive] [smallmoney]  default 1,
	RecordID INT IDENTITY (1,1)
)

--Sporttype Level
INSERT INTO @VRSettingHierarchy_Tbl(VRLeagueGroupID,VRBetTypeGroupID,BetType)
SELECT -1 AS LeagueGroupID,-1 AS BettypeGroupID,-1 AS Bettype

--USA 1 LeagueGroup
INSERT INTO @VRSettingHierarchy_Tbl(VRLeagueGroupID,VRBetTypeGroupID,BetType)
SELECT a.VRLeagueGroupID, gbt.GroupID AS BettypeGroupID,-1 AS Bettype 
FROM @LeagueGroup_Tbl a 
	CROSS APPLY (	SELECT vb.GroupID,vb.GroupName
					FROM @VRBettypeGroup_Tbl vb 
					UNION ALL
					SELECT -1 ,'All'
				)  Gbt
WHERE a.Groupname = 'USA 1'
UNION ALL 
SELECT a.VRLeagueGroupID,gbt.GroupID AS BettypeGroupID,bt.bettype AS Bettype 
FROM @LeagueGroup_Tbl a 
	CROSS APPLY (	SELECT vb.GroupID,vb.GroupName
					FROM @VRBettypeGroup_Tbl vb 
				)  Gbt
	INNER JOIN @BettypeRef_Tbl bt ON bt.VRBettypeGroupID = gbt.GroupID
WHERE a.Groupname = 'USA 1'
ORDER BY 1,2,3

--Other LeagueGroup
INSERT INTO @VRSettingHierarchy_Tbl(VRLeagueGroupID,VRBetTypeGroupID,BetType)
SELECT VRLeagueGroupID,gbt.GroupID AS BettypeGroupID,-1 AS Bettype 
FROM @LeagueGroup_Tbl a
	CROSS APPLY (	SELECT vb.GroupID,vb.GroupName
					FROM @VRBettypeGroup_Tbl vb 
					UNION ALL
					SELECT -1 ,'All'
				)  Gbt
WHERE a.Groupname <> 'USA 1'
ORDER BY a.RecordID,gbt.GroupID

DECLARE @CurrentLevelID INT
SELECT @CurrentLevelID = MAX(LevelID) from VRSettingHierarchy (NOLOCK)

UPDATE h
SET LevelID = RecordID + @CurrentLevelID
	,h.SortOrder = RecordID * 50
	,h.BitmapOrderAutoSuspend = RecordID
FROM @VRSettingHierarchy_Tbl h

UPDATE h
SET h.ParentLevelID = 0 
FROM @VRSettingHierarchy_Tbl h
where h.VRLeagueGroupID = -1

; WITH tmp as(
	SELECT LevelID FROM @VRSettingHierarchy_Tbl h WHERE h.VRLeagueGroupID = -1
)
UPDATE h
SET h.ParentLevelID = tmp.LevelID
FROM @VRSettingHierarchy_Tbl h
	Cross apply tmp
WHERE h.VRBetTypeGroupID = -1 AND h.ParentLevelID IS NULL

; WITH tmp as(
	SELECT * FROM @VRSettingHierarchy_Tbl h WHERE h.VRLeagueGroupID <> -1 and h.VRBetTypeGroupID = -1 
)
UPDATE h
SET h.ParentLevelID = t.LevelID
FROM @VRSettingHierarchy_Tbl h
	INNER JOIN tmp t ON t.VRLeagueGroupID = h.VRLeagueGroupID
WHERE h.ParentLevelID IS NULL AND h.bettype = -1

; WITH tmp as(
	SELECT * FROM @VRSettingHierarchy_Tbl h WHERE h.VRLeagueGroupID <> -1 and h.VRBetTypeGroupID <> -1  AND BetType = -1
)
UPDATE h
SET h.ParentLevelID = t.LevelID
FROM @VRSettingHierarchy_Tbl h
	INNER JOIN tmp t on t.VRLeagueGroupID = h.VRLeagueGroupID and h.VRBetTypeGroupID = t.VRBetTypeGroupID
WHERE h.ParentLevelID IS NULL AND h.bettype <> -1

--SELECT h.*,l.GroupName as LeagueGroup, v.GroupName AS BettypeGroup,bt.typenamee as BettypeName
--FROM @VRSettingHierarchy_Tbl h 
--	LEFT JOIN @LeagueGroup_Tbl mp ON h.VRLeagueGroupID = mp.VRLeagueGroupID
--	LEFT JOIN DBPRO.bodb02.dbo.LeagueGroup l WITH(NOLOCK) ON mp.LeagueGroupID = l.GroupID
--	LEFT JOIN @VRBettypeGroup_Tbl v ON h.VRBetTypeGroupID = v.GroupID
--	LEFT JOIN DBPRO.bodb02.dbo.Bettype bt WITH(NOLOCK) ON h.BetType = bt.typeid
--ORDER BY h.SortOrder

-------------INSERT REFERENCE Setting--------------------------------------------------------------------------------------------------
--For Orther LeagueGroup
DECLARE @RefVRSetting TABLE( 
	 Bettype INT
	,RefBettypeGroup NVARCHAR(20)
	,RefBettypeGroupID INT
	,RefBettype INT 
)
INSERT INTO @RefVRSetting(Bettype,RefBettypeGroup)
SELECT 1,'Handicap' UNION ALL --Handicap -->Handicap
SELECT 2,'Odd/Even' UNION ALL --Odd/Even -->Odd/Even
SELECT 3,'Over/Under' UNION ALL --Over/Under -->Over/Under
SELECT 20,'Moneyline' UNION ALL --Moneyline -->Moneyline
SELECT 7,'Handicap' UNION ALL --1H Handicap -->Handicap
SELECT 8,'Over/Under' UNION ALL --1H Over/Under -->Over/Under
SELECT 12,'Odd/Even' UNION ALL --1H Odd/Even -->Odd/Even
SELECT 21,'Moneyline' UNION ALL --1H Moneyline -->Moneyline
SELECT 401,'Over/Under' UNION ALL --Home Team Over/Under -->Over/Under
SELECT 402,'Over/Under' UNION ALL --Away Team Over/Under -->Over/Under
SELECT 403,'Over/Under' UNION ALL --1H Home Team Over/Under -->Over/Under
SELECT 404,'Over/Under' UNION ALL --1H Away Team Over/Under -->Over/Under
SELECT 603,'Handicap' UNION ALL --Which Team To Score The Highest Quarter -->Handicap
SELECT 604,'Handicap' UNION ALL --Which Team To Score The First Basket -->Handicap
SELECT 605,'Handicap' UNION ALL --Which Team To Score The Last Basket -->Handicap
SELECT 606,'<Same League Group>' UNION ALL --1H Race To X Points --><Same League Group>
SELECT 607,'<Same League Group>' UNION ALL --2H Race To X Points --><Same League Group>
SELECT 609,'Handicap' UNION ALL --Quarter X Handicap -->Handicap
SELECT 610,'Over/Under' UNION ALL --Quarter X Over/Under -->Over/Under
SELECT 611,'Odd/Even' UNION ALL --Quarter X Odd/Even -->Odd/Even
SELECT 612,'Moneyline' UNION ALL --Quarter X Moneyline -->Moneyline
SELECT 613,'<Same League Group>' UNION ALL --Quarter X Race To Y Points --><Same League Group>
SELECT 615,'Over/Under' UNION ALL --Quarter X Home Team Over/Under -->Over/Under
SELECT 616,'Over/Under' UNION ALL --Quarter X Away Team Over/Under -->Over/Under
SELECT 617,'Handicap'  --Quarter X Which Team To Score The Last Basket -->Handicap

UPDATE ref
SET ref.RefBettypeGroupID = ISNULL(btg.GroupID,0)
FROM @RefVRSetting ref
	LEFT JOIN @VRBettypeGroup_Tbl btg ON ref.RefBettypeGroup = btg.GroupName

--For USA 1 LeagueGroup
INSERT INTO @RefVRSetting(Bettype,RefBettype)
SELECT 1,1 UNION ALL -- Handicap -->Handicap
SELECT 2,2 UNION ALL -- Odd/Even -->Odd/Even
SELECT 3,3 UNION ALL -- Over/Under -->Over/Under
SELECT 20,20 UNION ALL -- Moneyline -->Moneyline
SELECT 7,7 UNION ALL -- 1H Handicap -->1H Handicap
SELECT 8,8 UNION ALL -- 1H Over/Under -->1H Over/Under
SELECT 12,2 UNION ALL -- 1H Odd/Even -->Odd/Even
SELECT 21,21 UNION ALL -- 1H Moneyline -->1H Moneyline
SELECT 401,401 UNION ALL -- Home Team Over/Under -->Home Team Over/Under
SELECT 402,401 UNION ALL -- Away Team Over/Under -->Home Team Over/Under
SELECT 403,401 UNION ALL -- 1H Home Team Over/Under -->Home Team Over/Under
SELECT 404,401 UNION ALL -- 1H Away Team Over/Under -->Home Team Over/Under
SELECT 603,603 UNION ALL -- Which Team To Score The Highest Quarter -->Which Team To Score The Highest Quarter
SELECT 604,603 UNION ALL -- Which Team To Score The First Basket -->Which Team To Score The Highest Quarter
SELECT 605,603 UNION ALL -- Which Team To Score The Last Basket -->Which Team To Score The Highest Quarter
SELECT 606,606 UNION ALL -- 1H Race To X Points -->1H Race To X Points
SELECT 607,606 UNION ALL -- 2H Race To X Points -->1H Race To X Points
SELECT 609,609 UNION ALL -- Quarter X Handicap -->Quarter X Handicap
SELECT 610,610 UNION ALL -- Quarter X Over/Under -->Quarter X Over/Under
SELECT 611,2 UNION ALL -- Quarter X Odd/Even -->Odd/Even
SELECT 612,612 UNION ALL -- Quarter X Moneyline -->Quarter X Moneyline
SELECT 613,606 UNION ALL -- Quarter X Race To Y Points -->1H Race To X Points
SELECT 615,401 UNION ALL -- Quarter X Home Team Over/Under -->Home Team Over/Under
SELECT 616,401 UNION ALL -- Quarter X Away Team Over/Under -->Home Team Over/Under
SELECT 617,603 -- Quarter X Which Team To Score The Last Basket -->Which Team To Score The Highest Quarter

DELETE FROM @RefVRSetting WHERE Bettype = RefBettype

DECLARE @VRSettingReference_Tbl TABLE (
	 SportType	int
	,LeagueGroupID	int
	,BetType	int
	,RefLevelID	int
	)

--> Insert VRSettingReference for Orther LeagueGroup
INSERT INTO @VRSettingReference_Tbl(SportType,LeagueGroupID,BetType,RefLevelID)
SELECT 2 AS Sporttype,l.LeagueGroupID, r.Bettype,h.LevelID
FROM @RefVRSetting r
	CROSS APPLY @LeagueGroup_Tbl l
	INNER JOIN @VRSettingHierarchy_Tbl h ON h.VRLeagueGroupID = l.VRLeagueGroupID 
		AND (
				(r.RefBettypeGroupID <> 0 AND h.VRBetTypeGroupID = r.RefBettypeGroupID  )
			OR  (r.RefBettypeGroupID = 0 AND h.VRBetTypeGroupID = -1)
			)

WHERE r.RefBettype IS NULL
	AND l.GroupName <> 'USA 1'
ORDER BY l.VRLeagueGroupID,r.RefBettypeGroupID,r.Bettype

--> Insert VRSettingReference for USA 1 LeagueGroup
INSERT INTO @VRSettingReference_Tbl(SportType,LeagueGroupID,BetType,RefLevelID)
SELECT 2 AS Sporttype,l.LeagueGroupID, r.Bettype,h.LevelID
FROM @RefVRSetting r
	CROSS APPLY @LeagueGroup_Tbl l
	INNER JOIN @VRSettingHierarchy_Tbl h ON h.VRLeagueGroupID = l.VRLeagueGroupID  ANd r.RefBettype = h.BetType
WHERE l.GroupName = 'USA 1'
ORDER BY l.VRLeagueGroupID,r.RefBettypeGroup,r.Bettype

----------------------------END PROCESS DATA------------------------------------

----------------------------BEGIN INSERT DATA-----------------------------------
INSERT INTO VRLeagueGroup(GroupID,GroupName,Sporttype) 
SELECT VRLeagueGroupID AS GroupID ,GroupName,2 AS SportType 
FROM @LeagueGroup_Tbl

INSERT INTO VRLeagueGroupMapping(LeagueGroupID,VRLeagueGroupID) 
SELECT LeagueGroupID, VRLeagueGroupID 
FROM @LeagueGroup_Tbl

INSERT INTO VRBettypeGroup(GroupID,GroupName,SportType)
SELECT btg.GroupID,btg.GroupName,btg.SportType
FROM @VRBettypeGroup_Tbl btg

INSERT [dbo].[VRSettingHierarchy] ([LevelID], [SportType], [VRLeagueGroupID], [VRBetTypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThresholdNonLive], [VRAutoSuspendThresholdLive])
SELECT h.LevelID,h.SportType,h.VRLeagueGroupID,h.VRBetTypeGroupID,h.BetType,h.ParentLevelID,h.SortOrder,h.BitmapOrderAutoSuspend,h.VRAutoSuspendThresholdNonLive,h.VRAutoSuspendThresholdLive 
FROM @VRSettingHierarchy_Tbl h

INSERT INTO VRSettingReference(SportType,LeagueGroupID,BetType,RefLevelID)
SELECT SportType,LeagueGroupID,BetType,RefLevelID
FROM @VRSettingReference_Tbl
----------------------------END INSERT DATA-------------------------------------

SELECT * FROM VRLeagueGroup WITH(NOLOCK) WHERE SportType = 2

SELECT v.*
FROM VRLeagueGroupMapping v WITH(NOLOCK)
	INNER JOIN VRLeagueGroup vr WITH(NOLOCK) ON vr.GroupID = v.VRLeagueGroupID
WHERE vr.SportType = 2
ORDER BY v.VRLeagueGroupID

SELECT * FROM VRBettypeGroup WITH(NOLOCK) WHERE SportType = 2
SELECT * FROM VRSettingHierarchy WITH(NOLOCK) WHERE SportType = 2 ORDER BY SortOrder
SELECT * FROM VRSettingReference WITH(NOLOCK) WHERE SportType = 2