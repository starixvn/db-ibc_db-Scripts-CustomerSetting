/*
	Created: 20191002@Winnie
	Task: 1 deposit Master accounts missing setting data due wrong set up #120639 [redmine:#121303]
	DB: DBCHECK/CheckResultDB
*/

  INSERT INTO [IgnoredCust](
							[CustID]
						  ,[RoleID]
						  ,[RuleID]
						  ,[Sporttype]
						  ,[Bettype]
						  ,[AllLine]
						  ,[ModifiedDate]
						  ,[Remark]
						  )
	SELECT 38730269,3,0,0,0,1,GETDATE(),'Master accounts missing setting data due wrong set up #120639'