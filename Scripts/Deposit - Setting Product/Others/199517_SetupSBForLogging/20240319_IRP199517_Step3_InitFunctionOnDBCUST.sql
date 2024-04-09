/*<info serverAlias="DBCUST-bodb_CustomerLog"></info>*/
/*
	Created: 20240319@Johnson	
	Task: Init Function for SB on DBCUST [RedmineID:#199517]
	DB: DBCust/bodb_CustomerLog
*/

--config table ConfigurationReferenceDetail
INSERT INTO [sb].[ConfigurationReferenceDetail]([FunctionName],[ContractName],[MessageType],[MinConversation],[MaxConversation])
VALUES ('UserLog_Others','Contract_CustomerLog_UserLog_DepCustSetting','MessageType_CustomerLog_UserLog_DepCustSetting',5,20)
	


--open conversations on DBCUST
EXEC [Sb].[ConversationManagement_Upd] 
		@functionName = 'UserLog_Others'
	  , @contractName = 'Contract_CustomerLog_UserLog_DepCustSetting'		  
	  , @fromService = 'Service_UserLog_Others_DBCUST'
	  , @toService = 'Service_UserLog_Others_DBLOG'
	  , @newCnt = 10
	  
GO