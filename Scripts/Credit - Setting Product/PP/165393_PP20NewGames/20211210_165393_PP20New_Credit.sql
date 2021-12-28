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
SELECT 4186 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4203 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4208 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4215 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4220 ,'0.1'     ,'3'           ,0.1     ,3           ,12   UNION ALL	--GBP	--GBP
SELECT 4221 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4236 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4239 ,'0.1'     ,'3'           ,0.1     ,3           ,12   UNION ALL	--GBP	--GBP
SELECT 4242 ,'0.2'     ,'2'           ,0.2     ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4244 ,'0.2'     ,'5'           ,0.2     ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 4248 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4253 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4255 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4267 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4268 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4276 ,'0.25'    ,'7.5'         ,0.25    ,7.5         ,12   UNION ALL	--GBP	--GBP
SELECT 4278 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4280 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4282 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4283 ,'0.1'     ,'3'           ,0.1     ,3           ,12   UNION ALL	--GBP	--GBP
SELECT 4286 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4289 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4292 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4293 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4294 ,'0.4'     ,'6'           ,0.4     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4295 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 4296 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6701 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6702 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6703 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6704 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6705 ,'0.25'    ,'7.5'         ,0.25    ,7.5         ,12   UNION ALL	--GBP	--GBP
SELECT 6706 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6707 ,'0.25'    ,'7.5'         ,0.25    ,7.5         ,12   UNION ALL	--GBP	--GBP
SELECT 6708 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6709 ,'0.1'     ,'3'           ,0.1     ,3           ,12   UNION ALL	--GBP	--GBP
SELECT 6710 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6711 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6712 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6713 ,'0.38'    ,'5.7'         ,0.38    ,5.7         ,12   UNION ALL	--GBP	--GBP
SELECT 6714 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6715 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'50'          ,0.1     ,50          ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'50'          ,0.1     ,50          ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'40'          ,0.2     ,40          ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'125'         ,0.25    ,125         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'50'          ,0.1     ,50          ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'120'         ,0.4     ,120         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'125'         ,0.25    ,125         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'125'         ,0.25    ,125         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'50'          ,0.1     ,50          ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'114'         ,0.38    ,114         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'50'          ,0.1     ,50          ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'50'          ,0.1     ,50          ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'40'          ,0.2     ,40          ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'125'         ,0.25    ,125         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'50'          ,0.1     ,50          ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'120'         ,0.4     ,120         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'125'         ,0.25    ,125         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'125'         ,0.25    ,125         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'50'          ,0.1     ,50          ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'114'         ,0.38    ,114         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'50'          ,0.1     ,50          ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'50'          ,0.1     ,50          ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'40'          ,0.2     ,40          ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'125'         ,0.25    ,125         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'50'          ,0.1     ,50          ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'120'         ,0.4     ,120         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'125'         ,0.25    ,125         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'125'         ,0.25    ,125         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'50'          ,0.1     ,50          ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'114'         ,0.38    ,114         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'50'          ,0.1     ,50          ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'50'          ,0.1     ,50          ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'40'          ,0.2     ,40          ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'125'         ,0.25    ,125         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'50'          ,0.1     ,50          ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'120'         ,0.4     ,120         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'125'         ,0.25    ,125         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'125'         ,0.25    ,125         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'50'          ,0.1     ,50          ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'114'         ,0.38    ,114         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4186 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4203 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4208 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4215 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4220 ,'0.1'     ,'50'          ,0.1     ,50          ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4221 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4236 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4239 ,'0.1'     ,'50'          ,0.1     ,50          ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4242 ,'0.2'     ,'40'          ,0.2     ,40          ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4244 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4248 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4253 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4255 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'0.25'    ,'125'         ,0.25    ,125         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.1'     ,'50'          ,0.1     ,50          ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4292 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4293 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4294 ,'0.4'     ,'120'         ,0.4     ,120         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4295 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4296 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6701 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6702 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6703 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6704 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6705 ,'0.25'    ,'125'         ,0.25    ,125         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6706 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6707 ,'0.25'    ,'125'         ,0.25    ,125         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6708 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6709 ,'0.1'     ,'50'          ,0.1     ,50          ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6710 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6711 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6712 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6713 ,'0.38'    ,'114'         ,0.38    ,114         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6714 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6715 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
--INH
SELECT 4186 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4203 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4208 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4215 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4220 ,'0.1'     ,'80'          ,0.1     ,80          ,51   UNION ALL	--INH	--INH
SELECT 4221 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4236 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4239 ,'0.1'     ,'80'          ,0.1     ,80          ,51   UNION ALL	--INH	--INH
SELECT 4242 ,'0.2'     ,'80'          ,0.2     ,80          ,51   UNION ALL	--INH	--INH
SELECT 4244 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4248 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4253 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4255 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4267 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4268 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4276 ,'0.25'    ,'200'         ,0.25    ,200         ,51   UNION ALL	--INH	--INH
SELECT 4278 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4280 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4282 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4283 ,'0.1'     ,'80'          ,0.1     ,80          ,51   UNION ALL	--INH	--INH
SELECT 4286 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4289 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4292 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4293 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4294 ,'0.4'     ,'160'         ,0.4     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4295 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 4296 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6701 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6702 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6703 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6704 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6705 ,'0.25'    ,'200'         ,0.25    ,200         ,51   UNION ALL	--INH	--INH
SELECT 6706 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6707 ,'0.25'    ,'200'         ,0.25    ,200         ,51   UNION ALL	--INH	--INH
SELECT 6708 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6709 ,'0.1'     ,'80'          ,0.1     ,80          ,51   UNION ALL	--INH	--INH
SELECT 6710 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6711 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6712 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6713 ,'0.38'    ,'152'         ,0.38    ,152         ,51   UNION ALL	--INH	--INH
SELECT 6714 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6715 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
--RM , HKK
SELECT 4186 ,'0.2'     ,'30'          ,0.2     ,30          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4203 ,'0.2'     ,'30'          ,0.2     ,30          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4208 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4215 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4220 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4221 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4236 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4239 ,'0.1'     ,'15'          ,0.1     ,15          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4242 ,'0.2'     ,'12'          ,0.2     ,12          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4244 ,'0.2'     ,'20'          ,0.2     ,20          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4248 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4253 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4255 ,'0.2'     ,'30'          ,0.2     ,30          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4267 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4268 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4276 ,'0.25'    ,'25'          ,0.25    ,25          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4278 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4280 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4282 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4283 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4286 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4289 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4292 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4293 ,'0.2'     ,'30'          ,0.2     ,30          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4294 ,'0.4'     ,'40'          ,0.4     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4295 ,'0.2'     ,'30'          ,0.2     ,30          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4296 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6701 ,'0.2'     ,'30'          ,0.2     ,30          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6702 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6703 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6704 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6705 ,'0.25'    ,'25'          ,0.25    ,25          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6706 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6707 ,'0.25'    ,'25'          ,0.25    ,25          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6708 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6709 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6710 ,'0.2'     ,'30'          ,0.2     ,30          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6711 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6712 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6713 ,'0.38'    ,'38'          ,0.38    ,38          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6714 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6715 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4186 ,'0.2'     ,'30'          ,0.2     ,30          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4203 ,'0.2'     ,'30'          ,0.2     ,30          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4208 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4215 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4220 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4221 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4236 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4239 ,'0.1'     ,'15'          ,0.1     ,15          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4242 ,'0.2'     ,'12'          ,0.2     ,12          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4244 ,'0.2'     ,'20'          ,0.2     ,20          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4248 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4253 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4255 ,'0.2'     ,'30'          ,0.2     ,30          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4267 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4268 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4276 ,'0.25'    ,'25'          ,0.25    ,25          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4278 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4280 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4282 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4283 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4286 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4289 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4292 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4293 ,'0.2'     ,'30'          ,0.2     ,30          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4294 ,'0.4'     ,'40'          ,0.4     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4295 ,'0.2'     ,'30'          ,0.2     ,30          ,2    UNION ALL	--RM	--RM , HKK
SELECT 4296 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6701 ,'0.2'     ,'30'          ,0.2     ,30          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6702 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6703 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6704 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6705 ,'0.25'    ,'25'          ,0.25    ,25          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6706 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6707 ,'0.25'    ,'25'          ,0.25    ,25          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6708 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6709 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6710 ,'0.2'     ,'30'          ,0.2     ,30          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6711 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6712 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6713 ,'0.38'    ,'38'          ,0.38    ,38          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6714 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6715 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
--RMB , HK$,CY
SELECT 4186 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4203 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4208 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4215 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4220 ,'0.1'     ,'30'          ,0.1     ,30          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4221 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4236 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4239 ,'0.1'     ,'30'          ,0.1     ,30          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4242 ,'0.2'     ,'30'          ,0.2     ,30          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4244 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4248 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4253 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4255 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4267 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4268 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4276 ,'0.25'    ,'50'          ,0.25    ,50          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4278 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4280 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4282 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4283 ,'0.1'     ,'30'          ,0.1     ,30          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4286 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4289 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4292 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4293 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4294 ,'0.4'     ,'60'          ,0.4     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4295 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4296 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6701 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6702 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6703 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6704 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6705 ,'0.25'    ,'50'          ,0.25    ,50          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6706 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6707 ,'0.25'    ,'50'          ,0.25    ,50          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6708 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6709 ,'0.1'     ,'30'          ,0.1     ,30          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6710 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6711 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6712 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6713 ,'0.38'    ,'57'          ,0.38    ,57          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6714 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6715 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4186 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4203 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4208 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4215 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4220 ,'0.1'     ,'30'          ,0.1     ,30          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4221 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4236 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4239 ,'0.1'     ,'30'          ,0.1     ,30          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4242 ,'0.2'     ,'30'          ,0.2     ,30          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4244 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4248 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4253 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4255 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4267 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4268 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4276 ,'0.25'    ,'50'          ,0.25    ,50          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4278 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4280 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4282 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4283 ,'0.1'     ,'30'          ,0.1     ,30          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4286 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4289 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4292 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4293 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4294 ,'0.4'     ,'60'          ,0.4     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4295 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4296 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6701 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6702 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6703 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6704 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6705 ,'0.25'    ,'50'          ,0.25    ,50          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6706 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6707 ,'0.25'    ,'50'          ,0.25    ,50          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6708 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6709 ,'0.1'     ,'30'          ,0.1     ,30          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6710 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6711 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6712 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6713 ,'0.38'    ,'57'          ,0.38    ,57          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6714 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6715 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4186 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4203 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4208 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4215 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4220 ,'0.1'     ,'30'          ,0.1     ,30          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4221 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4236 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4239 ,'0.1'     ,'30'          ,0.1     ,30          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4242 ,'0.2'     ,'30'          ,0.2     ,30          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4244 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4248 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4253 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4255 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4267 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4268 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4276 ,'0.25'    ,'50'          ,0.25    ,50          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4278 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4280 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4282 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4283 ,'0.1'     ,'30'          ,0.1     ,30          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4286 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4289 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4292 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4293 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4294 ,'0.4'     ,'60'          ,0.4     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4295 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4296 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6701 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6702 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6703 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6704 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6705 ,'0.25'    ,'50'          ,0.25    ,50          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6706 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6707 ,'0.25'    ,'50'          ,0.25    ,50          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6708 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6709 ,'0.1'     ,'30'          ,0.1     ,30          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6710 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6711 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6712 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6713 ,'0.38'    ,'57'          ,0.38    ,57          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6714 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6715 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
--THB , TB
SELECT 4186 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4203 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4208 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4215 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4220 ,'0.1'     ,'100'         ,0.1     ,100         ,43   UNION ALL	--THB	--THB , TB
SELECT 4221 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4236 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4239 ,'0.1'     ,'100'         ,0.1     ,100         ,43   UNION ALL	--THB	--THB , TB
SELECT 4242 ,'0.2'     ,'120'         ,0.2     ,120         ,43   UNION ALL	--THB	--THB , TB
SELECT 4244 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4248 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4253 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4255 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4267 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4268 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4276 ,'0.25'    ,'250'         ,0.25    ,250         ,43   UNION ALL	--THB	--THB , TB
SELECT 4278 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4280 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4282 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4283 ,'0.1'     ,'100'         ,0.1     ,100         ,43   UNION ALL	--THB	--THB , TB
SELECT 4286 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4289 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4292 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4293 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4294 ,'0.4'     ,'240'         ,0.4     ,240         ,43   UNION ALL	--THB	--THB , TB
SELECT 4295 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 4296 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6701 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6702 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6703 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6704 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6705 ,'0.25'    ,'250'         ,0.25    ,250         ,43   UNION ALL	--THB	--THB , TB
SELECT 6706 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6707 ,'0.25'    ,'250'         ,0.25    ,250         ,43   UNION ALL	--THB	--THB , TB
SELECT 6708 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6709 ,'0.1'     ,'100'         ,0.1     ,100         ,43   UNION ALL	--THB	--THB , TB
SELECT 6710 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6711 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6712 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6713 ,'0.38'    ,'228'         ,0.38    ,228         ,43   UNION ALL	--THB	--THB , TB
SELECT 6714 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6715 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'10'          ,0.2     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'10'          ,0.2     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'10'          ,0.1     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'5'           ,0.1     ,5           ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'5'           ,0.2     ,5           ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'8'           ,0.2     ,8           ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'10'          ,0.2     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'10'          ,0.2     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'20'          ,0.25    ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'10'          ,0.1     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'12'          ,0.2     ,12          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'20'          ,0.4     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'10'          ,0.2     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'10'          ,0.2     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'20'          ,0.25    ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'20'          ,0.25    ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'10'          ,0.1     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'10'          ,0.2     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'19'          ,0.38    ,19          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'10'          ,0.2     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'10'          ,0.2     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'10'          ,0.1     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'5'           ,0.1     ,5           ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'5'           ,0.2     ,5           ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'8'           ,0.2     ,8           ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'10'          ,0.2     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'10'          ,0.2     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'20'          ,0.25    ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'10'          ,0.1     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'12'          ,0.2     ,12          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'20'          ,0.4     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'10'          ,0.2     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'10'          ,0.2     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'20'          ,0.25    ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'20'          ,0.25    ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'10'          ,0.1     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'10'          ,0.2     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'19'          ,0.38    ,19          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'10'          ,0.2     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'10'          ,0.2     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'10'          ,0.1     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'5'           ,0.1     ,5           ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'5'           ,0.2     ,5           ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'8'           ,0.2     ,8           ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'10'          ,0.2     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'10'          ,0.2     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'20'          ,0.25    ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'10'          ,0.1     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'12'          ,0.2     ,12          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'20'          ,0.4     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'10'          ,0.2     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'10'          ,0.2     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'20'          ,0.25    ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'20'          ,0.25    ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'10'          ,0.1     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'10'          ,0.2     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'19'          ,0.38    ,19          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'10'          ,0.2     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'10'          ,0.2     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'10'          ,0.1     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'5'           ,0.1     ,5           ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'5'           ,0.2     ,5           ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'8'           ,0.2     ,8           ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'10'          ,0.2     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'10'          ,0.2     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'20'          ,0.25    ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'10'          ,0.1     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'12'          ,0.2     ,12          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'20'          ,0.4     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'10'          ,0.2     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'10'          ,0.2     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'20'          ,0.25    ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'20'          ,0.25    ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'10'          ,0.1     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'10'          ,0.2     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'19'          ,0.38    ,19          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'10'          ,0.2     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'10'          ,0.2     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'10'          ,0.1     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'5'           ,0.1     ,5           ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'5'           ,0.2     ,5           ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'8'           ,0.2     ,8           ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'10'          ,0.2     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'10'          ,0.2     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'20'          ,0.25    ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'10'          ,0.1     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'12'          ,0.2     ,12          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'20'          ,0.4     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'10'          ,0.2     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'10'          ,0.2     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'20'          ,0.25    ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'20'          ,0.25    ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'10'          ,0.1     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'10'          ,0.2     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'19'          ,0.38    ,19          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'10'          ,0.2     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'10'          ,0.2     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'10'          ,0.1     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'5'           ,0.1     ,5           ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'5'           ,0.2     ,5           ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'8'           ,0.2     ,8           ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'10'          ,0.2     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'10'          ,0.2     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'20'          ,0.25    ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'10'          ,0.1     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'12'          ,0.2     ,12          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'20'          ,0.4     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'10'          ,0.2     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'10'          ,0.2     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'20'          ,0.25    ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'20'          ,0.25    ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'10'          ,0.1     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'10'          ,0.2     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'19'          ,0.38    ,19          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'10'          ,0.2     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'10'          ,0.2     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'10'          ,0.1     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'5'           ,0.1     ,5           ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'5'           ,0.2     ,5           ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'8'           ,0.2     ,8           ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'10'          ,0.2     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'10'          ,0.2     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'20'          ,0.25    ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'10'          ,0.1     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'12'          ,0.2     ,12          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'20'          ,0.4     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'10'          ,0.2     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'10'          ,0.2     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'20'          ,0.25    ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'20'          ,0.25    ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'10'          ,0.1     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'10'          ,0.2     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'19'          ,0.38    ,19          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
--WON , KRW
SELECT 4186 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4203 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4208 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4215 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4220 ,'40'      ,'5000'        ,40      ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4221 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4236 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4239 ,'40'      ,'5000'        ,40      ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4242 ,'80'      ,'4000'        ,80      ,4000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4244 ,'80'      ,'8000'        ,80      ,8000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4248 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4253 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4255 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4267 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4268 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4276 ,'100'     ,'10000'       ,100     ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4278 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4280 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4282 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4283 ,'40'      ,'5000'        ,40      ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4286 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4289 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4292 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4293 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4294 ,'160'     ,'8000'        ,160     ,8000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4295 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4296 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6701 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6702 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6703 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6704 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6705 ,'100'     ,'10000'       ,100     ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6706 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6707 ,'100'     ,'10000'       ,100     ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6708 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6709 ,'40'      ,'5000'        ,40      ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6710 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6711 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6712 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6713 ,'152'     ,'11400'       ,152     ,11400       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6714 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6715 ,'80'      ,'10000'       ,80      ,10000       ,45				--Won	--WON , KRW

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