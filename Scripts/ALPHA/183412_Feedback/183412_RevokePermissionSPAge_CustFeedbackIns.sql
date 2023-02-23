/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
 Created: 20230220@Helios
 Task : revoke permission bodbDownlineNetView SP Age_CustFeedbackIns
 DB: DBBOT.bodb_ChatBot  
  
     
 Revisions:    
  - 20230220@Helios: revoke permission bodbDownlineNetView SP Age_CustFeedbackIns 
 Parameter's Explanation:  
*/


REVOKE EXECUTE ON dbo.Age_CustFeedbackIns TO bodbDownlineNetView
GO