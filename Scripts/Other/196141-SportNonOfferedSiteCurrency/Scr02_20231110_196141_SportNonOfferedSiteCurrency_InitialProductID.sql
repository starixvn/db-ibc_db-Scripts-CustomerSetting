/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20231110@Tacy
	Task: Initial data
		 https://nexdev.net/issues/196141
	Database: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE non
SET non.RealProductId=sm.RealProductId
FROM SportNonOfferedSiteCurrency non WITH (ROWLOCK, UPDLOCK) 
CROSS APPLY (SELECT TOP 1 sm.RealProductId
				FROM SportBettypeSettingMatrix sm WITH (NOLOCK)
				WHERE sm.SportType=non.SportType
				AND sm.BetTypeRefBetSetting=non.BetType
				AND sm.isDeleted=0 AND sm.Site='ALL'
				AND sm.isLicensee=0) sm