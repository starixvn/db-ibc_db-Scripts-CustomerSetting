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
SELECT 4186 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4203 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4208 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4215 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4220 ,'0.1'      ,'2'           ,0.1      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4221 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 4236 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4239 ,'0.1'      ,'2'           ,0.1      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4242 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4244 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4248 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4253 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4255 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4267 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 4268 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 4276 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,12   UNION ALL	--GBP	--GBP
SELECT 4278 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 4280 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 4282 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 4283 ,'0.1'      ,'2'           ,0.1      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4286 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 4289 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 4292 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 4293 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4294 ,'0.4'      ,'8'           ,0.4      ,8           ,12   UNION ALL	--GBP	--GBP
SELECT 4295 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 4296 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6701 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 6702 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6703 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 6704 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6705 ,'0.25'     ,'5'           ,0.25     ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6706 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6707 ,'0.25'     ,'5'           ,0.25     ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6708 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6709 ,'0.1'      ,'2'           ,0.1      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 6710 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 6711 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6712 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6713 ,'0.38'     ,'3.8'         ,0.38     ,3.8         ,12   UNION ALL	--GBP	--GBP
SELECT 6714 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6715 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
--IN,IDR
SELECT 4186 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4203 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4208 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4215 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4220 ,'0.1'      ,'10'          ,0.1      ,10          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4221 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4236 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4239 ,'0.1'      ,'10'          ,0.1      ,10          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4242 ,'0.2'      ,'10'          ,0.2      ,10          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4244 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4248 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4253 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4255 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4267 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4268 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4276 ,'0.25'     ,'25'          ,0.25     ,25          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4278 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4280 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4282 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4283 ,'0.1'      ,'10'          ,0.1      ,10          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4286 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4289 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4292 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4293 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4294 ,'0.4'      ,'40'          ,0.4      ,40          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4295 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 4296 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6701 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6702 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6703 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6704 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6705 ,'0.25'     ,'25'          ,0.25     ,25          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6706 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6707 ,'0.25'     ,'25'          ,0.25     ,25          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6708 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6709 ,'0.1'      ,'10'          ,0.1      ,10          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6710 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6711 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6712 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6713 ,'0.38'     ,'38'          ,0.38     ,38          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6714 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6715 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
--INH,VND
SELECT 4186 ,'0.2'      ,'30'          ,0.2      ,30          ,51   UNION ALL	--INH	--INH,VND
SELECT 4203 ,'0.2'      ,'40'          ,0.2      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 4208 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4215 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4220 ,'0.1'      ,'40'          ,0.1      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 4221 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4236 ,'0.2'      ,'40'          ,0.2      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 4239 ,'0.1'      ,'20'          ,0.1      ,20          ,51   UNION ALL	--INH	--INH,VND
SELECT 4242 ,'0.2'      ,'20'          ,0.2      ,20          ,51   UNION ALL	--INH	--INH,VND
SELECT 4244 ,'0.2'      ,'30'          ,0.2      ,30          ,51   UNION ALL	--INH	--INH,VND
SELECT 4248 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4253 ,'0.2'      ,'40'          ,0.2      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 4255 ,'0.2'      ,'40'          ,0.2      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 4267 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4268 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4276 ,'0.25'     ,'50'          ,0.25     ,50          ,51   UNION ALL	--INH	--INH,VND
SELECT 4278 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4280 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4282 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4283 ,'0.1'      ,'40'          ,0.1      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 4286 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4289 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4292 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 4293 ,'0.2'      ,'40'          ,0.2      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 4294 ,'0.4'      ,'160'         ,0.4      ,160         ,51   UNION ALL	--INH	--INH,VND
SELECT 4295 ,'0.2'      ,'40'          ,0.2      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 4296 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6701 ,'0.2'      ,'40'          ,0.2      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 6702 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6703 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6704 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6705 ,'0.25'     ,'100'         ,0.25     ,100         ,51   UNION ALL	--INH	--INH,VND
SELECT 6706 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6707 ,'0.25'     ,'100'         ,0.25     ,100         ,51   UNION ALL	--INH	--INH,VND
SELECT 6708 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6709 ,'0.1'      ,'40'          ,0.1      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 6710 ,'0.2'      ,'40'          ,0.2      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 6711 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6712 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6713 ,'0.38'     ,'38'          ,0.38     ,38          ,51   UNION ALL	--INH	--INH,VND
SELECT 6714 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6715 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
--INR, RUB
SELECT 4186 ,'1'        ,'120'         ,1        ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4203 ,'1'        ,'120'         ,1        ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4208 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4215 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4220 ,'0.5'      ,'120'         ,0.5      ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4221 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4236 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4239 ,'0.5'      ,'60'          ,0.5      ,60          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4242 ,'1'        ,'40'          ,1        ,40          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4244 ,'1'        ,'80'          ,1        ,80          ,61   UNION ALL	--INR	--INR, RUB
SELECT 4248 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4253 ,'1'        ,'120'         ,1        ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4255 ,'1'        ,'120'         ,1        ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4267 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4268 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4276 ,'1.25'     ,'200'         ,1.25     ,200         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4278 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4280 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4282 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4283 ,'0.5'      ,'120'         ,0.5      ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4286 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4289 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4292 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4293 ,'1'        ,'120'         ,1        ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4294 ,'2'        ,'480'         ,2        ,480         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4295 ,'1'        ,'120'         ,1        ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4296 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6701 ,'1'        ,'120'         ,1        ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6702 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6703 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6704 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6705 ,'1.25'     ,'300'         ,1.25     ,300         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6706 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6707 ,'1.25'     ,'300'         ,1.25     ,300         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6708 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6709 ,'0.5'      ,'120'         ,0.5      ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6710 ,'1'        ,'120'         ,1        ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6711 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6712 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6713 ,'1.9'      ,'76'          ,1.9      ,76          ,61   UNION ALL	--INR	--INR, RUB
SELECT 6714 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6715 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 4186 ,'1'        ,'120'         ,1        ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4203 ,'1'        ,'120'         ,1        ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4208 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4215 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4220 ,'0.5'      ,'120'         ,0.5      ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4221 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4236 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4239 ,'0.5'      ,'60'          ,0.5      ,60          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4242 ,'1'        ,'40'          ,1        ,40          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4244 ,'1'        ,'80'          ,1        ,80          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4248 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4253 ,'1'        ,'120'         ,1        ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4255 ,'1'        ,'120'         ,1        ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4267 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4268 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4276 ,'1.25'     ,'200'         ,1.25     ,200         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4278 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4280 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4282 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4283 ,'0.5'      ,'120'         ,0.5      ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4286 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4289 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4292 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4293 ,'1'        ,'120'         ,1        ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4294 ,'2'        ,'480'         ,2        ,480         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4295 ,'1'        ,'120'         ,1        ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4296 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6701 ,'1'        ,'120'         ,1        ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6702 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6703 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6704 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6705 ,'1.25'     ,'300'         ,1.25     ,300         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6706 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6707 ,'1.25'     ,'300'         ,1.25     ,300         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6708 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6709 ,'0.5'      ,'120'         ,0.5      ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6710 ,'1'        ,'120'         ,1        ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6711 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6712 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6713 ,'1.9'      ,'76'          ,1.9      ,76          ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6714 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6715 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
--JPY
SELECT 4186 ,'10'       ,'200'         ,10       ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 4203 ,'10'       ,'200'         ,10       ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 4208 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4215 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4220 ,'5'        ,'200'         ,5        ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 4221 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4236 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4239 ,'5'        ,'100'         ,5        ,100         ,32   UNION ALL	--JPY	--JPY
SELECT 4242 ,'10'       ,'100'         ,10       ,100         ,32   UNION ALL	--JPY	--JPY
SELECT 4244 ,'10'       ,'100'         ,10       ,100         ,32   UNION ALL	--JPY	--JPY
SELECT 4248 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4253 ,'10'       ,'200'         ,10       ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 4255 ,'10'       ,'200'         ,10       ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 4267 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4268 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4276 ,'12.5'     ,'200'         ,12.5     ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 4278 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4280 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4282 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4283 ,'5'        ,'200'         ,5        ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 4286 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4289 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4292 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 4293 ,'10'       ,'200'         ,10       ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 4294 ,'20'       ,'800'         ,20       ,800         ,32   UNION ALL	--JPY	--JPY
SELECT 4295 ,'10'       ,'200'         ,10       ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 4296 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6701 ,'10'       ,'200'         ,10       ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 6702 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6703 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6704 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6705 ,'12.5'     ,'500'         ,12.5     ,500         ,32   UNION ALL	--JPY	--JPY
SELECT 6706 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6707 ,'12.5'     ,'500'         ,12.5     ,500         ,32   UNION ALL	--JPY	--JPY
SELECT 6708 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6709 ,'5'        ,'200'         ,5        ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 6710 ,'10'       ,'200'         ,10       ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 6711 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6712 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6713 ,'19'       ,'380'         ,19       ,380         ,32   UNION ALL	--JPY	--JPY
SELECT 6714 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6715 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
--RM, MYR,  PLN, KHR
SELECT 4186 ,'0.2'      ,'6'           ,0.2      ,6           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4203 ,'0.2'      ,'6'           ,0.2      ,6           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4208 ,'0.2'      ,'12'          ,0.2      ,12          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4215 ,'0.2'      ,'12'          ,0.2      ,12          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4220 ,'0.1'      ,'8'           ,0.1      ,8           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4221 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4236 ,'0.2'      ,'12'          ,0.2      ,12          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4239 ,'0.1'      ,'3'           ,0.1      ,3           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4242 ,'0.2'      ,'2'           ,0.2      ,2           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4244 ,'0.2'      ,'4'           ,0.2      ,4           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4248 ,'0.2'      ,'12'          ,0.2      ,12          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4253 ,'0.2'      ,'8'           ,0.2      ,8           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4255 ,'0.2'      ,'6'           ,0.2      ,6           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4267 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4268 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4276 ,'0.25'     ,'15'          ,0.25     ,15          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4278 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4280 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4282 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4283 ,'0.1'      ,'8'           ,0.1      ,8           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4286 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4289 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4292 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4293 ,'0.2'      ,'6'           ,0.2      ,6           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4294 ,'0.4'      ,'32'          ,0.4      ,32          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4295 ,'0.2'      ,'6'           ,0.2      ,6           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4296 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6701 ,'0.2'      ,'6'           ,0.2      ,6           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6702 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6703 ,'0.2'      ,'12'          ,0.2      ,12          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6704 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6705 ,'0.25'     ,'20'          ,0.25     ,20          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6706 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6707 ,'0.25'     ,'20'          ,0.25     ,20          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6708 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6709 ,'0.1'      ,'8'           ,0.1      ,8           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6710 ,'0.2'      ,'6'           ,0.2      ,6           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6711 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6712 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6713 ,'0.38'     ,'15.2'        ,0.38     ,15.2        ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6714 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6715 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4186 ,'0.2'      ,'6'           ,0.2      ,6           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4203 ,'0.2'      ,'6'           ,0.2      ,6           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4208 ,'0.2'      ,'12'          ,0.2      ,12          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4215 ,'0.2'      ,'12'          ,0.2      ,12          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4220 ,'0.1'      ,'8'           ,0.1      ,8           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4221 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4236 ,'0.2'      ,'12'          ,0.2      ,12          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4239 ,'0.1'      ,'3'           ,0.1      ,3           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4242 ,'0.2'      ,'2'           ,0.2      ,2           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4244 ,'0.2'      ,'4'           ,0.2      ,4           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4248 ,'0.2'      ,'12'          ,0.2      ,12          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4253 ,'0.2'      ,'8'           ,0.2      ,8           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4255 ,'0.2'      ,'6'           ,0.2      ,6           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4267 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4268 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4276 ,'0.25'     ,'15'          ,0.25     ,15          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4278 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4280 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4282 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4283 ,'0.1'      ,'8'           ,0.1      ,8           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4286 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4289 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4292 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4293 ,'0.2'      ,'6'           ,0.2      ,6           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4294 ,'0.4'      ,'32'          ,0.4      ,32          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4295 ,'0.2'      ,'6'           ,0.2      ,6           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4296 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6701 ,'0.2'      ,'6'           ,0.2      ,6           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6702 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6703 ,'0.2'      ,'12'          ,0.2      ,12          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6704 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6705 ,'0.25'     ,'20'          ,0.25     ,20          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6706 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6707 ,'0.25'     ,'20'          ,0.25     ,20          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6708 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6709 ,'0.1'      ,'8'           ,0.1      ,8           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6710 ,'0.2'      ,'6'           ,0.2      ,6           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6711 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6712 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6713 ,'0.38'     ,'15.2'        ,0.38     ,15.2        ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6714 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6715 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4186 ,'0.2'      ,'6'           ,0.2      ,6           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4203 ,'0.2'      ,'6'           ,0.2      ,6           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4208 ,'0.2'      ,'12'          ,0.2      ,12          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4215 ,'0.2'      ,'12'          ,0.2      ,12          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4220 ,'0.1'      ,'8'           ,0.1      ,8           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4221 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4236 ,'0.2'      ,'12'          ,0.2      ,12          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4239 ,'0.1'      ,'3'           ,0.1      ,3           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4242 ,'0.2'      ,'2'           ,0.2      ,2           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4244 ,'0.2'      ,'4'           ,0.2      ,4           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4248 ,'0.2'      ,'12'          ,0.2      ,12          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4253 ,'0.2'      ,'8'           ,0.2      ,8           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4255 ,'0.2'      ,'6'           ,0.2      ,6           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4267 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4268 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4276 ,'0.25'     ,'15'          ,0.25     ,15          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4278 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4280 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4282 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4283 ,'0.1'      ,'8'           ,0.1      ,8           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4286 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4289 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4292 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4293 ,'0.2'      ,'6'           ,0.2      ,6           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4294 ,'0.4'      ,'32'          ,0.4      ,32          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4295 ,'0.2'      ,'6'           ,0.2      ,6           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4296 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6701 ,'0.2'      ,'6'           ,0.2      ,6           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6702 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6703 ,'0.2'      ,'12'          ,0.2      ,12          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6704 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6705 ,'0.25'     ,'20'          ,0.25     ,20          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6706 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6707 ,'0.25'     ,'20'          ,0.25     ,20          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6708 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6709 ,'0.1'      ,'8'           ,0.1      ,8           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6710 ,'0.2'      ,'6'           ,0.2      ,6           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6711 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6712 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6713 ,'0.38'     ,'15.2'        ,0.38     ,15.2        ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6714 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6715 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'      ,'10'          ,0.2      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'      ,'10'          ,0.2      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'      ,'10'          ,0.1      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'      ,'5'           ,0.1      ,5           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'      ,'4'           ,0.2      ,4           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'      ,'8'           ,0.2      ,8           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'      ,'10'          ,0.2      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'      ,'10'          ,0.2      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'     ,'20'          ,0.25     ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'      ,'10'          ,0.1      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'      ,'10'          ,0.2      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'      ,'40'          ,0.4      ,40          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'      ,'10'          ,0.2      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'      ,'10'          ,0.2      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'     ,'25'          ,0.25     ,25          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'     ,'25'          ,0.25     ,25          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'      ,'10'          ,0.1      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'      ,'10'          ,0.2      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'     ,'19'          ,0.38     ,19          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'      ,'10'          ,0.2      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'      ,'10'          ,0.2      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'      ,'10'          ,0.1      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'      ,'5'           ,0.1      ,5           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'      ,'4'           ,0.2      ,4           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'      ,'8'           ,0.2      ,8           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'      ,'10'          ,0.2      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'      ,'10'          ,0.2      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'     ,'20'          ,0.25     ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'      ,'10'          ,0.1      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'      ,'10'          ,0.2      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'      ,'40'          ,0.4      ,40          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'      ,'10'          ,0.2      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'      ,'10'          ,0.2      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'     ,'25'          ,0.25     ,25          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'     ,'25'          ,0.25     ,25          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'      ,'10'          ,0.1      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'      ,'10'          ,0.2      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'     ,'19'          ,0.38     ,19          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'      ,'10'          ,0.2      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'      ,'10'          ,0.2      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'      ,'10'          ,0.1      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'      ,'5'           ,0.1      ,5           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'      ,'4'           ,0.2      ,4           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'      ,'8'           ,0.2      ,8           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'      ,'10'          ,0.2      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'      ,'10'          ,0.2      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'     ,'20'          ,0.25     ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'      ,'10'          ,0.1      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'      ,'10'          ,0.2      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'      ,'40'          ,0.4      ,40          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'      ,'10'          ,0.2      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'      ,'10'          ,0.2      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'     ,'25'          ,0.25     ,25          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'     ,'25'          ,0.25     ,25          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'      ,'10'          ,0.1      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'      ,'10'          ,0.2      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'     ,'19'          ,0.38     ,19          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'      ,'10'          ,0.2      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'      ,'10'          ,0.2      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'      ,'10'          ,0.1      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'      ,'5'           ,0.1      ,5           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'      ,'4'           ,0.2      ,4           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'      ,'8'           ,0.2      ,8           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'      ,'10'          ,0.2      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'      ,'10'          ,0.2      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'     ,'20'          ,0.25     ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'      ,'10'          ,0.1      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'      ,'10'          ,0.2      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'      ,'40'          ,0.4      ,40          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'      ,'10'          ,0.2      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'      ,'10'          ,0.2      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'     ,'25'          ,0.25     ,25          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'     ,'25'          ,0.25     ,25          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'      ,'10'          ,0.1      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'      ,'10'          ,0.2      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'     ,'19'          ,0.38     ,19          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4186 ,'0.2'      ,'10'          ,0.2      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4203 ,'0.2'      ,'10'          ,0.2      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4208 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4215 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4220 ,'0.1'      ,'10'          ,0.1      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4221 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4236 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4239 ,'0.1'      ,'5'           ,0.1      ,5           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4242 ,'0.2'      ,'4'           ,0.2      ,4           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4244 ,'0.2'      ,'8'           ,0.2      ,8           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4248 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4253 ,'0.2'      ,'10'          ,0.2      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4255 ,'0.2'      ,'10'          ,0.2      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.25'     ,'20'          ,0.25     ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.1'      ,'10'          ,0.1      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4292 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4293 ,'0.2'      ,'10'          ,0.2      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4294 ,'0.4'      ,'40'          ,0.4      ,40          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4295 ,'0.2'      ,'10'          ,0.2      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4296 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6701 ,'0.2'      ,'10'          ,0.2      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6702 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6703 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6704 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6705 ,'0.25'     ,'25'          ,0.25     ,25          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6706 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6707 ,'0.25'     ,'25'          ,0.25     ,25          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6708 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6709 ,'0.1'      ,'10'          ,0.1      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6710 ,'0.2'      ,'10'          ,0.2      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6711 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6712 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6713 ,'0.38'     ,'19'          ,0.38     ,19          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6714 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6715 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
--THB , TB
SELECT 4186 ,'0.2'      ,'50'          ,0.2      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 4203 ,'0.2'      ,'50'          ,0.2      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 4208 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4215 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4220 ,'0.1'      ,'50'          ,0.1      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 4221 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4236 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4239 ,'0.1'      ,'25'          ,0.1      ,25          ,4    UNION ALL	--TB	--THB , TB
SELECT 4242 ,'0.2'      ,'20'          ,0.2      ,20          ,4    UNION ALL	--TB	--THB , TB
SELECT 4244 ,'0.2'      ,'40'          ,0.2      ,40          ,4    UNION ALL	--TB	--THB , TB
SELECT 4248 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4253 ,'0.2'      ,'50'          ,0.2      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 4255 ,'0.2'      ,'50'          ,0.2      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 4267 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4268 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4276 ,'0.25'     ,'100'         ,0.25     ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4278 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4280 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4282 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4283 ,'0.1'      ,'50'          ,0.1      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 4286 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4289 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4292 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 4293 ,'0.2'      ,'50'          ,0.2      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 4294 ,'0.4'      ,'200'         ,0.4      ,200         ,4    UNION ALL	--TB	--THB , TB
SELECT 4295 ,'0.2'      ,'50'          ,0.2      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 4296 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6701 ,'0.2'      ,'50'          ,0.2      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 6702 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6703 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6704 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6705 ,'0.25'     ,'125'         ,0.25     ,125         ,4    UNION ALL	--TB	--THB , TB
SELECT 6706 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6707 ,'0.25'     ,'125'         ,0.25     ,125         ,4    UNION ALL	--TB	--THB , TB
SELECT 6708 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6709 ,'0.1'      ,'50'          ,0.1      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 6710 ,'0.2'      ,'50'          ,0.2      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 6711 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6712 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6713 ,'0.38'     ,'38'          ,0.38     ,38          ,4    UNION ALL	--TB	--THB , TB
SELECT 6714 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6715 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'      ,'2'           ,0.2      ,2           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'      ,'2'           ,0.2      ,2           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'      ,'3'           ,0.2      ,3           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'      ,'4'           ,0.2      ,4           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'      ,'4'           ,0.1      ,4           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'      ,'3'           ,0.2      ,3           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'      ,'1'           ,0.1      ,1           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'      ,'2'           ,0.2      ,2           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'      ,'2'           ,0.2      ,2           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'      ,'4'           ,0.2      ,4           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'      ,'3'           ,0.2      ,3           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'      ,'2'           ,0.2      ,2           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'      ,'4'           ,0.1      ,4           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'      ,'2'           ,0.2      ,2           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'      ,'6'           ,0.4      ,6           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'      ,'2'           ,0.2      ,2           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'      ,'2'           ,0.2      ,2           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'      ,'3'           ,0.2      ,3           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'     ,'10'          ,0.25     ,10          ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'     ,'10'          ,0.25     ,10          ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'      ,'4'           ,0.1      ,4           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'      ,'2'           ,0.2      ,2           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'     ,'3.8'         ,0.38     ,3.8         ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'      ,'2'           ,0.2      ,2           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'      ,'2'           ,0.2      ,2           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'      ,'3'           ,0.2      ,3           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'      ,'4'           ,0.2      ,4           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'      ,'4'           ,0.1      ,4           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'      ,'3'           ,0.2      ,3           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'      ,'1'           ,0.1      ,1           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'      ,'2'           ,0.2      ,2           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'      ,'2'           ,0.2      ,2           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'      ,'4'           ,0.2      ,4           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'      ,'3'           ,0.2      ,3           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'      ,'2'           ,0.2      ,2           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'      ,'4'           ,0.1      ,4           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'      ,'2'           ,0.2      ,2           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'      ,'6'           ,0.4      ,6           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'      ,'2'           ,0.2      ,2           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'      ,'2'           ,0.2      ,2           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'      ,'3'           ,0.2      ,3           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'     ,'10'          ,0.25     ,10          ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'     ,'10'          ,0.25     ,10          ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'      ,'4'           ,0.1      ,4           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'      ,'2'           ,0.2      ,2           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'     ,'3.8'         ,0.38     ,3.8         ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'      ,'2'           ,0.2      ,2           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'      ,'2'           ,0.2      ,2           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'      ,'3'           ,0.2      ,3           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'      ,'4'           ,0.2      ,4           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'      ,'4'           ,0.1      ,4           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'      ,'3'           ,0.2      ,3           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'      ,'1'           ,0.1      ,1           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'      ,'2'           ,0.2      ,2           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'      ,'2'           ,0.2      ,2           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'      ,'4'           ,0.2      ,4           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'      ,'3'           ,0.2      ,3           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'      ,'2'           ,0.2      ,2           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'      ,'4'           ,0.1      ,4           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'      ,'2'           ,0.2      ,2           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'      ,'6'           ,0.4      ,6           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'      ,'2'           ,0.2      ,2           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'      ,'2'           ,0.2      ,2           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'      ,'3'           ,0.2      ,3           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'     ,'10'          ,0.25     ,10          ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'     ,'10'          ,0.25     ,10          ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'      ,'4'           ,0.1      ,4           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'      ,'2'           ,0.2      ,2           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'     ,'3.8'         ,0.38     ,3.8         ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'      ,'2'           ,0.2      ,2           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'      ,'2'           ,0.2      ,2           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'      ,'3'           ,0.2      ,3           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'      ,'4'           ,0.2      ,4           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'      ,'4'           ,0.1      ,4           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'      ,'3'           ,0.2      ,3           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'      ,'1'           ,0.1      ,1           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'      ,'2'           ,0.2      ,2           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'      ,'2'           ,0.2      ,2           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'      ,'4'           ,0.2      ,4           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'      ,'3'           ,0.2      ,3           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'      ,'2'           ,0.2      ,2           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'      ,'4'           ,0.1      ,4           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'      ,'2'           ,0.2      ,2           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'      ,'6'           ,0.4      ,6           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'      ,'2'           ,0.2      ,2           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'      ,'2'           ,0.2      ,2           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'      ,'3'           ,0.2      ,3           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'     ,'10'          ,0.25     ,10          ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'     ,'10'          ,0.25     ,10          ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'      ,'4'           ,0.1      ,4           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'      ,'2'           ,0.2      ,2           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'     ,'3.8'         ,0.38     ,3.8         ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'      ,'2'           ,0.2      ,2           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'      ,'2'           ,0.2      ,2           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'      ,'3'           ,0.2      ,3           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'      ,'4'           ,0.2      ,4           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'      ,'4'           ,0.1      ,4           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'      ,'3'           ,0.2      ,3           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'      ,'1'           ,0.1      ,1           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'      ,'2'           ,0.2      ,2           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'      ,'2'           ,0.2      ,2           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'      ,'4'           ,0.2      ,4           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'      ,'3'           ,0.2      ,3           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'      ,'2'           ,0.2      ,2           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'      ,'4'           ,0.1      ,4           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'      ,'2'           ,0.2      ,2           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'      ,'6'           ,0.4      ,6           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'      ,'2'           ,0.2      ,2           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'      ,'2'           ,0.2      ,2           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'      ,'3'           ,0.2      ,3           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'     ,'10'          ,0.25     ,10          ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'     ,'10'          ,0.25     ,10          ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'      ,'4'           ,0.1      ,4           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'      ,'2'           ,0.2      ,2           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'     ,'3.8'         ,0.38     ,3.8         ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
--WON , KRW
SELECT 4186 ,'80'       ,'2000'        ,80       ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4203 ,'80'       ,'2000'        ,80       ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4208 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4215 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4220 ,'40'       ,'2500'        ,40       ,2500        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4221 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4236 ,'80'       ,'2000'        ,80       ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4239 ,'40'       ,'1000'        ,40       ,1000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4242 ,'80'       ,'1000'        ,80       ,1000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4244 ,'80'       ,'1600'        ,80       ,1600        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4248 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4253 ,'80'       ,'2000'        ,80       ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4255 ,'80'       ,'2000'        ,80       ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4267 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4268 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4276 ,'100'      ,'2000'        ,100      ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4278 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4280 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4282 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4283 ,'40'       ,'2500'        ,40       ,2500        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4286 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4289 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4292 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4293 ,'80'       ,'2000'        ,80       ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4294 ,'160'      ,'10000'       ,160      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 4295 ,'80'       ,'2000'        ,80       ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 4296 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6701 ,'80'       ,'2000'        ,80       ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6702 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6703 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6704 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6705 ,'100'      ,'6250'        ,100      ,6250        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6706 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6707 ,'100'      ,'6250'        ,100      ,6250        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6708 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6709 ,'40'       ,'2500'        ,40       ,2500        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6710 ,'80'       ,'2000'        ,80       ,2000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6711 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6712 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6713 ,'152'      ,'3800'        ,152      ,3800        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6714 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6715 ,'80'       ,'5000'        ,80       ,5000        ,45				--Won	--WON , KRW

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