/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220309
	Created: Winfred 
	Task: #169510 - Pragmatic - Integrate 21 new games for Credit UUS [Redmine:169510]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 6716 ,'0.4'     ,'100'         ,0.4     ,100         ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6717 ,'0.4'     ,'50'          ,0.4     ,50          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6718 ,'0.4'     ,'50'          ,0.4     ,50          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6719 ,'0.5'     ,'50'          ,0.5     ,50          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6720 ,'0.4'     ,'50'          ,0.4     ,50          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6721 ,'1.76'    ,'88'          ,1.76    ,88          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6722 ,'0.4'     ,'50'          ,0.4     ,50          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6723 ,'0.5'     ,'25'          ,0.5     ,25          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6724 ,'0.4'     ,'50'          ,0.4     ,50          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6725 ,'2.5'     ,'100'         ,2.5     ,100         ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6726 ,'1.76'    ,'88'          ,1.76    ,88          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6727 ,'0.4'     ,'40'          ,0.4     ,40          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6728 ,'0.4'     ,'20'          ,0.4     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6729 ,'0.4'     ,'8'           ,0.4     ,8           ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6730 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6731 ,'0.1'     ,'10'          ,0.1     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6732 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6733 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6734 ,'0.25'    ,'25'          ,0.25    ,25          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6735 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6736 ,'0.1'     ,'10'          ,0.1     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
--YNG
SELECT 6716 ,'0.4'     ,'100'         ,0.4     ,100         ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6717 ,'0.4'     ,'50'          ,0.4     ,50          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6718 ,'0.4'     ,'50'          ,0.4     ,50          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6719 ,'0.5'     ,'50'          ,0.5     ,50          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6720 ,'0.4'     ,'50'          ,0.4     ,50          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6721 ,'1.76'    ,'88'          ,1.76    ,88          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6722 ,'0.4'     ,'50'          ,0.4     ,50          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6723 ,'0.5'     ,'25'          ,0.5     ,25          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6724 ,'0.4'     ,'50'          ,0.4     ,50          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6725 ,'2.5'     ,'100'         ,2.5     ,100         ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6726 ,'1.76'    ,'88'          ,1.76    ,88          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6727 ,'0.4'     ,'40'          ,0.4     ,40          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6728 ,'0.4'     ,'20'          ,0.4     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6729 ,'0.4'     ,'8'           ,0.4     ,8           ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6730 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6731 ,'0.1'     ,'10'          ,0.1     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6732 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6733 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6734 ,'0.25'    ,'25'          ,0.25    ,25          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6735 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6736 ,'0.1'     ,'10'          ,0.1     ,10          ,72				--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO

	
;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4101)

MERGE StakeLevelGroupDetail as g 
USING STAKE_TEMP s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake =  s.MinStake,
					g.MaxStake =  s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
					VALUES (s.StakeLevelID,s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake)					
					 ;
DROP TABLE #StakeLevel_Temp