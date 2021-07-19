/*
	Created by: Elodie
	Date: 20181218
	Task: Insert LogAction on SIT
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO
DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId)
SELECT 1105,'Update Closed status', 'Acc_CustomerUpdClosed',0,5 UNION ALL
SELECT 1106,'Update Special status', 'Acc_CustomerUpdImportant',1,5 UNION ALL
SELECT 1107,'Update Enabled/Disabled Horse racing status', 'Acc_CustomerUpdDisableHR',0,5 UNION ALL
SELECT 1108,'Update Enabled/Disabled Finance''s status', 'Acc_CustomerUpdDisableFI',0,5 UNION ALL
SELECT 1109,'Update Enabled/Disabled Casino''s status', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 1110,'Update Auto Suspended status', 'Acc_CustomerUpdAutoSuspend',1,5 UNION ALL
SELECT 1111,'Update to Allow/Disallow Outright', 'Acc_CustomerUpdDisableOutright',0,5 UNION ALL
SELECT 1140,'Account closed by failed login 100 times', 'DBA_CustomerUpdClosed',0,5 UNION ALL
SELECT 1141,'Sub-Account closed by failed login 100 times', 'DBA_CustomerUpdClosed',0,5 UNION ALL
SELECT 1142,'Update Closed status', 'Dot_Casino_CustomerClosed',0,5 UNION ALL
SELECT 1143,'Update Enabled/Disabled Casino''s status', 'Dot_Casino_UpdateCasinoStatus',0,5 UNION ALL
SELECT 1144,'Update Suspended status', 'Dot_Casino_CustomerUpdSuspended',0,5 UNION ALL
SELECT 1145,'Update Enabled/Disabled Casino''s bonus status', 'Acc_CustomerUpdDisableCasinoBonus',1,5 UNION ALL
SELECT 619,'Remove the customer from External Group', 'Acc_CustGroupDel',1,4 UNION ALL
SELECT 621,'Create nickname', 'Age_CustomerInsNickname',0,4 UNION ALL
SELECT 622,'Set login option by nickname only', 'Age_CustomerUpdNicknameLogOnly',0,4 UNION ALL
SELECT 623,'Set consolidated group', 'Acc_CustomerUpdConsolidatedGroup',1,4 UNION ALL
SELECT 624,'Add customer to consolidated group', 'Acc_CustomerInsConsolidatedGroup_User',1,4 UNION ALL
SELECT 625,'Remove customers from consolidated group', 'Acc_CustomerDelConsolidatedGroup',1,4 UNION ALL
SELECT 20008,'Update user policy (multiple)', 'EAS_UserPolicyUpd',0,0 UNION ALL
SELECT 20100,'Insert new function', 'EAS_FunctionIns',0,0 UNION ALL
SELECT 20101,'Update function information', 'EAS_FunctionUpd',0,0 UNION ALL
SELECT 20102,'Update function status', 'EAS_FuncUpdStatus',0,0 UNION ALL
SELECT 20103,'Insert new menu', 'EAS_MenuIns',0,0 UNION ALL
SELECT 20104,'Update menu information', 'EAS_MenuUpd',0,0 UNION ALL
SELECT 20105,'Update menu status', 'EAS_MenuUpdStatus',0,0 UNION ALL
SELECT 20106,'Delete menu', 'EAS_MenuDel',0,0 UNION ALL
SELECT 20300,'Update enabled status of user', 'EAS_UserInfoUpdStatus',0,0 UNION ALL
SELECT 20301,'Update user password', 'EAS_UserInfoUpdUserPwd',0,0 UNION ALL
SELECT 908,'Account was closed by failed login 5 times', 'Age_LoginVerifyDownline',0,4 UNION ALL
SELECT 910,'Account was closed by failed login 5 times', 'Age_LoginDownline',0,4 UNION ALL
SELECT 911,'Account was closed by failed login 5 times', 'Agm_LoginDownline',0,4 UNION ALL
SELECT 912,'Account was closed by failed login 5 times', 'Agm_LoginDownline_Sub',0,4 UNION ALL
SELECT 913,'Account was closed by failed login 5 times', 'Agw_LoginDownline_Sub',0,4 UNION ALL
SELECT 914,'Reset Security Code of customer', 'Acc_CustomerUpdSecurityCode',1,4 UNION ALL
SELECT 641,'Remover customer from follow bet group', 'Acc_AutoFollowBetDelCustomer',0,4 UNION ALL
SELECT 642,'Update profile picture', 'Age_CustomerUpdProfilePicture',0,4 UNION ALL
SELECT 643,'Remove profile picture', 'Age_CustomerUpdProfilePicture',0,4 UNION ALL
SELECT 647,'Update limit of newly created member per day for Super.', 'Acc_CustomerMaxNewMemPerDay_SAg',1,4 UNION ALL
SELECT 649,'Insert customer into robot list', 'NAP_CustomerInsRobotAccount',1,4 UNION ALL
SELECT 650,'Update status for robot account', 'NAP_CustomerUpdStatusRobotAccount',1,4 UNION ALL
SELECT 601,'Add the general information for master', 'Acc_CustomerInsMember_SAg',0,4 UNION ALL
SELECT 602,'Add the general information for agent', 'Acc_CustomerInsMember_MAg',0,4 UNION ALL
SELECT 603,'Add the general information for member', 'Acc_CustomerInsMember_Ag',0,4 UNION ALL
SELECT 604,'Update customer info', 'Acc_CustomerUpdUserInfo',0,4 UNION ALL
SELECT 605,'Change User Name', 'Acc_CustomerUpdUserName',0,4 UNION ALL
SELECT 606,'Move agent to new master', 'Acc_CustomerUpdMoveAgent',0,4 UNION ALL
SELECT 607,'Move master to new super', 'Acc_CustomerUpdMoveMaster',0,4 UNION ALL
SELECT 608,'Change User Group', 'Acc_CustomerUpdUserGroup',0,4 UNION ALL
SELECT 609,'Update downline''s info', 'Age_CustomerUpdUserInfo',0,4 UNION ALL
SELECT 922,'Sub-account was closed because of failed Security Code over 5 times', 'Age_CustomerUpdSecurityCodeStatus_Sub',0,4 UNION ALL
SELECT 923,'Reset Security Code of Sub-Account', 'Acc_CustomerUpdSecurityCode_Sub',0,4 UNION ALL
SELECT 924,'Reset own Security Code', 'Age_CustomerUpdSecurityCode',0,4 UNION ALL
SELECT 925,'Account was closed by failed login 5 times', 'Age_LoginDownline_API',0,4 UNION ALL
SELECT 926,'Register Mobile Authenticator App', 'Age_OTP_CustomerOTPIns',0,4 UNION ALL
SELECT 927,'Enable OTP via Mobile Authenticator App', 'Age_OTP_CustomerOTPStatusUpd',0,4 UNION ALL
SELECT 1120,'Update Enabled/Disabled Number Game status', 'Acc_CustomerUpdDisableNumber',0,5 UNION ALL
SELECT 1121,'Update Enabled/Disabled Bingo''s status', 'Acc_UpdBingoStatus',0,5 UNION ALL
SELECT 1122,'Add the initial bingo status', 'Acc_CustomerUpdSyncBingo',0,5 UNION ALL
SELECT 1123,'Update IP Limit', 'Acc_CustomerUpdIPLimit',1,5 UNION ALL
SELECT 1124,'Update Selected Betting', 'Acc_CustomerUpdSelectedBetting',1,5 UNION ALL
SELECT 1125,'Update Enable/Disable Aust Racing status', 'Acc_CustomerUpdDisable151_51',0,5 UNION ALL
SELECT 1126,'Update Enable/Disable UK/Irish Greyhounds status', 'Acc_CustomerUpdDisable152_41',0,5 UNION ALL
SELECT 1308,'Admin Login via Licensee Billing System''s site', 'Lbs_UserLogin',1,0 UNION ALL
SELECT 1309,'Login via Licensee Risk And Forecast System''s site', 'Lrf_UserLogin',0,0 UNION ALL
SELECT 1310,'Login via Agent''s Site', 'Age_LoginDownline',0,0 UNION ALL
SELECT 1311,'Login via Agent''s Smartphone Site', 'Agm_LoginDownline',0,0 UNION ALL
SELECT 1312,'Login via Agent''s Wap Site', 'Agw_LoginDownline_Sub',0,0 UNION ALL
SELECT 1313,'Login via Agent''s Smartphone Site', 'Agm_LoginDownline_Sub',0,0 UNION ALL
SELECT 2406,'Create Licensee User', 'Lrf_CreateNormalUser',0,4 UNION ALL
SELECT 2407,'Update special level for member', 'Lrf_CustomerUpdSpecialLevel',0,4 UNION ALL
SELECT 2408,'Insert new Licensee Member', 'Lrf_CustomerInfoIns',0,4 UNION ALL
SELECT 2412,'Add the general information for super', 'Acc_Dep_CustomerInsMember_Com',0,4 UNION ALL
SELECT 2413,'Add the general information for master', 'Acc_Dep_CustomerInsMember_SAg',0,4 UNION ALL
SELECT 2414,'Add the general information for agent', 'Acc_Dep_CustomerInsMember_MAg',0,4 UNION ALL
SELECT 2415,'Add the general information for member', 'Acc_Dep_CustomerInsMember_Ag',0,4 UNION ALL
SELECT 2606,'Update Racing Commission for super', 'Acc_Dep_CustomerUpdMember_Com',0,2 UNION ALL
SELECT 2607,'Update Racing Commission for Agent', 'Acc_Dep_CustomerUpdMember_MAg',0,2 UNION ALL
SELECT 2608,'Update Racing Commission for customer', 'Acc_Dep_CustomerUpdMember_Ag',0,2 UNION ALL
SELECT 2609,'Add New Group Commission', 'Lrf_LicenseeGroupCommIns',0,2 UNION ALL
SELECT 2610,'Update Group Commission', 'Lrf_LicenseeGroupCommUpd',0,2 UNION ALL
SELECT 2611,'Delete Group Commission', 'Lrf_LicenseeGroupCommDel',0,2 UNION ALL
SELECT 2612,'Update Member Commission', 'Lrf_CustomerUpdMemberComm',0,2 UNION ALL
SELECT 2614,'Call API update charge comm for exchange product', 'API_UpdateChargeCommExchange',0,2 UNION ALL
SELECT 2709,'Update Sportsbook Position Taking for super', 'Acc_Dep_CustomerUpdMember_Com',0,1 UNION ALL
SELECT 2800,'Update Virtual Rate', 'Acc_CustomerUpdVirtualMultiplier',1,4 UNION ALL
SELECT 2802,'Update status of virtual rate', 'Acc_CustomerUpdVirtualMultiplier',1,4 UNION ALL
SELECT 2900,'Deleted ticket for early kickoff', 'NAP_BettransDelSpecialDel_EarlyKO',1,0 UNION ALL
SELECT 2901,'Deleted Mix Parlay ticket', 'NAP_BettransDelSpecialDel_MixParlay',1,0 UNION ALL
SELECT 2902,'Deleted ticket', 'NAP_BettransDelSpecial',1,0 UNION ALL
SELECT 2903,'Recover deleted ticket', 'NAP_BettransRecoverBet',1,0 UNION ALL
SELECT 2904,'Update winlost date of LAS''s ticket', 'Las_UpdateWinlostDate',0,0 UNION ALL
SELECT 10006,'Update user policy (multiple)', 'RMS_UserPolicyUpd',0,0 UNION ALL
SELECT 10007,'Update account information', 'RMS_UserInfoUpdAll',0,0 UNION ALL
SELECT 10100,'Insert new function', 'RMS_FunctionIns',0,0 UNION ALL
SELECT 10101,'Update function information', 'RMS_FunctionUpd',0,0 UNION ALL
SELECT 10200,'Login via RMS''s site', 'RMS_UserLogin',0,0 UNION ALL
SELECT 10201,'User log out RMS', 'RMS_UserLogout',0,0 UNION ALL
SELECT 10300,'Update Active/Inactive status for account', 'RMS_UserInfoUpdStatus',0,0 UNION ALL
SELECT 10301,'Update user password', 'RMS_UserInfoUpdUserPwd',0,0 UNION ALL
SELECT 10400,'Add new special member', 'RMS_CustomerIns',0,0 UNION ALL
SELECT 10401,'Update customer info', 'RMS_CustomerUpd',0,0 UNION ALL
SELECT 10402,'Add new dangerous agent', 'RMS_DangerousAgentIns',0,0 UNION ALL
SELECT 10403,'Delete dangerous agent', 'RMS_DangerousAgentDel',0,0 UNION ALL
SELECT 112,'Refund FGLG', 'Admin_Settlement_Refund_FGLG',0,0 UNION ALL
SELECT 113,'Betdaq - Move From', 'Admin_Settlement_BetDaq_Move',0,0 UNION ALL
SELECT 114,'Betdaq - Move To', 'Admin_Settlement_BetDaq_Move',0,0 UNION ALL
SELECT 115,'Number Game - calculate Final', 'Admin_Settlement_s161',0,0 UNION ALL
SELECT 116,'Number Game - LIVE', 'Admin_Settlement_s161',0,0 UNION ALL
SELECT 117,'REFUND Number Game', 'Admin_Settlement_s161',0,0 UNION ALL
SELECT 118,'Number Game - calculate HT', 'Admin_Settlement_s161',0,0 UNION ALL
SELECT 119,'REFUND FT Number Game', 'Admin_Settlement_s161',0,0 UNION ALL
SELECT 120,'Refund Mix Parlay HT', 'Admin_Settlement_Parlay',0,0 UNION ALL
SELECT 121,'Live Casino - Calculate', 'Admin_Settlement_s162',0,0 UNION ALL
SELECT 122,'Live Casino - Refund', 'Admin_Settlement_s162',0,0 UNION ALL
SELECT 134,'Calculate Parlay', 'Task_Calculate_Parlay',0,0 UNION ALL
SELECT 135,'Refund BetFair Tickets', 'Admin_Settlement_Refund_BetFair',0,0 UNION ALL
SELECT 136,'Outright - Settlement event', 'Dot_Admin_SettleOutright_Event',0,0 UNION ALL
SELECT 137,'Calculate Outright Settlement', 'Dot_Admin_SettleOutright_Trans',0,0 UNION ALL
SELECT 138,'Outright - Refund event', 'Dot_Admin_SettleOutright_Event',0,0 UNION ALL
SELECT 139,'Refund Outright Settlement', 'Dot_Admin_SettleOutright_Trans',0,0 UNION ALL
SELECT 140,'Outright - Undo event', 'DBA_SettleOutright_Undo_Event',0,0 UNION ALL
SELECT 141,'Outright - Undo ticket', 'DBA_SettleOutright_Undo_Ticket',0,0 UNION ALL
SELECT 142,'Calculate PS', 'NAP_Admin_Settlement_135',0,0 UNION ALL
SELECT 143,'API Auto Settlement: succeed', 'NAP_Admin_Settlement_AutoWriteLog',0,0 UNION ALL
SELECT 214,'Update Sportsbook Commission for agent', 'Age_CustomerUpdAgentComm',0,2 UNION ALL
SELECT 215,'Update Sportsbook Commission for master', 'Age_CustomerUpdMasterComm',0,2 UNION ALL
SELECT 216,'Add Commission for member', 'Dot_Dep_CustomerInsMember_Ag',0,2 UNION ALL
SELECT 217,'Set Licensee BA Commission', 'Acc_BA_LicConfigIns',1,2 UNION ALL
SELECT 218,'Update Licensee BA Commission', 'Acc_BA_LicConfigUpd',1,2 UNION ALL
SELECT 219,'Update Licensee BA Commission for member', 'Lrf_CustomerUpdMemberBAComm',1,2 UNION ALL
SELECT 220,'Update Poker commission for super', 'Acc_CustomerUpdSuper_P2PCommission',0,2 UNION ALL
SELECT 221,'Update Poker commission for master', 'Acc_CustomerUpdMaster_P2PCommission',0,2 UNION ALL
SELECT 313,'Update Sportsbook Bet Setting', 'Age_CustomerUpdMemBetSetting',0,3 UNION ALL
SELECT 314,'Update Bet Setting for Deposit member', 'Dot_Dep_CustomerUpdMemBetSetting',0,3 UNION ALL
SELECT 315,'Add Bet Setting for member', 'Dot_Dep_CustomerInsMember_Ag',0,3 UNION ALL
SELECT 316,'Update Horse racing Bet Setting for super', 'Acc_CustomerUpdSuper_MinMaxBetOpenTote',0,3 UNION ALL
SELECT 317,'Update Horse racing Bet Setting for master', 'Acc_CustomerUpdMaster_MinMaxBetOpenTote',0,3 UNION ALL
SELECT 318,'Update Horse racing Bet Setting for agent', 'Acc_CustomerUpdAgent_MinMaxBetOpenTote',0,3 UNION ALL
SELECT 319,'Update Horse racing Bet Setting for member', 'Acc_CustomerUpdMember_MinMaxBetOpenTote',0,3 UNION ALL
SELECT 325,'Update UK/Irish Greyhounds Bet Setting for super', 'Acc_CustomerUpdSuper_MinMaxBet152_41',0,3 UNION ALL
SELECT 326,'Update UK/Irish Greyhounds Bet Setting for master', 'Acc_CustomerUpdMaster_MinMaxBet152_41',0,3 UNION ALL
SELECT 327,'Update UK/Irish Greyhounds Bet Setting for agent', 'Acc_CustomerUpdAgent_MinMaxBet152_41',0,3 UNION ALL
SELECT 328,'Update UK/Irish Greyhounds Bet Setting for member', 'Acc_CustomerUpdMember_MinMaxBet152_41',0,3 UNION ALL
SELECT 329,'Update Aust Greyhound Bet Setting for super', 'Acc_CustomerUpdSuper_MinMaxBet152_51',0,3 UNION ALL
SELECT 330,'Update Aust Greyhound Bet Setting for master', 'Acc_CustomerUpdMaster_MinMaxBet152_51',0,3 UNION ALL
SELECT 336,'Update Aust Harness Bet Setting for member', 'Acc_CustomerUpdMember_MinMaxBet153_51',0,3 UNION ALL
SELECT 337,'Update SA Racing Bet Setting for super', 'Acc_CustomerUpdSuper_MinMaxBet151_31',0,3 UNION ALL
SELECT 338,'Update SA Racing Bet Setting for master', 'Acc_CustomerUpdMaster_MinMaxBet151_31',0,3 UNION ALL
SELECT 339,'Update SA Racing Bet Setting for agent', 'Acc_CustomerUpdAgent_MinMaxBet151_31',0,3 UNION ALL
SELECT 340,'Update SA Racing Bet Setting for member', 'Acc_CustomerUpdMember_MinMaxBet151_31',0,3 UNION ALL
SELECT 341,'Update UK/Irish Racing Bet Setting for super', 'Acc_CustomerUpdSuper_MinMaxBet151_41',0,3 UNION ALL
SELECT 353,'Update Poker game setting for agent', 'Acc_CustomerUpdAgent_P2PGameSetting',0,3 UNION ALL
SELECT 354,'Update Poker game setting for member', 'Acc_CustomerUpdMember_P2PGameSetting',0,3 UNION ALL
SELECT 355,'Update Number Game Bet Setting for whole line', 'Acc_CustomerUpdNGEnableBetSetting',0,3 UNION ALL
SELECT 356,'Update Live Casino betting limit for Super', 'TP_User_CustGameType_UpdStakeLevel',0,3 UNION ALL
SELECT 357,'Update Live Casino betting limit for Master', 'TP_User_CustGameType_UpdStakeLevel',0,3 UNION ALL
SELECT 358,'Update Live Casino betting limit for Agent', 'TP_User_CustGameType_UpdStakeLevel',0,3 UNION ALL
SELECT 359,'Update Live Casino betting limit for Member', 'TP_User_CustGameType_UpdStakeLevel',0,3 UNION ALL
SELECT 365,'Automate add Live Casino betting limit for Agent', 'TP_User_Customer_AutoInsertAccount',0,3 UNION ALL
SELECT 366,'Automate add Live Casino betting limit for Member', 'TP_User_Customer_AutoInsertAccount',0,3 UNION ALL
SELECT 367,'Automate add Live Casino betting limit for Master from existing Master', 'TP_User_Customer_AutoInsertAccountFromExisting',0,3 UNION ALL
SELECT 368,'Automate add Live Casino betting limit for Agent from existing agent', 'TP_User_Customer_AutoInsertAccountFromExisting',0,3 UNION ALL
SELECT 369,'Automate add Live Casino betting limit for Member from existing member', 'TP_User_Customer_AutoInsertAccountFromExisting',0,3 UNION ALL
SELECT 1903,'Remove member out punter code', 'Acc_AB_CustomerDel',1,0 UNION ALL
SELECT 1904,'Assign multiple punter codes to admin', 'Acc_AB_PunterGroupUpd',1,0 UNION ALL
SELECT 1905,'Assign multiple admins to punter code', 'Acc_AB_AdminByPunterCodeUpd',1,0 UNION ALL
SELECT 2000,'Update Sportsbook Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBet',0,3 UNION ALL
SELECT 2001,'Update SA Racing Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBet151_31',0,3 UNION ALL
SELECT 2002,'Update UK/Irish Racing Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBet151_41',0,3 UNION ALL
SELECT 2003,'Update Aust Racing Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBet151_51',0,3 UNION ALL
SELECT 2010,'Add Bet Setting for master', 'Acc_Dep_CustomerInsMember_SAg',0,3 UNION ALL
SELECT 2011,'Add Bet Setting for agent', 'Acc_Dep_CustomerInsMember_MAg',0,3 UNION ALL
SELECT 2012,'Update Sportsbook Bet Setting for super', 'Acc_Dep_CustomerUpdMember_Com',0,3 UNION ALL
SELECT 2013,'Update Sportsbook Bet Setting for customer', 'Acc_Dep_CustomerUpdMember_Ag',0,3 UNION ALL
SELECT 2014,'Update Virtual Sports Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBet180',0,3 UNION ALL
SELECT 2019,'Update Sportsbook Bet Setting for master', 'Acc_Dep_CustomerUpdMember_SAg',0,3 UNION ALL
SELECT 2036,'Update Sportsbook Bet Setting for Agent', 'Acc_Dep_CustomerUpdMember_MAg',0,3 UNION ALL
SELECT 2416,'Update Customer User group when modify Special Cust', 'Acc_BA_SpecialCustUpdUgroup',1,0 UNION ALL
SELECT 2500,'Reset Account''s Password', 'Lrf_UserPwdReset',0,4 UNION ALL
SELECT 2600,'Update Licensee BA Commission for member', 'Lrf_CustomerUpdMemberBAComm',1,2 UNION ALL
SELECT 2601,'Add Commission for super', 'Acc_Dep_CustomerInsMember_Com',0,2 UNION ALL
SELECT 2602,'Add Commission for master', 'Acc_Dep_CustomerInsMember_SAg',0,2 UNION ALL
SELECT 2603,'Add Commission for agent', 'Acc_Dep_CustomerInsMember_MAg',0,2 UNION ALL
SELECT 2604,'Add Commission for member', 'Acc_Dep_CustomerInsMember_Ag',0,2 UNION ALL
SELECT 2605,'Update Racing Commission for master', 'Acc_Dep_CustomerUpdMember_SAg',0,2 UNION ALL
SELECT 20400,'Update Transfer Condition', 'EAS_CustomerUpdTransferOption',0,0 UNION ALL
SELECT 30000,'IT Admin update sport setting for SMA Turnover function', 'NAP_SMATurnover_SportControlUpd',1,0 UNION ALL
SELECT 30001,'IT Admin update league setting for SMA Turnover function', 'NAP_SMATurnover_LeagueControlUpd',1,0 UNION ALL
SELECT 30002,'IT Admin delete league setting for SMA Turnover function', 'NAP_SMATurnover_LeagueControlDel',1,0 UNION ALL
SELECT 30003,'IT Admin update match setting for SMA Turnover function', 'NAP_SMATurnover_MatchControlUpd',1,0 UNION ALL
SELECT 30007,'IT Admin delete SMA setting by match for SMA Turnover function', 'NAP_SMATurnover_SMAControlByEventDel',1,0 UNION ALL
SELECT 30008,'IT Admin insert SMA setting for SMA Turnover function', 'NAP_SMATurnover_SMAControlIns',1,0 UNION ALL
SELECT 30009,'IT Admin update SMA setting for SMA Turnover function', 'NAP_SMATurnover_SMAControlUpd',1,0 UNION ALL
SELECT 30010,'IT Admin delete SMA setting for SMA Turnover function', 'NAP_SMATurnover_SMAControlDel',1,0 UNION ALL
SELECT 31000,'Insert customer into smart punter list', 'Nap_CustomerInsSmartPunter',1,4 UNION ALL
SELECT 60008,'Update Product Status of Number Game on Super by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 60500,'Update Product Status of Virtual Sports on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60501,'Update Product Status of Virtual Sports on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60502,'Update Product Status of Allbet on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60503,'Update Product Status of Allbet on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60504,'Update Product Status of Macau Games on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60514,'Update Product Status of Lotto on Super by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 60515,'Update Product Status of Lotto on Super ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 60516,'Update Product Status of Poker Games on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60517,'Update Product Status of Poker Games on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60518,'Update Product Status of Sportsbook 2 on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60519,'Update Product Status of Sportsbook 2 on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65004,'Update Product Status of RNG Keno on Master ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 65005,'Update Product Status of RNG Keno on Super ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 65006,'Update Product Status of RNG Keno on Master by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 65007,'Update Product Status of RNG Keno on Super by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 65008,'Update Product Status of Casino on Master ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 65009,'Update Product Status of Casino on Super ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 65010,'Update Product Status of Casino on Master by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 70551,'Update Product Status of Poker Games on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70552,'Update Product Status of Poker Games on Master', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70553,'Update Product Status of Poker Games on Agent', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70554,'Update Product Status of Sportsbook 2 on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70555,'Update Product Status of Sportsbook 2 on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70556,'Update Product Status of Sportsbook 2 on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75005,'Update Product Status of Gold Deluxe on Agent by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 75006,'Update Product Status of Gold Deluxe on Master by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 75007,'Update Product Status of Gold Deluxe on Super by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 75008,'Update Product Status of RNG Keno on Member ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 75009,'Update Product Status of RNG Keno on Agent ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 75010,'Update Product Status of RNG Keno on Master ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 75011,'Update Product Status of RNG Keno on Super ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 75017,'Update Product Status of Casino on Agent ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 75018,'Update Product Status of Casino on Master ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 75019,'Update Product Status of Casino on Super ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 75020,'Update Product Status of Casino on Member by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 75021,'Update Product Status of Casino on Agent by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 75022,'Update Product Status of Casino on Master by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 75028,'Update Product Status of Colossus Bets on Member by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 75029,'Update Product Status of Colossus Bets on Agent by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 75030,'Update Product Status of Colossus Bets on Master by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 75031,'Update Product Status of Colossus Bets on Super by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 75032,'Update Product Status of Number Game on Member by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 75501,'Update Product Status of Virtual Sports on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75502,'Update Product Status of Virtual Sports on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75503,'Update Product Status of Virtual Sports on Member by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75504,'Update Product Status of Virtual Sports on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75505,'Update Product Status of Virtual Sports on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75506,'Update Product Status of Virtual Sports on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75512,'Update Product Status of Allbet on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75513,'Update Product Status of Allbet on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75514,'Update Product Status of Allbet on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75515,'Update Product Status of Allbet on Member ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75516,'Update Product Status of Macau Games on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75517,'Update Product Status of Macau Games on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75522,'Update Product Status of Macau Games on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75523,'Update Product Status of Macau Games on Member ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75524,'Update Product Status of Fishing World on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75525,'Update Product Status of Fishing World on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75526,'Update Product Status of Fishing World on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75527,'Update Product Status of Fishing World on Member by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75533,'Update Product Status of Lucky 3 on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75534,'Update Product Status of Lucky 3 on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75535,'Update Product Status of Lucky 3 on Member by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75536,'Update Product Status of Lucky 3 on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75537,'Update Product Status of Lucky 3 on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75538,'Update Product Status of Lucky 3 on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 165001,'Create Account Status for Agent', 'CS_CustomerIns_MAg',0,5 UNION ALL
SELECT 165002,'Create Account Status for Member', 'CS_CustomerIns_Ag',0,5 UNION ALL
SELECT 165003,'Add account status for SMA', 'CS_CustomerIns_Com',0,5 UNION ALL
SELECT 165004,'Update Account Status for SMA', 'CS_CustomerStatusUpd',0,5 UNION ALL
SELECT 165005,'Add account status for Master Agent', 'CS_CustomerIns_SAg',0,5 UNION ALL
SELECT 165006,'Add account status for Agent', 'CS_CustomerIns_MAg',0,5 UNION ALL
SELECT 165007,'Add account status for Member', 'CS_CustomerIns_Ag',0,5 UNION ALL
SELECT 165008,'Update Account Status for Master Agent', 'CS_CustomerStatusUpd',0,5 UNION ALL
SELECT 165009,'Update Account Status for Agent', 'CS_CustomerStatusUpd',0,5 UNION ALL
SELECT 165010,'Update Account Status for Member', 'CS_CustomerStatusUpd',0,5 UNION ALL
SELECT 165011,'Unlock access status for sub account', 'CS_CustSubUnlock',0,5 UNION ALL
SELECT 165012,'Inactivate Problem Account', 'CS_ProblemAccount_InactiveAccount',1,5 UNION ALL
SELECT 165013,'Add the initial statuses for member', 'CS_CustomerIns_Ag',1,5 UNION ALL
SELECT 139999,'Add Commission for Member', 'CS_CustomerIns_Ag',0,2 UNION ALL
SELECT 140000,'Update Bet Limit for SMA', 'CS_CustSetting_CommBetSetting_Upd',0,3 UNION ALL
SELECT 145000,'Update Bet Limit for Master Agent', 'CS_CustSetting_CommBetSetting_Upd',0,3 UNION ALL
SELECT 149996,'Add Bet Limit for SMA', 'CS_CustomerIns_Com',0,3 UNION ALL
SELECT 149997,'Add Bet Limit for Master Agent', 'CS_CustomerIns_SAg',0,3 UNION ALL
SELECT 149998,'Add Bet Limit for Agent', 'CS_CustomerIns_MAg',0,3 UNION ALL
SELECT 149999,'Add Bet Limit for Member', 'CS_CustomerIns_Ag',0,3 UNION ALL
SELECT 150000,'Update Bet Limit for Agent', 'CS_CustSetting_CommBetSetting_Upd',0,3 UNION ALL
SELECT 155000,'Update Bet Limit for Member', 'CS_CustSetting_CommBetSetting_Upd',0,3 UNION ALL
SELECT 160000,'Add general information for SMA', 'CS_CustomerIns_Com',0,4 UNION ALL
SELECT 160001,'Add general information for Master Agent', 'CS_CustomerIns_SAg',0,4 UNION ALL
SELECT 160002,'Add general information for Agent', 'CS_CustomerIns_MAg',0,4 UNION ALL
SELECT 160003,'Add general information for Member', 'CS_CustomerIns_Ag',0,4 UNION ALL
SELECT 160004,'Update general information for SMA', 'CS_CustSetting_GeneralInfo_Upd',0,4 UNION ALL
SELECT 160005,'Update general information for Master Agent', 'CS_CustSetting_GeneralInfo_Upd',0,4 UNION ALL
SELECT 160006,'Update general information for Agent', 'CS_CustSetting_GeneralInfo_Upd',0,4 UNION ALL
SELECT 160007,'Update general information for Member', 'CS_CustSetting_GeneralInfo_Upd',0,4 UNION ALL
SELECT 160008,'Add Primary Extra PT Group', 'CS_CustomerIns_Com',1,4 UNION ALL
SELECT 160009,'Change Extra PT Group for Super', 'CS_GroupExtraPT_Upd',1,4 UNION ALL
SELECT 160010,'Reset own password', 'CS_CustomerPwdUpd2',0,4 UNION ALL
SELECT 81011,'Bet Builder - Log MarketIds', 'NAP_Admin_Settlement_BetBuilder',0,0 UNION ALL
SELECT 81012,'Bet Builder - Auto Settle', 'NAP_Admin_Settlement_BetBuilder',0,0 UNION ALL
SELECT 81013,'API Auto Settlement: succeed', 'NAP_Admin_Settlement_AutoWriteLog',0,0 UNION ALL
SELECT 81014,'API Auto Settlement: failed', 'NAP_Admin_Settlement_AutoWriteLog',0,0 UNION ALL
SELECT 90000,'Insert request', 'TicketVoiding_Request_Insert',0,0 UNION ALL
SELECT 90001,'Insert request detail', 'TicketVoiding_RequestDetail_Insert',0,0 UNION ALL
SELECT 90002,'Update request', 'TicketVoiding_Request_Update',0,0 UNION ALL
SELECT 90003,'Update request detail', 'TicketVoiding_RequestDetail_Update',0,0 UNION ALL
SELECT 90100,'Void single ticket', 'TicketVoiding_SingleType_Update',0,0 UNION ALL
SELECT 90101,'Void parlay ticket', 'TicketVoiding_ParlayType_Update',0,0 UNION ALL
SELECT 90500,'Mark Ticket - Insert in table MarkedTransaction', 'Nap_SpecialDelete_UnMarkedTickets_Update',0,0 UNION ALL
SELECT 90501,'UnMarked Ticket - Delete ticket in table MarkedTransaction', 'Nap_SpecialDelete_MarkedTickets_Update',0,0 UNION ALL
SELECT 90502,'UnMark Ticket For Match - Delete ticket in table MarkedTransaction', 'Nap_SpecialDelete_AllMarkedTicketsSummary_Update',0,0 UNION ALL
SELECT 1300,'Login via Agent''s Wap Site', 'Agw_LoginDownline',0,0 UNION ALL
SELECT 1301,'Admin Login via Internal Agent''s Site', 'Age_LoginDownline_Admin',1,0 UNION ALL
SELECT 1302,'Login via Agent''s SITE', 'Age_LoginDownline_Sub',0,0 UNION ALL
SELECT 1303,'Login via Agent''s Site', 'Age_LoginClaimDownline',1,0 UNION ALL
SELECT 1304,'Login via Agent''s Site', 'Age_LoginVerifyDownline',0,0 UNION ALL
SELECT 1305,'Log-out', 'Acc_CheckOut',1,0 UNION ALL
SELECT 1306,'Admin Log-in via Accounting''s Site', 'Acc_LoginAdmin',1,0 UNION ALL
SELECT 1307,'Admin Log-out via Accounting''s Site', 'Acc_On_UserUpdLogout',1,0 UNION ALL
SELECT 936,'Reset Security Code of downline', 'CS_Customer_SecurityCode_upd',0,4 UNION ALL
SELECT 937,'Reset Password', 'CS_Acc_CustomerUpdPwdReset',0,4 UNION ALL
SELECT 938,'Reset downline''s password', 'CS_Age_CustomerUpdPwd',0,4 UNION ALL
SELECT 939,'Sub account is locked due to failed logins 5 times', 'CS_LoginVerifyDownline',0,4 UNION ALL
SELECT 940,'Account is locked due to failed logins 5 times', 'CS_LoginVerifyDownline',0,4 UNION ALL
SELECT 941,'Failed providing Security Code of Sub-Account', 'CS_CustomerUpdSecurityCodeStatus_Sub',0,4 UNION ALL
SELECT 942,'Sub account is locked due to failed security code validations', 'CS_CustomerUpdSecurityCodeStatus_Sub',0,4 UNION ALL
SELECT 943,'Failed providing Security Code of customer', 'CS_CustomerUpdSecurityCodeStatus',0,4 UNION ALL
SELECT 944,'Account is locked due to failed security code validations', 'CS_CustomerUpdSecurityCodeStatus',0,4 UNION ALL
SELECT 75572,'Update Product Status of Sportsbook 2 on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75573,'Update Product Status of Sportsbook 2 on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75574,'Update Product Status of Sportsbook 2 on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75575,'Update Product Status of Sportsbook 2 on Member by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75576,'Update Product Status of Sportsbook 2 on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75577,'Update Product Status of Sportsbook 2 on Master', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75578,'Update Product Status of Sportsbook 2 on Agent', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75579,'Update Product Status of Sportsbook 2 on Member', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70557,'Update Product Status of Sportsbook 2 on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70558,'Update Product Status of Sportsbook 2 on Master', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70559,'Update Product Status of Sportsbook 2 on Agent', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75000,'Update Product Status of Gold Deluxe on Member', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 65539,'Update Product Status of Sportsbook 2 on Master', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70000,'Update Product Status of Gold Deluxe on Agent', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 70001,'Update Product Status of Gold Deluxe on Master', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 70002,'Update Product Status of Gold Deluxe on Super', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 75544,'Update Product Status of Lottery on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75545,'Update Product Status of Lottery on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75546,'Update Product Status of Lottery on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75547,'Update Product Status of Lottery on Member ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75548,'Update Product Status of Bullfighting on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75549,'Update Product Status of Bullfighting on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70532,'Update Product Status of Lottery on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70533,'Update Product Status of Lottery on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70534,'Update Product Status of Lottery on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70535,'Update Product Status of Lottery on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70536,'Update Product Status of Bullfighting on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70537,'Update Product Status of Bullfighting on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65015,'Update Product Status of Colossus Bets on Super by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 65016,'Update Product Status of Number Game on Master by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 65017,'Update Product Status of Number Game on Super by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 65018,'Update Suspended status on Super', 'Acc_CustomerUpdSuspended',0,5 UNION ALL
SELECT 65500,'Update Product Status of Virtual Sports on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65501,'Update Product Status of Virtual Sports on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65502,'Update Product Status of Virtual Sports on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 1701,'Add new account', 'Acc_Con_AdminIns',0,0 UNION ALL
SELECT 1702,'Add existed account', 'Acc_Con_AdminInsFromExisted',0,0 UNION ALL
SELECT 1703,'Update account permissions', 'Acc_Con_AdminPolicyUpd',0,0 UNION ALL
SELECT 1704,'Update account information', 'Acc_Con_AdminUpd',0,0 UNION ALL
SELECT 1705,'Update account status (active or closed)', 'Acc_Con_AdminUpdClosed',0,0 UNION ALL
SELECT 1706,'Delete group', 'Acc_Con_GroupInfoDel',0,0 UNION ALL
SELECT 1707,'Add new group', 'Acc_Con_GroupInfoIns',0,0 UNION ALL
SELECT 1708,'Update group information', 'Acc_Con_GroupInfoUpd',0,0 UNION ALL
SELECT 1709,'Update group permissions', 'Acc_Con_GroupPolicyUpd',0,0 UNION ALL
SELECT 1710,'Reset password', 'Acc_CustomerUpdPwdReset',0,0 UNION ALL
SELECT 1711,'Remove account', 'Acc_Con_AdminDel',0,0 UNION ALL
SELECT 70547,'Update Product Status of Lotto on Agent ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 70548,'Update Product Status of Poker Games on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70549,'Update Product Status of Poker Games on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70550,'Update Product Status of Poker Games on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65529,'Update Product Status of Lotto on Master by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 65530,'Update Product Status of Lotto on Super ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 65531,'Update Product Status of Lotto on Master ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 65532,'Update Product Status of Poker Games on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60510,'Update Product Status of Lottery on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60511,'Update Product Status of Lottery on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60512,'Update Product Status of Bullfighting on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60513,'Update Product Status of Bullfighting on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 1162,'Synchronized Other Products status', 'Acc_CustSetting_DisableNewProductSyncStatusUpd',1,5 UNION ALL
SELECT 1163,'Enabled/Disabled Other Products status', 'Acc_Dep_CustSetting_DisableStatUpd',0,5 UNION ALL
SELECT 1164,'Enabled/Disabled DCS Products for Deposit Customers by Admin', 'Acc_Dep_CustSetting_StatusUpd',1,5 UNION ALL
SELECT 1165,'Update Dangerous status from FPS', 'Acc_CustomerUpdDangerCustList',1,5 UNION ALL
SELECT 1166,'Set default Collection Status', 'Acc_CreditCollStatusInit',1,5 UNION ALL
SELECT 1167,'Change Collection Status', 'Acc_CreditCollStatusUpd_CreditTerm',1,5 UNION ALL
SELECT 1168,'Change Collection Status from NAP CM', 'Acc_CreditCollStatusUpd',1,5 UNION ALL
SELECT 1169,'Unlock access status', 'CS_Acc_CustomerUpdUnlockAccess',0,5 UNION ALL
SELECT 1171,'Update possess monitor status', 'CS_Customer_MonitorPT_Upd',1,5 UNION ALL
SELECT 1127,'Update Enable/Disable Aust Greyhound status', 'Acc_CustomerUpdDisable152_51',0,5 UNION ALL
SELECT 1128,'Update Enable/Disable Aust Harness status', 'Acc_CustomerUpdDisable153_51',0,5 UNION ALL
SELECT 1129,'Update Enable/Disable SA Racing status', 'Acc_CustomerUpdDisable151_31',0,5 UNION ALL
SELECT 1130,'Update Enable/Disable UK/Irish Racing status', 'Acc_CustomerUpdDisable151_41',0,5 UNION ALL
SELECT 1132,'Update Enable/Disable Poker status', 'Acc_CustomerUpdDisableP2P',0,5 UNION ALL
SELECT 1133,'Update Enabled/Disabled Number Game status for whole line', 'Acc_CustomerUpdNGEnableBetSetting',0,5 UNION ALL
SELECT 1112,'Update Account type', 'Acc_CustomerUpdInternal',1,5 UNION ALL
SELECT 1113,'Update to Allow/Disallow Auto Position Taking for master', 'Acc_CustomerUpdMaster_DisableAutoMPT',0,5 UNION ALL
SELECT 1114,'Update Dangerous status', 'Acc_CustomerUpdDangercust',1,5 UNION ALL
SELECT 1115,'Close Agent to archive account by IT Admin', 'DBA_ArchiveAccount0_CloseAgent',0,5 UNION ALL
SELECT 1116,'Update Status by super', 'Acc_CustomerUpdMember_Super',0,5 UNION ALL
SELECT 1117,'Update Status by master', 'Acc_CustomerUpdMember_Master',0,5 UNION ALL
SELECT 1118,'Add the initial statuses for member', 'Dot_Dep_CustomerInsMember_Ag',0,5 UNION ALL
SELECT 1119,'Update Enabled/Disabled Horse racing status', 'Acc_CustomerUpdDisableOpenTote',0,5 UNION ALL
SELECT 75561,'Update Product Status of Lotto on Master ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 75562,'Update Product Status of Lotto on Agent ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 75563,'Update Product Status of Lotto on Member ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 75564,'Update Product Status of Poker Games on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75565,'Update Product Status of Poker Games on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75550,'Update Product Status of Bullfighting on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75551,'Update Product Status of Bullfighting on Member by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75552,'Update Product Status of Bullfighting on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75553,'Update Product Status of Bullfighting on Master', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75554,'Update Product Status of Bullfighting on Agent', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75539,'Update Product Status of Lucky 3 on Member ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75540,'Update Product Status of Lottery on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75541,'Update Product Status of Lottery on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75542,'Update Product Status of Lottery on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75543,'Update Product Status of Lottery on Member by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75528,'Update Product Status of Fishing World on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75529,'Update Product Status of Fishing World on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75530,'Update Product Status of Fishing World on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75531,'Update Product Status of Fishing World on Member ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75532,'Update Product Status of Lucky 3 on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 430,'Update Virtual Sports Position Taking for super', 'Acc_CustomerUpdSuperVS_Positiontaking',0,1 UNION ALL
SELECT 431,'Update Virtual Sports Position Taking for agent', 'Acc_CustomerUpdAgentVS_PositionTaking',0,1 UNION ALL
SELECT 432,'Update Master''s Virtual Sports Position Taking at member', 'Acc_CustomerUpdMemberVS_MAg',0,1 UNION ALL
SELECT 433,'Update Virtual Sports Position Taking for master', 'Acc_CustomerUpdMasterVS_Positiontaking',0,1 UNION ALL
SELECT 434,'Update Virtual Sports Position Taking for member', 'Acc_CustomerUpdMemberVS_Positiontaking',0,1 UNION ALL
SELECT 100,'Calculate All', 'Admin_Settlement_1',0,0 UNION ALL
SELECT 101,'Calculate FT', 'Admin_Settlement_1',0,0 UNION ALL
SELECT 102,'Calculate HT', 'Admin_Settlement_1',0,0 UNION ALL
SELECT 103,'Undo Settlement', 'Admin_Settlement_1',0,0 UNION ALL
SELECT 104,'Calculate Mix Parlay', 'Admin_Settlement_Parlay',0,0 UNION ALL
SELECT 105,'Undo Mix Parlay Settlement', 'Admin_Settlement_Parlay',0,0 UNION ALL
SELECT 106,'Refund Mix Parlay FT', 'Admin_Settlement_Parlay',0,0 UNION ALL
SELECT 107,'Refund Mix Parlay All', 'Admin_Settlement_Parlay',0,0 UNION ALL
SELECT 108,'Calculate FGLG', 'Admin_Settlement_FGLG',0,0 UNION ALL
SELECT 109,'Refund All', 'Admin_Settlement_Refund_All',0,0 UNION ALL
SELECT 110,'Refund HT', 'Admin_Settlement_RefundHT',0,0 UNION ALL
SELECT 111,'Refund FT', 'Admin_Settlement_RefundFT',0,0 UNION ALL
SELECT 123,'Calculate All for Abandoned/Postponed match', 'DBA_Settlement_AbandonedMatch',0,0 UNION ALL
SELECT 124,'Calculate FT for Abandoned/Postponed match', 'DBA_Settlement_AbandonedMatch',0,0 UNION ALL
SELECT 125,'Calculate HT for Abandoned/Postponed match', 'DBA_Settlement_AbandonedMatch',0,0 UNION ALL
SELECT 126,'Refund BetDaq Tickets', 'Admin_Settlement_Refund_BetDaq',0,0 UNION ALL
SELECT 127,'Calculate by oddsid', 'Admin_Settlement_SS',0,0 UNION ALL
SELECT 128,'Refund by matchid', 'Admin_Settlement_SS',0,0 UNION ALL
SELECT 129,'Refund by oddsid', 'Admin_Settlement_SS',0,0 UNION ALL
SELECT 222,'Update Poker commission for agent', 'Acc_CustomerUpdAgent_P2PCommission',0,2 UNION ALL
SELECT 223,'Update Poker commission for member', 'Acc_CustomerUpdMember_P2PCommission',0,2 UNION ALL
SELECT 224,'Update Live casino commission for super', 'Acc_CustomerUpdSuperLiveCS_Commission',0,2 UNION ALL
SELECT 225,'Update Live casino commission for master', 'Acc_CustomerUpdMasterLiveCS_Commission',0,2 UNION ALL
SELECT 226,'Update Live casino commission for agent', 'Acc_CustomerUpdAgentLiveCS_Commission',0,2 UNION ALL
SELECT 227,'Update Live casino commission for member', 'Acc_CustomerUpdMemberLiveCS_Commission',0,2 UNION ALL
SELECT 307,'Update Sportsbook Bet Setting for member', 'Acc_CustomerUpdMember_MinMaxBet',0,3 UNION ALL
SELECT 308,'Update Finance Bet Setting', 'Acc_CustomerUpdMinMaxBetFI',0,3 UNION ALL
SELECT 309,'Update Horse racing Bet Setting for super', 'Acc_CustomerUpdSuper_MinMaxBetHR',0,3 UNION ALL
SELECT 310,'Update Horse racing Bet Setting for master', 'Acc_CustomerUpdMaster_MinMaxBetHR',0,3 UNION ALL
SELECT 311,'Update Horse racing Bet Setting for agent', 'Acc_CustomerUpdAgent_MinMaxBetHR',0,3 UNION ALL
SELECT 312,'Update Horse racing Bet Setting for member', 'Acc_CustomerUpdMember_MinMaxBetHR',0,3 UNION ALL
SELECT 321,'Update Aust Racing Bet Setting for super', 'Acc_CustomerUpdSuper_MinMaxBet151_51',0,3 UNION ALL
SELECT 322,'Update Aust Racing Bet Setting for master', 'Acc_CustomerUpdMaster_MinMaxBet151_51',0,3 UNION ALL
SELECT 323,'Update Aust Racing Bet Setting for agent', 'Acc_CustomerUpdAgent_MinMaxBet151_51',0,3 UNION ALL
SELECT 324,'Update Aust Racing Bet Setting for member', 'Acc_CustomerUpdMember_MinMaxBet151_51',0,3 UNION ALL
SELECT 331,'Update Aust Greyhound Bet Setting for agent', 'Acc_CustomerUpdAgent_MinMaxBet152_51',0,3 UNION ALL
SELECT 332,'Update Aust Greyhound Bet Setting for member', 'Acc_CustomerUpdMember_MinMaxBet152_51',0,3 UNION ALL
SELECT 333,'Update Aust Harness Bet Setting for super', 'Acc_CustomerUpdSuper_MinMaxBet153_51',0,3 UNION ALL
SELECT 334,'Update Aust Harness Bet Setting for master', 'Acc_CustomerUpdMaster_MinMaxBet153_51',0,3 UNION ALL
SELECT 335,'Update Aust Harness Bet Setting for agent', 'Acc_CustomerUpdAgent_MinMaxBet153_51',0,3 UNION ALL
SELECT 342,'Update UK/Irish Racing Bet Setting for master', 'Acc_CustomerUpdMaster_MinMaxBet151_41',0,3 UNION ALL
SELECT 343,'Update UK/Irish Racing Bet Setting for agent', 'Acc_CustomerUpdAgent_MinMaxBet151_41',0,3 UNION ALL
SELECT 344,'Update UK/Irish Racing Bet Setting for member', 'Acc_CustomerUpdMember_MinMaxBet151_41',0,3 UNION ALL
SELECT 351,'Update Poker game setting for super', 'Acc_CustomerUpdSuper_P2PGameSetting',0,3 UNION ALL
SELECT 352,'Update Poker game setting for master', 'Acc_CustomerUpdMaster_P2PGameSetting',0,3 UNION ALL
SELECT 360,'Add Live Casino betting limit for Super', 'TP_User_Customer_ManualInsertAccount',0,3 UNION ALL
SELECT 361,'Add Live Casino betting limit for Master', 'TP_User_Customer_ManualInsertAccount',0,3 UNION ALL
SELECT 362,'Add Live Casino betting limit for Agent', 'TP_User_Customer_ManualInsertAccount',0,3 UNION ALL
SELECT 363,'Add Live Casino betting limit for Member', 'TP_User_Customer_ManualInsertAccount',0,3 UNION ALL
SELECT 364,'Automate add Live Casino betting limit for Master', 'TP_User_Customer_AutoInsertAccount',0,3 UNION ALL
SELECT 370,'Update Virtual Sports Bet Setting for super', 'Acc_CustomerUpdSuperVS_MinMaxBet',0,3 UNION ALL
SELECT 371,'Update Virtual Sports Bet Setting for agent', 'Acc_CustomerUpdAgentVS_MinMaxBet',0,3 UNION ALL
SELECT 372,'Update Virtual Sports Bet Setting for master', 'Acc_CustomerUpdMasterVS_MinMaxBet',0,3 UNION ALL
SELECT 373,'Update Virtual Sports Bet Setting for member', 'Acc_CustomerUpdMemberVS_MinMaxBet',0,3 UNION ALL
SELECT 374,'Update Virtual Sports bet setting for downlines', 'Acc_CustomerUpdStatusVS',0,3 UNION ALL
SELECT 405,'Update Super''s Finance Position Taking at member', 'Acc_CustomerUpdMemberFI_SAg',0,1 UNION ALL
SELECT 406,'Update Super''s Horse racing Position Taking at member', 'Acc_CustomerUpdMemberHR_SAg',0,1 UNION ALL
SELECT 407,'Update Master''s Sportsbook Position Taking at member', 'Acc_CustomerUpdMember_Master',0,1 UNION ALL
SELECT 408,'Update Master''s Finance Position Taking at member', 'Acc_CustomerUpdMemberFI_MAg',0,1 UNION ALL
SELECT 409,'Update Master''s Horse racing Position Taking at member', 'Acc_CustomerUpdMemberHR_MAg',0,1 UNION ALL
SELECT 417,'Update Finance Position Taking for member', 'Acc_CustomerUpdMemberFI_PositionTaking',0,1 UNION ALL
SELECT 418,'Update Racing Position Taking for super', 'Acc_CustomerUpdSuperHR_Positiontaking',0,1 UNION ALL
SELECT 419,'Update Racing Position Taking for master', 'Acc_CustomerUpdMasterHR_Positiontaking',0,1 UNION ALL
SELECT 420,'Update Racing Position Taking for agent', 'Acc_CustomerUpdAgentHR_PositionTaking',0,1 UNION ALL
SELECT 421,'Update Racing Position Taking for member', 'Acc_CustomerUpdMemberHR_PositionTaking',0,1 UNION ALL
SELECT 422,'Add Position Taking for member', 'Dot_Dep_CustomerInsMember_Ag',0,1 UNION ALL
SELECT 632,'Roll back moving Master to new Super for live casino', 'TP_User_Customer_MoveMaster_Rollback',1,4 UNION ALL
SELECT 633,'Move Agent to new Master for live casino', 'TP_User_Customer_MoveAgent_Update',1,4 UNION ALL
SELECT 634,'Roll back moving Agent to new Master for live casino', 'TP_User_Customer_MoveAgent_Rollback',1,4 UNION ALL
SELECT 635,'Insert BA Customers to Auto Follow Bet', 'Acc_AutoFollowBetInsBACustomer',1,0 UNION ALL
SELECT 636,'IT Admin add new super that they want to control for a match', 'Acc_SMATurnoverIns',1,4 UNION ALL
SELECT 800,'Update Max Exposure (%)', 'Acc_CustomerUpdMatchLimit',1,4 UNION ALL
SELECT 801,'Update Virtual Rate', 'Acc_CustomerUpdVirtualMultiplier',1,4 UNION ALL
SELECT 802,'Update new multiple Virtual Rates', 'Acc_VirtualRateMulUpd',1,4 UNION ALL
SELECT 803,'Sum up users when updating new multiple Virtual Rates', 'Acc_VirtualRateMulUpd_Sum',1,4 UNION ALL
SELECT 804,'IT Admin changed customer currency', 'DBA_ChangeCurrency',0,4 UNION ALL
SELECT 1134,'Update Enabled/Disabled Live Casino status', 'Acc_CustomerUpdDisableLiveCS',0,5 UNION ALL
SELECT 1135,'Add the initial live casino status', 'Acc_CustomerUpdSyncLiveCS_Cust',0,5 UNION ALL
SELECT 1136,'Update Enable/Disable Virtual Sports', 'Acc_CustomerUpdDisableVS',0,5 UNION ALL
SELECT 1137,'Update Abnormal status for member', 'Acc_CustomerUpdAbnormal',1,5 UNION ALL
SELECT 1138,'Update Enable Virtual Sports', 'Acc_CustomerUpdStatusVS',0,5 UNION ALL
SELECT 1139,'Update Double Commission for Losing Tickets', 'Acc_customerUpdDoubleCommLosing',0,5 UNION ALL
SELECT 1204,'Update Agent''s Credit', 'Age_CustomerUpdCredit_MAg',0,0 UNION ALL
SELECT 1205,'Update Master''s Credit', 'Age_CustomerUpdCredit_SAg',0,0 UNION ALL
SELECT 1206,'Update Member Max Credit', 'Age_CustomerUpdMaxCredit',0,0 UNION ALL
SELECT 1207,'Set Credit when Member''s created', 'Acc_CustomerInsMember_Ag',0,0 UNION ALL
SELECT 1208,'Set Credit when Super''s created', 'Acc_CustomerInsMember_Com',0,0 UNION ALL
SELECT 1209,'Set Credit when Agent''s created', 'Acc_CustomerInsMember_MAg',0,0 UNION ALL
SELECT 1210,'Set Credit when Master''s created', 'Acc_CustomerInsMember_SAg',0,0 UNION ALL
SELECT 1211,'Clear Credit', 'Age_CustomerUpdClearCredit',0,0 UNION ALL
SELECT 1212,'Clear Credit all downlines', 'Age_ClearCredit_All_Ins',0,0 UNION ALL
SELECT 1213,'Set Credits when SMA''s created', 'CS_CustomerIns_Com',0,0 UNION ALL
SELECT 1214,'Set Credits when Master Agent''s created', 'CS_CustomerIns_SAg',0,0 UNION ALL
SELECT 1215,'Set Credits when Agent''s created', 'CS_CustomerIns_MAg',0,0 UNION ALL
SELECT 1216,'Set Credits when Member''s created', 'CS_CustomerIns_Ag',0,0 UNION ALL
SELECT 1217,'Update Member''s Credits', 'CS_Customer_Credit_Upd',0,0 UNION ALL
SELECT 1218,'Update Agent''s Credits', 'CS_Customer_Credit_Upd',0,0 UNION ALL
SELECT 1219,'Update Master Agent''s Credits', 'CS_Customer_Credit_Upd',0,0 UNION ALL
SELECT 1220,'Update SMA''s Credits', 'CS_Customer_Credit_Upd',0,0 UNION ALL
SELECT 1403,'Update Mailing list for Special Delete', 'Acc_MailingListUpd',1,0 UNION ALL
SELECT 1500,'Archive Account by IT Admin', 'DBA_ArchiveAccount1_UpdateMove',0,0 UNION ALL
SELECT 1501,'Archive Account by IT Admin', 'DBA_ArchiveAccount2_UpdateMove',0,0 UNION ALL
SELECT 1502,'Clear Member Balance to archive account by IT Admin', 'DBA_ArchiveAccount2_ClearBalance',0,0 UNION ALL
SELECT 1503,'Roll back archive account by IT Admin', 'DBA_ArchiveAccount1_Rollback',0,0 UNION ALL
SELECT 1504,'Roll back archive account by IT Admin', 'DBA_ArchiveAccount2_Rollback',0,0 UNION ALL
SELECT 1700,'Change group', 'Acc_Con_AdminGroupUpd',0,0 UNION ALL
SELECT 1800,'Delete function', 'Acc_Con_FuncInfoDel',0,0 UNION ALL
SELECT 1801,'Add new or sub-function', 'Acc_Con_FuncInfoIns',0,0 UNION ALL
SELECT 1802,'Update function information', 'Acc_Con_FuncInfoUpd',0,0 UNION ALL
SELECT 1850,'Delete operator', 'Acc_OperatorDel',0,0 UNION ALL
SELECT 1851,'Add new operator', 'Acc_OperatorIns',0,0 UNION ALL
SELECT 1852,'Update operator information', 'Acc_OperatorUpd',0,0 UNION ALL
SELECT 1900,'Insert new punter code', 'Acc_AB_PunterCodeIns',1,0 UNION ALL
SELECT 1901,'Update punter code info', 'Acc_AB_PunterCodeUpd',1,0 UNION ALL
SELECT 1902,'Set punter code for member', 'Acc_AB_CustomerIns',1,0 UNION ALL
SELECT 2004,'Update UK/Irish Greyhounds Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBet152_41',0,3 UNION ALL
SELECT 2005,'Update Aust Greyhound Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBet152_51',0,3 UNION ALL
SELECT 2006,'Update Aust Harness Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBet153_51',0,3 UNION ALL
SELECT 2007,'Update Number Game Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBet161',0,3 UNION ALL
SELECT 2008,'Add Bet Setting for member', 'Acc_Dep_CustomerInsMember_Ag',0,3 UNION ALL
SELECT 2009,'Add Bet Setting for super', 'Acc_Dep_CustomerInsMember_Com',0,3 UNION ALL
SELECT 2037,'Update Live Casino bet setting for Member', 'TP_User_CustGameType_UpdStakeLevel',0,3 UNION ALL
SELECT 2038,'Update RNG Keno Bet Setting for member', 'Lrf_CustomerUpdMember_MinMaxBetKN',0,3 UNION ALL
SELECT 2039,'Update Bet Setting of AG Casino for Super', 'Acc_AGC_UpdSuperSetting',0,3 UNION ALL
SELECT 2040,'Update Bet Setting of AG Casino for Member', 'Lrf_AGC_UpdCustSetting',0,3 UNION ALL
SELECT 2041,'Set default Bet Setting of AG Casino for new Member', 'Lrf_AGC_Customer_SetDefaultSetting',0,3 UNION ALL
SELECT 2042,'Set enable/disable Esport for member', 'Lrf_CustomerUpdEsportStatus',0,3 UNION ALL
SELECT 2044,'Update PT setting', 'Acc_Dep_CustomerUpdSetting',0,3 UNION ALL
SELECT 2046,'Update Other Products Bet Setting for customers', 'Acc_Dep_CustSetting_BetLimitUpd',0,3 UNION ALL
SELECT 20000,'Create new group', 'EAS_GroupInfoIns',0,0 UNION ALL
SELECT 20001,'Update group information', 'EAS_GroupInfoUpd',0,0 UNION ALL
SELECT 20002,'Delete group information', 'EAS_GroupInfoDel',0,0 UNION ALL
SELECT 20003,'Update group policy (multiple)', 'EAS_GroupPolicyUpd',0,0 UNION ALL
SELECT 20004,'Create new account', 'EAS_UserInfoAddNew',0,0 UNION ALL
SELECT 20005,'Add account from existing account', 'EAS_UserInfoAddExistingUser',0,0 UNION ALL
SELECT 20006,'Update group of account', 'EAS_UserInfoUpdUserGroup',0,0 UNION ALL
SELECT 20007,'Update account information', 'EAS_UserInfoUpdAll',0,0 UNION ALL
SELECT 637,'IT Admin update max turnover of the super that they want to control for a match', 'Acc_SMATurnoverUpd',1,4 UNION ALL
SELECT 638,'Add the general information for super from existing super', 'Acc_CustomerInsMember_CloneSetting_Com',0,0 UNION ALL
SELECT 639,'Insert customer to follow bet', 'Acc_AutoFollowBetInsCustomer',0,4 UNION ALL
SELECT 640,'Update customer to follow bet', 'Acc_AutoFollowBetInsCustomer',0,4 UNION ALL
SELECT 200,'Add Commission for super', 'Acc_CustomerInsMember_Com',0,2 UNION ALL
SELECT 201,'Add Commission for master', 'Acc_CustomerInsMember_SAg',0,2 UNION ALL
SELECT 202,'Add Commission for agent', 'Acc_CustomerInsMember_MAg',0,2 UNION ALL
SELECT 203,'Add Commission for member', 'Acc_CustomerInsMember_Ag',0,2 UNION ALL
SELECT 204,'Update Sportsbook Commission for super', 'Acc_CustomerUpdSuper_Commission',0,2 UNION ALL
SELECT 205,'Update Sportsbook Commission for master', 'Acc_CustomerUpdMaster_Commission',0,2 UNION ALL
SELECT 206,'Update Sportsbook Commission for agent', 'Acc_CustomerUpdAgent_Commission',0,2 UNION ALL
SELECT 207,'Update Sportsbook Commission for member', 'Acc_CustomerUpdMember_Commission',0,2 UNION ALL
SELECT 6001,'Update the access right or remark for customer', 'Acc_CustAllowListUdp',1,4 UNION ALL
SELECT 6002,'Remove customer from the monitoring list', 'Acc_CustAllowListDel',1,4 UNION ALL
SELECT 6050,'Add new user to request login list', 'Member_LoginVerifyIns',1,4 UNION ALL
SELECT 6051,'Update cust request login list', 'Member_LoginVerifyUpd',1,4 UNION ALL
SELECT 6052,'Remove user from request login list', 'Member_LoginVerifyDel',1,4 UNION ALL
SELECT 10000,'Create new group', 'RMS_GroupInfoIns',0,0 UNION ALL
SELECT 10001,'Update group information', 'RMS_GroupInfoUpd',0,0 UNION ALL
SELECT 10002,'Update group policy (multiple)', 'RMS_GroupPolicyUpd',0,0 UNION ALL
SELECT 10003,'Create new admin account', 'RMS_UserInfoAddNew',0,0 UNION ALL
SELECT 10004,'Add admin account from existing account', 'RMS_UserInfoAddExisting',0,0 UNION ALL
SELECT 10005,'Update group name of account', 'RMS_UserInfoUpdUserGroup',0,0 UNION ALL
SELECT 2300,'Admin Login via Licensee Billing System''s site', 'Lbs_UserLogin',1,0 UNION ALL
SELECT 2301,'Login via Licensee Risk And Forecast System''s site', 'Lrf_UserLogin',1,0 UNION ALL
SELECT 2302,'Login Licensee Risk And Forecast System''s Site via Admin''s Site', 'Lrf_InternalLogin',1,0 UNION ALL
SELECT 2303,'Sync a Licensee Risk And Forecast System''s User from Admin''s Site', 'Lrf_SyncInternalUser',1,0 UNION ALL
SELECT 2400,'Update account info and account permission', 'Lrf_UserUpdAccount',0,4 UNION ALL
SELECT 2401,'Insert BA member', 'Lrf_LicenseeBAHistoryIns',1,0 UNION ALL
SELECT 2402,'Update level danger for member', 'Lrf_CustomerUpdDanger',1,0 UNION ALL
SELECT 2403,'Update BA Done for member', 'Lrf_LicenseeBAHistoryUpdDone',1,0 UNION ALL
SELECT 2404,'Insert Function to User', 'Lrf_LicenseeUserFunctionsIns',0,4 UNION ALL
SELECT 2405,'Remove Function of User', 'Lrf_LicenseeUserFunctionsDel',0,4 UNION ALL
SELECT 382,'Update RNG Keno Bet Setting for member', 'Acc_CustomerUpdMemberKeno_MinMaxBet',0,0 UNION ALL
SELECT 383,'Set Live casino betting limit for Super from existing Super', 'TP_User_Customer_AutoInsertSuperFromExisting',0,3 UNION ALL
SELECT 384,'Update Other Products Bet Setting for customers', 'Acc_CustSetting_BetLimitUpd',0,3 UNION ALL
SELECT 389,'Update Gold Deluxe Bet Setting', 'Acc_CustomerUpdGoldDeluxe_MinMaxBet',0,0 UNION ALL
SELECT 390,'Update Member Win Limit', 'Acc_CustomerWinlimitUpd',0,3 UNION ALL
SELECT 391,'Update Other Products Betting Limit for customers', 'Acc_CustSetting_StakeLevelUpd',0,3 UNION ALL
SELECT 410,'Update Sportsbook Position Taking for super', 'Acc_CustomerUpdSuper_PositionTaking',0,1 UNION ALL
SELECT 411,'Update Sportsbook Position Taking for master', 'Acc_CustomerUpdMaster_PositionTaking',0,1 UNION ALL
SELECT 412,'Update Sportsbook Position Taking for agent', 'Acc_CustomerUpdAgent_PositionTaking',0,1 UNION ALL
SELECT 413,'Update Sportsbook Position Taking for member', 'Acc_CustomerUpdMember_PositionTaking',0,1 UNION ALL
SELECT 414,'Update Finance Position Taking for super', 'Acc_CustomerUpdSuperFI_Positiontaking',0,1 UNION ALL
SELECT 415,'Update Finance Position Taking for master', 'Acc_CustomerUpdMasterFI_Positiontaking',0,1 UNION ALL
SELECT 416,'Update Finance Position Taking for agent', 'Acc_CustomerUpdAgentFI_PositionTaking',0,1 UNION ALL
SELECT 424,'Update Live Casino Position Taking for super', 'Acc_CustomerUpdSuperLiveCS_Positiontaking',0,1 UNION ALL
SELECT 425,'Update Live Casino Position Taking for master', 'Acc_CustomerUpdMasterLiveCS_Positiontaking',0,1 UNION ALL
SELECT 426,'Update Live Casino Position taking for agent', 'Acc_CustomerUpdAgentLiveCS_Positiontaking',0,1 UNION ALL
SELECT 427,'Update Live Casino Position taking for member', 'Acc_CustomerUpdMemberLiveCS_Positiontaking',0,1 UNION ALL
SELECT 428,'Update Super''s Live Casino Position Taking at member', 'Acc_CustomerUpdMemberLiveCS_SAg',0,1 UNION ALL
SELECT 429,'Update Master''s Live Casino Position Taking at member', 'Acc_CustomerUpdMemberLiveCS_MAg',0,1 UNION ALL
SELECT 610,'Update Sub-account''s info', 'Age_CustSubUpdInfo',0,4 UNION ALL
SELECT 611,'Update Sub-account''s permission', 'Age_CustSubUpdPageAccess',0,4 UNION ALL
SELECT 612,'Open new sub-account', 'Age_CustSubIns',0,4 UNION ALL
SELECT 613,'IT Admin moved master to new super', 'DBA_CustomerUpdMoveMaster',0,4 UNION ALL
SELECT 614,'Move site', 'Acc_CustomerUpdMoveSite',1,4 UNION ALL
SELECT 615,'Move member to new agent', 'Acc_CustomerUpdMoveMember',0,4 UNION ALL
SELECT 616,'Open new sub-account by IT Admin', 'DBA_CustSubIns',0,4 UNION ALL
SELECT 617,'Add the general information for member', 'Dot_Dep_CustomerInsMember_Ag',0,4 UNION ALL
SELECT 618,'Add the customer to External Group', 'Acc_CustGroupAddByUsername',1,4 UNION ALL
SELECT 626,'Change consolidated group Headline', 'Acc_CustomerUpdConsolidatedGroupHeader',1,4 UNION ALL
SELECT 627,'Add the general information for member', 'Agm_CustomerInsMember_Ag',0,4 UNION ALL
SELECT 628,'Add the general information for member from existing member', 'Age_CustomerInsMember_CloneSetting_Ag',0,4 UNION ALL
SELECT 629,'Add the general information for agent from existing agent', 'Age_CustomerInsMember_CloneSetting_MAg',0,4 UNION ALL
SELECT 630,'Add the general information for master from existing master', 'Age_CustomerInsMember_CloneSetting_SAg',0,4 UNION ALL
SELECT 631,'Move Master to new Super for live casino', 'TP_User_Customer_MoveMaster_Update',1,4 UNION ALL
SELECT 651,'Update info for robot account', 'NAP_CustomerUpdInfoRobotAccount',1,4 UNION ALL
SELECT 652,'Insert agent from file into automate transfer list', 'Acc_CustomerInsAutoTransferAgentFromFile',1,4 UNION ALL
SELECT 653,'Insert agent into automate transfer list', 'Acc_CustomerInsAutoTransferAgent',1,4 UNION ALL
SELECT 654,'Update transfer type for agent', 'Acc_CustomerUpdAutoTransferAgent',1,4 UNION ALL
SELECT 655,'Remove agent out of automate transfer list', 'Acc_CustomerDelAutoTransferAgent',1,4 UNION ALL
SELECT 656,'IT Admin insert SMA Global Setting for SMA Turnover function', 'NAP_SMATurnoverGlobalSettingIns',1,4 UNION ALL
SELECT 915,'Reset Security Code of member', 'Acc_CustomerUpdSecurityCode',1,4 UNION ALL
SELECT 916,'Reset Security Code of downline', 'Age_CustomerUpdSecurityCode',0,4 UNION ALL
SELECT 917,'Failed providing Security Code of customer', 'Age_CustomerUpdSecurityCodeStatus',0,4 UNION ALL
SELECT 918,'Account was closed because of failed Security Code over 5 times', 'Age_CustomerUpdSecurityCodeStatus',0,4 UNION ALL
SELECT 919,'Sub account resets his own Security Code', 'Age_CustomerUpdSecurityCode_Sub',0,4 UNION ALL
SELECT 920,'Reset Security Code of Sub-Account', 'Age_CustomerUpdSecurityCode_Sub2',0,4 UNION ALL
SELECT 921,'Failed providing Security Code of Sub-Account', 'Age_CustomerUpdSecurityCodeStatus_Sub',0,4 UNION ALL
SELECT 928,'Disable OTP via Mobile Authenticator App', 'Age_OTP_CustomerOTPStatusUpd',0,4 UNION ALL
SELECT 929,'Remove OTP', 'Age_OTP_CustomerOTPDel',0,4 UNION ALL
SELECT 930,'[Submit OTP] Result: Failed', 'Age_OTP_CustomerStatusUpdAfterVerifiedOTP',0,4 UNION ALL
SELECT 931,'Your account is closed due to 5 failed attempts with the OTP', 'Age_OTP_CustomerStatusUpdAfterVerifiedOTP',0,4 UNION ALL
SELECT 932,'Register Mobile Authenticator App', 'EAS_OTP_CustomerOTPIns',0,4 UNION ALL
SELECT 933,'Update OTP secret key', 'EAS_OTP_CustomerOTPSecretKeyUpd',0,4 UNION ALL
SELECT 934,'Account closed by failed login 5 times', 'CS_AdminLoginVerifyBefore',0,4 UNION ALL
SELECT 935,'Reset own Security Code', 'CS_Customer_SecurityCode_upd',0,4 UNION ALL
SELECT 65508,'Update Product Status of Macau Games on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65509,'Update Product Status of Macau Games on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65510,'Update Product Status of Macau Games on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65511,'Update Product Status of Macau Games on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65512,'Update Product Status of Fishing World on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65518,'Update Product Status of Lucky 3 on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65519,'Update Product Status of Lucky 3 on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65520,'Update Product Status of Lottery on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65521,'Update Product Status of Lottery on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65522,'Update Product Status of Lottery on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65523,'Update Product Status of Lottery on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65533,'Update Product Status of Poker Games on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65534,'Update Product Status of Poker Games on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65535,'Update Product Status of Poker Games on Master', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65536,'Update Product Status of Sportsbook 2 on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65537,'Update Product Status of Sportsbook 2 on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65538,'Update Product Status of Sportsbook 2 on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70007,'Update Product Status of RNG Keno on Master ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 70008,'Update Product Status of RNG Keno on Super ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 70009,'Update Product Status of RNG Keno on Agent by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 70010,'Update Product Status of RNG Keno on Master by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 70011,'Update Product Status of RNG Keno on Super by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 70012,'Update Product Status of Casino on Agent ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 70013,'Update Product Status of Casino on Master ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 70019,'Update Product Status of Colossus Bets on Master ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 70020,'Update Product Status of Colossus Bets on Super ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 70021,'Update Product Status of Colossus Bets on Agent by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 70022,'Update Product Status of Colossus Bets on Master by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 70023,'Update Product Status of Colossus Bets on Super by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 70501,'Update Product Status of Virtual Sports on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70502,'Update Product Status of Virtual Sports on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70503,'Update Product Status of Virtual Sports on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70504,'Update Product Status of Virtual Sports on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70505,'Update Product Status of Virtual Sports on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70506,'Update Product Status of Allbet on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70512,'Update Product Status of Macau Games on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70513,'Update Product Status of Macau Games on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70514,'Update Product Status of Macau Games on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70515,'Update Product Status of Macau Games on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70516,'Update Product Status of Macau Games on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70521,'Update Product Status of Fishing World on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70522,'Update Product Status of Fishing World on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70523,'Update Product Status of Fishing World on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70524,'Update Product Status of Lucky 3 on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70525,'Update Product Status of Lucky 3 on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70526,'Update Product Status of Lucky 3 on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75555,'Update Product Status of Bullfighting on Member', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75556,'Update Product Status of Lotto on Super by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 75557,'Update Product Status of Lotto on Master by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 75558,'Update Product Status of Lotto on Agent by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 75559,'Update Product Status of Lotto on Member by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 75560,'Update Product Status of Lotto on Super ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 75566,'Update Product Status of Poker Games on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75567,'Update Product Status of Poker Games on Member by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75568,'Update Product Status of Poker Games on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75569,'Update Product Status of Poker Games on Master', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75570,'Update Product Status of Poker Games on Agent', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75571,'Update Product Status of Poker Games on Member', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 100000,'Update Possess for SMA', 'CS_CustSetting_PTSetting_Upd',0,1 UNION ALL
SELECT 105000,'Update Possess for Master Agent', 'CS_CustSetting_PTSetting_Upd',0,1 UNION ALL
SELECT 110000,'Update Possess for Agent', 'CS_CustSetting_PTSetting_Upd',0,1 UNION ALL
SELECT 119997,'Add Possess for SMA', 'CS_CustomerIns_Com',0,1 UNION ALL
SELECT 119998,'Add Possess for Master Agent', 'CS_CustomerIns_SAg',0,1 UNION ALL
SELECT 119999,'Add Possess for Agent', 'CS_CustomerIns_MAg',0,1 UNION ALL
SELECT 120000,'Update Commission for SMA', 'CS_CustSetting_CommBetSetting_Upd',0,2 UNION ALL
SELECT 125000,'Update Commission for Master Agent', 'CS_CustSetting_CommBetSetting_Upd',0,2 UNION ALL
SELECT 130000,'Update Commission for Agent', 'CS_CustSetting_CommBetSetting_Upd',0,2 UNION ALL
SELECT 135000,'Update Commission for Member', 'CS_CustSetting_CommBetSetting_Upd',0,2 UNION ALL
SELECT 139996,'Add Commission for SMA', 'CS_CustomerIns_Com',0,2 UNION ALL
SELECT 139997,'Add Commission for Master Agent', 'CS_CustomerIns_SAg',0,2 UNION ALL
SELECT 139998,'Add Commission for Agent', 'CS_CustomerIns_MAg',0,2 UNION ALL
SELECT 1221,'Remove the unused account''s credit by IT Admin', '',0,0 UNION ALL
SELECT 688,'Sub account creates nickname', 'Age_CustSubInsNickname',0,4 UNION ALL
SELECT 689,'Sub account sets login option by nickname only', 'Age_CustSubUpdNicknameLoginOnly',0,4 UNION ALL
SELECT 690,'Sub account creates nickname', 'CS_CustSubInsNickname',0,4 UNION ALL
SELECT 691,'Delete sub account', 'CS_CustSubDel',0,4 UNION ALL
SELECT 692,'Add new managed account for sub account', 'CS_CustomerIns_SAg',0,4 UNION ALL
SELECT 693,'Managed account on sub account', 'CS_SubAccManagementUpd',0,4 UNION ALL
SELECT 694,'Update account in robot list', 'NAP_Customer_RobotAccountNew_Ins',1,4 UNION ALL
SELECT 695,'Add account to robot list', 'NAP_Customer_RobotAccountNew_Ins',1,4 UNION ALL
SELECT 696,'Remove account from robot list', 'NAP_Customer_RobotAccountNew_Del',1,4 UNION ALL
SELECT 697,'Default profile picture has been added.', 'Age_CustomerUpdProfilePicture',0,4 UNION ALL
SELECT 698,'Default profile picture has been changed to user''s picture.', 'Age_CustomerUpdProfilePicture',0,4 UNION ALL
SELECT 699,'User''s profile picture has been changed to default.', 'Age_CustomerUpdProfilePicture',0,4 UNION ALL
SELECT 40005,'Update discount on member for number game', 'Las_AgentEditMemDiscount3rd',0,2 UNION ALL
SELECT 40006,'Update betlimit on member for number game', 'Las_Dep_UpdateMemberBetLimit3rd',0,3 UNION ALL
SELECT 40007,'Insert cust setting 3rd for number game', 'Las_Dep_InsMember3rd',0,3 UNION ALL
SELECT 31608,'Update Review Status for MA', 'CS_ProblemAccount_ReviewStatusUpd',0,6 UNION ALL
SELECT 31609,'Update Review Status for Agent', 'CS_ProblemAccount_ReviewStatusUpd',0,6 UNION ALL
SELECT 31610,'Update Review Status for Member', 'CS_ProblemAccount_ReviewStatusUpd',0,6 UNION ALL
SELECT 31611,'Unmark Problem Account - Member', 'CS_ProblemAccount_RemoveCustomer',1,0 UNION ALL
SELECT 31701,'Add account to Bet Restriction List', 'NAP_BetRestriction_CustomerIns',1,0 UNION ALL
SELECT 31702,'Edit Bet Restriction Account', 'NAP_BetRestriction_CustomerUpd',1,0 UNION ALL
SELECT 31703,'Remove Bet Restriction Account', 'NAP_BetRestriction_CustomerDel',1,0 UNION ALL
SELECT 31704,'Add site to Bet Restriction List', 'NAP_BetRestriction_SiteIns',1,0 UNION ALL
SELECT 31705,'Edit Bet Restriction Site', 'NAP_BetRestriction_SiteUpd',1,0 UNION ALL
SELECT 31706,'Remove Bet Restriction Site', 'NAP_BetRestriction_SiteDel',1,0 UNION ALL
SELECT 31707,'Add currency to Bet Restriction List', 'NAP_BetRestriction_CurrencyIns',1,0 UNION ALL
SELECT 31708,'Edit Bet Restriction Currency', 'NAP_BetRestriction_CurrencyUpd',1,0 UNION ALL
SELECT 31709,'Remove Bet Restriction Currency', 'NAP_BetRestriction_CurrencyDel',1,0 UNION ALL
SELECT 31710,'On/Off Applying Bet Restriction', 'NAP_BetRestriction_SettingUpd',1,0 UNION ALL
SELECT 6000,'Add customer to the monitoring list', 'Acc_CustAllowListIns',1,4 UNION ALL
SELECT 208,'Update Finance Commission', 'Acc_CustomerUpdCommissionFI',0,2 UNION ALL
SELECT 209,'Update Racing Commission for super', 'Acc_CustomerUpdSuper_CommissionHR',0,2 UNION ALL
SELECT 210,'Update Racing Commission for master', 'Acc_CustomerUpdMaster_CommissionHR',0,2 UNION ALL
SELECT 211,'Update Racing Commission for agent', 'Acc_CustomerUpdAgent_CommissionHR',0,2 UNION ALL
SELECT 212,'Update Racing Commission for member', 'Acc_CustomerUpdMember_CommissionHR',0,2 UNION ALL
SELECT 213,'Update Sportsbook Commission for member', 'Age_CustomerUpdUserComm',0,2 UNION ALL
SELECT 40008,'Agent Update Member Discount', 'Las_Dep_AgentUpdateMemberDiscount',1,2 UNION ALL
SELECT 40009,'Insert member', 'Las_Dep_InsMember',1,3 UNION ALL
SELECT 40010,'Update Member BetLimit', 'Las_Dep_UpdateMemberBetLimit',1,3 UNION ALL
SELECT 40011,'Update Member Credit', 'Las_Dep_UpdateMemberCredit',1,4 UNION ALL
SELECT 40012,'Update Member Discount', 'Las_Dep_UpdateMemberDiscount',1,2 UNION ALL
SELECT 40013,'Calculate NG for LAS (live ball)', 'Admin_PreCalculate_s161_Live',1,0 UNION ALL
SELECT 40014,'Calculate NG for LAS (dead ball)', 'Admin_Calculate_s161_Pregame',1,0 UNION ALL
SELECT 40015,'Refund NG for LAS', 'Admin_Calculate_s161_Refund',1,0 UNION ALL
SELECT 40016,'Pre calculate VS (1) for LAS', 'Admin_PreCalculate_1',1,0 UNION ALL
SELECT 30004,'IT Admin delete match setting for SMA Turnover function', 'NAP_SMATurnover_MatchControlDel',1,0 UNION ALL
SELECT 30005,'IT Admin insert SMA setting by match for SMA Turnover function', 'NAP_SMATurnover_SMAControlByEventIns',1,0 UNION ALL
SELECT 30006,'IT Admin update SMA setting by match for SMA Turnover function', 'NAP_SMATurnover_SMAControlByEventUpd',1,0 UNION ALL
SELECT 31001,'Update info for smart punter', 'Nap_CustomerUpdSmartPunter',1,4 UNION ALL
SELECT 31002,'Remove customer from smart punter list', 'Nap_CustomerDelSmartPunter',1,4 UNION ALL
SELECT 31003,'Search Customer', 'Acc_CustomerSelCheckSmartPunter',1,0 UNION ALL
SELECT 31004,'View Bet List', 'Acc_CustomerSelCheckSmartPunter',1,0 UNION ALL
SELECT 31005,'View Bet List', 'Acc_CustomerSelCheckSmartPunter',1,0 UNION ALL
SELECT 31006,'View Bet List', 'Acc_CustomerSelCheckSmartPunter',1,0 UNION ALL
SELECT 31007,'View Bet List', 'Acc_CustomerSelCheckSmartPunter',1,0 UNION ALL
SELECT 31008,'View Bet List', 'Age_UserLog_SmartPunterInsMultiple',1,0 UNION ALL
SELECT 31201,'Update win limit control currency setting', 'NAP_WinLimit_CurrencySettingUpd',1,0 UNION ALL
SELECT 31203,'Add win limit control customer setting', 'NAP_WinLimit_CustSettingIns',1,0 UNION ALL
SELECT 31204,'Update win limit control customer setting', 'NAP_WinLimit_CustSettingUpd',1,0 UNION ALL
SELECT 31206,'Delete win limit control customer setting', 'NAP_WinLimit_CustSettingDel',1,0 UNION ALL
SELECT 228,'Update live casino commission for super and all downlines', 'Acc_CustomerUpdSuperLiveCS_CommissionForAllLevels',0,2 UNION ALL
SELECT 233,'Update RNG Keno Commission for super', 'Acc_CustomerUpdSuperKeno_Commission',0,0 UNION ALL
SELECT 234,'Update RNG Keno Commission for master', 'Acc_CustomerUpdMasterKeno_Commission',0,0 UNION ALL
SELECT 235,'Update RNG Keno Commission for agent', 'Acc_CustomerUpdAgentKeno_Commission',0,0 UNION ALL
SELECT 236,'Update RNG Keno Commission for member', 'Acc_CustomerUpdMemberKeno_Commission',0,0 UNION ALL
SELECT 237,'Update Other Products Commission for customers', 'Acc_CustSetting_DiscountUpd',0,2 UNION ALL
SELECT 238,'Update Gold Deluxe Commission for super', 'Acc_CustomerUpdSuperGoldDeluxe_Commission',0,2 UNION ALL
SELECT 435,'Update Super''s Virtual Sports Position Taking at member', 'Acc_CustomerUpdMemberVS_SAg',0,1 UNION ALL
SELECT 442,'Update RNG Keno Position Taking for super', 'Acc_CustomerUpdSuperKeno_Positiontaking',0,0 UNION ALL
SELECT 443,'Update RNG Keno Position Taking for master', 'Acc_CustomerUpdMasterKeno_Positiontaking',0,0 UNION ALL
SELECT 444,'Update RNG Keno Position Taking for agent', 'Acc_CustomerUpdAgentKeno_Positiontaking',0,0 UNION ALL
SELECT 445,'Update RNG Keno Position Taking for member', 'Acc_CustomerUpdMemberKeno_Positiontaking',0,0 UNION ALL
SELECT 446,'Update Master''s RNG Keno Position Taking for member', 'Acc_CustomerUpdMemberKeno_MAg',0,0 UNION ALL
SELECT 447,'Update Super''s RNG Keno Position Taking for member', 'Acc_CustomerUpdMemberKeno_SAg',0,0 UNION ALL
SELECT 448,'Update Other Products Position Taking for Super', 'Acc_CustSetting_SuperPTUpd',0,1 UNION ALL
SELECT 449,'Update Other Products Position Taking for Master', 'Acc_CustSetting_MasterPTUpd',0,1 UNION ALL
SELECT 450,'Update Other Products Position Taking for Member (Multiple)', 'Acc_CustSetting_AgentPTOnMemberMultiUpd',0,1 UNION ALL
SELECT 451,'Update Master''s Other Products Position Taking for Member (Multiple)', 'Acc_CustSetting_MasterPTOnMemberMultiUpd',0,1 UNION ALL
SELECT 452,'Update Super''s Other Products Position Taking for Member (Multiple)', 'Acc_CustSetting_SuperPTOnMemberMultiUpd',0,1 UNION ALL
SELECT 453,'Update Other Products Position Taking for Member', 'Acc_CustSetting_AgentPTOnMemberUpd',0,1 UNION ALL
SELECT 454,'Update Other Products Position Taking for Agent', 'Acc_CustSetting_AgentPTUpd',0,1 UNION ALL
SELECT 375,'Update Live Casino Member Win Limit', 'Acc_CustomerUpdLiveCS_WinLimit',0,3 UNION ALL
SELECT 376,'Update racing bet setting of third party', 'Acc_RacingBetSettingUpd',1,3 UNION ALL
SELECT 377,'Set racing bet setting of third party', 'Acc_RacingBetSettingUpd',1,3 UNION ALL
SELECT 379,'Update RNG Keno Bet Setting for super', 'Acc_CustomerUpdSuperKeno_MinMaxBet',0,0 UNION ALL
SELECT 380,'Update RNG Keno Bet Setting for master', 'Acc_CustomerUpdMasterKeno_MinMaxBet',0,0 UNION ALL
SELECT 381,'Update RNG Keno Bet Setting for agent', 'Acc_CustomerUpdAgentKeno_MinMaxBet',0,0 UNION ALL
SELECT 1000,'Add customer to Credit Term Group', 'Acc_CreditTermUpdAddToGroup',1,4 UNION ALL
SELECT 1001,'Update Credit Term', 'Acc_CreditTermUpdCustomer',1,4 UNION ALL
SELECT 1002,'Remove customer from Credit Term Group', 'Acc_CreditTermUpdRemoveFromGroup',1,4 UNION ALL
SELECT 1003,'Set customer to Credit Term Headline', 'Acc_CreditTermUpdSetGroupHeadline',1,4 UNION ALL
SELECT 157,'Auto Payout - Calculate HT', 'NAP_Admin_Settlement_1_AutoPayout',0,0 UNION ALL
SELECT 158,'Auto Payout - Calculate FT', 'NAP_Admin_Settlement_1_AutoPayout',0,0 UNION ALL
SELECT 159,'Auto Payout - Turn On/Off Auto Payout on League', 'NAP_Set_AutoPayout_SettingLeagueUpd',0,0 UNION ALL
SELECT 160,'Auto Payout - Turn On/Off Auto Payout on Match', 'NAP_Set_AutoPayout_SettingMatchUpd',0,0 UNION ALL
SELECT 161,'Calculate FT Corner', 'NAP_Admin_Settlement_Corner',0,0 UNION ALL
SELECT 162,'Calculate HT Corner', 'NAP_Admin_Settlement_Corner',0,0 UNION ALL
SELECT 163,'Calculate FT - FGLG', 'Admin_Settlement_FGLG',0,0 UNION ALL
SELECT 164,'Calculate HT - FGLG', 'Admin_Settlement_FGLG',0,0 UNION ALL
SELECT 165,'Calculate Fast Markets', 'NAP_Admin_Settlement_Fast_Market_Auto_1s',0,0 UNION ALL
SELECT 166,'Undo Fast Markets', 'NAP_Admin_Settlement_Fast_Market_Auto_1s',0,0 UNION ALL
SELECT 167,'Refund Fast Markets', 'NAP_Admin_Settlement_Fast_Market_Auto_1s',0,0 UNION ALL
SELECT 671,'IT Admin update max turnover of the super that they want to control for a match', 'NAP_TOControl_TurnOverUpdOnMatch',1,4 UNION ALL
SELECT 672,'Update Extra Information', 'Acc_CustDirectUpd',1,0 UNION ALL
SELECT 673,'Insert the setting of Extra PT Group', 'Acc_GroupExtraPT_GroupByProduct_Ins',1,4 UNION ALL
SELECT 674,'Update the setting of Extra PT Group', 'Acc_GroupExtraPT_GroupByProduct_Upd',1,4 UNION ALL
SELECT 675,'Remove the setting of Extra PT Group', 'Acc_GroupExtraPT_GroupByProduct_Del',1,4 UNION ALL
SELECT 676,'Update config to send LetsTalk notification', 'NAP_LimitLoss_SMANotificationUpd',1,0 UNION ALL
SELECT 677,'Update Super Profile', 'EAS_CustomerUpdSuperInfo',1,0 UNION ALL
SELECT 678,'Limit max members creation per Super', 'Acc_MaxMemberLimitBySuperUpd',1,4 UNION ALL
SELECT 679,'Link Letstalk ID', 'Chatbot_InsertUser',0,4 UNION ALL
SELECT 680,'Verify Letstalk ID', 'Chatbot_UpdateMessengerAccountStatus',0,4 UNION ALL
SELECT 681,'Update Chatbot''s Language', 'Chatbot_UpdateUserLanguage',0,4 UNION ALL
SELECT 682,'Update Chatbot''s Function', 'Chatbot_UpdateUserFunctions',0,4 UNION ALL
SELECT 683,'Unlink Letstalk ID', 'Chatbot_UpdateMessengerAccountStatus',0,4 UNION ALL
SELECT 684,'Update Chatbot''s Self-destruction Period', 'Chatbot_UpdateSelfdestructionPeriod',0,4 UNION ALL
SELECT 685,'Add new sub account', 'CS_CustSubIns',0,4 UNION ALL
SELECT 686,'Update sub account', 'CS_CustSubUpd',0,4 UNION ALL
SELECT 687,'Create nickname', 'CS_CustomerInsNickName',0,4 UNION ALL
SELECT 2905,'Update discount on member for number game', 'Las_Dep_AgentUpdateMemberDiscount3rd',0,0 UNION ALL
SELECT 2906,'Update betlimit on member for number game', 'Las_Dep_UpdateMemberBetLimit3rd',0,0 UNION ALL
SELECT 2907,'Insert cust setting 3rd for number game', 'Las_Dep_InsMember3rd',0,0 UNION ALL
SELECT 5000,'Login via Affiliate admin site', 'Aff_UserLogin',1,0 UNION ALL
SELECT 5001,'Login Affiliate System''s Site via Admin''s Site', 'Aff_InternalLogin',1,0 UNION ALL
SELECT 2700,'Update Licensee BA Position Taking for member', 'Lrf_CustomerUpdMemberBA_PositionTaking',1,1 UNION ALL
SELECT 2701,'Add Position Taking for super', 'Acc_Dep_CustomerInsMember_Com',0,1 UNION ALL
SELECT 2702,'Add Position Taking for master', 'Acc_Dep_CustomerInsMember_SAg',0,1 UNION ALL
SELECT 2703,'Add Position Taking for agent', 'Acc_Dep_CustomerInsMember_MAg',0,1 UNION ALL
SELECT 2704,'Add Position Taking for member', 'Acc_Dep_CustomerInsMember_Ag',0,1 UNION ALL
SELECT 2705,'Update Sportsbook Position Taking for master', 'Acc_Dep_CustomerUpdMember_SAg',0,1 UNION ALL
SELECT 2706,'Update Sportsbook Position Taking for customer', 'Acc_Dep_CustomerUpdMember_Ag',0,1 UNION ALL
SELECT 2707,'Update Sportsbook Position Taking for Agent', 'Acc_Dep_CustomerUpdMember_MAg',0,1 UNION ALL
SELECT 80000,'Check data processing due to Move Bet/Balance Up process', 'Acc_CheckProcessingData',0,0 UNION ALL
SELECT 81000,'Calculate', 'NAP_Admin_Settlement_s164',0,0 UNION ALL
SELECT 81001,'Refund', 'NAP_Admin_Settlement_s164',0,0 UNION ALL
SELECT 81002,'Turn On/Off Pending', 'NAP_Set_SettlementStatusUpd',0,0 UNION ALL
SELECT 81003,'Turn On/Off Undecided', 'NAP_Set_SettlementStatusUpd',0,0 UNION ALL
SELECT 81004,'Turn On/Off Under Settlement', 'NAP_Set_SettlementStatusUpd',0,0 UNION ALL
SELECT 81005,'Turn On/Off MTD hold', 'NAP_Set_SettlementStatusUpd',0,0 UNION ALL
SELECT 81006,'Bet Builder - Turn On/Off Auto Setting on League', 'NAP_Set_AutoPayout_SettingLeagueUpd',0,0 UNION ALL
SELECT 81007,'Bet Builder - Turn On/Off Auto Setting on Match', 'NAP_Set_AutoPayout_SettingLeagueUpd',0,0 UNION ALL
SELECT 81008,'Undo Settlement NG2', 'NAP_Admin_Settlement_Undo_s213',0,0 UNION ALL
SELECT 81009,'Bet Builder - Calculate', 'NAP_Admin_Settlement_BetBuilder',0,0 UNION ALL
SELECT 81010,'Bet Builder - Uncalculate', 'NAP_Admin_Settlement_BetBuilder',0,0 UNION ALL
SELECT 60004,'Update Product Status of Casino on Super ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 60005,'Update Product Status of Casino on Super by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 60006,'Update Product Status of Colossus Bets on Super ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 60007,'Update Product Status of Colossus Bets on Super by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 75518,'Update Product Status of Macau Games on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75519,'Update Product Status of Macau Games on Member by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75520,'Update Product Status of Macau Games on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75521,'Update Product Status of Macau Games on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75507,'Update Product Status of Virtual Sports on Member ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75508,'Update Product Status of Allbet on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75509,'Update Product Status of Allbet on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75510,'Update Product Status of Allbet on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75511,'Update Product Status of Allbet on Member by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75033,'Update Product Status of Number Game on Agent by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 75034,'Update Product Status of Number Game on Master by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 75035,'Update Product Status of Number Game on Super by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 75036,'Update Suspended status on Super', 'Acc_CustomerUpdSuspended',0,5 UNION ALL
SELECT 75037,'Update Suspended status on Master', 'Acc_CustomerUpdSuspended',0,5 UNION ALL
SELECT 75038,'Update Suspended status on Agent', 'Acc_CustomerUpdSuspended',0,5 UNION ALL
SELECT 75500,'Update Product Status of Virtual Sports on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 75023,'Update Product Status of Casino on Super by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 75024,'Update Product Status of Colossus Bets on Member ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 75025,'Update Product Status of Colossus Bets on Agent ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 75026,'Update Product Status of Colossus Bets on Master ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 75027,'Update Product Status of Colossus Bets on Super ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 75012,'Update Product Status of RNG Keno on Member by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 75013,'Update Product Status of RNG Keno on Agent by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 75014,'Update Product Status of RNG Keno on Master by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 75015,'Update Product Status of RNG Keno on Super by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 75016,'Update Product Status of Casino on Member ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 75001,'Update Product Status of Gold Deluxe on Agent', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 75002,'Update Product Status of Gold Deluxe on Master', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 75003,'Update Product Status of Gold Deluxe on Super', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 75004,'Update Product Status of Gold Deluxe on Member by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 70538,'Update Product Status of Bullfighting on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70539,'Update Product Status of Bullfighting on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70540,'Update Product Status of Bullfighting on Master', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70541,'Update Product Status of Bullfighting on Agent', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70542,'Update Product Status of Lotto on Super by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 70543,'Update Product Status of Lotto on Master by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 70544,'Update Product Status of Lotto on Agent by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 70545,'Update Product Status of Lotto on Super ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 70546,'Update Product Status of Lotto on Master ', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 70527,'Update Product Status of Lucky 3 on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70528,'Update Product Status of Lucky 3 on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70529,'Update Product Status of Lucky 3 on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70530,'Update Product Status of Lottery on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70531,'Update Product Status of Lottery on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70517,'Update Product Status of Macau Games on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70518,'Update Product Status of Fishing World on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70519,'Update Product Status of Fishing World on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70520,'Update Product Status of Fishing World on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70024,'Update Product Status of Number Game on Agent by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 70025,'Update Product Status of Number Game on Master by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 70026,'Update Product Status of Number Game on Super by Admin', 'Acc_AdminUpdDisableNumberGame',0,5 UNION ALL
SELECT 70027,'Update Suspended status on Super', 'Acc_CustomerUpdSuspended',0,5 UNION ALL
SELECT 70028,'Update Suspended status on Master', 'Acc_CustomerUpdSuspended',0,5 UNION ALL
SELECT 70500,'Update Product Status of Virtual Sports on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70014,'Update Product Status of Casino on Super ', 'Acc_UpdCSStatus_Cust',0,5 UNION ALL
SELECT 70015,'Update Product Status of Casino on Agent by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 70016,'Update Product Status of Casino on Master by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 70017,'Update Product Status of Casino on Super by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 70018,'Update Product Status of Colossus Bets on Agent ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 70003,'Update Product Status of Gold Deluxe on Agent by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 70004,'Update Product Status of Gold Deluxe on Master by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 70005,'Update Product Status of Gold Deluxe on Super by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 70006,'Update Product Status of RNG Keno on Agent ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 65524,'Update Product Status of Bullfighting on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65525,'Update Product Status of Bullfighting on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65526,'Update Product Status of Bullfighting on Super', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65527,'Update Product Status of Bullfighting on Master', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65528,'Update Product Status of Lotto on Super by Admin', 'Acc_Admin_DisableGameStatusUpd',0,5 UNION ALL
SELECT 65513,'Update Product Status of Fishing World on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65514,'Update Product Status of Fishing World on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65515,'Update Product Status of Fishing World on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65516,'Update Product Status of Lucky 3 on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65517,'Update Product Status of Lucky 3 on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65503,'Update Product Status of Virtual Sports on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65504,'Update Product Status of Allbet on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65505,'Update Product Status of Allbet on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65506,'Update Product Status of Allbet on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65507,'Update Product Status of Allbet on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 65011,'Update Product Status of Casino on Super by Admin', 'Acc_AdminUpdCSStatus_Cust',0,5 UNION ALL
SELECT 65012,'Update Product Status of Colossus Bets on Master ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 65013,'Update Product Status of Colossus Bets on Super ', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 65014,'Update Product Status of Colossus Bets on Master by Admin', 'Acc_AdminUpdDisableColossusBet',0,5 UNION ALL
SELECT 65000,'Update Product Status of Gold Deluxe on Master', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 65001,'Update Product Status of Gold Deluxe on Super', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 65002,'Update Product Status of Gold Deluxe on Master by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 65003,'Update Product Status of Gold Deluxe on Super by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 70507,'Update Product Status of Allbet on Master by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70508,'Update Product Status of Allbet on Agent by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70509,'Update Product Status of Allbet on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70510,'Update Product Status of Allbet on Master ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 70511,'Update Product Status of Allbet on Agent ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 144,'API Auto Settlement: failed', 'NAP_Admin_Settlement_AutoWriteLog',0,0 UNION ALL
SELECT 145,'Undo Outright Settlement', 'NAP_Admin_Settlement_Outright',0,0 UNION ALL
SELECT 148,'Calculate Early Settlement', 'NAP_Admin_Settlement_Auto_1s',0,0 UNION ALL
SELECT 149,'Undo Early Settlement', 'NAP_Admin_Settlement_Auto_1s',0,0 UNION ALL
SELECT 150,'Refund Early Settlement', 'NAP_Admin_Settlement_Auto_1s',0,0 UNION ALL
SELECT 151,'Calculate All Corner', 'NAP_Admin_Settlement_Corner',0,0 UNION ALL
SELECT 152,'Super Live - Calculate', 'Nap_Admin_Settlement_MetricGaming',0,0 UNION ALL
SELECT 153,'Super Live - Undo', 'Nap_Admin_Settlement_MetricGaming',0,0 UNION ALL
SELECT 154,'Super Live - Refund', 'Nap_Admin_Settlement_MetricGaming',0,0 UNION ALL
SELECT 2200,'Update Closed status', 'Lrf_CustomerUpdClosed',0,0 UNION ALL
SELECT 2201,'Update Suspended status', 'Lrf_CustomerUpdSuspended',0,0 UNION ALL
SELECT 2202,'Add the initial statuses for super', 'Acc_Dep_CustomerInsMember_Com',0,0 UNION ALL
SELECT 2203,'Add the initial statuses for master', 'Acc_Dep_CustomerInsMember_SAg',0,0 UNION ALL
SELECT 2204,'Add the initial statuses for agent', 'Acc_Dep_CustomerInsMember_MAg',0,0 UNION ALL
SELECT 2205,'Add the initial statuses for member', 'Acc_Dep_CustomerInsMember_Ag',0,0 UNION ALL
SELECT 2210,'Update Status of AG Casino for Super', 'Acc_AGC_UpdSuperStatus',0,0 UNION ALL
SELECT 2211,'Update Status of AG Casino for Member', 'Lrf_AGC_UpdCustStatus',0,0 UNION ALL
SELECT 2212,'Update Status of 3rd Product for Super', 'Acc_3rdProductUpdSuperStatus',0,0 UNION ALL
SELECT 2213,'Update Status of 3rd product for Member', 'Dep_3rdProductUpdCustStatus',0,0 UNION ALL
SELECT 2214,'Create Licensee', 'Dot_Dep_CreateLicensee',0,0 UNION ALL
SELECT 2215,'Create Licensee Subsidiary', 'Acc_Dep_CustomerInsLicenseeSubsidiary',0,0 UNION ALL
SELECT 1004,'Update customer remarks from Credit Term Report', 'Acc_CreditTermUpdRemark',1,4 UNION ALL
SELECT 1006,'Update Disallowed/Allowed Consolidation Report status', 'Acc_CreditTermUpdIsRptConsol',1,4 UNION ALL
SELECT 1050,'Update Message Customer Read Status', 'Age_MsgCustReadStatus_Upd',1,0 UNION ALL
SELECT 1100,'Add the initial statuses for super', 'Acc_CustomerInsMember_Com',0,5 UNION ALL
SELECT 1101,'Add the initial statuses for master', 'Acc_CustomerInsMember_SAg',0,5 UNION ALL
SELECT 1102,'Add the initial statuses for agent', 'Acc_CustomerInsMember_MAg',0,5 UNION ALL
SELECT 1103,'Add the initial statuses for member', 'Acc_CustomerInsMember_Ag',0,5 UNION ALL
SELECT 1104,'Update Suspended status', 'Acc_CustomerUpdSuspended',0,5 UNION ALL
SELECT 700,'Default profile picture has been changed.', 'Age_CustomerUpdProfilePicture',0,4 UNION ALL
SELECT 701,'User''s profile picture has been changed.', 'Age_CustomerUpdProfilePicture',0,4 UNION ALL
SELECT 702,'Update Poker max transfer credit for master', 'Acc_CustomerUpdP2PMaster_MaxTransfer',0,0 UNION ALL
SELECT 703,'Update Poker max transfer credit for agent', 'Acc_CustomerUpdP2PAgent_MaxTransfer',0,0 UNION ALL
SELECT 704,'Update Poker max transfer credit for member', 'Acc_CustomerUpdP2PMember_MaxTransfer',0,0 UNION ALL
SELECT 705,'Enabled/Disabled All day balance transfer', 'Acc_CustomerUpdAllDayBalTransfer',1,0 UNION ALL
SELECT 657,'IT Admin update SMA Global Setting for SMA Turnover function', 'NAP_SMATurnoverGlobalSettingUpd',1,4 UNION ALL
SELECT 658,'IT Admin delete SMA Global Setting for SMA Turnover function', 'NAP_SMATurnoverGlobalSettingDel',1,4 UNION ALL
SELECT 659,'Insert Win/Loss Limit for Customer', 'Acc_CustomerWinLimitIns',1,4 UNION ALL
SELECT 660,'Update Headline Type', 'Acc_CustomerUpdGroupHeadlineType',0,0 UNION ALL
SELECT 661,'Update Owner', 'Acc_CustomerUpdGroupHeadlineOwner',0,0 UNION ALL
SELECT 665,'Delete SMA from Limit Loss Control', 'NAP_LimitLoss_SMADel',0,0 UNION ALL
SELECT 666,'Insert SMA to Limit Loss Control', 'NAP_LimitLoss_SMAIns',0,0 UNION ALL
SELECT 667,'Update Max Loss', 'NAP_LimitLoss_SMAMaxLossUpd',0,0 UNION ALL
SELECT 668,'IT Admin insert SMA Global Setting for SMA Turnover function', 'NAP_TOControl_GlobalSettingIns',1,4 UNION ALL
SELECT 669,'IT Admin update SMA Global Setting for SMA Turnover function', 'NAP_TOControl_GlobalSettingUpd',1,4 UNION ALL
SELECT 670,'IT Admin delete SMA Global Setting for SMA Turnover function', 'NAP_TOControl_GlobalSettingDel',1,4 UNION ALL
SELECT 900,'Reset Password', 'Acc_CustomerUpdPwdReset',0,4 UNION ALL
SELECT 901,'Reset downline''s password', 'Age_CustomerUpdPwd',0,4 UNION ALL
SELECT 902,'Reset own password', 'Age_CustomerPwdUpd2',0,4 UNION ALL
SELECT 903,'Reset Sub-account''s password', 'Age_CustSubPwdUpd',0,4 UNION ALL
SELECT 904,'Sub-account changed his own password', 'Age_CustSubPwdUpd2',0,4 UNION ALL
SELECT 905,'Account was closed by failed login 5 times', 'Acc_LoginAdmin',0,4 UNION ALL
SELECT 906,'Account was closed by failed login 5 times', 'Agw_LoginDownline',0,4 UNION ALL
SELECT 907,'Sub-account was closed by failed login 5 times', 'Age_LoginDownline_Sub',0,4 UNION ALL
SELECT 400,'Add Position Taking for super', 'Acc_CustomerInsMember_Com',0,1 UNION ALL
SELECT 401,'Add Position Taking for master', 'Acc_CustomerInsMember_SAg',0,1 UNION ALL
SELECT 402,'Add Position Taking for agent', 'Acc_CustomerInsMember_MAg',0,1 UNION ALL
SELECT 403,'Add Position Taking for member', 'Acc_CustomerInsMember_Ag',0,1 UNION ALL
SELECT 404,'Update Super''s Sportsbook Position Taking at member', 'Acc_CustomerUpdMember_Super',0,1 UNION ALL
SELECT 300,'Add Bet Setting for super', 'Acc_CustomerInsMember_Com',0,3 UNION ALL
SELECT 301,'Add Bet Setting for master', 'Acc_CustomerInsMember_SAg',0,3 UNION ALL
SELECT 302,'Add Bet Setting for agent', 'Acc_CustomerInsMember_MAg',0,3 UNION ALL
SELECT 303,'Add Bet Setting for member', 'Acc_CustomerInsMember_Ag',0,3 UNION ALL
SELECT 304,'Update Sportsbook Bet Setting for super', 'Acc_CustomerUpdSuper_MinMaxBet',0,3 UNION ALL
SELECT 305,'Update Sportsbook Bet Setting for master', 'Acc_CustomerUpdMaster_MinMaxBet',0,3 UNION ALL
SELECT 306,'Update Sportsbook Bet Setting for agent', 'Acc_CustomerUpdAgent_MinMaxBet',0,3 UNION ALL
SELECT 40037,'Licensee edit discount on agent', 'Las_LicenseeEditAgentDiscount3rd',0,2 UNION ALL
SELECT 40038,'Disable or enable product setting', 'Las_Dep_DisableProductSetting',0,4 UNION ALL
SELECT 40039,'Adjust product setting', 'Las_Dep_AdjustProductSetting',0,4 UNION ALL
SELECT 60000,'Update Product Status of Gold Deluxe on Super', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 60001,'Update Product Status of Gold Deluxe on Super by Admin', 'Acc_AdminUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 60002,'Update Product Status of RNG Keno on Super ', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 60003,'Update Product Status of RNG Keno on Super by Admin', 'Acc_AdminUpdDisableKeno',0,5 UNION ALL
SELECT 40031,'Add the initial statuses for member', 'Las_Dep_CustomerInsMember',0,0 UNION ALL
SELECT 40032,'Update bet setting to prevent user place bet for legend cash', 'Las_Dep_UpdateBetSettingToPreventPlaceBet',0,3 UNION ALL
SELECT 40033,'Update bet setting after switch user from normal to legend cash', 'Las_Dep_SwitchUserUpateSetting',0,3 UNION ALL
SELECT 40034,'Update status after switch user from normal to legend cash', 'Las_Dep_SwitchUserUpateSetting',0,3 UNION ALL
SELECT 40035,'Adjust bet setting after add new member for legend cash', 'Las_Dep_AdjustBetSetting',0,3 UNION ALL
SELECT 40036,'Adjust cust comm to zero when re-arrangement', 'Las_LicenseeCustInfoUpdRearrangement',0,0 UNION ALL
SELECT 500,'Update Sportsbook Min/Max Position Taking', 'Acc_CustOverrideUpd',0,1 UNION ALL
SELECT 501,'Update Finance Min/Max Position Taking', 'Acc_CustOverrideUpdFI',0,1 UNION ALL
SELECT 502,'Update Racing Min/Max Position Taking', 'Acc_CustOverrideUpdHR',0,1 UNION ALL
SELECT 503,'Update Live casino Min Position Taking', 'Acc_CustOverrideUpdLiveCS',0,1 UNION ALL
SELECT 504,'Update Virtual Sports Min/Max Position Taking', 'Acc_CustOverrideUpdVS',0,1 UNION ALL
SELECT 506,'Update RNG Keno Min Position Taking', 'Acc_CustOverrideUpdKeno',0,0 UNION ALL
SELECT 507,'Update Gold Deluxe Min Position Taking', 'Acc_CustOverrideUpdGoldDeluxe',0,1 UNION ALL
SELECT 600,'Add the general information for super', 'Acc_CustomerInsMember_Com',0,4 UNION ALL
SELECT 1156,'Update Enable/Disable Super Live status', 'Acc_CustomerUpdDisableSuperLive',0,5 UNION ALL
SELECT 1157,'Update Enable/Disable Colossus Bets status', 'Acc_CustomerUpdDisableColossusBet',0,5 UNION ALL
SELECT 1158,'Enabled/Disabled Other Games status', 'Acc_CustSetting_DisableGameStatusUpd',0,5 UNION ALL
SELECT 1159,'Synchronized Other Games status', 'Acc_CustSetting_SyncGameStatusUpd',1,5 UNION ALL
SELECT 1160,'Multiple synchronized Other Games status', 'Acc_CustSetting_SyncGameStatusUpd_Multiple',1,5 UNION ALL
SELECT 1161,'Enabled/Disabled Other Products status', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 245,'Update Colossus Bets Cash-In Share For Super', 'Acc_CustomerUpdColossusBet_Commission',0,0 UNION ALL
SELECT 246,'Update Colossus Bets Cash-In Share For Master', 'Acc_CustomerUpdColossusBet_Commission',0,0 UNION ALL
SELECT 247,'Update Colossus Bets Cash-In Share For Agent', 'Acc_CustomerUpdColossusBet_Commission',0,0 UNION ALL
SELECT 248,'Update Other Products Charge Commission for customers', 'Acc_CustSetting_DiscountUpd',0,2 UNION ALL
SELECT 249,'Add customer have no commission', 'Acc_CustomerNoCommIns',1,2 UNION ALL
SELECT 250,'Update Other Products Ticket Commission for customers', 'Acc_CustSetting_TicketCommissionUpd',0,2 UNION ALL
SELECT 31207,'Company Winlimit - Unblock member', 'NAP_WinLimit_Game_Unblock',0,0 UNION ALL
SELECT 31301,'Update ON/OFF IMBC Restriction', 'Acc_CustSetting_SettingRestrictionUpdate',1,0 UNION ALL
SELECT 31401,'Update notified status for customers', 'NAP_BetMonitoring_NotifiedCustomerListUpd',1,0 UNION ALL
SELECT 31402,'Update bet monitoring config', 'NAP_BettingMonitor_SettingUpd',1,0 UNION ALL
SELECT 31501,'Insert Customer Limit Date', 'Acc_CustomerDateLimitIns',1,0 UNION ALL
SELECT 31502,'Delete Customer Limit Date', 'Acc_CustomerDateLimitDel',1,0 UNION ALL
SELECT 31503,'Update Customer Limit Date', 'EAS_CustomerDateLimitMultipleUpd',0,4 UNION ALL
SELECT 31601,'Mark New Problem Account', 'CS_ProblemAccount_AddCustomer',1,6 UNION ALL
SELECT 31602,'Reduce Bet Limit', 'CS_ProblemAccount_ReduceBetLimit',1,6 UNION ALL
SELECT 31603,'Remove Reduced Bet Limit - S/M/A', 'CS_ProblemAccount_RemoveReduceBetLimit',1,6 UNION ALL
SELECT 31604,'Remove Reduced Bet Limit - Member', 'CS_ProblemAccount_RemoveReduceBetLimit',1,6 UNION ALL
SELECT 31605,'Update Review Status for SMA', 'CS_ProblemAccount_ReviewStatusUpd',0,0 UNION ALL
SELECT 31606,'Remove Reduced Bet Limit - Following Upline', 'CS_ProblemAccount_RemoveReduceBetLimit',1,6 UNION ALL
SELECT 31607,'Unmark Problem Account - S/M/A', 'CS_ProblemAccount_RemoveCustomer',1,6 UNION ALL
SELECT 176,'Settlement NG2', 'NAP_Admin_Settlement_s213',0,0 UNION ALL
SELECT 177,'Refund NG2', 'NAP_Admin_Settlement_Refund_s213',0,0 UNION ALL
SELECT 178,'Instant Calculation HT', 'NAP_Admin_Settlement_1_InstantCalculation',0,0 UNION ALL
SELECT 179,'Instant Calculation FT', 'NAP_Admin_Settlement_1_InstantCalculation',0,0 UNION ALL
SELECT 180,'Instant Calculation - Turn On/Off Auto Setting on League', 'NAP_Set_AutoPayout_SettingLeagueUpd',0,0 UNION ALL
SELECT 181,'Instant Calculation - Turn On/Off Auto Setting on Match', 'NAP_Set_AutoPayout_SettingMatchUpd',0,0 UNION ALL
SELECT 182,'Undo Instant Settlement', 'NAP_Admin_Settlement_1_InstantCalculation_Undo',0,0 UNION ALL
SELECT 183,'Fast Market - Turn On/Off Auto Setting on League', 'NAP_Set_AutoPayout_SettingLeagueUpd',0,0 UNION ALL
SELECT 184,'Fast Market - Turn On/Off Auto Setting on Match', 'NAP_Set_AutoPayout_SettingMatchUpd',0,0 UNION ALL
SELECT 185,'Auto Payout - Calculate HT', 'NAP_Admin_Settlement_1_AutoPayout_Push',0,0 UNION ALL
SELECT 186,'Auto Payout - Calculate FT', 'NAP_Admin_Settlement_1_AutoPayout_Push',0,0 UNION ALL
SELECT 187,'VS BetRadar Calculate All', 'NAP_Admin_Settlement_VS_BetRadar',0,0 UNION ALL
SELECT 188,'VS BetRadar Refund All', 'NAP_Admin_Settlement_VS_BetRadar',0,0 UNION ALL
SELECT 189,'Calculate Early Settlement', 'NAP_Admin_Settlement_2b',0,0 UNION ALL
SELECT 190,'Undo Early Settlement', 'NAP_Admin_Settlement_2b',0,0 UNION ALL
SELECT 191,'Refund Early Settlement', 'NAP_Admin_Settlement_2b',0,0 UNION ALL
SELECT 192,'Lucky3 - Calculate', 'NAP_Admin_Settlement_s160',0,0 UNION ALL
SELECT 193,'Lucky3 - Refund', 'NAP_Admin_Settlement_s160',0,0 UNION ALL
SELECT 194,'Lucky3 - Undo', 'NAP_Admin_Settlement_s160',0,0 UNION ALL
SELECT 195,'Auto Instant Calculation HT', 'NAP_Admin_Settlement_1_InstantCalculation',0,0 UNION ALL
SELECT 196,'Auto Instant Calculation FT', 'NAP_Admin_Settlement_1_InstantCalculation',0,0 UNION ALL
SELECT 197,'Auto Instant Calculation HT', 'NAP_Admin_Settlement_1_InstantCalculation_Push',0,0 UNION ALL
SELECT 198,'Auto Instant Calculation FT', 'NAP_Admin_Settlement_1_InstantCalculation_Push',0,0 UNION ALL
SELECT 392,'Update Other Products Game Betting Limit for customers', 'Acc_CustSetting_GameBetLimitUpd',0,3 UNION ALL
SELECT 393,'Update Other Bet Setting for Deposit member', 'Dot_Dep_CustomerUpdMemBetSetting_DCS',0,3 UNION ALL
SELECT 394,'Update Bet Settings DCS Products for Deposit Customers by Admin', 'Acc_Dep_CustSetting_BetLimitFullLineUpd',1,3 UNION ALL
SELECT 395,'Update Other Products Bet Setting for customers', 'Acc_CustSetting_BetSettingUpd',0,0 UNION ALL
SELECT 396,'Update global Betting Limit', 'Acc_Dep_CustSetting_GlobalStakeLevelUpdate',1,3 UNION ALL
SELECT 397,'Update Betting Limit DCS Products for Deposit Customers by Admin', 'Acc_Dep_CustSetting_StakeLevelUpd',1,3 UNION ALL
SELECT 40017,'Pre calculate VS (3) for LAS', 'Admin_PreCalculate_3',1,0 UNION ALL
SELECT 40018,'Pre calculate VS (4) for LAS', 'Admin_PreCalculate_4',1,0 UNION ALL
SELECT 40019,'Pre calculate VS (5) for LAS', 'Admin_PreCalculate_5',1,0 UNION ALL
SELECT 40020,'Pre calculate VS (6) for LAS', 'Admin_PreCalculate_6',1,0 UNION ALL
SELECT 40021,'Pre calculate VS (24) for LAS', 'Admin_PreCalculate_24',1,0 UNION ALL
SELECT 40022,'Calculate mix parlay for LAS (s181)', 'Admin_Calculate_181M',1,0 UNION ALL
SELECT 40023,'Calculate for LAS (s181)', 'Admin_Calculate_181',1,0 UNION ALL
SELECT 40024,'Refund for LAS (s181)', 'Admin_Calculate_VS_181_Refund',1,0 UNION ALL
SELECT 40025,'Void NG for LAS', 'NAP_BettransDelSpecial_NumberGame',1,0 UNION ALL
SELECT 40026,'Recover NG for LAS', 'NAP_BettransRecoverBet_NumberGame',1,0 UNION ALL
SELECT 40027,'Add Commission for member', 'Las_Dep_CustomerInsMember',0,2 UNION ALL
SELECT 40028,'Add Bet Setting for member', 'Las_Dep_CustomerInsMember',0,3 UNION ALL
SELECT 40029,'Add Position Taking for member', 'Las_Dep_CustomerInsMember',0,1 UNION ALL
SELECT 40030,'Add the general information for member', 'Las_Dep_CustomerInsMember',0,4 UNION ALL
SELECT 1314,'Login via Agent''s Site', 'Age_LoginVerifyDownline',1,0 UNION ALL
SELECT 1315,'Login via Agent''s Site', 'Age_LoginVerifyDownline',1,0 UNION ALL
SELECT 1316,'Login via Agent''s Site', 'Age_LoginDownline',1,0 UNION ALL
SELECT 1317,'Login via Agent''s Site', 'Age_LoginDownline_Sub',1,0 UNION ALL
SELECT 1318,'Login via Agent''s Wap Site', 'Agw_LoginDownline',0,0 UNION ALL
SELECT 1319,'Login via Agent''s Smartphone Site', 'Agm_LoginDownline',0,0 UNION ALL
SELECT 1320,'Login via Agent''s Wap Site', 'Agw_LoginDownline_Sub',0,0 UNION ALL
SELECT 1321,'Login via Agent''s Smartphone Site', 'Agm_LoginDownline_Sub',0,0 UNION ALL
SELECT 1322,'Login via Agent''s Site', 'Age_LoginDownline_API',0,0 UNION ALL
SELECT 1324,'Login via Agent''s Site', 'CS_AdminLoginVerifyBefore',0,0 UNION ALL
SELECT 1325,'Login via Agent''s Site', 'CS_AdminLoginVerifyBefore',1,0 UNION ALL
SELECT 1326,'Login via Agent''s Site', 'CS_LoginVerifyDownline',0,0 UNION ALL
SELECT 1327,'Login via Agent''s Site', 'CS_LoginVerifyDownline',1,0 UNION ALL
SELECT 1328,'Login via Agent''s Site', 'CS_LoginVerifyDownline',1,0 UNION ALL
SELECT 1329,'Login via Agent''s Site', 'CS_LoginClaimDownline',1,0 UNION ALL
SELECT 1200,'Update Given Credit', 'Acc_CustomerUpdCredit',0,0 UNION ALL
SELECT 1201,'Clear Credit', 'Acc_CustomerUpdClearCredit',0,0 UNION ALL
SELECT 1202,'Clear Member''s Credit', 'Acc_CustomerUpdResetMemberCredit',0,0 UNION ALL
SELECT 1203,'Update Member''s Credit', 'Age_CustomerUpdCredit_Ag',0,0 UNION ALL
SELECT 239,'Update Gold Deluxe Commission for master', 'Acc_CustomerUpdMasterGoldDeluxe_Commission',0,2 UNION ALL
SELECT 240,'Update Gold Deluxe Commission for agent', 'Acc_CustomerUpdAgentGoldDeluxe_Commission',0,2 UNION ALL
SELECT 241,'Update Gold Deluxe Commission for member', 'Acc_CustomerUpdMemberGoldDeluxe_Commission',0,2 UNION ALL
SELECT 242,'Update Colossus Bets Commission For Super', 'Acc_CustomerUpdColossusBet_Commission',0,0 UNION ALL
SELECT 243,'Update Colossus Bets Commission For Master', 'Acc_CustomerUpdColossusBet_Commission',0,0 UNION ALL
SELECT 244,'Update Colossus Bets Commission For Agent', 'Acc_CustomerUpdColossusBet_Commission',0,0 UNION ALL
SELECT 457,'Update Gold Deluxe Position Taking for super', 'Acc_CustomerUpdSuperGoldDeluxe_Positiontaking',0,1 UNION ALL
SELECT 458,'Update Gold Deluxe Position Taking for master', 'Acc_CustomerUpdMasterGoldDeluxe_PositionTaking',0,1 UNION ALL
SELECT 459,'Update Gold Deluxe Position Taking for agent', 'Acc_CustomerUpdAgentGoldDeluxe_Positiontaking',0,1 UNION ALL
SELECT 460,'Update Gold Deluxe Position Taking for member', 'Acc_CustomerUpdMemberGoldDeluxe_Positiontaking',0,1 UNION ALL
SELECT 461,'Update Super''s Gold Deluxe Position Taking for member', 'Acc_CustomerUpdMemberGoldDeluxe_SAg',0,1 UNION ALL
SELECT 462,'Update Master''s Gold Deluxe Position Taking for member', 'Acc_CustomerUpdMemberGoldDeluxe_MAg',0,1 UNION ALL
SELECT 469,'Update Position Taking DCS Products for Deposit Customers by Admin', 'Acc_Dep_CustSetting_PositionTakingSettingUpd',1,1 UNION ALL
SELECT 455,'Update Super''s Other Products Position Taking for Member', 'Acc_CustSetting_SuperPTOnMemberUpd',0,1 UNION ALL
SELECT 456,'Update Master''s Other Products Position Taking for Member', 'Acc_CustSetting_MasterPTOnMemberUpd',0,1 UNION ALL
SELECT 1147,'Update Enabled/Disabled HR Fixed Odds status', 'Acc_CustomerUpdDisableHRFixedOdds',0,5 UNION ALL
SELECT 1148,'Update Enable/Disable RNG Keno status', 'Acc_CustomerUpdDisableKeno',0,5 UNION ALL
SELECT 1149,'Update Open/Close Customer Status', 'NAP_Misc_OpenCloseMembers_UPD',0,5 UNION ALL
SELECT 1150,'Update to Enable/Disable E-Sports.', 'Acc_CustomerUpdDisableEsports',0,5 UNION ALL
SELECT 1151,'Mark as a Direct Account.', 'Acc_CustomerUpdDirectStatus',1,5 UNION ALL
SELECT 1152,'Enabled/Disabled Other Products status', 'Acc_CustSetting_DisableStatUpd',0,5 UNION ALL
SELECT 1153,'Synchronized Other Products status', 'Acc_CustSetting_SyncStatusUpd',1,5 UNION ALL
SELECT 1154,'Enable Disable 3rd Product', 'Acc_3rdProductUpdSuperStatus',0,5 UNION ALL
SELECT 1155,'Update enable/disable Gold Deluxe status', 'Acc_CustomerUpdDisableGoldDeluxe',0,5 UNION ALL
SELECT 1330,'Log-out', 'CS_CheckOut',1,0 UNION ALL
SELECT 1331,'Kick out member', 'Age_OnUser_ForceKickedout',0,0 UNION ALL
SELECT 1332,'Admin Login via Internal Agent''s Site', 'CS_LoginDownline_Admin',1,0 UNION ALL
SELECT 1400,'Delete ticket', 'Acc_BettransDelSpecial',0,0 UNION ALL
SELECT 1402,'Add Mailing list for Special Delete', 'Acc_MailingListIns',1,0 UNION ALL
SELECT 165000,'Create Account Status for Master Agent', 'CS_CustomerIns_SAg',0,5 UNION ALL
SELECT 160011,'Sub-account changed his own password', 'CS_CustSubPwdUpd2',0,4 UNION ALL
SELECT 160012,'Add general information for Headline', 'CS_CustomerIns_Headline',0,4 UNION ALL
SELECT 160013,'Change user group', 'CS_CustomerUserGroup_Upd',0,4 UNION ALL
SELECT 805,'Change Agent Currency and move to new master by IT Admin', 'DBA_ChangeCurrencyAndMoveAgent',0,4 UNION ALL
SELECT 806,'Update status of virtual rate', 'Acc_CustomerUpdVirtualMultiplier',1,4 UNION ALL
SELECT 807,'Update Virtual Multiplier for multiple customers', 'Acc_CustomerUpdVirtualMultiplier_Multiple',1,4 UNION ALL
SELECT 809,'Update Autosuspend for Esports', 'Acc_CustVirtualMultiplier_ViewLog_AutoSuspend',1,0 UNION ALL
SELECT 850,'Update Other Products Member Win/Loss Limit for customers', 'Acc_CustSetting_WinLossLimitUpd',0,0 UNION ALL
SELECT 851,'Update Other Products Member Loss Limit for customers', 'Acc_CustSetting_WinLossLimitUpd',0,0 UNION ALL
SELECT 5550,'BA Status (Player Admin)', 'Lrf_CustomerUpdMemberBAStatus',0,0 UNION ALL
SELECT 5551,'Odds Group (Player Admin)', 'Lrf_CustomerUpdUgroup',0,0 UNION ALL
SELECT 5552,'Special Level (Player Admin)', 'Lrf_CustomerUpdSpecialLevel',0,0 UNION ALL
SELECT 5553,'LA_UserSettingDel', 'LA_UserSettingDel',0,0 UNION ALL
SELECT 5554,'LA_UserSettingIns', 'LA_UserSettingIns',0,0 UNION ALL
SELECT 5555,'LA_UserSettingUpd', 'LA_UserSettingUpd',0,0 UNION ALL
SELECT 5556,'Player Status (Player Admin)', '',0,0 UNION ALL
SELECT 5557,'Reset Password (Player Admin)', '',0,0 UNION ALL
SELECT 5558,'Change Password (Player Admin)', '',0,0 UNION ALL
SELECT 5559,'Bank Information (Player Admin)', '',0,0 UNION ALL
SELECT 5560,'Bank Account Reset (Player Admin)', '',0,0 UNION ALL
SELECT 5561,'Bet Limit (Player Admin)', '',0,0 UNION ALL
SELECT 5562,'Note (Player Admin)', '',0,0 UNION ALL
SELECT 5563,'Personal Message (Player Admin)', '',0,0 UNION ALL
SELECT 5564,'Fund Transfer Limit (Player Admin)', '',0,0 UNION ALL
SELECT 5565,'Commission (Player Admin)', '',0,0 UNION ALL
SELECT 5566,'Insert new LAP USER', 'Nap_LM_LAPUser_Insert',0,0 UNION ALL
SELECT 5567,'Update LAP USER INFO', 'Nap_LM_LAPUser_UpdatePW',0,0 UNION ALL
SELECT 5539,'Assign LRF Function to Licensee', 'Nap_LM_LrfFunction_AssignToLicensee',0,0 UNION ALL
SELECT 5540,'Add new IT User', 'Nap_LM_ITUser_Insert',0,0 UNION ALL
SELECT 5541,'Assign IT User to Licensee', 'Nap_LM_ITUser_AssignToLicensee',0,0 UNION ALL
SELECT 5542,'Update LRF Function of IT User', 'Nap_LM_ITUser_UpdateFunction',0,0 UNION ALL
SELECT 5543,'Update Currency of IT User', 'Nap_LM_ITUser_UpdateCurrency',0,0 UNION ALL
SELECT 5544,'Update IT User', 'Nap_LM_ITUser_Update',0,0 UNION ALL
SELECT 5545,'Reset IT User Password', 'Nap_LM_ITUser_ResetPassword',0,0 UNION ALL
SELECT 5546,'Update charge rate group', 'LA_ChargeRateGroupChange',0,0 UNION ALL
SELECT 5547,'Add new licensee group', 'LA_LicenseeGroupIns',0,0 UNION ALL
SELECT 5548,'Update licensee group', 'LA_LicenseeGroupUpd',0,0 UNION ALL
SELECT 5549,'Delete licensee group', 'LA_LicenseeGroupDel',0,0 UNION ALL
SELECT 5002,'Sync a Affiliate System''s User from Admin''s Site', 'Aff_SyncInternalUser',1,0 UNION ALL
SELECT 5100,'User requests payment', 'Aff_User_PaymentRequestIns',0,0 UNION ALL
SELECT 5101,'User''s payment request is in progress', 'AffAdmin_PaymentRequest_InProgress',0,0 UNION ALL
SELECT 5102,'User cancels payment request', 'Aff_User_PaymentRequestUpd',0,0 UNION ALL
SELECT 5103,'User''s payment request is approved or rejected', 'AffAdmin_PaymentRequestUpd',0,0 UNION ALL
SELECT 5200,'Web API is called', 'Aff_WebAPI_WriteLog',0,0 UNION ALL
SELECT 5513,'add new rebate ', 'LA_RebateIns',0,0 UNION ALL
SELECT 5514,'update rebate', 'LA_RebateUpd',0,0 UNION ALL
SELECT 5515,'delete rebate', 'LA_RebateDel',0,0 UNION ALL
SELECT 5516,'add new discount', 'LA_DiscountIns',0,0 UNION ALL
SELECT 5517,'update discount', 'LA_DiscountUpd',0,0 UNION ALL
SELECT 5518,'delete discount', 'LA_DiscountDel',0,0 UNION ALL
SELECT 5519,'Add/Remove discount product', 'LA_DiscountUpd',0,0 UNION ALL
SELECT 5520,'Add/Remove discount party', 'LA_DiscountUpd',0,0 UNION ALL
SELECT 5521,'Change discount rate settings', 'LA_DiscountUpd',0,0 UNION ALL
SELECT 5522,'Insert Operator', 'Nap_LM_Operator_Insert',0,0 UNION ALL
SELECT 5523,'Update Operator', 'Nap_LM_Operator_Update',0,0 UNION ALL
SELECT 5524,'Import Operator', 'Nap_LM_Operator_Import',0,0 UNION ALL
SELECT 5525,'Delete operator', 'Nap_LM_Operator_Delete',0,0 UNION ALL
SELECT 5526,'Set up new licensee', 'Nap_LM_Licensee_Insert',0,0 UNION ALL
SELECT 5527,'Add new licensee agent/currency', 'Nap_LM_Licensee_AddAgent',0,0 UNION ALL
SELECT 5528,'Offer new product for licensee', 'Nap_LM_Licensee_OfferProduct',0,0 UNION ALL
SELECT 5529,'Add licensee into pull service', 'Nap_LM_Licensee_EnablePullService',0,0 UNION ALL
SELECT 5530,'Remove product from licensee', 'Nap_LM_Licensee_RemoveProduct',0,0 UNION ALL
SELECT 5531,'Terminate Licensee', 'Nap_LM_Licensee_Terminate',0,0 UNION ALL
SELECT 5532,'Add new Source Licensee Setting', 'Nap_LM_SourceLicensee_Insert',0,0 UNION ALL
SELECT 5533,'Update Source Licensee Setting', 'Nap_LM_SourceLicensee_Update',0,0 UNION ALL
SELECT 5534,'insert/update new key/value', 'LA_ModifySetting',0,0 UNION ALL
SELECT 5535,'Launch new licensee', 'LA_LaunchLicensee',0,0 UNION ALL
SELECT 5536,'Add new LRF Function', 'Nap_LM_LrfFunction_Insert',0,0 UNION ALL
SELECT 5537,'Update LRF Function', 'Nap_LM_LrfFunction_Update',0,0 UNION ALL
SELECT 5538,'Activate System for Licensee', 'Nap_LM_Licensee_ActivateSystem',0,0 UNION ALL
SELECT 60505,'Update Product Status of Macau Games on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60506,'Update Product Status of Fishing World on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60507,'Update Product Status of Fishing World on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60508,'Update Product Status of Lucky 3 on Super by Admin', 'Acc_Admin_DisableNewProductStatusUpd',0,5 UNION ALL
SELECT 60509,'Update Product Status of Lucky 3 on Super ', 'Acc_CustSetting_DisableNewProductStatusUpd',0,5

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
