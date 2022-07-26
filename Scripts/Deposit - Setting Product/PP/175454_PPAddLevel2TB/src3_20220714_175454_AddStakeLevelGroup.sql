/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220714
	Created: Winfred 
	Task: #165393 - Pragmatic - Integrate TB Level 2 for Deposit [Redmine:175454]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId INT, GameGroupID INT DEFAULT(38))
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--TB
SELECT 4101 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4102 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4109 ,'0.3'    ,'570'       ,0.3    ,570       ,4    UNION ALL	--TB	--THB
SELECT 4110 ,'0.3'    ,'570'       ,0.3    ,570       ,4    UNION ALL	--TB	--THB
SELECT 4111 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4114 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4115 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4116 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4118 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4119 ,'0.38'   ,'722'       ,0.38   ,722       ,4    UNION ALL	--TB	--THB
SELECT 4121 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4122 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4128 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4131 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4160 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4163 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4164 ,'0.14'   ,'266'       ,0.14   ,266       ,4    UNION ALL	--TB	--THB
SELECT 4166 ,'0.5'    ,'950'       ,0.5    ,950       ,4    UNION ALL	--TB	--THB
SELECT 4169 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4173 ,'0.18'   ,'342'       ,0.18   ,342       ,4    UNION ALL	--TB	--THB
SELECT 4174 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4176 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4180 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4182 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4184 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4185 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4186 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4187 ,'0.14'   ,'266'       ,0.14   ,266       ,4    UNION ALL	--TB	--THB
SELECT 4188 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4190 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4197 ,'0.36'   ,'684'       ,0.36   ,684       ,4    UNION ALL	--TB	--THB
SELECT 4198 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4200 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4201 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4203 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4204 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4206 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4208 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4210 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4211 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4212 ,'0.3'    ,'570'       ,0.3    ,570       ,4    UNION ALL	--TB	--THB
SELECT 4213 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4214 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4215 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4218 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4219 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4224 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4225 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4228 ,'0.18'   ,'342'       ,0.18   ,342       ,4    UNION ALL	--TB	--THB
SELECT 4229 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4230 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4231 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4233 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4234 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4236 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4237 ,'0.18'   ,'342'       ,0.18   ,342       ,4    UNION ALL	--TB	--THB
SELECT 4239 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4245 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4248 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4251 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4254 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4255 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4256 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4258 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4259 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4260 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4261 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4263 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4266 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4268 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4269 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4270 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4274 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4276 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4277 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 4278 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4283 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4284 ,'0.36'   ,'684'       ,0.36   ,684       ,4    UNION ALL	--TB	--THB
SELECT 4285 ,'0.24'   ,'456'       ,0.24   ,456       ,4    UNION ALL	--TB	--THB
SELECT 4286 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4288 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4289 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4290 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4291 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4292 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4293 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4294 ,'0.4'    ,'760'       ,0.4    ,760       ,4    UNION ALL	--TB	--THB
SELECT 4295 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 4296 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6701 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6702 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6703 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6704 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6705 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 6708 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6709 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6710 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6711 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6712 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6713 ,'0.38'   ,'722'       ,0.38   ,722       ,4    UNION ALL	--TB	--THB
SELECT 6714 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6716 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6717 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6718 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6719 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 6720 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6721 ,'0.88'   ,'1672'      ,0.88   ,1672      ,4    UNION ALL	--TB	--THB
SELECT 6722 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6723 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6724 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6725 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 6726 ,'0.88'   ,'1672'      ,0.88   ,1672      ,4    UNION ALL	--TB	--THB
SELECT 6727 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6728 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6729 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6730 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6731 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6732 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6733 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6734 ,'0.25'   ,'475'       ,0.25   ,475       ,4    UNION ALL	--TB	--THB
SELECT 6735 ,'0.2'    ,'380'       ,0.2    ,380       ,4    UNION ALL	--TB	--THB
SELECT 6736 ,'0.2'    ,'380'       ,0.2    ,380       ,4				--TB	--THB

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  WHERE t.ExchangeId = s.ExchangeId  and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4101)

MERGE Dep_StakeLevelGroupDetail as g 
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