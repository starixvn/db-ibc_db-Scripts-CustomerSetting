/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211210
	Created: Winfred 
	Task: #165393 - Pragmatic - Integrate 20 new games for Credit [Redmine:165393]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--GBP
SELECT 4186 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4203 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4208 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4215 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4220 ,'0.1'     ,'300'         ,0.1     ,300         ,12   UNION ALL	--GBP	--GBP
SELECT 4221 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4236 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4239 ,'0.1'     ,'300'         ,0.1     ,300         ,12   UNION ALL	--GBP	--GBP
SELECT 4242 ,'0.2'     ,'200'         ,0.2     ,200         ,12   UNION ALL	--GBP	--GBP
SELECT 4244 ,'0.2'     ,'500'         ,0.2     ,500         ,12   UNION ALL	--GBP	--GBP
SELECT 4248 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4253 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4255 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4267 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4268 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4276 ,'0.25'    ,'750'         ,0.25    ,750         ,12   UNION ALL	--GBP	--GBP
SELECT 4278 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4280 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4282 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4283 ,'0.1'     ,'300'         ,0.1     ,300         ,12   UNION ALL	--GBP	--GBP
SELECT 4286 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4289 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4292 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4293 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4294 ,'0.4'     ,'600'         ,0.4     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4295 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 4296 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6701 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6702 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6703 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6704 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6705 ,'0.25'    ,'750'         ,0.25    ,750         ,12   UNION ALL	--GBP	--GBP
SELECT 6706 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6707 ,'0.25'    ,'750'         ,0.25    ,750         ,12   UNION ALL	--GBP	--GBP
SELECT 6708 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6709 ,'0.1'     ,'300'         ,0.1     ,300         ,12   UNION ALL	--GBP	--GBP
SELECT 6710 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6711 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6712 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6713 ,'0.38'    ,'570'         ,0.38    ,570         ,12   UNION ALL	--GBP	--GBP
SELECT 6714 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
SELECT 6715 ,'0.2'     ,'600'         ,0.2     ,600         ,12   UNION ALL	--GBP	--GBP
--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'5000'        ,0.1     ,5000        ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'5000'        ,0.1     ,5000        ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'4000'        ,0.2     ,4000        ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'12500'       ,0.25    ,12500       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'5000'        ,0.1     ,5000        ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'12000'       ,0.4     ,12000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'12500'       ,0.25    ,12500       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'12500'       ,0.25    ,12500       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'5000'        ,0.1     ,5000        ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'11400'       ,0.38    ,11400       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'10000'       ,0.2     ,10000       ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'5000'        ,0.1     ,5000        ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'5000'        ,0.1     ,5000        ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'4000'        ,0.2     ,4000        ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'12500'       ,0.25    ,12500       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'5000'        ,0.1     ,5000        ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'12000'       ,0.4     ,12000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'12500'       ,0.25    ,12500       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'12500'       ,0.25    ,12500       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'5000'        ,0.1     ,5000        ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'11400'       ,0.38    ,11400       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'10000'       ,0.2     ,10000       ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'5000'        ,0.1     ,5000        ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'5000'        ,0.1     ,5000        ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'4000'        ,0.2     ,4000        ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'12500'       ,0.25    ,12500       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'5000'        ,0.1     ,5000        ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'12000'       ,0.4     ,12000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'12500'       ,0.25    ,12500       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'12500'       ,0.25    ,12500       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'5000'        ,0.1     ,5000        ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'11400'       ,0.38    ,11400       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'10000'       ,0.2     ,10000       ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'5000'        ,0.1     ,5000        ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'5000'        ,0.1     ,5000        ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'4000'        ,0.2     ,4000        ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'12500'       ,0.25    ,12500       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'5000'        ,0.1     ,5000        ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'12000'       ,0.4     ,12000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'12500'       ,0.25    ,12500       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'12500'       ,0.25    ,12500       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'5000'        ,0.1     ,5000        ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'11400'       ,0.38    ,11400       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'10000'       ,0.2     ,10000       ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'5000'        ,0.1     ,5000        ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'5000'        ,0.1     ,5000        ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'4000'        ,0.2     ,4000        ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'12500'       ,0.25    ,12500       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'5000'        ,0.1     ,5000        ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'12000'       ,0.4     ,12000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'12500'       ,0.25    ,12500       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'12500'       ,0.25    ,12500       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'5000'        ,0.1     ,5000        ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'11400'       ,0.38    ,11400       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'10000'       ,0.2     ,10000       ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
--INH
SELECT 4186 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4203 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4208 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4215 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4220 ,'0.1'     ,'8000'        ,0.1     ,8000        ,51   UNION ALL	--INH	--INH
SELECT 4221 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4236 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4239 ,'0.1'     ,'8000'        ,0.1     ,8000        ,51   UNION ALL	--INH	--INH
SELECT 4242 ,'0.2'     ,'8000'        ,0.2     ,8000        ,51   UNION ALL	--INH	--INH
SELECT 4244 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4248 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4253 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4255 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4267 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4268 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4276 ,'0.25'    ,'20000'       ,0.25    ,20000       ,51   UNION ALL	--INH	--INH
SELECT 4278 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4280 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4282 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4283 ,'0.1'     ,'8000'        ,0.1     ,8000        ,51   UNION ALL	--INH	--INH
SELECT 4286 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4289 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4292 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4293 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4294 ,'0.4'     ,'16000'       ,0.4     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4295 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 4296 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6701 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6702 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6703 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6704 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6705 ,'0.25'    ,'20000'       ,0.25    ,20000       ,51   UNION ALL	--INH	--INH
SELECT 6706 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6707 ,'0.25'    ,'20000'       ,0.25    ,20000       ,51   UNION ALL	--INH	--INH
SELECT 6708 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6709 ,'0.1'     ,'8000'        ,0.1     ,8000        ,51   UNION ALL	--INH	--INH
SELECT 6710 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6711 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6712 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6713 ,'0.38'    ,'15200'       ,0.38    ,15200       ,51   UNION ALL	--INH	--INH
SELECT 6714 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
SELECT 6715 ,'0.2'     ,'16000'       ,0.2     ,16000       ,51   UNION ALL	--INH	--INH
--RM , HKK
SELECT 4186 ,'0.2'     ,'3000'        ,0.2     ,3000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4203 ,'0.2'     ,'3000'        ,0.2     ,3000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4208 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4215 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4220 ,'0.1'     ,'2000'        ,0.1     ,2000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4221 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4236 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4239 ,'0.1'     ,'1500'        ,0.1     ,1500        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4242 ,'0.2'     ,'1200'        ,0.2     ,1200        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4244 ,'0.2'     ,'2000'        ,0.2     ,2000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4248 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4253 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4255 ,'0.2'     ,'3000'        ,0.2     ,3000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4267 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4268 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4276 ,'0.25'    ,'2500'        ,0.25    ,2500        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4278 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4280 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4282 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4283 ,'0.1'     ,'2000'        ,0.1     ,2000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4286 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4289 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4292 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4293 ,'0.2'     ,'3000'        ,0.2     ,3000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4294 ,'0.4'     ,'4000'        ,0.4     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4295 ,'0.2'     ,'3000'        ,0.2     ,3000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4296 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6701 ,'0.2'     ,'3000'        ,0.2     ,3000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6702 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6703 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6704 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6705 ,'0.25'    ,'2500'        ,0.25    ,2500        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6706 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6707 ,'0.25'    ,'2500'        ,0.25    ,2500        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6708 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6709 ,'0.1'     ,'2000'        ,0.1     ,2000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6710 ,'0.2'     ,'3000'        ,0.2     ,3000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6711 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6712 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6713 ,'0.38'    ,'3800'        ,0.38    ,3800        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6714 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6715 ,'0.2'     ,'4000'        ,0.2     ,4000        ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4186 ,'0.2'     ,'3000'        ,0.2     ,3000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4203 ,'0.2'     ,'3000'        ,0.2     ,3000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4208 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4215 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4220 ,'0.1'     ,'2000'        ,0.1     ,2000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4221 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4236 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4239 ,'0.1'     ,'1500'        ,0.1     ,1500        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4242 ,'0.2'     ,'1200'        ,0.2     ,1200        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4244 ,'0.2'     ,'2000'        ,0.2     ,2000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4248 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4253 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4255 ,'0.2'     ,'3000'        ,0.2     ,3000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4267 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4268 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4276 ,'0.25'    ,'2500'        ,0.25    ,2500        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4278 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4280 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4282 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4283 ,'0.1'     ,'2000'        ,0.1     ,2000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4286 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4289 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4292 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4293 ,'0.2'     ,'3000'        ,0.2     ,3000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4294 ,'0.4'     ,'4000'        ,0.4     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4295 ,'0.2'     ,'3000'        ,0.2     ,3000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 4296 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6701 ,'0.2'     ,'3000'        ,0.2     ,3000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6702 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6703 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6704 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6705 ,'0.25'    ,'2500'        ,0.25    ,2500        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6706 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6707 ,'0.25'    ,'2500'        ,0.25    ,2500        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6708 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6709 ,'0.1'     ,'2000'        ,0.1     ,2000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6710 ,'0.2'     ,'3000'        ,0.2     ,3000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6711 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6712 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6713 ,'0.38'    ,'3800'        ,0.38    ,3800        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6714 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
SELECT 6715 ,'0.2'     ,'4000'        ,0.2     ,4000        ,2    UNION ALL	--RM	--RM , HKK
--RMB , HK$,CY
SELECT 4186 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4203 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4208 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4215 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4220 ,'0.1'     ,'3000'        ,0.1     ,3000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4221 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4236 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4239 ,'0.1'     ,'3000'        ,0.1     ,3000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4242 ,'0.2'     ,'3000'        ,0.2     ,3000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4244 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4248 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4253 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4255 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4267 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4268 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4276 ,'0.25'    ,'5000'        ,0.25    ,5000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4278 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4280 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4282 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4283 ,'0.1'     ,'3000'        ,0.1     ,3000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4286 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4289 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4292 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4293 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4294 ,'0.4'     ,'6000'        ,0.4     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4295 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4296 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6701 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6702 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6703 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6704 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6705 ,'0.25'    ,'5000'        ,0.25    ,5000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6706 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6707 ,'0.25'    ,'5000'        ,0.25    ,5000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6708 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6709 ,'0.1'     ,'3000'        ,0.1     ,3000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6710 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6711 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6712 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6713 ,'0.38'    ,'5700'        ,0.38    ,5700        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6714 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6715 ,'0.2'     ,'6000'        ,0.2     ,6000        ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4186 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4203 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4208 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4215 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4220 ,'0.1'     ,'3000'        ,0.1     ,3000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4221 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4236 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4239 ,'0.1'     ,'3000'        ,0.1     ,3000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4242 ,'0.2'     ,'3000'        ,0.2     ,3000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4244 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4248 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4253 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4255 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4267 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4268 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4276 ,'0.25'    ,'5000'        ,0.25    ,5000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4278 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4280 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4282 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4283 ,'0.1'     ,'3000'        ,0.1     ,3000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4286 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4289 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4292 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4293 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4294 ,'0.4'     ,'6000'        ,0.4     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4295 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4296 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6701 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6702 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6703 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6704 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6705 ,'0.25'    ,'5000'        ,0.25    ,5000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6706 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6707 ,'0.25'    ,'5000'        ,0.25    ,5000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6708 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6709 ,'0.1'     ,'3000'        ,0.1     ,3000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6710 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6711 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6712 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6713 ,'0.38'    ,'5700'        ,0.38    ,5700        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6714 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6715 ,'0.2'     ,'6000'        ,0.2     ,6000        ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4186 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4203 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4208 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4215 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4220 ,'0.1'     ,'3000'        ,0.1     ,3000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4221 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4236 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4239 ,'0.1'     ,'3000'        ,0.1     ,3000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4242 ,'0.2'     ,'3000'        ,0.2     ,3000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4244 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4248 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4253 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4255 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4267 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4268 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4276 ,'0.25'    ,'5000'        ,0.25    ,5000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4278 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4280 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4282 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4283 ,'0.1'     ,'3000'        ,0.1     ,3000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4286 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4289 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4292 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4293 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4294 ,'0.4'     ,'6000'        ,0.4     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4295 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4296 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6701 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6702 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6703 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6704 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6705 ,'0.25'    ,'5000'        ,0.25    ,5000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6706 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6707 ,'0.25'    ,'5000'        ,0.25    ,5000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6708 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6709 ,'0.1'     ,'3000'        ,0.1     ,3000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6710 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6711 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6712 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6713 ,'0.38'    ,'5700'        ,0.38    ,5700        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6714 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6715 ,'0.2'     ,'6000'        ,0.2     ,6000        ,13   UNION ALL	--RMB	--RMB , HK$,CY
--THB , TB
SELECT 4186 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4203 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4208 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4215 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4220 ,'0.1'     ,'10000'       ,0.1     ,10000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4221 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4236 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4239 ,'0.1'     ,'10000'       ,0.1     ,10000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4242 ,'0.2'     ,'12000'       ,0.2     ,12000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4244 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4248 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4253 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4255 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4267 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4268 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4276 ,'0.25'    ,'25000'       ,0.25    ,25000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4278 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4280 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4282 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4283 ,'0.1'     ,'10000'       ,0.1     ,10000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4286 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4289 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4292 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4293 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4294 ,'0.4'     ,'24000'       ,0.4     ,24000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4295 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 4296 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6701 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6702 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6703 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6704 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6705 ,'0.25'    ,'25000'       ,0.25    ,25000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6706 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6707 ,'0.25'    ,'25000'       ,0.25    ,25000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6708 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6709 ,'0.1'     ,'10000'       ,0.1     ,10000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6710 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6711 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6712 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6713 ,'0.38'    ,'22800'       ,0.38    ,22800       ,43   UNION ALL	--THB	--THB , TB
SELECT 6714 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
SELECT 6715 ,'0.2'     ,'20000'       ,0.2     ,20000       ,43   UNION ALL	--THB	--THB , TB
--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'1000'        ,0.2     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'1000'        ,0.2     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'1000'        ,0.1     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'500'         ,0.1     ,500         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'500'         ,0.2     ,500         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'800'         ,0.2     ,800         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'1000'        ,0.2     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'1000'        ,0.2     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'2000'        ,0.25    ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'1000'        ,0.1     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'1200'        ,0.2     ,1200        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'2000'        ,0.4     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'1000'        ,0.2     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'1000'        ,0.2     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'2000'        ,0.25    ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'2000'        ,0.25    ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'1000'        ,0.1     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'1000'        ,0.2     ,1000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'1900'        ,0.38    ,1900        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'2000'        ,0.2     ,2000        ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'1000'        ,0.2     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'1000'        ,0.2     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'1000'        ,0.1     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'500'         ,0.1     ,500         ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'500'         ,0.2     ,500         ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'800'         ,0.2     ,800         ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'1000'        ,0.2     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'1000'        ,0.2     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'2000'        ,0.25    ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'1000'        ,0.1     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'1200'        ,0.2     ,1200        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'2000'        ,0.4     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'1000'        ,0.2     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'1000'        ,0.2     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'2000'        ,0.25    ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'2000'        ,0.25    ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'1000'        ,0.1     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'1000'        ,0.2     ,1000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'1900'        ,0.38    ,1900        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'2000'        ,0.2     ,2000        ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'1000'        ,0.2     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'1000'        ,0.2     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'1000'        ,0.1     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'500'         ,0.1     ,500         ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'500'         ,0.2     ,500         ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'800'         ,0.2     ,800         ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'1000'        ,0.2     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'1000'        ,0.2     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'2000'        ,0.25    ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'1000'        ,0.1     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'1200'        ,0.2     ,1200        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'2000'        ,0.4     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'1000'        ,0.2     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'1000'        ,0.2     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'2000'        ,0.25    ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'2000'        ,0.25    ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'1000'        ,0.1     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'1000'        ,0.2     ,1000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'1900'        ,0.38    ,1900        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'2000'        ,0.2     ,2000        ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'1000'        ,0.2     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'1000'        ,0.2     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'1000'        ,0.1     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'500'         ,0.1     ,500         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'500'         ,0.2     ,500         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'800'         ,0.2     ,800         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'1000'        ,0.2     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'1000'        ,0.2     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'2000'        ,0.25    ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'1000'        ,0.1     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'1200'        ,0.2     ,1200        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'2000'        ,0.4     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'1000'        ,0.2     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'1000'        ,0.2     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'2000'        ,0.25    ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'2000'        ,0.25    ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'1000'        ,0.1     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'1000'        ,0.2     ,1000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'1900'        ,0.38    ,1900        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'2000'        ,0.2     ,2000        ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'1000'        ,0.2     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'1000'        ,0.2     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'1000'        ,0.1     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'500'         ,0.1     ,500         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'500'         ,0.2     ,500         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'800'         ,0.2     ,800         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'1000'        ,0.2     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'1000'        ,0.2     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'2000'        ,0.25    ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'1000'        ,0.1     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'1200'        ,0.2     ,1200        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'2000'        ,0.4     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'1000'        ,0.2     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'1000'        ,0.2     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'2000'        ,0.25    ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'2000'        ,0.25    ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'1000'        ,0.1     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'1000'        ,0.2     ,1000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'1900'        ,0.38    ,1900        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'2000'        ,0.2     ,2000        ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'1000'        ,0.2     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'1000'        ,0.2     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'1000'        ,0.1     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'500'         ,0.1     ,500         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'500'         ,0.2     ,500         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'800'         ,0.2     ,800         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'1000'        ,0.2     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'1000'        ,0.2     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'2000'        ,0.25    ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'1000'        ,0.1     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'1200'        ,0.2     ,1200        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'2000'        ,0.4     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'1000'        ,0.2     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'1000'        ,0.2     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'2000'        ,0.25    ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'2000'        ,0.25    ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'1000'        ,0.1     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'1000'        ,0.2     ,1000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'1900'        ,0.38    ,1900        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'2000'        ,0.2     ,2000        ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'1000'        ,0.2     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'1000'        ,0.2     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'1000'        ,0.1     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'500'         ,0.1     ,500         ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'500'         ,0.2     ,500         ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'800'         ,0.2     ,800         ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'1000'        ,0.2     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'1000'        ,0.2     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'2000'        ,0.25    ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'1000'        ,0.1     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'1200'        ,0.2     ,1200        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'2000'        ,0.4     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'1000'        ,0.2     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'1000'        ,0.2     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'2000'        ,0.25    ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'2000'        ,0.25    ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'1000'        ,0.1     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'1000'        ,0.2     ,1000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'1900'        ,0.38    ,1900        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'2000'        ,0.2     ,2000        ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
--WON , KRW
SELECT 4186 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4203 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4208 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4215 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4220 ,'40'      ,'500000'      ,40      ,500000      ,45   UNION ALL	--Won	--WON , KRW
SELECT 4221 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4236 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4239 ,'40'      ,'500000'      ,40      ,500000      ,45   UNION ALL	--Won	--WON , KRW
SELECT 4242 ,'80'      ,'400000'      ,80      ,400000      ,45   UNION ALL	--Won	--WON , KRW
SELECT 4244 ,'80'      ,'800000'      ,80      ,800000      ,45   UNION ALL	--Won	--WON , KRW
SELECT 4248 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4253 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4255 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4267 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4268 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4276 ,'100'     ,'1000000'     ,100     ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4278 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4280 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4282 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4283 ,'40'      ,'500000'      ,40      ,500000      ,45   UNION ALL	--Won	--WON , KRW
SELECT 4286 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4289 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4292 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4293 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4294 ,'160'     ,'800000'      ,160     ,800000      ,45   UNION ALL	--Won	--WON , KRW
SELECT 4295 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 4296 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6701 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6702 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6703 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6704 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6705 ,'100'     ,'1000000'     ,100     ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6706 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6707 ,'100'     ,'1000000'     ,100     ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6708 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6709 ,'40'      ,'500000'      ,40      ,500000      ,45   UNION ALL	--Won	--WON , KRW
SELECT 6710 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6711 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6712 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6713 ,'152'     ,'1140000'     ,152     ,1140000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6714 ,'80'      ,'1000000'     ,80      ,1000000     ,45   UNION ALL	--Won	--WON , KRW
SELECT 6715 ,'80'      ,'1000000'     ,80      ,1000000     ,45				--Won	--WON , KRW

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999	

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999999	
	
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