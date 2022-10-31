/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20221018@Johnson    
    Task : Initial setting for league group E-Sports [redmine:#177594]
    DB: DBCUST/CustDB
*/


----------------------------BEGIN PROCESS DATA------------------------------------
DECLARE @LeagueGroup_Tbl TABLE ( 
	 RecordID INT IDENTITY(1,1)
	,GroupName Varchar(50)
	,LeagueGroupID INT 
	,VRLeagueGroupID INT
)
INSERT INTO @LeagueGroup_Tbl(GroupName) 
SELECT 'Arena of Valor'
UNION SELECT 'League of Legends: Wild Rift'
UNION SELECT 'PUBG'
UNION SELECT 'Streamer'
UNION SELECT 'Valorant'

--DELETE existing settings
DELETE VRLeagueGroupMapping WITH(ROWLOCK)
WHERE VRLeagueGroupID IN ( SELECT GroupID 
						FROM VRLeagueGroup WITH(NOLOCK)
						WHERE GroupName IN (SELECT GroupName FROM @LeagueGroup_Tbl)
							AND sporttype = 43
						)
						
DELETE VRSettingHierarchy WITH(ROWLOCK)
WHERE VRLeagueGroupID IN ( SELECT GroupID 
						FROM VRLeagueGroup WITH(NOLOCK)
						WHERE GroupName IN (SELECT GroupName FROM @LeagueGroup_Tbl)
							AND sporttype = 43
						)

DELETE VRLeagueGroup WITH(ROWLOCK)
WHERE  GroupName IN (SELECT GroupName FROM @LeagueGroup_Tbl)
	AND sporttype = 43
						

DECLARE @MaxVRLeagueGroupID INT
SELECT @MaxVRLeagueGroupID = MAX(GroupID) FROM VRLeagueGroup WITH(NOLOCK)

UPDATE lg1
SET lg1.LeagueGroupID = lg.GroupID
	,lg1.VRLeagueGroupID = @MaxVRLeagueGroupID + lg1.RecordID
FROM @LeagueGroup_Tbl lg1 
	INNER JOIN DBPRO.bodb02.dbo.LeagueGroup lg WITH(NOLOCK) ON lg1.GroupName = lg.GroupName 
WHERE lg.Sporttype IN(43)

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
WHERE SportType IN (43)
	AND GroupName IN ('Handicap','Over/Under','Moneyline')


DECLARE @BettypeRef_Tbl TABLE (
	 VRBettypeGroupID INT
	,BettypeGroup NVARCHAR(200) 
	,Bettype INT
	,Id INT IDENTITY (1,1)
	)

INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Handicap',1) --Handicap
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Over/Under',3) --Over/Under
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Moneyline',20) --Moneyline
INSERT INTO @BettypeRef_Tbl(BettypeGroup,Bettype) VALUES( 'Moneyline',9001) --Quarter X Moneyline


UPDATE  ref
SET ref.VRBettypeGroupID = btg.GroupID
FROM @BettypeRef_Tbl ref
	INNER JOIN @VRBettypeGroup_Tbl btg ON ref.BettypeGroup = btg.GroupName

--select * from @BettypeRef_Tbl
--return

DECLARE  @VRSettingHierarchy_Tbl TABLE(
	[LevelID] [int]  ,
	[SportType] [int] DEFAULT 43,
	[VRLeagueGroupID] [smallint] ,
	[VRBetTypeGroupID] [smallint] ,
	[BetType] [int] ,
	[ParentLevelID] [int] ,
	[SortOrder] [smallint]  ,
	[BitmapOrderAutoSuspend] [smallint] ,
	[VRAutoSuspendThresholdNonLive] [smallmoney] default 0 ,
	[VRAutoSuspendThresholdLive] [smallmoney]  default 0,
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
	
UNION ALL 
SELECT a.VRLeagueGroupID,gbt.GroupID AS BettypeGroupID,bt.bettype AS Bettype 
FROM @LeagueGroup_Tbl a 
	CROSS APPLY (	SELECT vb.GroupID,vb.GroupName
					FROM @VRBettypeGroup_Tbl vb 
				)  Gbt
	INNER JOIN @BettypeRef_Tbl bt ON bt.VRBettypeGroupID = gbt.GroupID
ORDER BY 1,2,3

DECLARE @CurrentLevelID INT, @CurrentSortOrder INT, @CurrentBitmapAutoSuspend INT 

SELECT @CurrentLevelID = MAX(LevelID),
	@CurrentSortOrder = MAX(CASE WHEN SportType = 43 THEN SortOrder ELSE 0 END),
	@CurrentBitmapAutoSuspend = MAX(CASE WHEN SportType = 43 THEN BitmapOrderAutoSuspend ELSE 0 END)
FROM VRSettingHierarchy (NOLOCK)

UPDATE h
SET LevelID = RecordID + @CurrentLevelID
	,h.SortOrder = RecordID * 50 + @CurrentSortOrder	
FROM @VRSettingHierarchy_Tbl h

;WITH T AS(
SELECT ROW_NUMBER() OVER (ORDER by RecordID) ID, LevelID from @VRSettingHierarchy_Tbl where BetType <> -1
)
UPDATE h
SET h.BitmapOrderAutoSuspend = ID + @CurrentBitmapAutoSuspend
FROM @VRSettingHierarchy_Tbl h
	INNER JOIN T ON h.LevelID = t.LevelID

UPDATE h
SET LevelID = RecordID + @CurrentLevelID
	,h.SortOrder = RecordID * 50 + @CurrentSortOrder	
FROM @VRSettingHierarchy_Tbl h

UPDATE h
SET h.ParentLevelID = (select LevelID FROM VRSettingHierarchy where SportType = 43 and VRLeagueGroupID = -1)
FROM @VRSettingHierarchy_Tbl h
where h.VRBettypeGroupID = -1

; WITH tmp as(
	SELECT * FROM @VRSettingHierarchy_Tbl h WHERE h.VRLeagueGroupID <> -1 and h.VRBetTypeGroupID = -1 
)
UPDATE h
SET h.ParentLevelID = t.LevelID
FROM @VRSettingHierarchy_Tbl h
	INNER JOIN tmp t ON t.VRLeagueGroupID = h.VRLeagueGroupID
WHERE h.ParentLevelID IS NULL AND h.bettype = -1

; WITH tmp as(
	SELECT * FROM @VRSettingHierarchy_Tbl h WHERE h.VRLeagueGroupID <> -1 and h.VRBetTypeGroupID <> -1 AND h.BetType = -1
)
UPDATE h
SET h.ParentLevelID = t.LevelID
FROM @VRSettingHierarchy_Tbl h
	INNER JOIN tmp t ON t.VRLeagueGroupID = h.VRLeagueGroupID AND t.VRBettypeGroupID = h.VRBetTypeGroupID
WHERE h.ParentLevelID IS NULL AND h.bettype <> -1
----------------------------END PROCESS DATA------------------------------------

----------------------------BEGIN INSERT DATA-----------------------------------
INSERT INTO VRLeagueGroup(GroupID,GroupName,Sporttype) 
SELECT VRLeagueGroupID AS GroupID ,GroupName,43 AS SportType 
FROM @LeagueGroup_Tbl

INSERT INTO VRLeagueGroupMapping(LeagueGroupID,VRLeagueGroupID) 
SELECT LeagueGroupID, VRLeagueGroupID 
FROM @LeagueGroup_Tbl

INSERT [dbo].[VRSettingHierarchy] ([LevelID], [SportType], [VRLeagueGroupID], [VRBetTypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThresholdNonLive], [VRAutoSuspendThresholdLive])
SELECT h.LevelID,h.SportType,h.VRLeagueGroupID,h.VRBetTypeGroupID,h.BetType,h.ParentLevelID,h.SortOrder,h.BitmapOrderAutoSuspend,h.VRAutoSuspendThresholdNonLive,h.VRAutoSuspendThresholdLive 
FROM @VRSettingHierarchy_Tbl h
----------------------------END INSERT DATA-------------------------------------

SELECT * FROM VRLeagueGroup WITH(NOLOCK) WHERE GroupID IN (SELECT VRLeagueGroupID FROM @LeagueGroup_Tbl)
SELECT * FROM VRLeagueGroupMapping WITH(NOLOCK) WHERE VRLeagueGroupID IN (SELECT VRLeagueGroupID FROM @LeagueGroup_Tbl)
SELECT * FROM VRSettingHierarchy WITH(NOLOCK) WHERE VRLeagueGroupID IN (SELECT VRLeagueGroupID FROM @LeagueGroup_Tbl)
GO

-----Update LeagueGroupOrder 
;WITH T AS (
SELECT 	'Major League'	GroupName,	10	LeagueGroupOrder--	1 Sporttype
UNION SELECT 	'Minor League 1'	,	20	--	1
UNION SELECT 	'Minor League 2'	,	30	--	1
UNION SELECT 	'Minor League 3'	,	40	--	1
UNION SELECT 	'Others'	,	50	--	1
UNION SELECT 	'Minor League 4'	,	60	--	1
UNION SELECT 	'Others1'	,	70	--	1
UNION SELECT 	'Others2'	,	80	--	1
UNION SELECT 	'Others3'	,	90	--	1
UNION SELECT 	'Others4'	,	100	--	1
UNION SELECT 	'Others5'	,	110	--	1
UNION SELECT 	'Specials'	,	120	--	1
UNION SELECT 	'Specific 10min'	,	130	--	1
UNION SELECT 	'Specific 15min'	,	140	--	1
UNION SELECT 	'USA 1'	,	10	--	2
UNION SELECT 	'3X3 1'	,	20	--	2
UNION SELECT 	'3X3 2'	,	30	--	2
UNION SELECT 	'3X3 3'	,	40	--	2
UNION SELECT 	'AFRICA 5'	,	50	--	2
UNION SELECT 	'AMERICAS 1'	,	60	--	2
UNION SELECT 	'AMERICAS 2'	,	70	--	2
UNION SELECT 	'AMERICAS 3'	,	80	--	2
UNION SELECT 	'AMERICAS 4'	,	90	--	2
UNION SELECT 	'AMERICAS 5'	,	100	--	2
UNION SELECT 	'ASIA 1'	,	110	--	2
UNION SELECT 	'ASIA 2'	,	120	--	2
UNION SELECT 	'ASIA 3'	,	130	--	2
UNION SELECT 	'ASIA 4'	,	140	--	2
UNION SELECT 	'ASIA 5'	,	150	--	2
UNION SELECT 	'EUROPE 1'	,	160	--	2
UNION SELECT 	'EUROPE 2'	,	170	--	2
UNION SELECT 	'EUROPE 3'	,	180	--	2
UNION SELECT 	'EUROPE 4'	,	190	--	2
UNION SELECT 	'EUROPE 5'	,	200	--	2
UNION SELECT 	'INTERNATIONAL 1'	,	210	--	2
UNION SELECT 	'INTERNATIONAL 2'	,	220	--	2
UNION SELECT 	'INTERNATIONAL 3'	,	230	--	2
UNION SELECT 	'INTERNATIONAL 4'	,	240	--	2
UNION SELECT 	'INTERNATIONAL 5'	,	250	--	2
UNION SELECT 	'OTHERS'	,	260	--	2
UNION SELECT 	'SPECIALS'	,	270	--	2
UNION SELECT 	'USA 2'	,	280	--	2
UNION SELECT 	'USA 3'	,	290	--	2
UNION SELECT 	'USA OTHER'	,	300	--	2
UNION SELECT 	'VIRTUAL'	,	310	--	2
UNION SELECT 	'VIRTUAL GAMER'	,	320	--	2
UNION SELECT 	'SABA Basketball Pingoal'	,	330	--	2
UNION SELECT 	'Arena of Valor'	,	10	--	43
UNION SELECT 	'CS:GO'	,	20	--	43
UNION SELECT 	'Dota 2'	,	30	--	43
UNION SELECT 	'King of Glory'	,	40	--	43
UNION SELECT 	'League of Legends'	,	50	--	43
UNION SELECT 	'League of Legends: Wild Rift'	,	60	--	43
UNION SELECT 	'PUBG'	,	70	--	43
UNION SELECT 	'Streamer'	,	80	--	43
UNION SELECT 	'Valorant'	,	90	--	43
UNION SELECT 	'Other Games'	,	100	--	43
)
UPDATE l 
SET l.LeagueGroupOrder = t.LeagueGroupOrder
FROM VRLeagueGroup l WITH(ROWLOCK)
	INNER JOIN t ON l.GroupName = t.GroupName
GO
	
--Move Bet types
--Dota2: Move bet type: Map X Will Any Aegis Be Snatched Yes/No from Odd/Even to Moneyline
DECLARE @VRBetTypeGroupID INT,
	@ParentLevelID INT, 
	@SortOrder INT,
	@VRLeagueGroupID INT 

SELECT @VRLeagueGroupID = GroupID from VRLeagueGroup (NOLOCK) WHERE SportType = 43 AND GroupName = 'Dota 2'	
SELECT @VRBetTypeGroupID = GroupID FROM VRBettypeGroup (NOLOCK) WHERE SportType = 43 AND GroupName = 'Moneyline'
SELECT @ParentLevelID = LevelID FROM VRSettingHierarchy (NOLOCK) WHERE SportType = 43 AND VRLeagueGroupID = @VRLeagueGroupID AND VRBetTypeGroupID = @VRBetTypeGroupID AND Bettype = -1
SELECT @SortOrder = MAX(SortOrder) FROM VRSettingHierarchy (NOLOCK) WHERE SportType = 43 AND VRLeagueGroupID = @VRLeagueGroupID AND VRBetTypeGroupID = @VRBetTypeGroupID

UPDATE vr
SET VRBetTypeGroupID = @VRBetTypeGroupID,
	ParentLevelID = @ParentLevelID,
	SortOrder = @SortOrder + 1
FROM VRSettingHierarchy vr WITH(ROWLOCK)
WHERE VRLeagueGroupID  = @VRLeagueGroupID
	AND Bettype = 9133

--CS:Go: Move bet type: Map X Round Y Bomb Plant from Odd/Even to Moneyline
SELECT @VRLeagueGroupID = GroupID from VRLeagueGroup (NOLOCK) WHERE SportType = 43 AND GroupName = 'CS:Go'	
SELECT @VRBetTypeGroupID = GroupID FROM VRBettypeGroup (NOLOCK) WHERE SportType = 43 AND GroupName = 'Moneyline'
SELECT @ParentLevelID = LevelID FROM VRSettingHierarchy (NOLOCK) WHERE SportType = 43 AND VRLeagueGroupID = @VRLeagueGroupID AND VRBetTypeGroupID = @VRBetTypeGroupID AND Bettype = -1
SELECT @SortOrder = MAX(SortOrder) FROM VRSettingHierarchy (NOLOCK) WHERE SportType = 43 AND VRLeagueGroupID = @VRLeagueGroupID AND VRBetTypeGroupID = @VRBetTypeGroupID

UPDATE vr
SET VRBetTypeGroupID = @VRBetTypeGroupID,
	ParentLevelID = @ParentLevelID,
	SortOrder = @SortOrder + 1
FROM VRSettingHierarchy vr WITH(ROWLOCK)
WHERE VRLeagueGroupID  = @VRLeagueGroupID	
	AND Bettype = 9073
	
--King of Glory: Move bet type: Map X Will Storm Dragon Be Killed Yes/No from Odd/Even to Moneyline
SELECT @VRLeagueGroupID = GroupID from VRLeagueGroup (NOLOCK) WHERE SportType = 43 AND GroupName = 'King of Glory'	
SELECT @VRBetTypeGroupID = GroupID FROM VRBettypeGroup (NOLOCK) WHERE SportType = 43 AND GroupName = 'Moneyline'
SELECT @ParentLevelID = LevelID FROM VRSettingHierarchy (NOLOCK) WHERE SportType = 43 AND VRLeagueGroupID = @VRLeagueGroupID AND VRBetTypeGroupID = @VRBetTypeGroupID AND Bettype = -1
SELECT @SortOrder = MAX(SortOrder) FROM VRSettingHierarchy (NOLOCK) WHERE SportType = 43 AND VRLeagueGroupID = @VRLeagueGroupID AND VRBetTypeGroupID = @VRBetTypeGroupID

UPDATE vr
SET VRBetTypeGroupID = @VRBetTypeGroupID,
	ParentLevelID = @ParentLevelID,
	SortOrder = @SortOrder + 1
FROM VRSettingHierarchy vr WITH(ROWLOCK)
WHERE VRLeagueGroupID  = @VRLeagueGroupID	
	AND Bettype = 9124

	