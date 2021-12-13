/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211210
	Created: Winfred 
	Task: #165393 - Pragmatic - Integrate 20 new games for Deposit [Redmine:165393]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--GBP
SELECT 4186 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4203 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4208 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4215 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4220 ,'0.1'         ,'200'            ,0.1         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4221 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 4236 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4239 ,'0.1'         ,'200'            ,0.1         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4244 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4248 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4253 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4255 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4267 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 4268 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 4276 ,'0.25'        ,'250'            ,0.25        ,250            ,12   UNION ALL	--GBP	--GBP
SELECT 4278 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 4280 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 4282 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 4283 ,'0.1'         ,'200'            ,0.1         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4286 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 4289 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 4292 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 4293 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4294 ,'0.4'         ,'800'            ,0.4         ,800            ,12   UNION ALL	--GBP	--GBP
SELECT 4295 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 4296 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 6701 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 6702 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 6703 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 6704 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 6705 ,'0.25'        ,'500'            ,0.25        ,500            ,12   UNION ALL	--GBP	--GBP
SELECT 6706 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 6707 ,'0.25'        ,'500'            ,0.25        ,500            ,12   UNION ALL	--GBP	--GBP
SELECT 6708 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 6709 ,'0.1'         ,'200'            ,0.1         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 6710 ,'0.2'         ,'200'            ,0.2         ,200            ,12   UNION ALL	--GBP	--GBP
SELECT 6711 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 6712 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 6713 ,'0.38'        ,'380'            ,0.38        ,380            ,12   UNION ALL	--GBP	--GBP
SELECT 6714 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
SELECT 6715 ,'0.2'         ,'400'            ,0.2         ,400            ,12   UNION ALL	--GBP	--GBP
--IN,IDR
SELECT 4186 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4203 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4208 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4215 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4220 ,'0.1'         ,'1000'           ,0.1         ,1000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4221 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4236 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4239 ,'0.1'         ,'1000'           ,0.1         ,1000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4242 ,'0.2'         ,'1000'           ,0.2         ,1000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4244 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4248 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4253 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4255 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4267 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4268 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4276 ,'0.25'        ,'2500'           ,0.25        ,2500           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4278 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4280 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4282 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4283 ,'0.1'         ,'1000'           ,0.1         ,1000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4286 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4289 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4292 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4293 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4294 ,'0.4'         ,'4000'           ,0.4         ,4000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4295 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 4296 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6701 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6702 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6703 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6704 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6705 ,'0.25'        ,'2500'           ,0.25        ,2500           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6706 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6707 ,'0.25'        ,'2500'           ,0.25        ,2500           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6708 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6709 ,'0.1'         ,'1000'           ,0.1         ,1000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6710 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6711 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6712 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6713 ,'0.38'        ,'3800'           ,0.38        ,3800           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6714 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
SELECT 6715 ,'0.2'         ,'2000'           ,0.2         ,2000           ,15   UNION ALL	--IN	--IN,IDR
--INH,VND
SELECT 4186 ,'0.2'         ,'3000'           ,0.2         ,3000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4203 ,'0.2'         ,'4000'           ,0.2         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4208 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4215 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4220 ,'0.1'         ,'4000'           ,0.1         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4221 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4236 ,'0.2'         ,'4000'           ,0.2         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4239 ,'0.1'         ,'2000'           ,0.1         ,2000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4242 ,'0.2'         ,'2000'           ,0.2         ,2000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4244 ,'0.2'         ,'3000'           ,0.2         ,3000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4248 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4253 ,'0.2'         ,'4000'           ,0.2         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4255 ,'0.2'         ,'4000'           ,0.2         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4267 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4268 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4276 ,'0.25'        ,'5000'           ,0.25        ,5000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4278 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4280 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4282 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4283 ,'0.1'         ,'4000'           ,0.1         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4286 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4289 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4292 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4293 ,'0.2'         ,'4000'           ,0.2         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4294 ,'0.4'         ,'16000'          ,0.4         ,16000          ,51   UNION ALL	--INH	--INH,VND
SELECT 4295 ,'0.2'         ,'4000'           ,0.2         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 4296 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6701 ,'0.2'         ,'4000'           ,0.2         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6702 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6703 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6704 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6705 ,'0.25'        ,'10000'          ,0.25        ,10000          ,51   UNION ALL	--INH	--INH,VND
SELECT 6706 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6707 ,'0.25'        ,'10000'          ,0.25        ,10000          ,51   UNION ALL	--INH	--INH,VND
SELECT 6708 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6709 ,'0.1'         ,'4000'           ,0.1         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6710 ,'0.2'         ,'4000'           ,0.2         ,4000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6711 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6712 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6713 ,'0.38'        ,'3800'           ,0.38        ,3800           ,51   UNION ALL	--INH	--INH,VND
SELECT 6714 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
SELECT 6715 ,'0.2'         ,'8000'           ,0.2         ,8000           ,51   UNION ALL	--INH	--INH,VND
--INR, RUB
SELECT 4186 ,'1'           ,'12000'          ,1           ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4203 ,'1'           ,'12000'          ,1           ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4208 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4215 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4220 ,'0.5'         ,'12000'          ,0.5         ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4221 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4236 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4239 ,'0.5'         ,'6000'           ,0.5         ,6000           ,61   UNION ALL	--INR	--INR, RUB
SELECT 4242 ,'1'           ,'4000'           ,1           ,4000           ,61   UNION ALL	--INR	--INR, RUB
SELECT 4244 ,'1'           ,'8000'           ,1           ,8000           ,61   UNION ALL	--INR	--INR, RUB
SELECT 4248 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4253 ,'1'           ,'12000'          ,1           ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4255 ,'1'           ,'12000'          ,1           ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4267 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4268 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4276 ,'1.25'        ,'20000'          ,1.25        ,20000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4278 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4280 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4282 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4283 ,'0.5'         ,'12000'          ,0.5         ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4286 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4289 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4292 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4293 ,'1'           ,'12000'          ,1           ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4294 ,'2'           ,'48000'          ,2           ,48000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4295 ,'1'           ,'12000'          ,1           ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4296 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6701 ,'1'           ,'12000'          ,1           ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6702 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6703 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6704 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6705 ,'1.25'        ,'30000'          ,1.25        ,30000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6706 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6707 ,'1.25'        ,'30000'          ,1.25        ,30000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6708 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6709 ,'0.5'         ,'12000'          ,0.5         ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6710 ,'1'           ,'12000'          ,1           ,12000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6711 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6712 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6713 ,'1.9'         ,'7600'           ,1.9         ,7600           ,61   UNION ALL	--INR	--INR, RUB
SELECT 6714 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6715 ,'1'           ,'24000'          ,1           ,24000          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4186 ,'1'           ,'12000'          ,1           ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4203 ,'1'           ,'12000'          ,1           ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4208 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4215 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4220 ,'0.5'         ,'12000'          ,0.5         ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4221 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4236 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4239 ,'0.5'         ,'6000'           ,0.5         ,6000           ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4242 ,'1'           ,'4000'           ,1           ,4000           ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4244 ,'1'           ,'8000'           ,1           ,8000           ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4248 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4253 ,'1'           ,'12000'          ,1           ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4255 ,'1'           ,'12000'          ,1           ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4267 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4268 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4276 ,'1.25'        ,'20000'          ,1.25        ,20000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4278 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4280 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4282 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4283 ,'0.5'         ,'12000'          ,0.5         ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4286 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4289 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4292 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4293 ,'1'           ,'12000'          ,1           ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4294 ,'2'           ,'48000'          ,2           ,48000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4295 ,'1'           ,'12000'          ,1           ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4296 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6701 ,'1'           ,'12000'          ,1           ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6702 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6703 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6704 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6705 ,'1.25'        ,'30000'          ,1.25        ,30000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6706 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6707 ,'1.25'        ,'30000'          ,1.25        ,30000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6708 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6709 ,'0.5'         ,'12000'          ,0.5         ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6710 ,'1'           ,'12000'          ,1           ,12000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6711 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6712 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6713 ,'1.9'         ,'7600'           ,1.9         ,7600           ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6714 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6715 ,'1'           ,'24000'          ,1           ,24000          ,55   UNION ALL	--RUB	--INR, RUB
--JPY
SELECT 4186 ,'10'          ,'20000'          ,10          ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 4203 ,'10'          ,'20000'          ,10          ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 4208 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4215 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4220 ,'5'           ,'20000'          ,5           ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 4221 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4236 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4239 ,'5'           ,'10000'          ,5           ,10000          ,32   UNION ALL	--JPY	--JPY
SELECT 4242 ,'10'          ,'10000'          ,10          ,10000          ,32   UNION ALL	--JPY	--JPY
SELECT 4244 ,'10'          ,'10000'          ,10          ,10000          ,32   UNION ALL	--JPY	--JPY
SELECT 4248 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4253 ,'10'          ,'20000'          ,10          ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 4255 ,'10'          ,'20000'          ,10          ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 4267 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4268 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4276 ,'12.5'        ,'20000'          ,12.5        ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 4278 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4280 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4282 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4283 ,'5'           ,'20000'          ,5           ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 4286 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4289 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4292 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 4293 ,'10'          ,'20000'          ,10          ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 4294 ,'20'          ,'80000'          ,20          ,80000          ,32   UNION ALL	--JPY	--JPY
SELECT 4295 ,'10'          ,'20000'          ,10          ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 4296 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 6701 ,'10'          ,'20000'          ,10          ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 6702 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 6703 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 6704 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 6705 ,'12.5'        ,'50000'          ,12.5        ,50000          ,32   UNION ALL	--JPY	--JPY
SELECT 6706 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 6707 ,'12.5'        ,'50000'          ,12.5        ,50000          ,32   UNION ALL	--JPY	--JPY
SELECT 6708 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 6709 ,'5'           ,'20000'          ,5           ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 6710 ,'10'          ,'20000'          ,10          ,20000          ,32   UNION ALL	--JPY	--JPY
SELECT 6711 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 6712 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 6713 ,'19'          ,'38000'          ,19          ,38000          ,32   UNION ALL	--JPY	--JPY
SELECT 6714 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
SELECT 6715 ,'10'          ,'40000'          ,10          ,40000          ,32   UNION ALL	--JPY	--JPY
--RM, MYR,  PLN, KHR
SELECT 4186 ,'0.2'         ,'600'            ,0.2         ,600            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4203 ,'0.2'         ,'600'            ,0.2         ,600            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4208 ,'0.2'         ,'1200'           ,0.2         ,1200           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4215 ,'0.2'         ,'1200'           ,0.2         ,1200           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4220 ,'0.1'         ,'800'            ,0.1         ,800            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4221 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4236 ,'0.2'         ,'1200'           ,0.2         ,1200           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4239 ,'0.1'         ,'300'            ,0.1         ,300            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4244 ,'0.2'         ,'400'            ,0.2         ,400            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4248 ,'0.2'         ,'1200'           ,0.2         ,1200           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4253 ,'0.2'         ,'800'            ,0.2         ,800            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4255 ,'0.2'         ,'600'            ,0.2         ,600            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4267 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4268 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4276 ,'0.25'        ,'1500'           ,0.25        ,1500           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4278 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4280 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4282 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4283 ,'0.1'         ,'800'            ,0.1         ,800            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4286 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4289 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4292 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4293 ,'0.2'         ,'600'            ,0.2         ,600            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4294 ,'0.4'         ,'3200'           ,0.4         ,3200           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4295 ,'0.2'         ,'600'            ,0.2         ,600            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4296 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6701 ,'0.2'         ,'600'            ,0.2         ,600            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6702 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6703 ,'0.2'         ,'1200'           ,0.2         ,1200           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6704 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6705 ,'0.25'        ,'2000'           ,0.25        ,2000           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6706 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6707 ,'0.25'        ,'2000'           ,0.25        ,2000           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6708 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6709 ,'0.1'         ,'800'            ,0.1         ,800            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6710 ,'0.2'         ,'600'            ,0.2         ,600            ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6711 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6712 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6713 ,'0.38'        ,'1520'           ,0.38        ,1520           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6714 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6715 ,'0.2'         ,'1600'           ,0.2         ,1600           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4186 ,'0.2'         ,'600'            ,0.2         ,600            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4203 ,'0.2'         ,'600'            ,0.2         ,600            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4208 ,'0.2'         ,'1200'           ,0.2         ,1200           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4215 ,'0.2'         ,'1200'           ,0.2         ,1200           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4220 ,'0.1'         ,'800'            ,0.1         ,800            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4221 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4236 ,'0.2'         ,'1200'           ,0.2         ,1200           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4239 ,'0.1'         ,'300'            ,0.1         ,300            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4244 ,'0.2'         ,'400'            ,0.2         ,400            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4248 ,'0.2'         ,'1200'           ,0.2         ,1200           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4253 ,'0.2'         ,'800'            ,0.2         ,800            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4255 ,'0.2'         ,'600'            ,0.2         ,600            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4267 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4268 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4276 ,'0.25'        ,'1500'           ,0.25        ,1500           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4278 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4280 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4282 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4283 ,'0.1'         ,'800'            ,0.1         ,800            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4286 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4289 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4292 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4293 ,'0.2'         ,'600'            ,0.2         ,600            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4294 ,'0.4'         ,'3200'           ,0.4         ,3200           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4295 ,'0.2'         ,'600'            ,0.2         ,600            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4296 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6701 ,'0.2'         ,'600'            ,0.2         ,600            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6702 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6703 ,'0.2'         ,'1200'           ,0.2         ,1200           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6704 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6705 ,'0.25'        ,'2000'           ,0.25        ,2000           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6706 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6707 ,'0.25'        ,'2000'           ,0.25        ,2000           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6708 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6709 ,'0.1'         ,'800'            ,0.1         ,800            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6710 ,'0.2'         ,'600'            ,0.2         ,600            ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6711 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6712 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6713 ,'0.38'        ,'1520'           ,0.38        ,1520           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6714 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6715 ,'0.2'         ,'1600'           ,0.2         ,1600           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4186 ,'0.2'         ,'600'            ,0.2         ,600            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4203 ,'0.2'         ,'600'            ,0.2         ,600            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4208 ,'0.2'         ,'1200'           ,0.2         ,1200           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4215 ,'0.2'         ,'1200'           ,0.2         ,1200           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4220 ,'0.1'         ,'800'            ,0.1         ,800            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4221 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4236 ,'0.2'         ,'1200'           ,0.2         ,1200           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4239 ,'0.1'         ,'300'            ,0.1         ,300            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4244 ,'0.2'         ,'400'            ,0.2         ,400            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4248 ,'0.2'         ,'1200'           ,0.2         ,1200           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4253 ,'0.2'         ,'800'            ,0.2         ,800            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4255 ,'0.2'         ,'600'            ,0.2         ,600            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4267 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4268 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4276 ,'0.25'        ,'1500'           ,0.25        ,1500           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4278 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4280 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4282 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4283 ,'0.1'         ,'800'            ,0.1         ,800            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4286 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4289 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4292 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4293 ,'0.2'         ,'600'            ,0.2         ,600            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4294 ,'0.4'         ,'3200'           ,0.4         ,3200           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4295 ,'0.2'         ,'600'            ,0.2         ,600            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4296 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6701 ,'0.2'         ,'600'            ,0.2         ,600            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6702 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6703 ,'0.2'         ,'1200'           ,0.2         ,1200           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6704 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6705 ,'0.25'        ,'2000'           ,0.25        ,2000           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6706 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6707 ,'0.25'        ,'2000'           ,0.25        ,2000           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6708 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6709 ,'0.1'         ,'800'            ,0.1         ,800            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6710 ,'0.2'         ,'600'            ,0.2         ,600            ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6711 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6712 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6713 ,'0.38'        ,'1520'           ,0.38        ,1520           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6714 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6715 ,'0.2'         ,'1600'           ,0.2         ,1600           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'         ,'1000'           ,0.2         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'         ,'1000'           ,0.2         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'         ,'1000'           ,0.1         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'         ,'500'            ,0.1         ,500            ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'         ,'400'            ,0.2         ,400            ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'         ,'800'            ,0.2         ,800            ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'         ,'1000'           ,0.2         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'         ,'1000'           ,0.2         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'        ,'2000'           ,0.25        ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'         ,'1000'           ,0.1         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'         ,'1000'           ,0.2         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'         ,'4000'           ,0.4         ,4000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'         ,'1000'           ,0.2         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'         ,'1000'           ,0.2         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'        ,'2500'           ,0.25        ,2500           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'        ,'2500'           ,0.25        ,2500           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'         ,'1000'           ,0.1         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'         ,'1000'           ,0.2         ,1000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'        ,'1900'           ,0.38        ,1900           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'         ,'2000'           ,0.2         ,2000           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'         ,'1000'           ,0.2         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'         ,'1000'           ,0.2         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'         ,'1000'           ,0.1         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'         ,'500'            ,0.1         ,500            ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'         ,'400'            ,0.2         ,400            ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'         ,'800'            ,0.2         ,800            ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'         ,'1000'           ,0.2         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'         ,'1000'           ,0.2         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'        ,'2000'           ,0.25        ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'         ,'1000'           ,0.1         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'         ,'1000'           ,0.2         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'         ,'4000'           ,0.4         ,4000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'         ,'1000'           ,0.2         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'         ,'1000'           ,0.2         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'        ,'2500'           ,0.25        ,2500           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'        ,'2500'           ,0.25        ,2500           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'         ,'1000'           ,0.1         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'         ,'1000'           ,0.2         ,1000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'        ,'1900'           ,0.38        ,1900           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'         ,'2000'           ,0.2         ,2000           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'         ,'1000'           ,0.2         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'         ,'1000'           ,0.2         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'         ,'1000'           ,0.1         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'         ,'500'            ,0.1         ,500            ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'         ,'400'            ,0.2         ,400            ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'         ,'800'            ,0.2         ,800            ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'         ,'1000'           ,0.2         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'         ,'1000'           ,0.2         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'        ,'2000'           ,0.25        ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'         ,'1000'           ,0.1         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'         ,'1000'           ,0.2         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'         ,'4000'           ,0.4         ,4000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'         ,'1000'           ,0.2         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'         ,'1000'           ,0.2         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'        ,'2500'           ,0.25        ,2500           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'        ,'2500'           ,0.25        ,2500           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'         ,'1000'           ,0.1         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'         ,'1000'           ,0.2         ,1000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'        ,'1900'           ,0.38        ,1900           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'         ,'2000'           ,0.2         ,2000           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'         ,'1000'           ,0.2         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'         ,'1000'           ,0.2         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'         ,'1000'           ,0.1         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'         ,'500'            ,0.1         ,500            ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'         ,'400'            ,0.2         ,400            ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'         ,'800'            ,0.2         ,800            ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'         ,'1000'           ,0.2         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'         ,'1000'           ,0.2         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'        ,'2000'           ,0.25        ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'         ,'1000'           ,0.1         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'         ,'1000'           ,0.2         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'         ,'4000'           ,0.4         ,4000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'         ,'1000'           ,0.2         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'         ,'1000'           ,0.2         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'        ,'2500'           ,0.25        ,2500           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'        ,'2500'           ,0.25        ,2500           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'         ,'1000'           ,0.1         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'         ,'1000'           ,0.2         ,1000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'        ,'1900'           ,0.38        ,1900           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'         ,'2000'           ,0.2         ,2000           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'         ,'1000'           ,0.2         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'         ,'1000'           ,0.2         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'         ,'1000'           ,0.1         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'         ,'500'            ,0.1         ,500            ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'         ,'400'            ,0.2         ,400            ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'         ,'800'            ,0.2         ,800            ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'         ,'1000'           ,0.2         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'         ,'1000'           ,0.2         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'        ,'2000'           ,0.25        ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'         ,'1000'           ,0.1         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'         ,'1000'           ,0.2         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'         ,'4000'           ,0.4         ,4000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'         ,'1000'           ,0.2         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'         ,'1000'           ,0.2         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'        ,'2500'           ,0.25        ,2500           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'        ,'2500'           ,0.25        ,2500           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'         ,'1000'           ,0.1         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'         ,'1000'           ,0.2         ,1000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'        ,'1900'           ,0.38        ,1900           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'         ,'2000'           ,0.2         ,2000           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
--THB , TB
SELECT 4186 ,'0.2'         ,'5000'           ,0.2         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4203 ,'0.2'         ,'5000'           ,0.2         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4208 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4215 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4220 ,'0.1'         ,'5000'           ,0.1         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4221 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4236 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4239 ,'0.1'         ,'2500'           ,0.1         ,2500           ,4    UNION ALL	--TB	--THB , TB
SELECT 4242 ,'0.2'         ,'2000'           ,0.2         ,2000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4244 ,'0.2'         ,'4000'           ,0.2         ,4000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4248 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4253 ,'0.2'         ,'5000'           ,0.2         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4255 ,'0.2'         ,'5000'           ,0.2         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4267 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4268 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4276 ,'0.25'        ,'10000'          ,0.25        ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4278 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4280 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4282 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4283 ,'0.1'         ,'5000'           ,0.1         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4286 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4289 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4292 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4293 ,'0.2'         ,'5000'           ,0.2         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4294 ,'0.4'         ,'20000'          ,0.4         ,20000          ,4    UNION ALL	--TB	--THB , TB
SELECT 4295 ,'0.2'         ,'5000'           ,0.2         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 4296 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 6701 ,'0.2'         ,'5000'           ,0.2         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 6702 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 6703 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 6704 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 6705 ,'0.25'        ,'12500'          ,0.25        ,12500          ,4    UNION ALL	--TB	--THB , TB
SELECT 6706 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 6707 ,'0.25'        ,'12500'          ,0.25        ,12500          ,4    UNION ALL	--TB	--THB , TB
SELECT 6708 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 6709 ,'0.1'         ,'5000'           ,0.1         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 6710 ,'0.2'         ,'5000'           ,0.2         ,5000           ,4    UNION ALL	--TB	--THB , TB
SELECT 6711 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 6712 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 6713 ,'0.38'        ,'3800'           ,0.38        ,3800           ,4    UNION ALL	--TB	--THB , TB
SELECT 6714 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
SELECT 6715 ,'0.2'         ,'10000'          ,0.2         ,10000          ,4    UNION ALL	--TB	--THB , TB
--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'         ,'200'            ,0.2         ,200            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'         ,'200'            ,0.2         ,200            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'         ,'300'            ,0.2         ,300            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'         ,'400'            ,0.2         ,400            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'         ,'400'            ,0.1         ,400            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'         ,'300'            ,0.2         ,300            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'         ,'100'            ,0.1         ,100            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'         ,'200'            ,0.2         ,200            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'         ,'400'            ,0.2         ,400            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'         ,'300'            ,0.2         ,300            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'         ,'200'            ,0.2         ,200            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'        ,'250'            ,0.25        ,250            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'         ,'400'            ,0.1         ,400            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'         ,'200'            ,0.2         ,200            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'         ,'600'            ,0.4         ,600            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'         ,'200'            ,0.2         ,200            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'         ,'200'            ,0.2         ,200            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'         ,'300'            ,0.2         ,300            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'        ,'1000'           ,0.25        ,1000           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'        ,'1000'           ,0.25        ,1000           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'         ,'400'            ,0.1         ,400            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'         ,'200'            ,0.2         ,200            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'        ,'380'            ,0.38        ,380            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'         ,'800'            ,0.2         ,800            ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'         ,'200'            ,0.2         ,200            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'         ,'200'            ,0.2         ,200            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'         ,'300'            ,0.2         ,300            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'         ,'400'            ,0.2         ,400            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'         ,'400'            ,0.1         ,400            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'         ,'300'            ,0.2         ,300            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'         ,'100'            ,0.1         ,100            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'         ,'200'            ,0.2         ,200            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'         ,'400'            ,0.2         ,400            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'         ,'300'            ,0.2         ,300            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'         ,'200'            ,0.2         ,200            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'        ,'250'            ,0.25        ,250            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'         ,'400'            ,0.1         ,400            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'         ,'200'            ,0.2         ,200            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'         ,'600'            ,0.4         ,600            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'         ,'200'            ,0.2         ,200            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'         ,'200'            ,0.2         ,200            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'         ,'300'            ,0.2         ,300            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'        ,'1000'           ,0.25        ,1000           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'        ,'1000'           ,0.25        ,1000           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'         ,'400'            ,0.1         ,400            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'         ,'200'            ,0.2         ,200            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'        ,'380'            ,0.38        ,380            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'         ,'800'            ,0.2         ,800            ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'         ,'200'            ,0.2         ,200            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'         ,'200'            ,0.2         ,200            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'         ,'300'            ,0.2         ,300            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'         ,'400'            ,0.2         ,400            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'         ,'400'            ,0.1         ,400            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'         ,'300'            ,0.2         ,300            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'         ,'100'            ,0.1         ,100            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'         ,'200'            ,0.2         ,200            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'         ,'400'            ,0.2         ,400            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'         ,'300'            ,0.2         ,300            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'         ,'200'            ,0.2         ,200            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'        ,'250'            ,0.25        ,250            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'         ,'400'            ,0.1         ,400            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'         ,'200'            ,0.2         ,200            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'         ,'600'            ,0.4         ,600            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'         ,'200'            ,0.2         ,200            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'         ,'200'            ,0.2         ,200            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'         ,'300'            ,0.2         ,300            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'        ,'1000'           ,0.25        ,1000           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'        ,'1000'           ,0.25        ,1000           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'         ,'400'            ,0.1         ,400            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'         ,'200'            ,0.2         ,200            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'        ,'380'            ,0.38        ,380            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'         ,'800'            ,0.2         ,800            ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'         ,'200'            ,0.2         ,200            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'         ,'200'            ,0.2         ,200            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'         ,'300'            ,0.2         ,300            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'         ,'400'            ,0.2         ,400            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'         ,'400'            ,0.1         ,400            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'         ,'300'            ,0.2         ,300            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'         ,'100'            ,0.1         ,100            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'         ,'200'            ,0.2         ,200            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'         ,'400'            ,0.2         ,400            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'         ,'300'            ,0.2         ,300            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'         ,'200'            ,0.2         ,200            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'        ,'250'            ,0.25        ,250            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'         ,'400'            ,0.1         ,400            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'         ,'200'            ,0.2         ,200            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'         ,'600'            ,0.4         ,600            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'         ,'200'            ,0.2         ,200            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'         ,'200'            ,0.2         ,200            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'         ,'300'            ,0.2         ,300            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'        ,'1000'           ,0.25        ,1000           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'        ,'1000'           ,0.25        ,1000           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'         ,'400'            ,0.1         ,400            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'         ,'200'            ,0.2         ,200            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'        ,'380'            ,0.38        ,380            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'         ,'800'            ,0.2         ,800            ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'         ,'200'            ,0.2         ,200            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'         ,'200'            ,0.2         ,200            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'         ,'300'            ,0.2         ,300            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'         ,'400'            ,0.2         ,400            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'         ,'400'            ,0.1         ,400            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'         ,'300'            ,0.2         ,300            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'         ,'100'            ,0.1         ,100            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'         ,'200'            ,0.2         ,200            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'         ,'400'            ,0.2         ,400            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'         ,'300'            ,0.2         ,300            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'         ,'200'            ,0.2         ,200            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'        ,'250'            ,0.25        ,250            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'         ,'400'            ,0.1         ,400            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'         ,'200'            ,0.2         ,200            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'         ,'600'            ,0.4         ,600            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'         ,'200'            ,0.2         ,200            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'         ,'200'            ,0.2         ,200            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'         ,'300'            ,0.2         ,300            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'        ,'1000'           ,0.25        ,1000           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'        ,'1000'           ,0.25        ,1000           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'         ,'400'            ,0.1         ,400            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'         ,'200'            ,0.2         ,200            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'        ,'380'            ,0.38        ,380            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'         ,'800'            ,0.2         ,800            ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
--WON , KRW
SELECT 4186 ,'80'          ,'200000'         ,80          ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4203 ,'80'          ,'200000'         ,80          ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4208 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4215 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4220 ,'40'          ,'250000'         ,40          ,250000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4221 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4236 ,'80'          ,'200000'         ,80          ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4239 ,'40'          ,'100000'         ,40          ,100000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4242 ,'80'          ,'100000'         ,80          ,100000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4244 ,'80'          ,'160000'         ,80          ,160000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4248 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4253 ,'80'          ,'200000'         ,80          ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4255 ,'80'          ,'200000'         ,80          ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4267 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4268 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4276 ,'100'         ,'200000'         ,100         ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4278 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4280 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4282 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4283 ,'40'          ,'250000'         ,40          ,250000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4286 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4289 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4292 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4293 ,'80'          ,'200000'         ,80          ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4294 ,'160'         ,'1000000'        ,160         ,1000000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4295 ,'80'          ,'200000'         ,80          ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 4296 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6701 ,'80'          ,'200000'         ,80          ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6702 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6703 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6704 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6705 ,'100'         ,'625000'         ,100         ,625000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6706 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6707 ,'100'         ,'625000'         ,100         ,625000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6708 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6709 ,'40'          ,'250000'         ,40          ,250000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6710 ,'80'          ,'200000'         ,80          ,200000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6711 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6712 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6713 ,'152'         ,'380000'         ,152         ,380000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6714 ,'80'          ,'500000'         ,80          ,500000         ,45   UNION ALL	--Won	--WON , KRW
SELECT 6715 ,'80'          ,'500000'         ,80          ,500000         ,45				--Won	--WON , KRW

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999


;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  WHERE t.ExchangeId = s.ExchangeId) t
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