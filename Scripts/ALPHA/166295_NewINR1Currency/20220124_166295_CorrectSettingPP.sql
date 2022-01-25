/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220121
	Task:		Update setting 248	Pragmatic (Pragmatic) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 4101 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4102 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4104 ,'15'      ,'4500'        ,15      ,4500        ,10   UNION ALL	--INR1
SELECT 4106 ,'17.5'    ,'105'         ,17.5    ,105         ,10   UNION ALL	--INR1
SELECT 4107 ,'17.5'    ,'1050'        ,17.5    ,1050        ,10   UNION ALL	--INR1
SELECT 4108 ,'22.5'    ,'6750'        ,22.5    ,6750        ,10   UNION ALL	--INR1
SELECT 4109 ,'15'      ,'4500'        ,15      ,4500        ,10   UNION ALL	--INR1
SELECT 4110 ,'15'      ,'4500'        ,15      ,4500        ,10   UNION ALL	--INR1
SELECT 4111 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4112 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4113 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4114 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4115 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4116 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4117 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4118 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4119 ,'19'      ,'3800'        ,19      ,3800        ,10   UNION ALL	--INR1
SELECT 4120 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 4121 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4122 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4123 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4124 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4125 ,'15'      ,'4500'        ,15      ,4500        ,10   UNION ALL	--INR1
SELECT 4126 ,'32.5'    ,'3250'        ,32.5    ,3250        ,10   UNION ALL	--INR1
SELECT 4127 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4128 ,'12.5'    ,'750'         ,12.5    ,750         ,10   UNION ALL	--INR1
SELECT 4129 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4130 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4131 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4132 ,'25'      ,'250'         ,25      ,250         ,10   UNION ALL	--INR1
SELECT 4133 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4134 ,'15'      ,'1500'        ,15      ,1500        ,10   UNION ALL	--INR1
SELECT 4135 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 4136 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4137 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 4138 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 4139 ,'15'      ,'900'         ,15      ,900         ,10   UNION ALL	--INR1
SELECT 4140 ,'20'      ,'2000'        ,20      ,2000        ,10   UNION ALL	--INR1
SELECT 4141 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 4142 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4143 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4144 ,'22.5'    ,'1125'        ,22.5    ,1125        ,10   UNION ALL	--INR1
SELECT 4145 ,'32.5'    ,'3250'        ,32.5    ,3250        ,10   UNION ALL	--INR1
SELECT 4146 ,'15'      ,'3000'        ,15      ,3000        ,10   UNION ALL	--INR1
SELECT 4147 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4148 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4149 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4150 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4151 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4152 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4153 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4154 ,'15'      ,'4500'        ,15      ,4500        ,10   UNION ALL	--INR1
SELECT 4155 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4156 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4157 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 4158 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1
SELECT 4159 ,'22.5'    ,'2250'        ,22.5    ,2250        ,10   UNION ALL	--INR1
SELECT 4160 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4161 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4162 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4163 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4164 ,'17.5'    ,'5250'        ,17.5    ,5250        ,10   UNION ALL	--INR1
SELECT 4165 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4166 ,'25'      ,'1500'        ,25      ,1500        ,10   UNION ALL	--INR1
SELECT 4167 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4168 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4169 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4171 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4174 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4175 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4176 ,'12.5'    ,'500'         ,12.5    ,500         ,10   UNION ALL	--INR1
SELECT 4177 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4178 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1
SELECT 4179 ,'45'      ,'900'         ,45      ,900         ,10   UNION ALL	--INR1
SELECT 4180 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4181 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4182 ,'10'      ,'100'         ,10      ,100         ,10   UNION ALL	--INR1
SELECT 4183 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4184 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4186 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4190 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4191 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4192 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4193 ,'22.5'    ,'6750'        ,22.5    ,6750        ,10   UNION ALL	--INR1
SELECT 4194 ,'10'      ,'500'         ,10      ,500         ,10   UNION ALL	--INR1
SELECT 4195 ,'12.5'    ,'750'         ,12.5    ,750         ,10   UNION ALL	--INR1
SELECT 4196 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4197 ,'45'      ,'450'         ,45      ,450         ,10   UNION ALL	--INR1
SELECT 4198 ,'12.5'    ,'500'         ,12.5    ,500         ,10   UNION ALL	--INR1
SELECT 4199 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4200 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4201 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 4202 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4203 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4204 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4205 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4206 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4207 ,'20'      ,'1200'        ,20      ,1200        ,10   UNION ALL	--INR1
SELECT 4208 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4209 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4210 ,'12.5'    ,'625'         ,12.5    ,625         ,10   UNION ALL	--INR1
SELECT 4211 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4212 ,'15'      ,'300'         ,15      ,300         ,10   UNION ALL	--INR1
SELECT 4213 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4214 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4215 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4216 ,'20'      ,'2000'        ,20      ,2000        ,10   UNION ALL	--INR1
SELECT 4218 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4219 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4220 ,'0.5'     ,'250'         ,0.5     ,250         ,10   UNION ALL	--INR1
SELECT 4221 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4222 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4223 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4224 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4225 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4226 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4232 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4233 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4234 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4235 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4236 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4237 ,'22.5'    ,'225'         ,22.5    ,225         ,10   UNION ALL	--INR1
SELECT 4238 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4239 ,'0.5'     ,'250'         ,0.5     ,250         ,10   UNION ALL	--INR1
SELECT 4240 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4241 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4242 ,'1'       ,'300'         ,1       ,300         ,10   UNION ALL	--INR1
SELECT 4243 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4244 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4245 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4246 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4247 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4248 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4249 ,'10'      ,'300'         ,10      ,300         ,10   UNION ALL	--INR1
SELECT 4250 ,'12.5'    ,'250'         ,12.5    ,250         ,10   UNION ALL	--INR1
SELECT 4251 ,'10'      ,'300'         ,10      ,300         ,10   UNION ALL	--INR1
SELECT 4252 ,'10'      ,'300'         ,10      ,300         ,10   UNION ALL	--INR1
SELECT 4253 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4254 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4256 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4257 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4258 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4259 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4260 ,'10'      ,'300'         ,10      ,300         ,10   UNION ALL	--INR1
SELECT 4261 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4262 ,'12.5'    ,'3750'        ,12.5    ,3750        ,10   UNION ALL	--INR1
SELECT 4263 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4264 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4265 ,'10'      ,'300'         ,10      ,300         ,10   UNION ALL	--INR1
SELECT 4266 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4267 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4268 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4269 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4270 ,'12.5'    ,'1250'        ,12.5    ,1250        ,10   UNION ALL	--INR1
SELECT 4271 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4272 ,'12.5'    ,'500'         ,12.5    ,500         ,10   UNION ALL	--INR1
SELECT 4273 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4274 ,'10'      ,'300'         ,10      ,300         ,10   UNION ALL	--INR1
SELECT 4275 ,'12.5'    ,'250'         ,12.5    ,250         ,10   UNION ALL	--INR1
SELECT 4276 ,'1.25'    ,'500'         ,1.25    ,500         ,10   UNION ALL	--INR1
SELECT 4277 ,'12.5'    ,'500'         ,12.5    ,500         ,10   UNION ALL	--INR1
SELECT 4278 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4279 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4280 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4281 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 4282 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4283 ,'0.5'     ,'250'         ,0.5     ,250         ,10   UNION ALL	--INR1
SELECT 4284 ,'45'      ,'450'         ,45      ,450         ,10   UNION ALL	--INR1
SELECT 4285 ,'30'      ,'1200'        ,30      ,1200        ,10   UNION ALL	--INR1
SELECT 4286 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4287 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4288 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4289 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4290 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4291 ,'10'      ,'600'         ,10      ,600         ,10   UNION ALL	--INR1
SELECT 4292 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4293 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4294 ,'2'       ,'600'         ,2       ,600         ,10   UNION ALL	--INR1
SELECT 4295 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 4296 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 6701 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 6702 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 6704 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 6705 ,'1.25'    ,'500'         ,1.25    ,500         ,10   UNION ALL	--INR1
SELECT 6706 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 6707 ,'1.25'    ,'500'         ,1.25    ,500         ,10   UNION ALL	--INR1
SELECT 6708 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 6709 ,'0.5'     ,'250'         ,0.5     ,250         ,10   UNION ALL	--INR1
SELECT 6710 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 6712 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 6713 ,'1.9'     ,'570'         ,1.9     ,570         ,10   UNION ALL	--INR1
SELECT 6714 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1
SELECT 6715 ,'1'       ,'500'         ,1       ,500         ,10				--INR1
	
UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999	
	
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