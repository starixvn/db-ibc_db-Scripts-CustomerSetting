/*<info serverAlias="DBHIS-bodb_CustHistory" executers="" viewers="" isFunction="0"></info>*/
/*
	 Created by: 20241224@Johnson
	 Task: Credit - Transform data from DBCUST/CustDB_History to DBTP/bodb_CustHistory  [Redmine:#212684]
	 DB: DBTP-bodb_CustHistory
*/


USE bodb_CustHistory
GO

UPDATE Dest_ServiceTransform WITH(ROWLOCK, UPDLOCK)
SET StatusID = 1
WHERE StatusID = 0
	AND TableName IN  (
		'CustDiscount3rd_Agent_History',
		'CustDiscount3rd_Member_History',
		'CustInfo_History',
		'CustMaxPayoutSetting_Agent_History',
		'CustMaxPayoutSetting_Member_History',
		'Customer_History',
		'CustProductStatus_History',
		'CustPTGroupSetting3rd_Member_History',
		'CustPTSetting3rd_Agent_History',
		'CustPTSetting3rd_Member_History',
		'CustSettingMode3rd_History',
		'CustStakeLevel_Agent_History',
		'CustStakeLevel_Member_History',
		'CustWinLossLimit_Agent_History',
		'CustWinLossLimit_Member_History'
	)	
