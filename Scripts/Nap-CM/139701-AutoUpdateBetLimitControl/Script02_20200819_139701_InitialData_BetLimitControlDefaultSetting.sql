/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200818@Eden
	Task: Initial Data for BetLimitControlDefaultSetting table [Redmine:#139701]	
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
--Initial data Bet limit default setting for New Account Bet Limit by Performance type
SELECT CustID
INTO #CustID
FROM custinfo  WITH(NOLOCK)
WHERE username IN (
					 'BOG22SuperRMB'
					,'TitanCraftSuperRMB'
					,'JarvisSuperRMB'
					,'weicaiSuperRMB'
					,'GMASTERSuperRMB'
					,'TitanOneSuperRMB'
					,'OPEBETSuperRMB'
					,'GESABSuperRMB'
					,'HecbetSuperRMB'
					,'W88SuperRMB'
					,'ANGbetSuperRMB'
					,'GampagSuperRMB'
					,'TopGameSuperRMB'
					,'allwincitySuperRMB'
					,'SwinSuperRMB'
					,'XinYoSuperRMB'
					,'HBO999SuperRMB'
					,'UwinYSuperRMB'
					,'GPIGAMESuperRMB'
					,'Happy8SuperRMB'
					,'MS88SuperRMB'
					,'633esportsSuperRMB'
					,'TianboSuperRMB'
					,'CallmebossSuperRMB'
					,'IBOSuperRMB'
					,'hjccasinoSuperRMB'
					,'HAIFASuperRMB'
					,'OLE777SuperRMB'
					,'BigGamingSuperRMB'
					,'BobbetSuperRMB'
					,'erhaozhanSuperRMB'
					,'24AVIASuperRMB'
					,'VWIN66SuperRMB'
					,'YAYOUSuperRMB'
					,'WKCURSuperRMB'
					,'DawooSuperRMB')

DELETE d 
FROM BetLimitControlDefaultSetting d WITH(ROWLOCK)
	INNER JOIN #CustID t ON d.CustID = t.custid
WHERE d.BetLimitTypeID = 25 --New Account Bet Limit by Performance

INSERT INTO BetLimitControlDefaultSetting (CustID,BetLimitTypeID,MaxBet,MaxPerMatch)
SELECT CustID, 25,  10000, 20000
FROM #CustID

DROP TABLE #CustID