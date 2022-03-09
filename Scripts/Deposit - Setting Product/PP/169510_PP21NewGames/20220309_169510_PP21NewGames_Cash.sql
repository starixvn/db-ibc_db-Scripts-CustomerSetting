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
SELECT 6716 ,'0.2'      ,'10'          ,0.2      ,10          ,12   UNION ALL	--GBP	--GBP
SELECT 6717 ,'0.2'      ,'5'           ,0.2      ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6718 ,'0.2'      ,'5'           ,0.2      ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6719 ,'0.25'     ,'5'           ,0.25     ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6720 ,'0.2'      ,'5'           ,0.2      ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6721 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,12   UNION ALL	--GBP	--GBP
SELECT 6722 ,'0.2'      ,'5'           ,0.2      ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6723 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,12   UNION ALL	--GBP	--GBP
SELECT 6724 ,'0.2'      ,'5'           ,0.2      ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6725 ,'1.25'     ,'10'          ,1.25     ,10          ,12   UNION ALL	--GBP	--GBP
SELECT 6726 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,12   UNION ALL	--GBP	--GBP
SELECT 6727 ,'0.2'      ,'5'           ,0.2      ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6728 ,'0.2'      ,'2'           ,0.2      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 6729 ,'0.2'      ,'0.8'         ,0.2      ,0.8         ,12   UNION ALL	--GBP	--GBP
SELECT 6730 ,'0.2'      ,'2.4'         ,0.2      ,2.4         ,12   UNION ALL	--GBP	--GBP
SELECT 6731 ,'0.1'      ,'2'           ,0.1      ,2           ,12   UNION ALL	--GBP	--GBP
SELECT 6732 ,'0.2'      ,'4'           ,0.2      ,4           ,12   UNION ALL	--GBP	--GBP
SELECT 6733 ,'0.2'      ,'2.4'         ,0.2      ,2.4         ,12   UNION ALL	--GBP	--GBP
SELECT 6734 ,'0.25'     ,'5'           ,0.25     ,5           ,12   UNION ALL	--GBP	--GBP
SELECT 6735 ,'0.2'      ,'3.2'         ,0.2      ,3.2         ,12   UNION ALL	--GBP	--GBP
SELECT 6736 ,'0.1'      ,'2'           ,0.1      ,2           ,12   UNION ALL	--GBP	--GBP
--IN,IDR
SELECT 6716 ,'0.2'      ,'160'         ,0.2      ,160         ,15   UNION ALL	--IN	--IN,IDR
SELECT 6717 ,'0.2'      ,'80'          ,0.2      ,80          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6718 ,'0.2'      ,'80'          ,0.2      ,80          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6719 ,'0.25'     ,'100'         ,0.25     ,100         ,15   UNION ALL	--IN	--IN,IDR
SELECT 6720 ,'0.2'      ,'80'          ,0.2      ,80          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6721 ,'0.88'     ,'176'         ,0.88     ,176         ,15   UNION ALL	--IN	--IN,IDR
SELECT 6722 ,'0.2'      ,'80'          ,0.2      ,80          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6723 ,'0.25'     ,'50'          ,0.25     ,50          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6724 ,'0.2'      ,'80'          ,0.2      ,80          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6725 ,'1.25'     ,'125'         ,1.25     ,125         ,15   UNION ALL	--IN	--IN,IDR
SELECT 6726 ,'0.88'     ,'176'         ,0.88     ,176         ,15   UNION ALL	--IN	--IN,IDR
SELECT 6727 ,'0.2'      ,'80'          ,0.2      ,80          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6728 ,'0.2'      ,'40'          ,0.2      ,40          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6729 ,'0.2'      ,'14'          ,0.2      ,14          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6730 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6731 ,'0.1'      ,'10'          ,0.1      ,10          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6732 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6733 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6734 ,'0.25'     ,'25'          ,0.25     ,25          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6735 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,IDR
SELECT 6736 ,'0.1'      ,'10'          ,0.1      ,10          ,15   UNION ALL	--IN	--IN,IDR
--INH,VND
SELECT 6716 ,'2'        ,'360'         ,2        ,360         ,51   UNION ALL	--INH	--INH,VND
SELECT 6717 ,'2'        ,'160'         ,2        ,160         ,51   UNION ALL	--INH	--INH,VND
SELECT 6718 ,'2'        ,'160'         ,2        ,160         ,51   UNION ALL	--INH	--INH,VND
SELECT 6719 ,'2.5'      ,'200'         ,2.5      ,200         ,51   UNION ALL	--INH	--INH,VND
SELECT 6720 ,'2'        ,'280'         ,2        ,280         ,51   UNION ALL	--INH	--INH,VND
SELECT 6721 ,'8.8'      ,'440'         ,8.8      ,440         ,51   UNION ALL	--INH	--INH,VND
SELECT 6722 ,'2'        ,'160'         ,2        ,160         ,51   UNION ALL	--INH	--INH,VND
SELECT 6723 ,'2.5'      ,'75'          ,2.5      ,75          ,51   UNION ALL	--INH	--INH,VND
SELECT 6724 ,'2'        ,'160'         ,2        ,160         ,51   UNION ALL	--INH	--INH,VND
SELECT 6725 ,'12.5'     ,'375'         ,12.5     ,375         ,51   UNION ALL	--INH	--INH,VND
SELECT 6726 ,'8.8'      ,'440'         ,8.8      ,440         ,51   UNION ALL	--INH	--INH,VND
SELECT 6727 ,'2'        ,'160'         ,2        ,160         ,51   UNION ALL	--INH	--INH,VND
SELECT 6728 ,'2'        ,'100'         ,2        ,100         ,51   UNION ALL	--INH	--INH,VND
SELECT 6729 ,'2'        ,'40'          ,2        ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 6730 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6731 ,'0.1'      ,'40'          ,0.1      ,40          ,51   UNION ALL	--INH	--INH,VND
SELECT 6732 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6733 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6734 ,'0.25'     ,'100'         ,0.25     ,100         ,51   UNION ALL	--INH	--INH,VND
SELECT 6735 ,'0.2'      ,'80'          ,0.2      ,80          ,51   UNION ALL	--INH	--INH,VND
SELECT 6736 ,'0.1'      ,'40'          ,0.1      ,40          ,51   UNION ALL	--INH	--INH,VND
--INR, RUB
SELECT 6716 ,'1'        ,'1200'        ,1        ,1200        ,61   UNION ALL	--INR	--INR, RUB
SELECT 6717 ,'1'        ,'600'         ,1        ,600         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6718 ,'1'        ,'600'         ,1        ,600         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6719 ,'1.25'     ,'500'         ,1.25     ,500         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6720 ,'1'        ,'600'         ,1        ,600         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6721 ,'4.4'      ,'880'         ,4.4      ,880         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6722 ,'1'        ,'600'         ,1        ,600         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6723 ,'1.25'     ,'250'         ,1.25     ,250         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6724 ,'1'        ,'600'         ,1        ,600         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6725 ,'6.25'     ,'625'         ,6.25     ,625         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6726 ,'4.4'      ,'880'         ,4.4      ,880         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6727 ,'1'        ,'600'         ,1        ,600         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6728 ,'1'        ,'200'         ,1        ,200         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6729 ,'1'        ,'100'         ,1        ,100         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6730 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6731 ,'0.5'      ,'120'         ,0.5      ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6732 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6733 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6734 ,'1.25'     ,'300'         ,1.25     ,300         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6735 ,'1'        ,'240'         ,1        ,240         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6736 ,'0.5'      ,'120'         ,0.5      ,120         ,61   UNION ALL	--INR	--INR, RUB
SELECT 6716 ,'1'        ,'1200'        ,1        ,1200        ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6717 ,'1'        ,'600'         ,1        ,600         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6718 ,'1'        ,'600'         ,1        ,600         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6719 ,'1.25'     ,'500'         ,1.25     ,500         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6720 ,'1'        ,'600'         ,1        ,600         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6721 ,'4.4'      ,'880'         ,4.4      ,880         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6722 ,'1'        ,'600'         ,1        ,600         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6723 ,'1.25'     ,'250'         ,1.25     ,250         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6724 ,'1'        ,'600'         ,1        ,600         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6725 ,'6.25'     ,'625'         ,6.25     ,625         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6726 ,'4.4'      ,'880'         ,4.4      ,880         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6727 ,'1'        ,'600'         ,1        ,600         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6728 ,'1'        ,'200'         ,1        ,200         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6729 ,'1'        ,'100'         ,1        ,100         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6730 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6731 ,'0.5'      ,'120'         ,0.5      ,120         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6732 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6733 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6734 ,'1.25'     ,'300'         ,1.25     ,300         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6735 ,'1'        ,'240'         ,1        ,240         ,55   UNION ALL	--RUB	--INR, RUB
SELECT 6736 ,'0.5'      ,'120'         ,0.5      ,120         ,55   UNION ALL	--RUB	--INR, RUB
--JPY
SELECT 6716 ,'10'       ,'2000'        ,10       ,2000        ,32   UNION ALL	--JPY	--JPY
SELECT 6717 ,'10'       ,'1000'        ,10       ,1000        ,32   UNION ALL	--JPY	--JPY
SELECT 6718 ,'10'       ,'1000'        ,10       ,1000        ,32   UNION ALL	--JPY	--JPY
SELECT 6719 ,'12.5'     ,'1000'        ,12.5     ,1000        ,32   UNION ALL	--JPY	--JPY
SELECT 6720 ,'10'       ,'1000'        ,10       ,1000        ,32   UNION ALL	--JPY	--JPY
SELECT 6721 ,'44'       ,'1760'        ,44       ,1760        ,32   UNION ALL	--JPY	--JPY
SELECT 6722 ,'10'       ,'1000'        ,10       ,1000        ,32   UNION ALL	--JPY	--JPY
SELECT 6723 ,'12.5'     ,'500'         ,12.5     ,500         ,32   UNION ALL	--JPY	--JPY
SELECT 6724 ,'10'       ,'1000'        ,10       ,1000        ,32   UNION ALL	--JPY	--JPY
SELECT 6725 ,'62.5'     ,'1875'        ,62.5     ,1875        ,32   UNION ALL	--JPY	--JPY
SELECT 6726 ,'44'       ,'1760'        ,44       ,1760        ,32   UNION ALL	--JPY	--JPY
SELECT 6727 ,'10'       ,'1000'        ,10       ,1000        ,32   UNION ALL	--JPY	--JPY
SELECT 6728 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6729 ,'10'       ,'100'         ,10       ,100         ,32   UNION ALL	--JPY	--JPY
SELECT 6730 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6731 ,'5'        ,'200'         ,5        ,200         ,32   UNION ALL	--JPY	--JPY
SELECT 6732 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6733 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6734 ,'12.5'     ,'500'         ,12.5     ,500         ,32   UNION ALL	--JPY	--JPY
SELECT 6735 ,'10'       ,'400'         ,10       ,400         ,32   UNION ALL	--JPY	--JPY
SELECT 6736 ,'5'        ,'200'         ,5        ,200         ,32   UNION ALL	--JPY	--JPY
--RM, MYR,  PLN, KHR
SELECT 6716 ,'0.2'      ,'50'          ,0.2      ,50          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6717 ,'0.2'      ,'30'          ,0.2      ,30          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6718 ,'0.2'      ,'30'          ,0.2      ,30          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6719 ,'0.25'     ,'30'          ,0.25     ,30          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6720 ,'0.2'      ,'30'          ,0.2      ,30          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6721 ,'0.88'     ,'44'          ,0.88     ,44          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6722 ,'0.2'      ,'30'          ,0.2      ,30          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6723 ,'0.25'     ,'15'          ,0.25     ,15          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6724 ,'0.2'      ,'30'          ,0.2      ,30          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6725 ,'1.25'     ,'50'          ,1.25     ,50          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6726 ,'0.88'     ,'44'          ,0.88     ,44          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6727 ,'0.2'      ,'30'          ,0.2      ,30          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6728 ,'0.2'      ,'14'          ,0.2      ,14          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6729 ,'0.2'      ,'4'           ,0.2      ,4           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6730 ,'0.2'      ,'12'          ,0.2      ,12          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6731 ,'0.1'      ,'8'           ,0.1      ,8           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6732 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6733 ,'0.2'      ,'12'          ,0.2      ,12          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6734 ,'0.25'     ,'20'          ,0.25     ,20          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6735 ,'0.2'      ,'16'          ,0.2      ,16          ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6736 ,'0.1'      ,'8'           ,0.1      ,8           ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 6716 ,'0.2'      ,'50'          ,0.2      ,50          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6717 ,'0.2'      ,'30'          ,0.2      ,30          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6718 ,'0.2'      ,'30'          ,0.2      ,30          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6719 ,'0.25'     ,'30'          ,0.25     ,30          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6720 ,'0.2'      ,'30'          ,0.2      ,30          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6721 ,'0.88'     ,'44'          ,0.88     ,44          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6722 ,'0.2'      ,'30'          ,0.2      ,30          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6723 ,'0.25'     ,'15'          ,0.25     ,15          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6724 ,'0.2'      ,'30'          ,0.2      ,30          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6725 ,'1.25'     ,'50'          ,1.25     ,50          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6726 ,'0.88'     ,'44'          ,0.88     ,44          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6727 ,'0.2'      ,'30'          ,0.2      ,30          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6728 ,'0.2'      ,'14'          ,0.2      ,14          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6729 ,'0.2'      ,'4'           ,0.2      ,4           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6730 ,'0.2'      ,'12'          ,0.2      ,12          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6731 ,'0.1'      ,'8'           ,0.1      ,8           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6732 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6733 ,'0.2'      ,'12'          ,0.2      ,12          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6734 ,'0.25'     ,'20'          ,0.25     ,20          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6735 ,'0.2'      ,'16'          ,0.2      ,16          ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6736 ,'0.1'      ,'8'           ,0.1      ,8           ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 6716 ,'0.2'      ,'50'          ,0.2      ,50          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6717 ,'0.2'      ,'30'          ,0.2      ,30          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6718 ,'0.2'      ,'30'          ,0.2      ,30          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6719 ,'0.25'     ,'30'          ,0.25     ,30          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6720 ,'0.2'      ,'30'          ,0.2      ,30          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6721 ,'0.88'     ,'44'          ,0.88     ,44          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6722 ,'0.2'      ,'30'          ,0.2      ,30          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6723 ,'0.25'     ,'15'          ,0.25     ,15          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6724 ,'0.2'      ,'30'          ,0.2      ,30          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6725 ,'1.25'     ,'50'          ,1.25     ,50          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6726 ,'0.88'     ,'44'          ,0.88     ,44          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6727 ,'0.2'      ,'30'          ,0.2      ,30          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6728 ,'0.2'      ,'14'          ,0.2      ,14          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6729 ,'0.2'      ,'4'           ,0.2      ,4           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6730 ,'0.2'      ,'12'          ,0.2      ,12          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6731 ,'0.1'      ,'8'           ,0.1      ,8           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6732 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6733 ,'0.2'      ,'12'          ,0.2      ,12          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6734 ,'0.25'     ,'20'          ,0.25     ,20          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6735 ,'0.2'      ,'16'          ,0.2      ,16          ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 6736 ,'0.1'      ,'8'           ,0.1      ,8           ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6716 ,'0.4'      ,'100'         ,0.4      ,100         ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6717 ,'0.4'      ,'50'          ,0.4      ,50          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6718 ,'0.4'      ,'50'          ,0.4      ,50          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6719 ,'0.5'      ,'50'          ,0.5      ,50          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6720 ,'0.4'      ,'50'          ,0.4      ,50          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6721 ,'1.76'     ,'44'          ,1.76     ,44          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6722 ,'0.4'      ,'50'          ,0.4      ,50          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6723 ,'0.5'      ,'12.5'        ,0.5      ,12.5        ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6724 ,'0.4'      ,'50'          ,0.4      ,50          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6725 ,'2.5'      ,'62.5'        ,2.5      ,62.5        ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6726 ,'1.76'     ,'44'          ,1.76     ,44          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6727 ,'0.4'      ,'50'          ,0.4      ,50          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6728 ,'0.4'      ,'10'          ,0.4      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6729 ,'0.4'      ,'8'           ,0.4      ,8           ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6730 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6731 ,'0.1'      ,'10'          ,0.1      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6732 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6733 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6734 ,'0.25'     ,'25'          ,0.25     ,25          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6735 ,'0.2'      ,'20'          ,0.2      ,20          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6736 ,'0.1'      ,'10'          ,0.1      ,10          ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6716 ,'0.4'      ,'100'         ,0.4      ,100         ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6717 ,'0.4'      ,'50'          ,0.4      ,50          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6718 ,'0.4'      ,'50'          ,0.4      ,50          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6719 ,'0.5'      ,'50'          ,0.5      ,50          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6720 ,'0.4'      ,'50'          ,0.4      ,50          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6721 ,'1.76'     ,'44'          ,1.76     ,44          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6722 ,'0.4'      ,'50'          ,0.4      ,50          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6723 ,'0.5'      ,'12.5'        ,0.5      ,12.5        ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6724 ,'0.4'      ,'50'          ,0.4      ,50          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6725 ,'2.5'      ,'62.5'        ,2.5      ,62.5        ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6726 ,'1.76'     ,'44'          ,1.76     ,44          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6727 ,'0.4'      ,'50'          ,0.4      ,50          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6728 ,'0.4'      ,'10'          ,0.4      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6729 ,'0.4'      ,'8'           ,0.4      ,8           ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6730 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6731 ,'0.1'      ,'10'          ,0.1      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6732 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6733 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6734 ,'0.25'     ,'25'          ,0.25     ,25          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6735 ,'0.2'      ,'20'          ,0.2      ,20          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6736 ,'0.1'      ,'10'          ,0.1      ,10          ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6716 ,'0.4'      ,'100'         ,0.4      ,100         ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6717 ,'0.4'      ,'50'          ,0.4      ,50          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6718 ,'0.4'      ,'50'          ,0.4      ,50          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6719 ,'0.5'      ,'50'          ,0.5      ,50          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6720 ,'0.4'      ,'50'          ,0.4      ,50          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6721 ,'1.76'     ,'44'          ,1.76     ,44          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6722 ,'0.4'      ,'50'          ,0.4      ,50          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6723 ,'0.5'      ,'12.5'        ,0.5      ,12.5        ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6724 ,'0.4'      ,'50'          ,0.4      ,50          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6725 ,'2.5'      ,'62.5'        ,2.5      ,62.5        ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6726 ,'1.76'     ,'44'          ,1.76     ,44          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6727 ,'0.4'      ,'50'          ,0.4      ,50          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6728 ,'0.4'      ,'10'          ,0.4      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6729 ,'0.4'      ,'8'           ,0.4      ,8           ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6730 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6731 ,'0.1'      ,'10'          ,0.1      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6732 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6733 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6734 ,'0.25'     ,'25'          ,0.25     ,25          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6735 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6736 ,'0.1'      ,'10'          ,0.1      ,10          ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6716 ,'0.4'      ,'100'         ,0.4      ,100         ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6717 ,'0.4'      ,'50'          ,0.4      ,50          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6718 ,'0.4'      ,'50'          ,0.4      ,50          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6719 ,'0.5'      ,'50'          ,0.5      ,50          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6720 ,'0.4'      ,'50'          ,0.4      ,50          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6721 ,'1.76'     ,'44'          ,1.76     ,44          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6722 ,'0.4'      ,'50'          ,0.4      ,50          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6723 ,'0.5'      ,'12.5'        ,0.5      ,12.5        ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6724 ,'0.4'      ,'50'          ,0.4      ,50          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6725 ,'2.5'      ,'62.5'        ,2.5      ,62.5        ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6726 ,'1.76'     ,'44'          ,1.76     ,44          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6727 ,'0.4'      ,'50'          ,0.4      ,50          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6728 ,'0.4'      ,'10'          ,0.4      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6729 ,'0.4'      ,'8'           ,0.4      ,8           ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6730 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6731 ,'0.1'      ,'10'          ,0.1      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6732 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6733 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6734 ,'0.25'     ,'25'          ,0.25     ,25          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6735 ,'0.2'      ,'20'          ,0.2      ,20          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6736 ,'0.1'      ,'10'          ,0.1      ,10          ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6716 ,'0.4'      ,'100'         ,0.4      ,100         ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6717 ,'0.4'      ,'50'          ,0.4      ,50          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6718 ,'0.4'      ,'50'          ,0.4      ,50          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6719 ,'0.5'      ,'50'          ,0.5      ,50          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6720 ,'0.4'      ,'50'          ,0.4      ,50          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6721 ,'1.76'     ,'44'          ,1.76     ,44          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6722 ,'0.4'      ,'50'          ,0.4      ,50          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6723 ,'0.5'      ,'12.5'        ,0.5      ,12.5        ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6724 ,'0.4'      ,'50'          ,0.4      ,50          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6725 ,'2.5'      ,'62.5'        ,2.5      ,62.5        ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6726 ,'1.76'     ,'44'          ,1.76     ,44          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6727 ,'0.4'      ,'50'          ,0.4      ,50          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6728 ,'0.4'      ,'10'          ,0.4      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6729 ,'0.4'      ,'8'           ,0.4      ,8           ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6730 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6731 ,'0.1'      ,'10'          ,0.1      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6732 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6733 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6734 ,'0.25'     ,'25'          ,0.25     ,25          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6735 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 6736 ,'0.1'      ,'10'          ,0.1      ,10          ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
--THB , TB
SELECT 6716 ,'2'        ,'500'         ,2        ,500         ,4    UNION ALL	--TB	--THB , TB
SELECT 6717 ,'2'        ,'240'         ,2        ,240         ,4    UNION ALL	--TB	--THB , TB
SELECT 6718 ,'2'        ,'240'         ,2        ,240         ,4    UNION ALL	--TB	--THB , TB
SELECT 6719 ,'2.5'      ,'300'         ,2.5      ,300         ,4    UNION ALL	--TB	--THB , TB
SELECT 6720 ,'2'        ,'400'         ,2        ,400         ,4    UNION ALL	--TB	--THB , TB
SELECT 6721 ,'8.8'      ,'528'         ,8.8      ,528         ,4    UNION ALL	--TB	--THB , TB
SELECT 6722 ,'2'        ,'240'         ,2        ,240         ,4    UNION ALL	--TB	--THB , TB
SELECT 6723 ,'2.5'      ,'150'         ,2.5      ,150         ,4    UNION ALL	--TB	--THB , TB
SELECT 6724 ,'2'        ,'240'         ,2        ,240         ,4    UNION ALL	--TB	--THB , TB
SELECT 6725 ,'12.5'     ,'500'         ,12.5     ,500         ,4    UNION ALL	--TB	--THB , TB
SELECT 6726 ,'8.8'      ,'528'         ,8.8      ,528         ,4    UNION ALL	--TB	--THB , TB
SELECT 6727 ,'2'        ,'240'         ,2        ,240         ,4    UNION ALL	--TB	--THB , TB
SELECT 6728 ,'2'        ,'160'         ,2        ,160         ,4    UNION ALL	--TB	--THB , TB
SELECT 6729 ,'2'        ,'60'          ,2        ,60          ,4    UNION ALL	--TB	--THB , TB
SELECT 6730 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6731 ,'0.1'      ,'50'          ,0.1      ,50          ,4    UNION ALL	--TB	--THB , TB
SELECT 6732 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6733 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6734 ,'0.25'     ,'125'         ,0.25     ,125         ,4    UNION ALL	--TB	--THB , TB
SELECT 6735 ,'0.2'      ,'100'         ,0.2      ,100         ,4    UNION ALL	--TB	--THB , TB
SELECT 6736 ,'0.1'      ,'50'          ,0.1      ,50          ,4    UNION ALL	--TB	--THB , TB
--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6716 ,'0.2'      ,'12'          ,0.2      ,12          ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6717 ,'0.2'      ,'7'           ,0.2      ,7           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6718 ,'0.2'      ,'7'           ,0.2      ,7           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6719 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6720 ,'0.2'      ,'6'           ,0.2      ,6           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6721 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6722 ,'0.2'      ,'6'           ,0.2      ,6           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6723 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6724 ,'0.2'      ,'6'           ,0.2      ,6           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6725 ,'1.25'     ,'12.5'        ,1.25     ,12.5        ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6726 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6727 ,'0.2'      ,'6'           ,0.2      ,6           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6728 ,'0.2'      ,'3'           ,0.2      ,3           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6729 ,'0.2'      ,'0.8'         ,0.2      ,0.8         ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6730 ,'0.2'      ,'4'           ,0.2      ,4           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6731 ,'0.1'      ,'4'           ,0.1      ,4           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6732 ,'0.2'      ,'8'           ,0.2      ,8           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6733 ,'0.2'      ,'4'           ,0.2      ,4           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6734 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6735 ,'0.2'      ,'6'           ,0.2      ,6           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6736 ,'0.1'      ,'4'           ,0.1      ,4           ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6716 ,'0.2'      ,'12'          ,0.2      ,12          ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6717 ,'0.2'      ,'7'           ,0.2      ,7           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6718 ,'0.2'      ,'7'           ,0.2      ,7           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6719 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6720 ,'0.2'      ,'6'           ,0.2      ,6           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6721 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6722 ,'0.2'      ,'6'           ,0.2      ,6           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6723 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6724 ,'0.2'      ,'6'           ,0.2      ,6           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6725 ,'1.25'     ,'12.5'        ,1.25     ,12.5        ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6726 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6727 ,'0.2'      ,'6'           ,0.2      ,6           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6728 ,'0.2'      ,'3'           ,0.2      ,3           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6729 ,'0.2'      ,'0.8'         ,0.2      ,0.8         ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6730 ,'0.2'      ,'4'           ,0.2      ,4           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6731 ,'0.1'      ,'4'           ,0.1      ,4           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6732 ,'0.2'      ,'8'           ,0.2      ,8           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6733 ,'0.2'      ,'4'           ,0.2      ,4           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6734 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6735 ,'0.2'      ,'6'           ,0.2      ,6           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6736 ,'0.1'      ,'4'           ,0.1      ,4           ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6716 ,'0.2'      ,'12'          ,0.2      ,12          ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6717 ,'0.2'      ,'7'           ,0.2      ,7           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6718 ,'0.2'      ,'7'           ,0.2      ,7           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6719 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6720 ,'0.2'      ,'6'           ,0.2      ,6           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6721 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6722 ,'0.2'      ,'6'           ,0.2      ,6           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6723 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6724 ,'0.2'      ,'6'           ,0.2      ,6           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6725 ,'1.25'     ,'12.5'        ,1.25     ,12.5        ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6726 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6727 ,'0.2'      ,'6'           ,0.2      ,6           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6728 ,'0.2'      ,'3'           ,0.2      ,3           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6729 ,'0.2'      ,'0.8'         ,0.2      ,0.8         ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6730 ,'0.2'      ,'4'           ,0.2      ,4           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6731 ,'0.1'      ,'4'           ,0.1      ,4           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6732 ,'0.2'      ,'8'           ,0.2      ,8           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6733 ,'0.2'      ,'4'           ,0.2      ,4           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6734 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6735 ,'0.2'      ,'6'           ,0.2      ,6           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6736 ,'0.1'      ,'4'           ,0.1      ,4           ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6716 ,'0.2'      ,'12'          ,0.2      ,12          ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6717 ,'0.2'      ,'7'           ,0.2      ,7           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6718 ,'0.2'      ,'7'           ,0.2      ,7           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6719 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6720 ,'0.2'      ,'6'           ,0.2      ,6           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6721 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6722 ,'0.2'      ,'6'           ,0.2      ,6           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6723 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6724 ,'0.2'      ,'6'           ,0.2      ,6           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6725 ,'1.25'     ,'12.5'        ,1.25     ,12.5        ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6726 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6727 ,'0.2'      ,'6'           ,0.2      ,6           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6728 ,'0.2'      ,'3'           ,0.2      ,3           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6729 ,'0.2'      ,'0.8'         ,0.2      ,0.8         ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6730 ,'0.2'      ,'4'           ,0.2      ,4           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6731 ,'0.1'      ,'4'           ,0.1      ,4           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6732 ,'0.2'      ,'8'           ,0.2      ,8           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6733 ,'0.2'      ,'4'           ,0.2      ,4           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6734 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6735 ,'0.2'      ,'6'           ,0.2      ,6           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6736 ,'0.1'      ,'4'           ,0.1      ,4           ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6716 ,'0.2'      ,'12'          ,0.2      ,12          ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6717 ,'0.2'      ,'7'           ,0.2      ,7           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6718 ,'0.2'      ,'7'           ,0.2      ,7           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6719 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6720 ,'0.2'      ,'6'           ,0.2      ,6           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6721 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6722 ,'0.2'      ,'6'           ,0.2      ,6           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6723 ,'0.25'     ,'2.5'         ,0.25     ,2.5         ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6724 ,'0.2'      ,'6'           ,0.2      ,6           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6725 ,'1.25'     ,'12.5'        ,1.25     ,12.5        ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6726 ,'0.88'     ,'8.8'         ,0.88     ,8.8         ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6727 ,'0.2'      ,'6'           ,0.2      ,6           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6728 ,'0.2'      ,'3'           ,0.2      ,3           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6729 ,'0.2'      ,'0.8'         ,0.2      ,0.8         ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6730 ,'0.2'      ,'4'           ,0.2      ,4           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6731 ,'0.1'      ,'4'           ,0.1      ,4           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6732 ,'0.2'      ,'8'           ,0.2      ,8           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6733 ,'0.2'      ,'4'           ,0.2      ,4           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6734 ,'0.25'     ,'7.5'         ,0.25     ,7.5         ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6735 ,'0.2'      ,'6'           ,0.2      ,6           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6736 ,'0.1'      ,'4'           ,0.1      ,4           ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
--WON , KRW
SELECT 6716 ,'80'       ,'20000'       ,80       ,20000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6717 ,'80'       ,'10000'       ,80       ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6718 ,'80'       ,'10000'       ,80       ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6719 ,'100'      ,'10000'       ,100      ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6720 ,'80'       ,'10000'       ,80       ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6721 ,'352'      ,'17600'       ,352      ,17600       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6722 ,'80'       ,'10000'       ,80       ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6723 ,'100'      ,'5000'        ,100      ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6724 ,'80'       ,'10000'       ,80       ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6725 ,'500'      ,'12500'       ,500      ,12500       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6726 ,'352'      ,'17600'       ,352      ,17600       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6727 ,'80'       ,'10000'       ,80       ,10000       ,45   UNION ALL	--Won	--WON , KRW
SELECT 6728 ,'80'       ,'4000'        ,80       ,4000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6729 ,'80'       ,'1000'        ,80       ,1000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6730 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6731 ,'40'       ,'2500'        ,40       ,2500        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6732 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6733 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6734 ,'100'      ,'6250'        ,100      ,6250        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6735 ,'80'       ,'5000'        ,80       ,5000        ,45   UNION ALL	--Won	--WON , KRW
SELECT 6736 ,'40'       ,'2500'        ,40       ,2500        ,45				--Won	--WON , KRW

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