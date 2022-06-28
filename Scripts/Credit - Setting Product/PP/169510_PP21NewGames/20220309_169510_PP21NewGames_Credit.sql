/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220309
	Created: Winfred 
	Task: #169510 - Pragmatic - Integrate 21 new games for Credit [Redmine:169510]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--GBP
SELECT 6716 ,'0.4'     ,'50'          ,0.4     ,50          ,12   UNION ALL	--GBP	--GBP
SELECT 6717 ,'0.4'     ,'16'          ,0.4     ,16          ,12   UNION ALL	--GBP	--GBP
SELECT 6718 ,'0.4'     ,'16'          ,0.4     ,16          ,12   UNION ALL	--GBP	--GBP
SELECT 6719 ,'0.5'     ,'20'          ,0.5     ,20          ,12   UNION ALL	--GBP	--GBP
SELECT 6720 ,'0.4'     ,'20'          ,0.4     ,20          ,12   UNION ALL	--GBP	--GBP
SELECT 6721 ,'1.76'    ,'44'          ,1.76    ,44          ,12   UNION ALL	--GBP	--GBP
SELECT 6722 ,'0.4'     ,'20'          ,0.4     ,20          ,12   UNION ALL	--GBP	--GBP
SELECT 6723 ,'0.5'     ,'12.5'        ,0.5     ,12.5        ,12   UNION ALL	--GBP	--GBP
SELECT 6724 ,'0.4'     ,'20'          ,0.4     ,20          ,12   UNION ALL	--GBP	--GBP
SELECT 6725 ,'2.5'     ,'50'          ,2.5     ,50          ,12   UNION ALL	--GBP	--GBP
SELECT 6726 ,'1.76'    ,'44'          ,1.76    ,44          ,12   UNION ALL	--GBP	--GBP
SELECT 6727 ,'0.4'     ,'20'          ,0.4     ,20          ,12   UNION ALL	--GBP	--GBP
SELECT 6728 ,'0.4'     ,'10'          ,0.4     ,10          ,12   UNION ALL	--GBP	--GBP
SELECT 6729 ,'0.4'     ,'4'           ,0.4     ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6730 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6731 ,'0.1'     ,'3'           ,0.1     ,3           ,12   UNION ALL	--GBP	--GBP
SELECT 6732 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6733 ,'0.2'     ,'6'           ,0.2     ,6           ,12   UNION ALL	--GBP	--GBP
SELECT 6734 ,'0.25'    ,'7.5'         ,0.25    ,7.5         ,12   UNION ALL	--GBP	--GBP
SELECT 6735 ,'0.2'     ,'3'           ,0.2     ,3           ,12   UNION ALL	--GBP	--GBP
SELECT 6736 ,'0.1'     ,'3'           ,0.1     ,3           ,12   UNION ALL	--GBP	--GBP
--IDR,DDD,IDD,IN,IND
SELECT 6716 ,'0.2'     ,'240'         ,0.2     ,240         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6717 ,'0.2'     ,'240'         ,0.2     ,240         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6718 ,'0.2'     ,'240'         ,0.2     ,240         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6719 ,'0.25'    ,'300'         ,0.25    ,300         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6720 ,'0.2'     ,'240'         ,0.2     ,240         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6721 ,'0.88'    ,'1056'        ,0.88    ,1056        ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6722 ,'0.2'     ,'240'         ,0.2     ,240         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6723 ,'0.25'    ,'200'         ,0.25    ,200         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6724 ,'0.2'     ,'240'         ,0.2     ,240         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6725 ,'1.25'    ,'1000'        ,1.25    ,1000        ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6726 ,'0.88'    ,'1056'        ,0.88    ,1056        ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6727 ,'0.2'     ,'240'         ,0.2     ,240         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6728 ,'0.2'     ,'240'         ,0.2     ,240         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6729 ,'0.2'     ,'80'          ,0.2     ,80          ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6730 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6731 ,'0.1'     ,'50'          ,0.1     ,50          ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6732 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6733 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6734 ,'0.25'    ,'125'         ,0.25    ,125         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6735 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6736 ,'0.1'     ,'50'          ,0.1     ,50          ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 6716 ,'0.2'     ,'240'         ,0.2     ,240         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6717 ,'0.2'     ,'240'         ,0.2     ,240         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6718 ,'0.2'     ,'240'         ,0.2     ,240         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6719 ,'0.25'    ,'300'         ,0.25    ,300         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6720 ,'0.2'     ,'240'         ,0.2     ,240         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6721 ,'0.88'    ,'1056'        ,0.88    ,1056        ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6722 ,'0.2'     ,'240'         ,0.2     ,240         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6723 ,'0.25'    ,'200'         ,0.25    ,200         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6724 ,'0.2'     ,'240'         ,0.2     ,240         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6725 ,'1.25'    ,'1000'        ,1.25    ,1000        ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6726 ,'0.88'    ,'1056'        ,0.88    ,1056        ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6727 ,'0.2'     ,'240'         ,0.2     ,240         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6728 ,'0.2'     ,'240'         ,0.2     ,240         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6729 ,'0.2'     ,'80'          ,0.2     ,80          ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6730 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6731 ,'0.1'     ,'50'          ,0.1     ,50          ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6732 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6733 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6734 ,'0.25'    ,'125'         ,0.25    ,125         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6735 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6736 ,'0.1'     ,'50'          ,0.1     ,50          ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 6716 ,'0.2'     ,'240'         ,0.2     ,240         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6717 ,'0.2'     ,'240'         ,0.2     ,240         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6718 ,'0.2'     ,'240'         ,0.2     ,240         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6719 ,'0.25'    ,'300'         ,0.25    ,300         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6720 ,'0.2'     ,'240'         ,0.2     ,240         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6721 ,'0.88'    ,'1056'        ,0.88    ,1056        ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6722 ,'0.2'     ,'240'         ,0.2     ,240         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6723 ,'0.25'    ,'200'         ,0.25    ,200         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6724 ,'0.2'     ,'240'         ,0.2     ,240         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6725 ,'1.25'    ,'1000'        ,1.25    ,1000        ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6726 ,'0.88'    ,'1056'        ,0.88    ,1056        ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6727 ,'0.2'     ,'240'         ,0.2     ,240         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6728 ,'0.2'     ,'240'         ,0.2     ,240         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6729 ,'0.2'     ,'80'          ,0.2     ,80          ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6730 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6731 ,'0.1'     ,'50'          ,0.1     ,50          ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6732 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6733 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6734 ,'0.25'    ,'125'         ,0.25    ,125         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6735 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6736 ,'0.1'     ,'50'          ,0.1     ,50          ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 6716 ,'0.2'     ,'240'         ,0.2     ,240         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6717 ,'0.2'     ,'240'         ,0.2     ,240         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6718 ,'0.2'     ,'240'         ,0.2     ,240         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6719 ,'0.25'    ,'300'         ,0.25    ,300         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6720 ,'0.2'     ,'240'         ,0.2     ,240         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6721 ,'0.88'    ,'1056'        ,0.88    ,1056        ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6722 ,'0.2'     ,'240'         ,0.2     ,240         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6723 ,'0.25'    ,'200'         ,0.25    ,200         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6724 ,'0.2'     ,'240'         ,0.2     ,240         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6725 ,'1.25'    ,'1000'        ,1.25    ,1000        ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6726 ,'0.88'    ,'1056'        ,0.88    ,1056        ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6727 ,'0.2'     ,'240'         ,0.2     ,240         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6728 ,'0.2'     ,'240'         ,0.2     ,240         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6729 ,'0.2'     ,'80'          ,0.2     ,80          ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6730 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6731 ,'0.1'     ,'50'          ,0.1     ,50          ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6732 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6733 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6734 ,'0.25'    ,'125'         ,0.25    ,125         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6735 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6736 ,'0.1'     ,'50'          ,0.1     ,50          ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 6716 ,'0.2'     ,'240'         ,0.2     ,240         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6717 ,'0.2'     ,'240'         ,0.2     ,240         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6718 ,'0.2'     ,'240'         ,0.2     ,240         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6719 ,'0.25'    ,'300'         ,0.25    ,300         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6720 ,'0.2'     ,'240'         ,0.2     ,240         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6721 ,'0.88'    ,'1056'        ,0.88    ,1056        ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6722 ,'0.2'     ,'240'         ,0.2     ,240         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6723 ,'0.25'    ,'200'         ,0.25    ,200         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6724 ,'0.2'     ,'240'         ,0.2     ,240         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6725 ,'1.25'    ,'1000'        ,1.25    ,1000        ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6726 ,'0.88'    ,'1056'        ,0.88    ,1056        ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6727 ,'0.2'     ,'240'         ,0.2     ,240         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6728 ,'0.2'     ,'240'         ,0.2     ,240         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6729 ,'0.2'     ,'80'          ,0.2     ,80          ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6730 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6731 ,'0.1'     ,'50'          ,0.1     ,50          ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6732 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6733 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6734 ,'0.25'    ,'125'         ,0.25    ,125         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6735 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 6736 ,'0.1'     ,'50'          ,0.1     ,50          ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
--INH
SELECT 6716 ,'10'      ,'1600'        ,10      ,1600        ,51   UNION ALL	--INH	--INH
SELECT 6717 ,'10'      ,'800'         ,10      ,800         ,51   UNION ALL	--INH	--INH
SELECT 6718 ,'10'      ,'800'         ,10      ,800         ,51   UNION ALL	--INH	--INH
SELECT 6719 ,'12.5'    ,'750'         ,12.5    ,750         ,51   UNION ALL	--INH	--INH
SELECT 6720 ,'10'      ,'800'         ,10      ,800         ,51   UNION ALL	--INH	--INH
SELECT 6721 ,'44'      ,'1760'        ,44      ,1760        ,51   UNION ALL	--INH	--INH
SELECT 6722 ,'10'      ,'800'         ,10      ,800         ,51   UNION ALL	--INH	--INH
SELECT 6723 ,'12.5'    ,'375'         ,12.5    ,375         ,51   UNION ALL	--INH	--INH
SELECT 6724 ,'10'      ,'800'         ,10      ,800         ,51   UNION ALL	--INH	--INH
SELECT 6725 ,'62.5'    ,'1250'        ,62.5    ,1250        ,51   UNION ALL	--INH	--INH
SELECT 6726 ,'44'      ,'1760'        ,44      ,1760        ,51   UNION ALL	--INH	--INH
SELECT 6727 ,'10'      ,'800'         ,10      ,800         ,51   UNION ALL	--INH	--INH
SELECT 6728 ,'10'      ,'400'         ,10      ,400         ,51   UNION ALL	--INH	--INH
SELECT 6729 ,'10'      ,'160'         ,10      ,160         ,51   UNION ALL	--INH	--INH
SELECT 6730 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6731 ,'0.1'     ,'80'          ,0.1     ,80          ,51   UNION ALL	--INH	--INH
SELECT 6732 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6733 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6734 ,'0.25'    ,'200'         ,0.25    ,200         ,51   UNION ALL	--INH	--INH
SELECT 6735 ,'0.2'     ,'160'         ,0.2     ,160         ,51   UNION ALL	--INH	--INH
SELECT 6736 ,'0.1'     ,'80'          ,0.1     ,80          ,51   UNION ALL	--INH	--INH
--INR1
SELECT 6716 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1	--INR1
SELECT 6717 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1	--INR1
SELECT 6718 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1	--INR1
SELECT 6719 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1	--INR1
SELECT 6720 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1	--INR1
SELECT 6721 ,'44'      ,'2200'        ,44      ,2200        ,10   UNION ALL	--INR1	--INR1
SELECT 6722 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1	--INR1
SELECT 6723 ,'12.5'    ,'625'         ,12.5    ,625         ,10   UNION ALL	--INR1	--INR1
SELECT 6724 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1	--INR1
SELECT 6725 ,'62.5'    ,'2500'        ,62.5    ,2500        ,10   UNION ALL	--INR1	--INR1
SELECT 6726 ,'44'      ,'2200'        ,44      ,2200        ,10   UNION ALL	--INR1	--INR1
SELECT 6727 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1	--INR1
SELECT 6728 ,'10'      ,'500'         ,10      ,500         ,10   UNION ALL	--INR1	--INR1
SELECT 6729 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1	--INR1
SELECT 6730 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1	--INR1
SELECT 6731 ,'0.5'     ,'250'         ,0.5     ,250         ,10   UNION ALL	--INR1	--INR1
SELECT 6732 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1	--INR1
SELECT 6733 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1	--INR1
SELECT 6734 ,'1.25'    ,'625'         ,1.25    ,625         ,10   UNION ALL	--INR1	--INR1
SELECT 6735 ,'1'       ,'500'         ,1       ,500         ,10   UNION ALL	--INR1	--INR1
SELECT 6736 ,'0.5'     ,'250'         ,0.5     ,250         ,10   UNION ALL	--INR1	--INR1
--RM , HKK
SELECT 6716 ,'1'       ,'160'         ,1       ,160         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6717 ,'1'       ,'160'         ,1       ,160         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6718 ,'1'       ,'160'         ,1       ,160         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6719 ,'1.25'    ,'200'         ,1.25    ,200         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6720 ,'1'       ,'200'         ,1       ,200         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6721 ,'4.4'     ,'352'         ,4.4     ,352         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6722 ,'1'       ,'200'         ,1       ,200         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6723 ,'1.25'    ,'100'         ,1.25    ,100         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6724 ,'1'       ,'200'         ,1       ,200         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6725 ,'6.25'    ,'250'         ,6.25    ,250         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6726 ,'4.4'     ,'352'         ,4.4     ,352         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6727 ,'1'       ,'200'         ,1       ,200         ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6728 ,'1'       ,'80'          ,1       ,80          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6729 ,'1'       ,'30'          ,1       ,30          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6730 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6731 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6732 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6733 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6734 ,'0.25'    ,'50'          ,0.25    ,50          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6735 ,'0.2'     ,'40'          ,0.2     ,40          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6736 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM , HKK
SELECT 6716 ,'1'       ,'160'         ,1       ,160         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6717 ,'1'       ,'160'         ,1       ,160         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6718 ,'1'       ,'160'         ,1       ,160         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6719 ,'1.25'    ,'200'         ,1.25    ,200         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6720 ,'1'       ,'200'         ,1       ,200         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6721 ,'4.4'     ,'352'         ,4.4     ,352         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6722 ,'1'       ,'200'         ,1       ,200         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6723 ,'1.25'    ,'100'         ,1.25    ,100         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6724 ,'1'       ,'200'         ,1       ,200         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6725 ,'6.25'    ,'250'         ,6.25    ,250         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6726 ,'4.4'     ,'352'         ,4.4     ,352         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6727 ,'1'       ,'200'         ,1       ,200         ,2    UNION ALL	--RM	--RM , HKK
SELECT 6728 ,'1'       ,'80'          ,1       ,80          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6729 ,'1'       ,'30'          ,1       ,30          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6730 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6731 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6732 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6733 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6734 ,'0.25'    ,'50'          ,0.25    ,50          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6735 ,'0.2'     ,'40'          ,0.2     ,40          ,2    UNION ALL	--RM	--RM , HKK
SELECT 6736 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM , HKK
--RMB , HK$
SELECT 6716 ,'2'       ,'300'         ,2       ,300         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6717 ,'2'       ,'300'         ,2       ,300         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6718 ,'2'       ,'300'         ,2       ,300         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6719 ,'2.5'     ,'250'         ,2.5     ,250         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6720 ,'2'       ,'300'         ,2       ,300         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6721 ,'8.8'     ,'528'         ,8.8     ,528         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6722 ,'2'       ,'300'         ,2       ,300         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6723 ,'2.5'     ,'150'         ,2.5     ,150         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6724 ,'2'       ,'300'         ,2       ,300         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6725 ,'12.5'    ,'500'         ,12.5    ,500         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6726 ,'8.8'     ,'528'         ,8.8     ,528         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6727 ,'2'       ,'300'         ,2       ,300         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6728 ,'2'       ,'160'         ,2       ,160         ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6729 ,'2'       ,'60'          ,2       ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6730 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6731 ,'0.1'     ,'30'          ,0.1     ,30          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6732 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6733 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6734 ,'0.25'    ,'75'          ,0.25    ,75          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6735 ,'0.2'     ,'60'          ,0.2     ,60          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6736 ,'0.1'     ,'30'          ,0.1     ,30          ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 6716 ,'2'       ,'300'         ,2       ,300         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6717 ,'2'       ,'300'         ,2       ,300         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6718 ,'2'       ,'300'         ,2       ,300         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6719 ,'2.5'     ,'250'         ,2.5     ,250         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6720 ,'2'       ,'300'         ,2       ,300         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6721 ,'8.8'     ,'528'         ,8.8     ,528         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6722 ,'2'       ,'300'         ,2       ,300         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6723 ,'2.5'     ,'150'         ,2.5     ,150         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6724 ,'2'       ,'300'         ,2       ,300         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6725 ,'12.5'    ,'500'         ,12.5    ,500         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6726 ,'8.8'     ,'528'         ,8.8     ,528         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6727 ,'2'       ,'300'         ,2       ,300         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6728 ,'2'       ,'160'         ,2       ,160         ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6729 ,'2'       ,'60'          ,2       ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6730 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6731 ,'0.1'     ,'30'          ,0.1     ,30          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6732 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6733 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6734 ,'0.25'    ,'75'          ,0.25    ,75          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6735 ,'0.2'     ,'60'          ,0.2     ,60          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6736 ,'0.1'     ,'30'          ,0.1     ,30          ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 6716 ,'2'       ,'300'         ,2       ,300         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6717 ,'2'       ,'300'         ,2       ,300         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6718 ,'2'       ,'300'         ,2       ,300         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6719 ,'2.5'     ,'250'         ,2.5     ,250         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6720 ,'2'       ,'300'         ,2       ,300         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6721 ,'8.8'     ,'528'         ,8.8     ,528         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6722 ,'2'       ,'300'         ,2       ,300         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6723 ,'2.5'     ,'150'         ,2.5     ,150         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6724 ,'2'       ,'300'         ,2       ,300         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6725 ,'12.5'    ,'500'         ,12.5    ,500         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6726 ,'8.8'     ,'528'         ,8.8     ,528         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6727 ,'2'       ,'300'         ,2       ,300         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6728 ,'2'       ,'160'         ,2       ,160         ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6729 ,'2'       ,'60'          ,2       ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6730 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6731 ,'0.1'     ,'30'          ,0.1     ,30          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6732 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6733 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6734 ,'0.25'    ,'75'          ,0.25    ,75          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6735 ,'0.2'     ,'60'          ,0.2     ,60          ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 6736 ,'0.1'     ,'30'          ,0.1     ,30          ,13   UNION ALL	--RMB	--RMB , HK$,CY
--THB , TB
SELECT 6716 ,'10'      ,'1000'        ,10      ,1000        ,43   UNION ALL	--THB	--THB , TB
SELECT 6717 ,'10'      ,'1000'        ,10      ,1000        ,43   UNION ALL	--THB	--THB , TB
SELECT 6718 ,'10'      ,'1000'        ,10      ,1000        ,43   UNION ALL	--THB	--THB , TB
SELECT 6719 ,'12.5'    ,'1250'        ,12.5    ,1250        ,43   UNION ALL	--THB	--THB , TB
SELECT 6720 ,'10'      ,'1000'        ,10      ,1000        ,43   UNION ALL	--THB	--THB , TB
SELECT 6721 ,'44'      ,'2200'        ,44      ,2200        ,43   UNION ALL	--THB	--THB , TB
SELECT 6722 ,'10'      ,'1000'        ,10      ,1000        ,43   UNION ALL	--THB	--THB , TB
SELECT 6723 ,'12.5'    ,'625'         ,12.5    ,625         ,43   UNION ALL	--THB	--THB , TB
SELECT 6724 ,'10'      ,'1000'        ,10      ,1000        ,43   UNION ALL	--THB	--THB , TB
SELECT 6725 ,'62.5'    ,'2500'        ,62.5    ,2500        ,43   UNION ALL	--THB	--THB , TB
SELECT 6726 ,'44'      ,'2200'        ,44      ,2200        ,43   UNION ALL	--THB	--THB , TB
SELECT 6727 ,'10'      ,'1000'        ,10      ,1000        ,43   UNION ALL	--THB	--THB , TB
SELECT 6728 ,'10'      ,'500'         ,10      ,500         ,43   UNION ALL	--THB	--THB , TB
SELECT 6729 ,'10'      ,'200'         ,10      ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6730 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6731 ,'0.1'     ,'100'         ,0.1     ,100         ,43   UNION ALL	--THB	--THB , TB
SELECT 6732 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6733 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6734 ,'0.25'    ,'250'         ,0.25    ,250         ,43   UNION ALL	--THB	--THB , TB
SELECT 6735 ,'0.2'     ,'200'         ,0.2     ,200         ,43   UNION ALL	--THB	--THB , TB
SELECT 6736 ,'0.1'     ,'100'         ,0.1     ,100         ,43   UNION ALL	--THB	--THB , TB
-- US$, USD , YEN , UT , $US , YNG , MMK
SELECT 6716 ,'0.4'     ,'100'         ,0.4     ,100         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6717 ,'0.4'     ,'50'          ,0.4     ,50          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6718 ,'0.4'     ,'50'          ,0.4     ,50          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6719 ,'0.5'     ,'50'          ,0.5     ,50          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6720 ,'0.4'     ,'50'          ,0.4     ,50          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6721 ,'1.76'    ,'88'          ,1.76    ,88          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6722 ,'0.4'     ,'50'          ,0.4     ,50          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6723 ,'0.5'     ,'25'          ,0.5     ,25          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6724 ,'0.4'     ,'50'          ,0.4     ,50          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6725 ,'2.5'     ,'100'         ,2.5     ,100         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6726 ,'1.76'    ,'88'          ,1.76    ,88          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6727 ,'0.4'     ,'40'          ,0.4     ,40          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6728 ,'0.4'     ,'20'          ,0.4     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6729 ,'0.4'     ,'8'           ,0.4     ,8           ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6730 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6731 ,'0.1'     ,'10'          ,0.1     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6732 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6733 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6734 ,'0.25'    ,'25'          ,0.25    ,25          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6735 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6736 ,'0.1'     ,'10'          ,0.1     ,10          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6716 ,'0.4'     ,'100'         ,0.4     ,100         ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6717 ,'0.4'     ,'50'          ,0.4     ,50          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6718 ,'0.4'     ,'50'          ,0.4     ,50          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6719 ,'0.5'     ,'50'          ,0.5     ,50          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6720 ,'0.4'     ,'50'          ,0.4     ,50          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6721 ,'1.76'    ,'88'          ,1.76    ,88          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6722 ,'0.4'     ,'50'          ,0.4     ,50          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6723 ,'0.5'     ,'25'          ,0.5     ,25          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6724 ,'0.4'     ,'50'          ,0.4     ,50          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6725 ,'2.5'     ,'100'         ,2.5     ,100         ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6726 ,'1.76'    ,'88'          ,1.76    ,88          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6727 ,'0.4'     ,'40'          ,0.4     ,40          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6728 ,'0.4'     ,'20'          ,0.4     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6729 ,'0.4'     ,'8'           ,0.4     ,8           ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6730 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6731 ,'0.1'     ,'10'          ,0.1     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6732 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6733 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6734 ,'0.25'    ,'25'          ,0.25    ,25          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6735 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6736 ,'0.1'     ,'10'          ,0.1     ,10          ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6716 ,'0.4'     ,'100'         ,0.4     ,100         ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6717 ,'0.4'     ,'50'          ,0.4     ,50          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6718 ,'0.4'     ,'50'          ,0.4     ,50          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6719 ,'0.5'     ,'50'          ,0.5     ,50          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6720 ,'0.4'     ,'50'          ,0.4     ,50          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6721 ,'1.76'    ,'88'          ,1.76    ,88          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6722 ,'0.4'     ,'50'          ,0.4     ,50          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6723 ,'0.5'     ,'25'          ,0.5     ,25          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6724 ,'0.4'     ,'50'          ,0.4     ,50          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6725 ,'2.5'     ,'100'         ,2.5     ,100         ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6726 ,'1.76'    ,'88'          ,1.76    ,88          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6727 ,'0.4'     ,'40'          ,0.4     ,40          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6728 ,'0.4'     ,'20'          ,0.4     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6729 ,'0.4'     ,'8'           ,0.4     ,8           ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6730 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6731 ,'0.1'     ,'10'          ,0.1     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6732 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6733 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6734 ,'0.25'    ,'25'          ,0.25    ,25          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6735 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6736 ,'0.1'     ,'10'          ,0.1     ,10          ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6716 ,'0.4'     ,'100'         ,0.4     ,100         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6717 ,'0.4'     ,'50'          ,0.4     ,50          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6718 ,'0.4'     ,'50'          ,0.4     ,50          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6719 ,'0.5'     ,'50'          ,0.5     ,50          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6720 ,'0.4'     ,'50'          ,0.4     ,50          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6721 ,'1.76'    ,'88'          ,1.76    ,88          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6722 ,'0.4'     ,'50'          ,0.4     ,50          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6723 ,'0.5'     ,'25'          ,0.5     ,25          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6724 ,'0.4'     ,'50'          ,0.4     ,50          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6725 ,'2.5'     ,'100'         ,2.5     ,100         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6726 ,'1.76'    ,'88'          ,1.76    ,88          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6727 ,'0.4'     ,'40'          ,0.4     ,40          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6728 ,'0.4'     ,'20'          ,0.4     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6729 ,'0.4'     ,'8'           ,0.4     ,8           ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6730 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6731 ,'0.1'     ,'10'          ,0.1     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6732 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6733 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6734 ,'0.25'    ,'25'          ,0.25    ,25          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6735 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6736 ,'0.1'     ,'10'          ,0.1     ,10          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6716 ,'0.4'     ,'100'         ,0.4     ,100         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6717 ,'0.4'     ,'50'          ,0.4     ,50          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6718 ,'0.4'     ,'50'          ,0.4     ,50          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6719 ,'0.5'     ,'50'          ,0.5     ,50          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6720 ,'0.4'     ,'50'          ,0.4     ,50          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6721 ,'1.76'    ,'88'          ,1.76    ,88          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6722 ,'0.4'     ,'50'          ,0.4     ,50          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6723 ,'0.5'     ,'25'          ,0.5     ,25          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6724 ,'0.4'     ,'50'          ,0.4     ,50          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6725 ,'2.5'     ,'100'         ,2.5     ,100         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6726 ,'1.76'    ,'88'          ,1.76    ,88          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6727 ,'0.4'     ,'40'          ,0.4     ,40          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6728 ,'0.4'     ,'20'          ,0.4     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6729 ,'0.4'     ,'8'           ,0.4     ,8           ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6730 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6731 ,'0.1'     ,'10'          ,0.1     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6732 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6733 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6734 ,'0.25'    ,'25'          ,0.25    ,25          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6735 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6736 ,'0.1'     ,'10'          ,0.1     ,10          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6716 ,'0.4'     ,'100'         ,0.4     ,100         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6717 ,'0.4'     ,'50'          ,0.4     ,50          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6718 ,'0.4'     ,'50'          ,0.4     ,50          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6719 ,'0.5'     ,'50'          ,0.5     ,50          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6720 ,'0.4'     ,'50'          ,0.4     ,50          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6721 ,'1.76'    ,'88'          ,1.76    ,88          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6722 ,'0.4'     ,'50'          ,0.4     ,50          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6723 ,'0.5'     ,'25'          ,0.5     ,25          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6724 ,'0.4'     ,'50'          ,0.4     ,50          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6725 ,'2.5'     ,'100'         ,2.5     ,100         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6726 ,'1.76'    ,'88'          ,1.76    ,88          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6727 ,'0.4'     ,'40'          ,0.4     ,40          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6728 ,'0.4'     ,'20'          ,0.4     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6729 ,'0.4'     ,'8'           ,0.4     ,8           ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6730 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6731 ,'0.1'     ,'10'          ,0.1     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6732 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6733 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6734 ,'0.25'    ,'25'          ,0.25    ,25          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6735 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6736 ,'0.1'     ,'10'          ,0.1     ,10          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6716 ,'0.4'     ,'100'         ,0.4     ,100         ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6717 ,'0.4'     ,'50'          ,0.4     ,50          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6718 ,'0.4'     ,'50'          ,0.4     ,50          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6719 ,'0.5'     ,'50'          ,0.5     ,50          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6720 ,'0.4'     ,'50'          ,0.4     ,50          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6721 ,'1.76'    ,'88'          ,1.76    ,88          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6722 ,'0.4'     ,'50'          ,0.4     ,50          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6723 ,'0.5'     ,'25'          ,0.5     ,25          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6724 ,'0.4'     ,'50'          ,0.4     ,50          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6725 ,'2.5'     ,'100'         ,2.5     ,100         ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6726 ,'1.76'    ,'88'          ,1.76    ,88          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6727 ,'0.4'     ,'40'          ,0.4     ,40          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6728 ,'0.4'     ,'20'          ,0.4     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6729 ,'0.4'     ,'8'           ,0.4     ,8           ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6730 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6731 ,'0.1'     ,'10'          ,0.1     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6732 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6733 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6734 ,'0.25'    ,'25'          ,0.25    ,25          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6735 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6736 ,'0.1'     ,'10'          ,0.1     ,10          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
--WON , KRW
SELECT 6716 ,'400'     ,'100000'      ,400     ,100000      ,45   UNION ALL	--Won	--WON , KRW
SELECT 6717 ,'400'     ,'40000'       ,400     ,40000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6718 ,'400'     ,'40000'       ,400     ,40000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6719 ,'500'     ,'50000'       ,500     ,50000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6720 ,'400'     ,'60000'       ,400     ,60000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6721 ,'1760'    ,'88000'       ,1760    ,88000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6722 ,'400'     ,'40000'       ,400     ,40000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6723 ,'500'     ,'25000'       ,500     ,25000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6724 ,'400'     ,'40000'       ,400     ,40000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6725 ,'2500'    ,'100000'      ,2500    ,100000      ,45   UNION ALL	--Won	--WON , KRW
SELECT 6726 ,'1760'    ,'88000'       ,1760    ,88000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6727 ,'400'     ,'40000'       ,400     ,40000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6728 ,'400'     ,'20000'       ,400     ,20000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6729 ,'400'     ,'8000'        ,400     ,8000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6730 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6731 ,'40'      ,'5000'        ,40      ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6732 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6733 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6734 ,'100'     ,'12500'       ,100     ,12500       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6735 ,'80'      ,'10000'       ,80      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6736 ,'40'      ,'5000'        ,40      ,5000        ,45				--Won	--WON , KRW
	
UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MinStake > 999	
	
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