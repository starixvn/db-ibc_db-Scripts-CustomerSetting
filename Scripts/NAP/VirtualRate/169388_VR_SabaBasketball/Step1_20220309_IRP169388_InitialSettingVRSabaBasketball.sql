/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20220309@Johnson    
    Task : Initial setting for league group Saba Basketball
    DB: DBCUST/CustDB
*/
USE CustDB

DELETE VRSettingHierarchy where SportType = 2 and VRLeagueGroupID IN (select GroupID from VRLeagueGroup WHERE GroupName = 'SABA Basketball PinGoal')
DELETE VRLeagueGroup WHERE GroupName = 'SABA Basketball PinGoal'
DELETE VRLeagueGroupMapping WHERE LeagueGroupID = 122
DELETE VRSettingReference WHERE SportType = 2 AND LeagueGroupID = 122

----------------------------BEGIN PROCESS DATA------------------------------------
DECLARE @LeagueGroup_Tbl TABLE ( 
	 RecordID INT IDENTITY(1,1)
	,GroupName Varchar(50)
	,LeagueGroupID INT 
	,VRLeagueGroupID INT
)
INSERT INTO @LeagueGroup_Tbl(GroupName) VALUES('SABA Basketball PinGoal')

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

INSERT INTO @VRBettypeGroup_Tbl(GroupID,GroupName,SportType) 
SELECT *
FROM VRBettypeGroup
WHERE SportType = 2
	AND GroupName IN ('Handicap','Over/Under','Odd/Even')

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
	[VRAutoSuspendThresholdNonLive] [smallmoney] default 3 ,
	[VRAutoSuspendThresholdLive] [smallmoney]  default 1.5,
	RecordID INT IDENTITY (1,1)
)

INSERT INTO @VRSettingHierarchy_Tbl(VRLeagueGroupID,VRBetTypeGroupID,BetType)
SELECT VRLeagueGroupID,gbt.GroupID AS BettypeGroupID,-1 AS Bettype 
FROM @LeagueGroup_Tbl a
	CROSS APPLY (	SELECT vb.GroupID,vb.GroupName
					FROM @VRBettypeGroup_Tbl vb 
					UNION ALL
					SELECT -1 ,'All'					
				)  Gbt
ORDER BY a.RecordID,gbt.GroupID

DECLARE @CurrentLevelID INT, @CurrentSortOrder INT, @CurrentBitmapAutoSuspend INT 

SELECT @CurrentLevelID = MAX(LevelID),
	@CurrentSortOrder = MAX(CASE WHEN SportType = 2 THEN SortOrder ELSE 0 END),
	@CurrentBitmapAutoSuspend = MAX(CASE WHEN SportType = 2 THEN BitmapOrderAutoSuspend ELSE 0 END)
FROM VRSettingHierarchy (NOLOCK)

UPDATE h
SET LevelID = RecordID + @CurrentLevelID
	,h.SortOrder = RecordID * 50 + @CurrentSortOrder
	,h.BitmapOrderAutoSuspend = RecordID + @CurrentBitmapAutoSuspend
FROM @VRSettingHierarchy_Tbl h

--select * from VRSettingHierarchy where SportType = 2 and VRLeagueGroupID = -1

UPDATE h
SET h.ParentLevelID = (select LevelID FROM VRSettingHierarchy where SportType = 2 and VRLeagueGroupID = -1)
FROM @VRSettingHierarchy_Tbl h
where h.VRBettypeGroupID = -1

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
SELECT 7,'Handicap' UNION ALL --1H Handicap -->Handicap
SELECT 8,'Over/Under' UNION ALL --1H Over/Under -->Over/Under
SELECT 12,'Odd/Even' UNION ALL --1H Odd/Even -->Odd/Even
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
SELECT 613,'<Same League Group>' UNION ALL --Quarter X Race To Y Points --><Same League Group>
SELECT 615,'Over/Under' UNION ALL --Quarter X Home Team Over/Under -->Over/Under
SELECT 616,'Over/Under' UNION ALL --Quarter X Away Team Over/Under -->Over/Under
SELECT 617,'Handicap'  --Quarter X Which Team To Score The Last Basket -->Handicap

UPDATE ref
SET ref.RefBettypeGroupID = ISNULL(btg.GroupID,0)
FROM @RefVRSetting ref
	LEFT JOIN @VRBettypeGroup_Tbl btg ON ref.RefBettypeGroup = btg.GroupName
	
INSERT INTO @RefVRSetting(Bettype,RefBettype)
SELECT 1,1 UNION ALL -- Handicap -->Handicap
SELECT 2,2 UNION ALL -- Odd/Even -->Odd/Even
SELECT 3,3 UNION ALL -- Over/Under -->Over/Under
SELECT 7,7 UNION ALL -- 1H Handicap -->1H Handicap
SELECT 8,8 UNION ALL -- 1H Over/Under -->1H Over/Under
SELECT 12,2 UNION ALL -- 1H Odd/Even -->Odd/Even
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
ORDER BY l.VRLeagueGroupID,r.RefBettypeGroupID,r.Bettype
--------------------------END PROCESS DATA------------------------------------

----------------------------BEGIN INSERT DATA-----------------------------------
INSERT INTO VRLeagueGroup(GroupID,GroupName,Sporttype) 
SELECT VRLeagueGroupID AS GroupID ,GroupName,2 AS SportType 
FROM @LeagueGroup_Tbl

INSERT INTO VRLeagueGroupMapping(LeagueGroupID,VRLeagueGroupID) 
SELECT LeagueGroupID, VRLeagueGroupID 
FROM @LeagueGroup_Tbl


INSERT [dbo].[VRSettingHierarchy] ([LevelID], [SportType], [VRLeagueGroupID], [VRBetTypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThresholdNonLive], [VRAutoSuspendThresholdLive])
SELECT h.LevelID,h.SportType,h.VRLeagueGroupID,h.VRBetTypeGroupID,h.BetType,h.ParentLevelID,h.SortOrder,h.BitmapOrderAutoSuspend,h.VRAutoSuspendThresholdNonLive,h.VRAutoSuspendThresholdLive 
FROM @VRSettingHierarchy_Tbl h

INSERT INTO VRSettingReference(SportType,LeagueGroupID,BetType,RefLevelID)
SELECT SportType,LeagueGroupID,BetType,RefLevelID
FROM @VRSettingReference_Tbl
----------------------------END INSERT DATA-------------------------------------

SELECT * FROM VRLeagueGroup WITH(NOLOCK) WHERE SportType = 2 and GroupID IN (SELECT VRLeagueGroupID from @LeagueGroup_Tbl)

SELECT v.*
FROM VRLeagueGroupMapping v WITH(NOLOCK)
	INNER JOIN VRLeagueGroup vr WITH(NOLOCK) ON vr.GroupID = v.VRLeagueGroupID
WHERE vr.SportType = 2
	and vr.GroupID IN (SELECT VRLeagueGroupID from @LeagueGroup_Tbl)
ORDER BY v.VRLeagueGroupID

SELECT * FROM VRBettypeGroup WITH(NOLOCK) WHERE SportType = 2
SELECT * FROM VRSettingHierarchy WITH(NOLOCK) WHERE SportType = 2 and VRLeagueGroupID IN (SELECT VRLeagueGroupID from @LeagueGroup_Tbl) ORDER BY SortOrder
SELECT * FROM VRSettingReference WITH(NOLOCK) WHERE SportType = 2 and LeagueGroupID = 122 