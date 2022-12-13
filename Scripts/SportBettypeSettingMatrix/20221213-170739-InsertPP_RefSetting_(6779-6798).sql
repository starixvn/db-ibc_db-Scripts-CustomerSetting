﻿/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20221213@Tacy
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBCUST-CustDB
*/
/*
	PP: [6779-6798]
*/
INSERT INTO SportBettypeSettingMatrix ([SportType], [BetType], [isLicensee], IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans])
SELECT sbm.[SportType], sbm.[BetType], [isLicensee], sbm.IsLive, [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting], [TableBettrans]
FROM dbtxn.bodb02.dbo.SportBettypeMatrix sbm WITH (NOLOCK)
INNER JOIN SportBettypeSettingMatrix sm WITH (NOLOCK)
	ON sbm.SportType=sm.SportType
	AND sbm.IsLive=sm.isLive
WHERE sbm.BetType BETWEEN 6779 AND 6798 
AND sm.BetType=6701 AND sm.SportType=248
AND NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix t WITH (NOLOCK) WHERE t.SportType=sbm.SportType AND t.BetType=sbm.BetType and t.isLive=sbm.IsLive)