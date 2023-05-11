/*<info serverAlias="DBCUST-NAP_UserControl"></info>*/
/*
    Created by: Helios
    Date: 2024/04/26
    Task: SIT - FixIssue - Initial Miss data CustStakeLevel_Member [redmine : #186524]
    DB: DBCUST/CustDB
    
    Revisions:  
*/

INSERT INTO [dbo].[CustStakeLevel_Member]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList]
           ,[LastUpdated])

SELECT 24978030 , 156 , 8999 , 6059 , GETDATE()



