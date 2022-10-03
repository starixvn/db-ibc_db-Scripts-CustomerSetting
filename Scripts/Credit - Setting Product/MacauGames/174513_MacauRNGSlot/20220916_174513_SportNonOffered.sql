/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 202209152
	Task: Macau Games - Insert value SportNonOfferedSiteCurrency [#RM:17453]
	DB: DBCUST/CustDB 
*/

USE CustDB
GO

--INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT SportType,BetType,Currency,SiteID
FROM (
	  SELECT 212 AS SportType, 4001 AS BetType, 42 AS Currency ,1 AS SiteID --Macau Games  PE  BEST-ODDS
UNION SELECT 212      ,4001     ,6        ,3           --Macau Games  EURO  789y
UNION SELECT 212      ,4001     ,2        ,3           --Macau Games  RM  789y
UNION SELECT 212      ,4001     ,42       ,16          --Macau Games  PE  611111
UNION SELECT 212      ,4001     ,2        ,16          --Macau Games  RM  611111
UNION SELECT 212      ,4001     ,13       ,20          --Macau Games  RMB  722222
UNION SELECT 212      ,4001     ,13       ,21          --Macau Games  RMB  733333
UNION SELECT 212      ,4001     ,2        ,188         --Macau Games  RM  7aa666
UNION SELECT 248      ,4101     ,42       ,1           --PP  PE  BEST-ODDS
UNION SELECT 248      ,4101     ,6        ,3           --PP  EURO  789y
UNION SELECT 248      ,4101     ,2        ,3           --PP  RM  789y
UNION SELECT 248      ,4101     ,42       ,16          --PP  PE  611111
UNION SELECT 248      ,4101     ,2        ,16          --PP  RM  611111
UNION SELECT 248      ,4101     ,13       ,20          --PP  RMB  722222
UNION SELECT 248      ,4101     ,13       ,21          --PP  RMB  733333
UNION SELECT 248      ,4101     ,2        ,188         --PP  RM  7aa666
UNION SELECT 165      ,1901     ,42       ,1           --Arcadia Gaming  PE  BEST-ODDS
UNION SELECT 165      ,1901     ,6        ,3           --Arcadia Gaming  EURO  789y
UNION SELECT 165      ,1901     ,2        ,3           --Arcadia Gaming  RM  789y
UNION SELECT 165      ,1901     ,42       ,16          --Arcadia Gaming  PE  611111
UNION SELECT 165      ,1901     ,2        ,16          --Arcadia Gaming  RM  611111
UNION SELECT 165      ,1901     ,13       ,20          --Arcadia Gaming  RMB  722222
UNION SELECT 165      ,1901     ,13       ,21          --Arcadia Gaming  RMB  733333
UNION SELECT 165      ,1901     ,2        ,188         --Arcadia Gaming  RM  7aa666
UNION SELECT 247      ,4301     ,42       ,1           --SG  PE  BEST-ODDS
UNION SELECT 247      ,4301     ,6        ,3           --SG  EURO  789y
UNION SELECT 247      ,4301     ,2        ,3           --SG  RM  789y
UNION SELECT 247      ,4301     ,42       ,16          --SG  PE  611111
UNION SELECT 247      ,4301     ,2        ,16          --SG  RM  611111
UNION SELECT 247      ,4301     ,13       ,20          --SG  RMB  722222
UNION SELECT 247      ,4301     ,13       ,21          --SG  RMB  733333
UNION SELECT 247      ,4301     ,2        ,188         --SG  RM  7aa666
UNION SELECT 232      ,6001     ,35       ,1           --PG Soft  $US  BEST-ODDS
UNION SELECT 232      ,6001     ,9        ,1           --PG Soft  AUD  BEST-ODDS
UNION SELECT 232      ,6001     ,41       ,1           --PG Soft  CHF  BEST-ODDS
UNION SELECT 232      ,6001     ,6        ,1           --PG Soft  EURO  BEST-ODDS
UNION SELECT 232      ,6001     ,12       ,1           --PG Soft  GBP  BEST-ODDS
UNION SELECT 232      ,6001     ,5        ,1           --PG Soft  HK$  BEST-ODDS
UNION SELECT 232      ,6001     ,33       ,1           --PG Soft  IDD  BEST-ODDS
UNION SELECT 232      ,6001     ,34       ,1           --PG Soft  IDR  BEST-ODDS
UNION SELECT 232      ,6001     ,15       ,1           --PG Soft  IN  BEST-ODDS
UNION SELECT 232      ,6001     ,22       ,1           --PG Soft  IND  BEST-ODDS
UNION SELECT 232      ,6001     ,42       ,1           --PG Soft  PE  BEST-ODDS
UNION SELECT 232      ,6001     ,2        ,1           --PG Soft  RM  BEST-ODDS
UNION SELECT 232      ,6001     ,13       ,1           --PG Soft  RMB  BEST-ODDS
UNION SELECT 232      ,6001     ,43       ,1           --PG Soft  THB  BEST-ODDS
UNION SELECT 232      ,6001     ,3        ,1           --PG Soft  US$  BEST-ODDS
UNION SELECT 232      ,6001     ,45       ,1           --PG Soft  Won  BEST-ODDS
UNION SELECT 232      ,6001     ,16       ,1           --PG Soft  Yen  BEST-ODDS
UNION SELECT 232      ,6001     ,6        ,3           --PG Soft  EURO  789y
UNION SELECT 232      ,6001     ,2        ,3           --PG Soft  RM  789y
UNION SELECT 232      ,6001     ,6        ,13          --PG Soft  EURO  XYZBET
UNION SELECT 232      ,6001     ,12       ,13          --PG Soft  GBP  XYZBET
UNION SELECT 232      ,6001     ,5        ,13          --PG Soft  HK$  XYZBET
UNION SELECT 232      ,6001     ,15       ,13          --PG Soft  IN  XYZBET
UNION SELECT 232      ,6001     ,2        ,13          --PG Soft  RM  XYZBET
UNION SELECT 232      ,6001     ,13       ,13          --PG Soft  RMB  XYZBET
UNION SELECT 232      ,6001     ,5        ,16          --PG Soft  HK$  611111
UNION SELECT 232      ,6001     ,42       ,16          --PG Soft  PE  611111
UNION SELECT 232      ,6001     ,2        ,16          --PG Soft  RM  611111
UNION SELECT 232      ,6001     ,13       ,16          --PG Soft  RMB  611111
UNION SELECT 232      ,6001     ,5        ,20          --PG Soft  HK$  722222
UNION SELECT 232      ,6001     ,67       ,20          --PG Soft  HKK  722222
UNION SELECT 232      ,6001     ,2        ,20          --PG Soft  RM  722222
UNION SELECT 232      ,6001     ,13       ,20          --PG Soft  RMB  722222
UNION SELECT 232      ,6001     ,5        ,21          --PG Soft  HK$  733333
UNION SELECT 232      ,6001     ,67       ,21          --PG Soft  HKK  733333
UNION SELECT 232      ,6001     ,2        ,21          --PG Soft  RM  733333
UNION SELECT 232      ,6001     ,13       ,21          --PG Soft  RMB  733333
UNION SELECT 232      ,6001     ,5        ,23          --PG Soft  HK$  222223
UNION SELECT 232      ,6001     ,67       ,23          --PG Soft  HKK  222223
UNION SELECT 232      ,6001     ,2        ,23          --PG Soft  RM  222223
UNION SELECT 232      ,6001     ,13       ,147         --PG Soft  RMB  IMBC
UNION SELECT 232      ,6001     ,69       ,188         --PG Soft  MMK  7aa666
UNION SELECT 232      ,6001     ,2        ,188         --PG Soft  RM  7aa666
UNION SELECT 234      ,6401     ,42       ,1           --Joker  PE  BEST-ODDS
UNION SELECT 234      ,6401     ,35       ,3           --Joker  $US  789y
UNION SELECT 234      ,6401     ,6        ,3           --Joker  EURO  789y
UNION SELECT 234      ,6401     ,2        ,3           --Joker  RM  789y
UNION SELECT 234      ,6401     ,3        ,3           --Joker  US$  789y
UNION SELECT 234      ,6401     ,64       ,3           --Joker  UT  789y
UNION SELECT 234      ,6401     ,16       ,3           --Joker  Yen  789y
UNION SELECT 234      ,6401     ,42       ,16          --Joker  PE  611111
UNION SELECT 234      ,6401     ,2        ,16          --Joker  RM  611111
UNION SELECT 234      ,6401     ,13       ,20          --Joker  RMB  722222
UNION SELECT 234      ,6401     ,13       ,21          --Joker  RMB  733333
UNION SELECT 234      ,6401     ,2        ,188         --Joker  RM  7aa666
UNION SELECT 237      ,5401     ,9        ,1           --MaxGame  AUD  BEST-ODDS
UNION SELECT 237      ,5401     ,41       ,1           --MaxGame  CHF  BEST-ODDS
UNION SELECT 237      ,5401     ,42       ,1           --MaxGame  PE  BEST-ODDS
UNION SELECT 237      ,5401     ,6        ,3           --MaxGame  EURO  789y
UNION SELECT 237      ,5401     ,2        ,3           --MaxGame  RM  789y
UNION SELECT 237      ,5401     ,42       ,16          --MaxGame  PE  611111
UNION SELECT 237      ,5401     ,2        ,16          --MaxGame  RM  611111
UNION SELECT 237      ,5401     ,13       ,20          --MaxGame  RMB  722222
UNION SELECT 237      ,5401     ,13       ,21          --MaxGame  RMB  733333
UNION SELECT 237      ,5401     ,2        ,188         --MaxGame  RM  7aa666
UNION SELECT 238      ,7001     ,9        ,1           --Habanero  AUD  BEST-ODDS
UNION SELECT 238      ,7001     ,41       ,1           --Habanero  CHF  BEST-ODDS
UNION SELECT 238      ,7001     ,42       ,1           --Habanero  PE  BEST-ODDS
UNION SELECT 238      ,7001     ,6        ,3           --Habanero  EURO  789y
UNION SELECT 238      ,7001     ,2        ,3           --Habanero  RM  789y
UNION SELECT 238      ,7001     ,42       ,16          --Habanero  PE  611111
UNION SELECT 238      ,7001     ,2        ,16          --Habanero  RM  611111
UNION SELECT 238      ,7001     ,13       ,20          --Habanero  RMB  722222
UNION SELECT 238      ,7001     ,13       ,21          --Habanero  RMB  733333
UNION SELECT 238      ,7001     ,2        ,188         --Habanero  RM  7aa666
UNION SELECT 238      ,7001     ,69       ,547         --Habanero  MMK  76666B
UNION SELECT 167      ,7301     ,9        ,1           --CG  AUD  BEST-ODDS
UNION SELECT 167      ,7301     ,41       ,1           --CG  CHF  BEST-ODDS
UNION SELECT 167      ,7301     ,42       ,1           --CG  PE  BEST-ODDS
UNION SELECT 167      ,7301     ,6        ,3           --CG  EURO  789y
UNION SELECT 167      ,7301     ,2        ,3           --CG  RM  789y
UNION SELECT 167      ,7301     ,42       ,16          --CG  PE  611111
UNION SELECT 167      ,7301     ,2        ,16          --CG  RM  611111
UNION SELECT 167      ,7301     ,13       ,20          --CG  RMB  722222
UNION SELECT 167      ,7301     ,13       ,21          --CG  RMB  733333
UNION SELECT 167      ,7301     ,2        ,188         --CG  RM  7aa666
UNION SELECT 167      ,7301     ,69       ,547         --CG  MMK  76666B
UNION SELECT 172      ,7701     ,9        ,1           --AdvantPlay  AUD  BEST-ODDS
UNION SELECT 172      ,7701     ,41       ,1           --AdvantPlay  CHF  BEST-ODDS
UNION SELECT 172      ,7701     ,6        ,1           --AdvantPlay  EURO  BEST-ODDS
UNION SELECT 172      ,7701     ,12       ,1           --AdvantPlay  GBP  BEST-ODDS
UNION SELECT 172      ,7701     ,5        ,1           --AdvantPlay  HK$  BEST-ODDS
UNION SELECT 172      ,7701     ,42       ,1           --AdvantPlay  PE  BEST-ODDS
UNION SELECT 172      ,7701     ,6        ,3           --AdvantPlay  EURO  789y
UNION SELECT 172      ,7701     ,2        ,3           --AdvantPlay  RM  789y
UNION SELECT 172      ,7701     ,6        ,13          --AdvantPlay  EURO  XYZBET
UNION SELECT 172      ,7701     ,12       ,13          --AdvantPlay  GBP  XYZBET
UNION SELECT 172      ,7701     ,5        ,13          --AdvantPlay  HK$  XYZBET
UNION SELECT 172      ,7701     ,5        ,16          --AdvantPlay  HK$  611111
UNION SELECT 172      ,7701     ,42       ,16          --AdvantPlay  PE  611111
UNION SELECT 172      ,7701     ,2        ,16          --AdvantPlay  RM  611111
UNION SELECT 172      ,7701     ,5        ,20          --AdvantPlay  HK$  722222
UNION SELECT 172      ,7701     ,13       ,20          --AdvantPlay  RMB  722222
UNION SELECT 172      ,7701     ,5        ,21          --AdvantPlay  HK$  733333
UNION SELECT 172      ,7701     ,13       ,21          --AdvantPlay  RMB  733333
UNION SELECT 172      ,7701     ,5        ,23          --AdvantPlay  HK$  222223
UNION SELECT 172      ,7701     ,69       ,188         --AdvantPlay  MMK  7aa666
UNION SELECT 172      ,7701     ,2        ,188         --AdvantPlay  RM  7aa666
UNION SELECT 172      ,7701     ,69       ,547         --AdvantPlay  MMK  76666B
UNION SELECT 174      ,7801     ,9        ,1           --AdvantPlay Mini  AUD  BEST-ODDS
UNION SELECT 174      ,7801     ,41       ,1           --AdvantPlay Mini  CHF  BEST-ODDS
UNION SELECT 174      ,7801     ,42       ,1           --AdvantPlay Mini  PE  BEST-ODDS
UNION SELECT 174      ,7801     ,6        ,3           --AdvantPlay Mini  EURO  789y
UNION SELECT 174      ,7801     ,2        ,3           --AdvantPlay Mini  RM  789y
UNION SELECT 174      ,7801     ,42       ,16          --AdvantPlay Mini  PE  611111
UNION SELECT 174      ,7801     ,2        ,16          --AdvantPlay Mini  RM  611111
UNION SELECT 174      ,7801     ,13       ,20          --AdvantPlay Mini  RMB  722222
UNION SELECT 174      ,7801     ,13       ,21          --AdvantPlay Mini  RMB  733333
UNION SELECT 174      ,7801     ,2        ,188         --AdvantPlay Mini  RM  7aa666
UNION SELECT 174      ,7801     ,69       ,547         --AdvantPlay Mini  MMK  76666B
UNION SELECT 156      ,8900     ,42       ,1           --SEAL Entertainment  PE  BEST-ODDS
UNION SELECT 156      ,8900     ,6        ,3           --SEAL Entertainment  EURO  789y
UNION SELECT 156      ,8900     ,2        ,3           --SEAL Entertainment  RM  789y
UNION SELECT 156      ,8900     ,42       ,16          --SEAL Entertainment  PE  611111
UNION SELECT 156      ,8900     ,2        ,16          --SEAL Entertainment  RM  611111
UNION SELECT 156      ,8900     ,13       ,20          --SEAL Entertainment  RMB  722222
UNION SELECT 156      ,8900     ,13       ,21          --SEAL Entertainment  RMB  733333
UNION SELECT 156      ,8900     ,2        ,188         --SEAL Entertainment  RM  7aa666
UNION SELECT 155      ,8400     ,42       ,1           --MG-RNG  PE  BEST-ODDS
UNION SELECT 155      ,8400     ,6        ,3           --MG-RNG  EURO  789y
UNION SELECT 155      ,8400     ,2        ,3           --MG-RNG  RM  789y
UNION SELECT 155      ,8400     ,42       ,16          --MG-RNG  PE  611111
UNION SELECT 155      ,8400     ,2        ,16          --MG-RNG  RM  611111
UNION SELECT 155      ,8400     ,13       ,20          --MG-RNG  RMB  722222
UNION SELECT 155      ,8400     ,13       ,21          --MG-RNG  RMB  733333
UNION SELECT 155      ,8400     ,2        ,188         --MG-RNG  RM  7aa666
) KQ
WHERE NOT EXISTS(SELECT TOP 1 1 FROM SportNonOfferedSiteCurrency WITH(NOLOCK) 
					WHERE SportType=KQ.SportType AND BetType=KQ.BetType 
					AND Currency=KQ.Currency AND SiteID=KQ.SiteID)


