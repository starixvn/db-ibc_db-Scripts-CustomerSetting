/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220907@Tacy
	Task: Insert HP5 Linked reference setting to SportBettypeSettingMatrix with isLive=0
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBCUST-CustDB
*/

INSERT INTO SportBettypeSettingMatrix ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting])
		  SELECT 168, 3601, 0, 0, 'All', 1, 161, 85, 1, 'CustSetting3rd',NULL,NULL,NULL,NULL,NULL,164,8101,'CustBetSetting_Member','default',0,0
UNION ALL SELECT 168, 3601, 1, 0, 'All', 1, 161, 81, 1, 'Dep_CustPTGroupSetting_Member','default',161,81,'Dep_CustDiscountGroupSetting_Member','default',161,81,'Dep_CustBetSettingGameGroup_Member','default',0,0
UNION ALL SELECT 168, 3602, 0, 0, 'All', 1, 161, 85, 1, 'CustSetting3rd',NULL,NULL,NULL,NULL,NULL,164,8101,'CustBetSetting_Member','default',0,0
UNION ALL SELECT 168, 3602, 1, 0, 'All', 1, 161, 81, 1, 'Dep_CustPTGroupSetting_Member','default',161,81,'Dep_CustDiscountGroupSetting_Member','default',161,81,'Dep_CustBetSettingGameGroup_Member','default',0,0
UNION ALL SELECT 168, 3603, 0, 0, 'All', 1, 161, 85, 1, 'CustSetting3rd',NULL,NULL,NULL,NULL,NULL,164,8101,'CustBetSetting_Member','default',0,0
UNION ALL SELECT 168, 3603, 1, 0, 'All', 1, 161, 81, 1, 'Dep_CustPTGroupSetting_Member','default',161,81,'Dep_CustDiscountGroupSetting_Member','default',161,81,'Dep_CustBetSettingGameGroup_Member','default',0,0
UNION ALL SELECT 168, 3604, 0, 0, 'All', 1, 161, 85, 1, 'CustSetting3rd',NULL,NULL,NULL,NULL,NULL,164,8101,'CustBetSetting_Member','default',0,0
UNION ALL SELECT 168, 3604, 1, 0, 'All', 1, 161, 81, 1, 'Dep_CustPTGroupSetting_Member','default',161,81,'Dep_CustDiscountGroupSetting_Member','default',161,81,'Dep_CustBetSettingGameGroup_Member','default',0,0