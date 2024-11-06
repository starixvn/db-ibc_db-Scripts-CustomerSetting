/*<info serverAlias="DBHIS-bodb_CustHistory" executers="" viewers="" isFunction="0"></info>*/
/*
	 Created by: 20241223@Johnson
	 Task: Credit - Transform data from DBCUST/CustDB_History to DBTP/bodb_CustHistory  [Redmine:#212684]
	 DB: DBTP-bodb_CustHistory
*/
USE bodb_CustHistory
GO

INSERT INTO  Dest_ServiceTransform 
(	
	TableName, GroupID, Interval
	, rID, BatchSize
	, SPSelect, SPInsert, StatusID ,SiteDBGroupID ,UpdateTime	
)	
SELECT 'CustDiscount3rd_Agent_History', 4, 1000, 0, 1000, 'ServiceTransform_CustDiscount3rd_Agent_Select', 'ServiceTransform_CustDiscount3rd_Agent_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustDiscount3rd_Member_History', 4, 1000, 0, 1000, 'ServiceTransform_CustDiscount3rd_Member_Select', 'ServiceTransform_CustDiscount3rd_Member_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustInfo_History', 4, 1000, 0, 1000, 'ServiceTransform_CustInfo_Select', 'ServiceTransform_CustInfo_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustMaxPayoutSetting_Agent_History', 4, 1000, 0, 1000, 'ServiceTransform_CustMaxPayoutSetting_Agent_Select', 'ServiceTransform_CustMaxPayoutSetting_Agent_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustMaxPayoutSetting_Member_History', 4, 1000, 0, 1000, 'ServiceTransform_CustMaxPayoutSetting_Member_Select', 'ServiceTransform_CustMaxPayoutSetting_Member_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'Customer_History', 4, 1000, 0, 1000, 'ServiceTransform_Customer_Select', 'ServiceTransform_Customer_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustProductStatus_History', 4, 1000, 0, 1000, 'ServiceTransform_CustProductStatus_Select', 'ServiceTransform_CustProductStatus_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustPTGroupSetting3rd_Member_History', 4, 1000, 0, 1000, 'ServiceTransform_CustPTGroupSetting3rd_Member_Select', 'ServiceTransform_CustPTGroupSetting3rd_Member_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustPTSetting3rd_Agent_History', 4, 1000, 0, 1000, 'ServiceTransform_CustPTSetting3rd_Agent_Select', 'ServiceTransform_CustPTSetting3rd_Agent_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustPTSetting3rd_Member_History', 4, 1000, 0, 1000, 'ServiceTransform_CustPTSetting3rd_Member_Select', 'ServiceTransform_CustPTSetting3rd_Member_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustSettingMode3rd_History', 4, 1000, 0, 1000, 'ServiceTransform_CustSettingMode3rd_Select', 'ServiceTransform_CustSettingMode3rd_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustStakeLevel_Agent_History', 4, 1000, 0, 1000, 'ServiceTransform_CustStakeLevel_Agent_Select', 'ServiceTransform_CustStakeLevel_Agent_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustStakeLevel_Member_History', 4, 1000, 0, 1000, 'ServiceTransform_CustStakeLevel_Member_Select', 'ServiceTransform_CustStakeLevel_Member_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustWinLossLimit_Agent_History', 4, 1000, 0, 1000, 'ServiceTransform_CustWinLossLimit_Agent_Select', 'ServiceTransform_CustWinLossLimit_Agent_Insert', 0, 0,SYSDATETIME() 
UNION SELECT 'CustWinLossLimit_Member_History', 4, 1000, 0, 1000, 'ServiceTransform_CustWinLossLimit_Member_Select', 'ServiceTransform_CustWinLossLimit_Member_Insert', 0, 0,SYSDATETIME() 

