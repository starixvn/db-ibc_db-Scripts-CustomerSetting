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
IF EXISTS (SELECT TOP 1 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportBettypeSettingMatrix_UAT')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 130
		AND [name] =  'SportBettypeSettingMatrix_UAT'
END
ELSE
BEGIN  
	SELECT 'SportBettypeSettingMatrix_UAT not exists !!!'
END
GO
