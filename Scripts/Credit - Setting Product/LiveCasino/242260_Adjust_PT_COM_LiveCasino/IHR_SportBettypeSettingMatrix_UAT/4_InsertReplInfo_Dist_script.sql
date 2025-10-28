/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
  Created: 20251027@Eden
  Task: In-House setup by GitHub Copilot
  DB: DBCustRepl-ReplCustDB
  
  Revisions:
    - 20251027@Eden: Initial [RedmineID: #242260]
    
*/
/**************************************************************************
						SportBettypeSettingMatrix_UAT
**************************************************************************/
IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportBettypeSettingMatrix_UAT')
BEGIN
    INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
    SELECT 130,'SportBettypeSettingMatrix_UAT',0,'repupdatetime',0,'BetType,SportType,isLicensee,isLive,Site','Repl_GetSportBettypeSettingMatrix_UAT','Repl_PutSportBettypeSettingMatrix_UAT',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'SportBettypeSettingMatrix_UAT exists !!!'
END
GO
