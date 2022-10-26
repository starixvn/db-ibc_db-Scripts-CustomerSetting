/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Macau Games - Update value ProductStatusSiteCurrency [#RM:174744]
	DB: DBCUST/CustDB 
*/

	USE CustDB
	GO

	CREATE TABLE #NonOfferedSiteCurency(SiteID INT,	currency INT, SportType	SMALLINT, BetType SMALLINT, 
					IsHidden BIT DEFAULT(1), IsDisabled	BIT DEFAULT(1), HasSynced BIT DEFAULT(0) )

	INSERT INTO #NonOfferedSiteCurency (SportType,BetType,Currency,SiteID)
	SELECT SportType,BetType,Currency,SiteID
	FROM (
		  SELECT 213 AS SportType, 2501 AS BetType, 35 AS Currency ,1 AS SiteID --NG2--$US--BEST-ODDS
	UNION SELECT 219      ,1011     ,35       ,1           --Fishing World--$US--BEST-ODDS
	UNION SELECT 200      ,1611     ,35       ,1           --SABA.games--$US--BEST-ODDS
	UNION SELECT 242      ,3201     ,35       ,1           --IBCBet Live Casino--$US--BEST-ODDS
	UNION SELECT 171      ,3801     ,35       ,1           --Vgaming--$US--BEST-ODDS
	UNION SELECT 208      ,2101     ,9        ,1           --Saba Casino--AUD--BEST-ODDS
	UNION SELECT 213      ,2501     ,9        ,1           --NG2--AUD--BEST-ODDS
	UNION SELECT 219      ,1011     ,9        ,1           --Fishing World--AUD--BEST-ODDS
	UNION SELECT 200      ,1611     ,9        ,1           --SABA.games--AUD--BEST-ODDS
	UNION SELECT 243      ,3101     ,9        ,1           --AE Sexy--AUD--BEST-ODDS
	UNION SELECT 242      ,3201     ,9        ,1           --IBCBet Live Casino--AUD--BEST-ODDS
	UNION SELECT 241      ,3300     ,9        ,1           --BBIN--AUD--BEST-ODDS
	UNION SELECT 233      ,3401     ,9        ,1           --WM--AUD--BEST-ODDS
	UNION SELECT 225      ,5601     ,9        ,1           --ION--AUD--BEST-ODDS
	UNION SELECT 239      ,3501     ,9        ,1           --BG--AUD--BEST-ODDS
	UNION SELECT 236      ,5701     ,9        ,1           --GDG--AUD--BEST-ODDS
	UNION SELECT 170      ,3701     ,9        ,1           --PP Live Casino--AUD--BEST-ODDS
	UNION SELECT 171      ,3801     ,9        ,1           --Vgaming--AUD--BEST-ODDS
	UNION SELECT 176      ,8201     ,9        ,1           --FGG--AUD--BEST-ODDS
	UNION SELECT 208      ,2101     ,41       ,1           --Saba Casino--CHF--BEST-ODDS
	UNION SELECT 213      ,2501     ,41       ,1           --NG2--CHF--BEST-ODDS
	UNION SELECT 219      ,1011     ,41       ,1           --Fishing World--CHF--BEST-ODDS
	UNION SELECT 244      ,3001     ,41       ,1           --SA Gaming--CHF--BEST-ODDS
	UNION SELECT 200      ,1611     ,41       ,1           --SABA.games--CHF--BEST-ODDS
	UNION SELECT 243      ,3101     ,41       ,1           --AE Sexy--CHF--BEST-ODDS
	UNION SELECT 242      ,3201     ,41       ,1           --IBCBet Live Casino--CHF--BEST-ODDS
	UNION SELECT 241      ,3300     ,41       ,1           --BBIN--CHF--BEST-ODDS
	UNION SELECT 233      ,3401     ,41       ,1           --WM--CHF--BEST-ODDS
	UNION SELECT 225      ,5601     ,41       ,1           --ION--CHF--BEST-ODDS
	UNION SELECT 239      ,3501     ,41       ,1           --BG--CHF--BEST-ODDS
	UNION SELECT 236      ,5701     ,41       ,1           --GDG--CHF--BEST-ODDS
	UNION SELECT 170      ,3701     ,41       ,1           --PP Live Casino--CHF--BEST-ODDS
	UNION SELECT 171      ,3801     ,41       ,1           --Vgaming--CHF--BEST-ODDS
	UNION SELECT 176      ,8201     ,41       ,1           --FGG--CHF--BEST-ODDS
	UNION SELECT 213      ,2501     ,6        ,1           --NG2--EURO--BEST-ODDS
	UNION SELECT 219      ,1011     ,6        ,1           --Fishing World--EURO--BEST-ODDS
	UNION SELECT 242      ,3201     ,6        ,1           --IBCBet Live Casino--EURO--BEST-ODDS
	UNION SELECT 233      ,3401     ,6        ,1           --WM--EURO--BEST-ODDS
	UNION SELECT 236      ,5701     ,6        ,1           --GDG--EURO--BEST-ODDS
	UNION SELECT 208      ,2101     ,12       ,1           --Saba Casino--GBP--BEST-ODDS
	UNION SELECT 213      ,2501     ,12       ,1           --NG2--GBP--BEST-ODDS
	UNION SELECT 219      ,1011     ,12       ,1           --Fishing World--GBP--BEST-ODDS
	UNION SELECT 242      ,3201     ,12       ,1           --IBCBet Live Casino--GBP--BEST-ODDS
	UNION SELECT 233      ,3401     ,12       ,1           --WM--GBP--BEST-ODDS
	UNION SELECT 236      ,5701     ,12       ,1           --GDG--GBP--BEST-ODDS
	UNION SELECT 176      ,8201     ,12       ,1           --FGG--GBP--BEST-ODDS
	UNION SELECT 213      ,2501     ,5        ,1           --NG2--HK$--BEST-ODDS
	UNION SELECT 219      ,1011     ,5        ,1           --Fishing World--HK$--BEST-ODDS
	UNION SELECT 242      ,3201     ,5        ,1           --IBCBet Live Casino--HK$--BEST-ODDS
	UNION SELECT 239      ,3501     ,5        ,1           --BG--HK$--BEST-ODDS
	UNION SELECT 213      ,2501     ,33       ,1           --NG2--IDD--BEST-ODDS
	UNION SELECT 219      ,1011     ,33       ,1           --Fishing World--IDD--BEST-ODDS
	UNION SELECT 200      ,1611     ,33       ,1           --SABA.games--IDD--BEST-ODDS
	UNION SELECT 242      ,3201     ,33       ,1           --IBCBet Live Casino--IDD--BEST-ODDS
	UNION SELECT 171      ,3801     ,33       ,1           --Vgaming--IDD--BEST-ODDS
	UNION SELECT 213      ,2501     ,34       ,1           --NG2--IDR--BEST-ODDS
	UNION SELECT 219      ,1011     ,34       ,1           --Fishing World--IDR--BEST-ODDS
	UNION SELECT 200      ,1611     ,34       ,1           --SABA.games--IDR--BEST-ODDS
	UNION SELECT 242      ,3201     ,34       ,1           --IBCBet Live Casino--IDR--BEST-ODDS
	UNION SELECT 171      ,3801     ,34       ,1           --Vgaming--IDR--BEST-ODDS
	UNION SELECT 213      ,2501     ,15       ,1           --NG2--IN--BEST-ODDS
	UNION SELECT 219      ,1011     ,15       ,1           --Fishing World--IN--BEST-ODDS
	UNION SELECT 200      ,1611     ,15       ,1           --SABA.games--IN--BEST-ODDS
	UNION SELECT 242      ,3201     ,15       ,1           --IBCBet Live Casino--IN--BEST-ODDS
	UNION SELECT 171      ,3801     ,15       ,1           --Vgaming--IN--BEST-ODDS
	UNION SELECT 213      ,2501     ,22       ,1           --NG2--IND--BEST-ODDS
	UNION SELECT 219      ,1011     ,22       ,1           --Fishing World--IND--BEST-ODDS
	UNION SELECT 200      ,1611     ,22       ,1           --SABA.games--IND--BEST-ODDS
	UNION SELECT 242      ,3201     ,22       ,1           --IBCBet Live Casino--IND--BEST-ODDS
	UNION SELECT 171      ,3801     ,22       ,1           --Vgaming--IND--BEST-ODDS
	UNION SELECT 213      ,2501     ,10       ,1           --NG2--INR1--BEST-ODDS
	UNION SELECT 219      ,1011     ,10       ,1           --Fishing World--INR1--BEST-ODDS
	UNION SELECT 200      ,1611     ,10       ,1           --SABA.games--INR1--BEST-ODDS
	UNION SELECT 242      ,3201     ,10       ,1           --IBCBet Live Casino--INR1--BEST-ODDS
	UNION SELECT 180      ,1201     ,42       ,1           --Virtual Sports--PE--BEST-ODDS
	UNION SELECT 208      ,2101     ,42       ,1           --Saba Casino--PE--BEST-ODDS
	UNION SELECT 211      ,2401     ,42       ,1           --Allbet--PE--BEST-ODDS
	UNION SELECT 213      ,2501     ,42       ,1           --NG2--PE--BEST-ODDS
	UNION SELECT 219      ,1011     ,42       ,1           --Fishing World--PE--BEST-ODDS
	UNION SELECT 220      ,1021     ,42       ,1           --Lottery--PE--BEST-ODDS
	UNION SELECT 245      ,4601     ,42       ,1           --Virtual Games--PE--BEST-ODDS
	UNION SELECT 244      ,3001     ,42       ,1           --SA Gaming--PE--BEST-ODDS
	UNION SELECT 222      ,4901     ,42       ,1           --Table Game--PE--BEST-ODDS
	UNION SELECT 200      ,1611     ,42       ,1           --SABA.games--PE--BEST-ODDS
	UNION SELECT 243      ,3101     ,42       ,1           --AE Sexy--PE--BEST-ODDS
	UNION SELECT 242      ,3201     ,42       ,1           --IBCBet Live Casino--PE--BEST-ODDS
	UNION SELECT 241      ,3300     ,42       ,1           --BBIN--PE--BEST-ODDS
	UNION SELECT 224      ,5500     ,42       ,1           --Funky Games--PE--BEST-ODDS
	UNION SELECT 233      ,3401     ,42       ,1           --WM--PE--BEST-ODDS
	UNION SELECT 225      ,5601     ,42       ,1           --ION--PE--BEST-ODDS
	UNION SELECT 239      ,3501     ,42       ,1           --BG--PE--BEST-ODDS
	UNION SELECT 236      ,5701     ,42       ,1           --GDG--PE--BEST-ODDS
	UNION SELECT 169      ,3611     ,42       ,1           --Sports Lottery--PE--BEST-ODDS
	UNION SELECT 170      ,3701     ,42       ,1           --PP Live Casino--PE--BEST-ODDS
	UNION SELECT 171      ,3801     ,42       ,1           --Vgaming--PE--BEST-ODDS
	UNION SELECT 175      ,7901     ,42       ,1           --Bitcoin--PE--BEST-ODDS
	UNION SELECT 176      ,8201     ,42       ,1           --FGG--PE--BEST-ODDS
	UNION SELECT 213      ,2501     ,2        ,1           --NG2--RM--BEST-ODDS
	UNION SELECT 219      ,1011     ,2        ,1           --Fishing World--RM--BEST-ODDS
	UNION SELECT 242      ,3201     ,2        ,1           --IBCBet Live Casino--RM--BEST-ODDS
	UNION SELECT 213      ,2501     ,13       ,1           --NG2--RMB--BEST-ODDS
	UNION SELECT 219      ,1011     ,13       ,1           --Fishing World--RMB--BEST-ODDS
	UNION SELECT 244      ,3001     ,13       ,1           --SA Gaming--RMB--BEST-ODDS
	UNION SELECT 242      ,3201     ,13       ,1           --IBCBet Live Casino--RMB--BEST-ODDS
	UNION SELECT 213      ,2501     ,43       ,1           --NG2--THB--BEST-ODDS
	UNION SELECT 219      ,1011     ,43       ,1           --Fishing World--THB--BEST-ODDS
	UNION SELECT 200      ,1611     ,43       ,1           --SABA.games--THB--BEST-ODDS
	UNION SELECT 242      ,3201     ,43       ,1           --IBCBet Live Casino--THB--BEST-ODDS
	UNION SELECT 171      ,3801     ,43       ,1           --Vgaming--THB--BEST-ODDS
	UNION SELECT 213      ,2501     ,3        ,1           --NG2--US$--BEST-ODDS
	UNION SELECT 219      ,1011     ,3        ,1           --Fishing World--US$--BEST-ODDS
	UNION SELECT 200      ,1611     ,3        ,1           --SABA.games--US$--BEST-ODDS
	UNION SELECT 242      ,3201     ,3        ,1           --IBCBet Live Casino--US$--BEST-ODDS
	UNION SELECT 171      ,3801     ,3        ,1           --Vgaming--US$--BEST-ODDS
	UNION SELECT 213      ,2501     ,45       ,1           --NG2--Won--BEST-ODDS
	UNION SELECT 219      ,1011     ,45       ,1           --Fishing World--Won--BEST-ODDS
	UNION SELECT 244      ,3001     ,45       ,1           --SA Gaming--Won--BEST-ODDS
	UNION SELECT 242      ,3201     ,45       ,1           --IBCBet Live Casino--Won--BEST-ODDS
	UNION SELECT 239      ,3501     ,45       ,1           --BG--Won--BEST-ODDS
	UNION SELECT 236      ,5701     ,45       ,1           --GDG--Won--BEST-ODDS
	UNION SELECT 213      ,2501     ,16       ,1           --NG2--Yen--BEST-ODDS
	UNION SELECT 219      ,1011     ,16       ,1           --Fishing World--Yen--BEST-ODDS
	UNION SELECT 200      ,1611     ,16       ,1           --SABA.games--Yen--BEST-ODDS
	UNION SELECT 242      ,3201     ,16       ,1           --IBCBet Live Casino--Yen--BEST-ODDS
	UNION SELECT 171      ,3801     ,16       ,1           --Vgaming--Yen--BEST-ODDS
	UNION SELECT 219      ,1011     ,35       ,3           --Fishing World--$US--789y
	UNION SELECT 242      ,3201     ,35       ,3           --IBCBet Live Casino--$US--789y
	UNION SELECT 171      ,3801     ,35       ,3           --Vgaming--$US--789y
	UNION SELECT 180      ,1201     ,6        ,3           --Virtual Sports--EURO--789y
	UNION SELECT 208      ,2101     ,6        ,3           --Saba Casino--EURO--789y
	UNION SELECT 211      ,2401     ,6        ,3           --Allbet--EURO--789y
	UNION SELECT 213      ,2501     ,6        ,3           --NG2--EURO--789y
	UNION SELECT 219      ,1011     ,6        ,3           --Fishing World--EURO--789y
	UNION SELECT 220      ,1021     ,6        ,3           --Lottery--EURO--789y
	UNION SELECT 245      ,4601     ,6        ,3           --Virtual Games--EURO--789y
	UNION SELECT 244      ,3001     ,6        ,3           --SA Gaming--EURO--789y
	UNION SELECT 222      ,4901     ,6        ,3           --Table Game--EURO--789y
	UNION SELECT 200      ,1611     ,6        ,3           --SABA.games--EURO--789y
	UNION SELECT 243      ,3101     ,6        ,3           --AE Sexy--EURO--789y
	UNION SELECT 242      ,3201     ,6        ,3           --IBCBet Live Casino--EURO--789y
	UNION SELECT 241      ,3300     ,6        ,3           --BBIN--EURO--789y
	UNION SELECT 224      ,5500     ,6        ,3           --Funky Games--EURO--789y
	UNION SELECT 233      ,3401     ,6        ,3           --WM--EURO--789y
	UNION SELECT 225      ,5601     ,6        ,3           --ION--EURO--789y
	UNION SELECT 239      ,3501     ,6        ,3           --BG--EURO--789y
	UNION SELECT 236      ,5701     ,6        ,3           --GDG--EURO--789y
	UNION SELECT 169      ,3611     ,6        ,3           --Sports Lottery--EURO--789y
	UNION SELECT 170      ,3701     ,6        ,3           --PP Live Casino--EURO--789y
	UNION SELECT 171      ,3801     ,6        ,3           --Vgaming--EURO--789y
	UNION SELECT 175      ,7901     ,6        ,3           --Bitcoin--EURO--789y
	UNION SELECT 176      ,8201     ,6        ,3           --FGG--EURO--789y
	UNION SELECT 180      ,1201     ,2        ,3           --Virtual Sports--RM--789y
	UNION SELECT 208      ,2101     ,2        ,3           --Saba Casino--RM--789y
	UNION SELECT 211      ,2401     ,2        ,3           --Allbet--RM--789y
	UNION SELECT 213      ,2501     ,2        ,3           --NG2--RM--789y
	UNION SELECT 219      ,1011     ,2        ,3           --Fishing World--RM--789y
	UNION SELECT 220      ,1021     ,2        ,3           --Lottery--RM--789y
	UNION SELECT 245      ,4601     ,2        ,3           --Virtual Games--RM--789y
	UNION SELECT 244      ,3001     ,2        ,3           --SA Gaming--RM--789y
	UNION SELECT 222      ,4901     ,2        ,3           --Table Game--RM--789y
	UNION SELECT 200      ,1611     ,2        ,3           --SABA.games--RM--789y
	UNION SELECT 243      ,3101     ,2        ,3           --AE Sexy--RM--789y
	UNION SELECT 242      ,3201     ,2        ,3           --IBCBet Live Casino--RM--789y
	UNION SELECT 241      ,3300     ,2        ,3           --BBIN--RM--789y
	UNION SELECT 224      ,5500     ,2        ,3           --Funky Games--RM--789y
	UNION SELECT 233      ,3401     ,2        ,3           --WM--RM--789y
	UNION SELECT 225      ,5601     ,2        ,3           --ION--RM--789y
	UNION SELECT 239      ,3501     ,2        ,3           --BG--RM--789y
	UNION SELECT 236      ,5701     ,2        ,3           --GDG--RM--789y
	UNION SELECT 169      ,3611     ,2        ,3           --Sports Lottery--RM--789y
	UNION SELECT 170      ,3701     ,2        ,3           --PP Live Casino--RM--789y
	UNION SELECT 171      ,3801     ,2        ,3           --Vgaming--RM--789y
	UNION SELECT 175      ,7901     ,2        ,3           --Bitcoin--RM--789y
	UNION SELECT 176      ,8201     ,2        ,3           --FGG--RM--789y
	UNION SELECT 219      ,1011     ,3        ,3           --Fishing World--US$--789y
	UNION SELECT 242      ,3201     ,3        ,3           --IBCBet Live Casino--US$--789y
	UNION SELECT 171      ,3801     ,3        ,3           --Vgaming--US$--789y
	UNION SELECT 219      ,1011     ,64       ,3           --Fishing World--UT--789y
	UNION SELECT 242      ,3201     ,64       ,3           --IBCBet Live Casino--UT--789y
	UNION SELECT 171      ,3801     ,64       ,3           --Vgaming--UT--789y
	UNION SELECT 219      ,1011     ,16       ,3           --Fishing World--Yen--789y
	UNION SELECT 242      ,3201     ,16       ,3           --IBCBet Live Casino--Yen--789y
	UNION SELECT 171      ,3801     ,16       ,3           --Vgaming--Yen--789y
	UNION SELECT 213      ,2501     ,47       ,11          --NG2--DDD--INDO
	UNION SELECT 219      ,1011     ,47       ,11          --Fishing World--DDD--INDO
	UNION SELECT 242      ,3201     ,47       ,11          --IBCBet Live Casino--DDD--INDO
	UNION SELECT 213      ,2501     ,33       ,11          --NG2--IDD--INDO
	UNION SELECT 219      ,1011     ,33       ,11          --Fishing World--IDD--INDO
	UNION SELECT 242      ,3201     ,33       ,11          --IBCBet Live Casino--IDD--INDO
	UNION SELECT 213      ,2501     ,34       ,11          --NG2--IDR--INDO
	UNION SELECT 219      ,1011     ,34       ,11          --Fishing World--IDR--INDO
	UNION SELECT 242      ,3201     ,34       ,11          --IBCBet Live Casino--IDR--INDO
	UNION SELECT 213      ,2501     ,15       ,11          --NG2--IN--INDO
	UNION SELECT 219      ,1011     ,15       ,11          --Fishing World--IN--INDO
	UNION SELECT 242      ,3201     ,15       ,11          --IBCBet Live Casino--IN--INDO
	UNION SELECT 213      ,2501     ,22       ,11          --NG2--IND--INDO
	UNION SELECT 219      ,1011     ,22       ,11          --Fishing World--IND--INDO
	UNION SELECT 242      ,3201     ,22       ,11          --IBCBet Live Casino--IND--INDO
	UNION SELECT 213      ,2501     ,6        ,13          --NG2--EURO--XYZBET
	UNION SELECT 219      ,1011     ,6        ,13          --Fishing World--EURO--XYZBET
	UNION SELECT 242      ,3201     ,6        ,13          --IBCBet Live Casino--EURO--XYZBET
	UNION SELECT 233      ,3401     ,6        ,13          --WM--EURO--XYZBET
	UNION SELECT 236      ,5701     ,6        ,13          --GDG--EURO--XYZBET
	UNION SELECT 208      ,2101     ,12       ,13          --Saba Casino--GBP--XYZBET
	UNION SELECT 213      ,2501     ,12       ,13          --NG2--GBP--XYZBET
	UNION SELECT 219      ,1011     ,12       ,13          --Fishing World--GBP--XYZBET
	UNION SELECT 242      ,3201     ,12       ,13          --IBCBet Live Casino--GBP--XYZBET
	UNION SELECT 233      ,3401     ,12       ,13          --WM--GBP--XYZBET
	UNION SELECT 236      ,5701     ,12       ,13          --GDG--GBP--XYZBET
	UNION SELECT 176      ,8201     ,12       ,13          --FGG--GBP--XYZBET
	UNION SELECT 213      ,2501     ,5        ,13          --NG2--HK$--XYZBET
	UNION SELECT 219      ,1011     ,5        ,13          --Fishing World--HK$--XYZBET
	UNION SELECT 242      ,3201     ,5        ,13          --IBCBet Live Casino--HK$--XYZBET
	UNION SELECT 239      ,3501     ,5        ,13          --BG--HK$--XYZBET
	UNION SELECT 213      ,2501     ,15       ,13          --NG2--IN--XYZBET
	UNION SELECT 219      ,1011     ,15       ,13          --Fishing World--IN--XYZBET
	UNION SELECT 200      ,1611     ,15       ,13          --SABA.games--IN--XYZBET
	UNION SELECT 242      ,3201     ,15       ,13          --IBCBet Live Casino--IN--XYZBET
	UNION SELECT 171      ,3801     ,15       ,13          --Vgaming--IN--XYZBET
	UNION SELECT 213      ,2501     ,2        ,13          --NG2--RM--XYZBET
	UNION SELECT 219      ,1011     ,2        ,13          --Fishing World--RM--XYZBET
	UNION SELECT 242      ,3201     ,2        ,13          --IBCBet Live Casino--RM--XYZBET
	UNION SELECT 213      ,2501     ,13       ,13          --NG2--RMB--XYZBET
	UNION SELECT 219      ,1011     ,13       ,13          --Fishing World--RMB--XYZBET
	UNION SELECT 244      ,3001     ,13       ,13          --SA Gaming--RMB--XYZBET
	UNION SELECT 242      ,3201     ,13       ,13          --IBCBet Live Casino--RMB--XYZBET
	UNION SELECT 213      ,2501     ,5        ,16          --NG2--HK$--611111
	UNION SELECT 219      ,1011     ,5        ,16          --Fishing World--HK$--611111
	UNION SELECT 242      ,3201     ,5        ,16          --IBCBet Live Casino--HK$--611111
	UNION SELECT 239      ,3501     ,5        ,16          --BG--HK$--611111
	UNION SELECT 180      ,1201     ,42       ,16          --Virtual Sports--PE--611111
	UNION SELECT 208      ,2101     ,42       ,16          --Saba Casino--PE--611111
	UNION SELECT 211      ,2401     ,42       ,16          --Allbet--PE--611111
	UNION SELECT 213      ,2501     ,42       ,16          --NG2--PE--611111
	UNION SELECT 219      ,1011     ,42       ,16          --Fishing World--PE--611111
	UNION SELECT 220      ,1021     ,42       ,16          --Lottery--PE--611111
	UNION SELECT 245      ,4601     ,42       ,16          --Virtual Games--PE--611111
	UNION SELECT 244      ,3001     ,42       ,16          --SA Gaming--PE--611111
	UNION SELECT 222      ,4901     ,42       ,16          --Table Game--PE--611111
	UNION SELECT 200      ,1611     ,42       ,16          --SABA.games--PE--611111
	UNION SELECT 243      ,3101     ,42       ,16          --AE Sexy--PE--611111
	UNION SELECT 242      ,3201     ,42       ,16          --IBCBet Live Casino--PE--611111
	UNION SELECT 241      ,3300     ,42       ,16          --BBIN--PE--611111
	UNION SELECT 224      ,5500     ,42       ,16          --Funky Games--PE--611111
	UNION SELECT 233      ,3401     ,42       ,16          --WM--PE--611111
	UNION SELECT 225      ,5601     ,42       ,16          --ION--PE--611111
	UNION SELECT 239      ,3501     ,42       ,16          --BG--PE--611111
	UNION SELECT 236      ,5701     ,42       ,16          --GDG--PE--611111
	UNION SELECT 169      ,3611     ,42       ,16          --Sports Lottery--PE--611111
	UNION SELECT 170      ,3701     ,42       ,16          --PP Live Casino--PE--611111
	UNION SELECT 171      ,3801     ,42       ,16          --Vgaming--PE--611111
	UNION SELECT 175      ,7901     ,42       ,16          --Bitcoin--PE--611111
	UNION SELECT 176      ,8201     ,42       ,16          --FGG--PE--611111
	UNION SELECT 180      ,1201     ,2        ,16          --Virtual Sports--RM--611111
	UNION SELECT 208      ,2101     ,2        ,16          --Saba Casino--RM--611111
	UNION SELECT 211      ,2401     ,2        ,16          --Allbet--RM--611111
	UNION SELECT 213      ,2501     ,2        ,16          --NG2--RM--611111
	UNION SELECT 219      ,1011     ,2        ,16          --Fishing World--RM--611111
	UNION SELECT 220      ,1021     ,2        ,16          --Lottery--RM--611111
	UNION SELECT 245      ,4601     ,2        ,16          --Virtual Games--RM--611111
	UNION SELECT 244      ,3001     ,2        ,16          --SA Gaming--RM--611111
	UNION SELECT 222      ,4901     ,2        ,16          --Table Game--RM--611111
	UNION SELECT 200      ,1611     ,2        ,16          --SABA.games--RM--611111
	UNION SELECT 243      ,3101     ,2        ,16          --AE Sexy--RM--611111
	UNION SELECT 242      ,3201     ,2        ,16          --IBCBet Live Casino--RM--611111
	UNION SELECT 241      ,3300     ,2        ,16          --BBIN--RM--611111
	UNION SELECT 224      ,5500     ,2        ,16          --Funky Games--RM--611111
	UNION SELECT 233      ,3401     ,2        ,16          --WM--RM--611111
	UNION SELECT 225      ,5601     ,2        ,16          --ION--RM--611111
	UNION SELECT 239      ,3501     ,2        ,16          --BG--RM--611111
	UNION SELECT 236      ,5701     ,2        ,16          --GDG--RM--611111
	UNION SELECT 169      ,3611     ,2        ,16          --Sports Lottery--RM--611111
	UNION SELECT 170      ,3701     ,2        ,16          --PP Live Casino--RM--611111
	UNION SELECT 171      ,3801     ,2        ,16          --Vgaming--RM--611111
	UNION SELECT 175      ,7901     ,2        ,16          --Bitcoin--RM--611111
	UNION SELECT 176      ,8201     ,2        ,16          --FGG--RM--611111
	UNION SELECT 213      ,2501     ,13       ,16          --NG2--RMB--611111
	UNION SELECT 219      ,1011     ,13       ,16          --Fishing World--RMB--611111
	UNION SELECT 244      ,3001     ,13       ,16          --SA Gaming--RMB--611111
	UNION SELECT 242      ,3201     ,13       ,16          --IBCBet Live Casino--RMB--611111
	UNION SELECT 213      ,2501     ,5        ,20          --NG2--HK$--722222
	UNION SELECT 219      ,1011     ,5        ,20          --Fishing World--HK$--722222
	UNION SELECT 242      ,3201     ,5        ,20          --IBCBet Live Casino--HK$--722222
	UNION SELECT 239      ,3501     ,5        ,20          --BG--HK$--722222
	UNION SELECT 213      ,2501     ,67       ,20          --NG2--HKK--722222
	UNION SELECT 219      ,1011     ,67       ,20          --Fishing World--HKK--722222
	UNION SELECT 242      ,3201     ,67       ,20          --IBCBet Live Casino--HKK--722222
	UNION SELECT 213      ,2501     ,2        ,20          --NG2--RM--722222
	UNION SELECT 219      ,1011     ,2        ,20          --Fishing World--RM--722222
	UNION SELECT 242      ,3201     ,2        ,20          --IBCBet Live Casino--RM--722222
	UNION SELECT 180      ,1201     ,13       ,20          --Virtual Sports--RMB--722222
	UNION SELECT 208      ,2101     ,13       ,20          --Saba Casino--RMB--722222
	UNION SELECT 211      ,2401     ,13       ,20          --Allbet--RMB--722222
	UNION SELECT 213      ,2501     ,13       ,20          --NG2--RMB--722222
	UNION SELECT 219      ,1011     ,13       ,20          --Fishing World--RMB--722222
	UNION SELECT 220      ,1021     ,13       ,20          --Lottery--RMB--722222
	UNION SELECT 245      ,4601     ,13       ,20          --Virtual Games--RMB--722222
	UNION SELECT 244      ,3001     ,13       ,20          --SA Gaming--RMB--722222
	UNION SELECT 222      ,4901     ,13       ,20          --Table Game--RMB--722222
	UNION SELECT 200      ,1611     ,13       ,20          --SABA.games--RMB--722222
	UNION SELECT 243      ,3101     ,13       ,20          --AE Sexy--RMB--722222
	UNION SELECT 242      ,3201     ,13       ,20          --IBCBet Live Casino--RMB--722222
	UNION SELECT 241      ,3300     ,13       ,20          --BBIN--RMB--722222
	UNION SELECT 224      ,5500     ,13       ,20          --Funky Games--RMB--722222
	UNION SELECT 233      ,3401     ,13       ,20          --WM--RMB--722222
	UNION SELECT 225      ,5601     ,13       ,20          --ION--RMB--722222
	UNION SELECT 239      ,3501     ,13       ,20          --BG--RMB--722222
	UNION SELECT 236      ,5701     ,13       ,20          --GDG--RMB--722222
	UNION SELECT 169      ,3611     ,13       ,20          --Sports Lottery--RMB--722222
	UNION SELECT 170      ,3701     ,13       ,20          --PP Live Casino--RMB--722222
	UNION SELECT 171      ,3801     ,13       ,20          --Vgaming--RMB--722222
	UNION SELECT 175      ,7901     ,13       ,20          --Bitcoin--RMB--722222
	UNION SELECT 176      ,8201     ,13       ,20          --FGG--RMB--722222
	UNION SELECT 213      ,2501     ,5        ,21          --NG2--HK$--733333
	UNION SELECT 219      ,1011     ,5        ,21          --Fishing World--HK$--733333
	UNION SELECT 242      ,3201     ,5        ,21          --IBCBet Live Casino--HK$--733333
	UNION SELECT 239      ,3501     ,5        ,21          --BG--HK$--733333
	UNION SELECT 213      ,2501     ,67       ,21          --NG2--HKK--733333
	UNION SELECT 219      ,1011     ,67       ,21          --Fishing World--HKK--733333
	UNION SELECT 242      ,3201     ,67       ,21          --IBCBet Live Casino--HKK--733333
	UNION SELECT 213      ,2501     ,2        ,21          --NG2--RM--733333
	UNION SELECT 219      ,1011     ,2        ,21          --Fishing World--RM--733333
	UNION SELECT 242      ,3201     ,2        ,21          --IBCBet Live Casino--RM--733333
	UNION SELECT 180      ,1201     ,13       ,21          --Virtual Sports--RMB--733333
	UNION SELECT 208      ,2101     ,13       ,21          --Saba Casino--RMB--733333
	UNION SELECT 211      ,2401     ,13       ,21          --Allbet--RMB--733333
	UNION SELECT 213      ,2501     ,13       ,21          --NG2--RMB--733333
	UNION SELECT 219      ,1011     ,13       ,21          --Fishing World--RMB--733333
	UNION SELECT 220      ,1021     ,13       ,21          --Lottery--RMB--733333
	UNION SELECT 245      ,4601     ,13       ,21          --Virtual Games--RMB--733333
	UNION SELECT 244      ,3001     ,13       ,21          --SA Gaming--RMB--733333
	UNION SELECT 222      ,4901     ,13       ,21          --Table Game--RMB--733333
	UNION SELECT 200      ,1611     ,13       ,21          --SABA.games--RMB--733333
	UNION SELECT 243      ,3101     ,13       ,21          --AE Sexy--RMB--733333
	UNION SELECT 242      ,3201     ,13       ,21          --IBCBet Live Casino--RMB--733333
	UNION SELECT 241      ,3300     ,13       ,21          --BBIN--RMB--733333
	UNION SELECT 224      ,5500     ,13       ,21          --Funky Games--RMB--733333
	UNION SELECT 233      ,3401     ,13       ,21          --WM--RMB--733333
	UNION SELECT 225      ,5601     ,13       ,21          --ION--RMB--733333
	UNION SELECT 239      ,3501     ,13       ,21          --BG--RMB--733333
	UNION SELECT 236      ,5701     ,13       ,21          --GDG--RMB--733333
	UNION SELECT 169      ,3611     ,13       ,21          --Sports Lottery--RMB--733333
	UNION SELECT 170      ,3701     ,13       ,21          --PP Live Casino--RMB--733333
	UNION SELECT 171      ,3801     ,13       ,21          --Vgaming--RMB--733333
	UNION SELECT 175      ,7901     ,13       ,21          --Bitcoin--RMB--733333
	UNION SELECT 176      ,8201     ,13       ,21          --FGG--RMB--733333
	UNION SELECT 213      ,2501     ,43       ,22          --NG2--THB--755555
	UNION SELECT 219      ,1011     ,43       ,22          --Fishing World--THB--755555
	UNION SELECT 242      ,3201     ,43       ,22          --IBCBet Live Casino--THB--755555
	UNION SELECT 213      ,2501     ,5        ,23          --NG2--HK$--222223
	UNION SELECT 219      ,1011     ,5        ,23          --Fishing World--HK$--222223
	UNION SELECT 242      ,3201     ,5        ,23          --IBCBet Live Casino--HK$--222223
	UNION SELECT 239      ,3501     ,5        ,23          --BG--HK$--222223
	UNION SELECT 213      ,2501     ,67       ,23          --NG2--HKK--222223
	UNION SELECT 219      ,1011     ,67       ,23          --Fishing World--HKK--222223
	UNION SELECT 242      ,3201     ,67       ,23          --IBCBet Live Casino--HKK--222223
	UNION SELECT 213      ,2501     ,2        ,23          --NG2--RM--222223
	UNION SELECT 219      ,1011     ,2        ,23          --Fishing World--RM--222223
	UNION SELECT 242      ,3201     ,2        ,23          --IBCBet Live Casino--RM--222223
	UNION SELECT 213      ,2501     ,45       ,35          --NG2--Won--KORIBC
	UNION SELECT 219      ,1011     ,45       ,35          --Fishing World--Won--KORIBC
	UNION SELECT 244      ,3001     ,45       ,35          --SA Gaming--Won--KORIBC
	UNION SELECT 242      ,3201     ,45       ,35          --IBCBet Live Casino--Won--KORIBC
	UNION SELECT 239      ,3501     ,45       ,35          --BG--Won--KORIBC
	UNION SELECT 236      ,5701     ,45       ,35          --GDG--Won--KORIBC
	UNION SELECT 213      ,2501     ,13       ,147         --NG2--RMB--IMBC
	UNION SELECT 219      ,1011     ,13       ,147         --Fishing World--RMB--IMBC
	UNION SELECT 244      ,3001     ,13       ,147         --SA Gaming--RMB--IMBC
	UNION SELECT 242      ,3201     ,13       ,147         --IBCBet Live Casino--RMB--IMBC
	UNION SELECT 213      ,2501     ,69       ,188         --NG2--MMK--7aa666
	UNION SELECT 219      ,1011     ,69       ,188         --Fishing World--MMK--7aa666
	UNION SELECT 242      ,3201     ,69       ,188         --IBCBet Live Casino--MMK--7aa666
	UNION SELECT 241      ,3300     ,69       ,188         --BBIN--MMK--7aa666
	UNION SELECT 233      ,3401     ,69       ,188         --WM--MMK--7aa666
	UNION SELECT 180      ,1201     ,2        ,188         --Virtual Sports--RM--7aa666
	UNION SELECT 208      ,2101     ,2        ,188         --Saba Casino--RM--7aa666
	UNION SELECT 211      ,2401     ,2        ,188         --Allbet--RM--7aa666
	UNION SELECT 213      ,2501     ,2        ,188         --NG2--RM--7aa666
	UNION SELECT 219      ,1011     ,2        ,188         --Fishing World--RM--7aa666
	UNION SELECT 220      ,1021     ,2        ,188         --Lottery--RM--7aa666
	UNION SELECT 245      ,4601     ,2        ,188         --Virtual Games--RM--7aa666
	UNION SELECT 244      ,3001     ,2        ,188         --SA Gaming--RM--7aa666
	UNION SELECT 222      ,4901     ,2        ,188         --Table Game--RM--7aa666
	UNION SELECT 200      ,1611     ,2        ,188         --SABA.games--RM--7aa666
	UNION SELECT 243      ,3101     ,2        ,188         --AE Sexy--RM--7aa666
	UNION SELECT 242      ,3201     ,2        ,188         --IBCBet Live Casino--RM--7aa666
	UNION SELECT 241      ,3300     ,2        ,188         --BBIN--RM--7aa666
	UNION SELECT 224      ,5500     ,2        ,188         --Funky Games--RM--7aa666
	UNION SELECT 233      ,3401     ,2        ,188         --WM--RM--7aa666
	UNION SELECT 225      ,5601     ,2        ,188         --ION--RM--7aa666
	UNION SELECT 239      ,3501     ,2        ,188         --BG--RM--7aa666
	UNION SELECT 236      ,5701     ,2        ,188         --GDG--RM--7aa666
	UNION SELECT 169      ,3611     ,2        ,188         --Sports Lottery--RM--7aa666
	UNION SELECT 170      ,3701     ,2        ,188         --PP Live Casino--RM--7aa666
	UNION SELECT 171      ,3801     ,2        ,188         --Vgaming--RM--7aa666
	UNION SELECT 175      ,7901     ,2        ,188         --Bitcoin--RM--7aa666
	UNION SELECT 176      ,8201     ,2        ,188         --FGG--RM--7aa666
	UNION SELECT 213      ,2501     ,33       ,487         --NG2--IDD--IBCIndo
	UNION SELECT 219      ,1011     ,33       ,487         --Fishing World--IDD--IBCIndo
	UNION SELECT 213      ,2501     ,34       ,487         --NG2--IDR--IBCIndo
	UNION SELECT 219      ,1011     ,34       ,487         --Fishing World--IDR--IBCIndo
	UNION SELECT 213      ,2501     ,22       ,487         --NG2--IND--IBCIndo
	UNION SELECT 219      ,1011     ,22       ,487         --Fishing World--IND--IBCIndo
	UNION SELECT 213      ,2501     ,69       ,547         --NG2--MMK--76666B
	UNION SELECT 219      ,1011     ,69       ,547         --Fishing World--MMK--76666B
	UNION SELECT 200      ,1611     ,69       ,547         --SABA.games--MMK--76666B
	UNION SELECT 242      ,3201     ,69       ,547         --IBCBet Live Casino--MMK--76666B
	UNION SELECT 241      ,3300     ,69       ,547         --BBIN--MMK--76666B
	UNION SELECT 233      ,3401     ,69       ,547         --WM--MMK--76666B
	UNION SELECT 171      ,3801     ,69       ,547         --Vgaming--MMK--76666B
	) KQ

	-- Offer all site or all Currency
	SELECT * INTO #AllOfferedSiteCurency FROM #NonOfferedSiteCurency where 1 = 2

	INSERT INTO #AllOfferedSiteCurency (SportType, BetType, Currency, SiteID, IsHidden, IsDisabled, HasSynced)
	SELECT a.SportType, a.BetType, a.Currency, a.SiteID, a.IsHidden, a.IsDisabled, a.HasSynced 
	FROM ProductStatusSiteCurrency a WITH(NOLOCK) 
	INNER JOIN #NonOfferedSiteCurency b ON a.SportType = b.SportType AND a.BetType = b.BetType AND 
			((a.SiteID = b.SiteID AND a.Currency = 0) OR (a.currency = b.currency AND a.SiteID = 0))
	WHERE a.IsHidden = 0

	-- Create record non offer 
	INSERT INTO #NonOfferedSiteCurency (SportType, BetType, Currency, SiteID, IsHidden, IsDisabled, HasSynced)
	SELECT a.SportType, a.BetType, e.ExchangeId AS Currency, a.SiteID, a.IsHidden, a.IsDisabled, a.HasSynced
	FROM #AllOfferedSiteCurency a
	CROSS JOIN dbo.exchange e WITH (NOLOCK) 
	WHERE e.IsActive = 1 AND e.OfferSite IN (0,1) AND a.currency = 0
	UNION ALL
	SELECT a.SportType, a.BetType, a.Currency,s.SiteID, a.IsHidden, a.IsDisabled, a.HasSynced
	FROM #AllOfferedSiteCurency a
	CROSS JOIN dbo.Site s WITH (NOLOCK) 
	WHERE a.SiteID = 0 AND s.isActive = 1 AND s.isLicensee = 0

	DELETE b 
	FROM ProductStatusSiteCurrency a
	INNER JOIN #AllOfferedSiteCurency b ON a.SportType = b.SportType AND a.BetType = b.BetType AND a.Currency = b.currency AND a.SiteID = b.SiteID

	INSERT INTO ProductStatusSiteCurrency (SportType, BetType, Currency, SiteID, IsHidden, IsDisabled, HasSynced)
	SELECT SportType, BetType, Currency, SiteID, IsHidden, IsDisabled, HasSynced
	FROM #NonOfferedSiteCurency KQ
	WHERE NOT EXISTS(SELECT TOP 1 1 FROM ProductStatusSiteCurrency WITH(NOLOCK) 
						WHERE SportType=KQ.SportType AND BetType=KQ.BetType 
						AND Currency=KQ.Currency AND SiteID=KQ.SiteID)

	DROP TABLE #NonOfferedSiteCurency
	DROP TABLE #AllOfferedSiteCurency


