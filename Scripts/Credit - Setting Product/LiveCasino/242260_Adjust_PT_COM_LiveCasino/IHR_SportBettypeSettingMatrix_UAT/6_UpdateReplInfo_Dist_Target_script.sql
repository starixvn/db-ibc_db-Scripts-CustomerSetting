/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB"></info>*/
/*
  Created: 20251027@Eden
  Task: In-House setup by GitHub Copilot
  DB: DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
  
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
	WHERE [name] =  'SportBettypeSettingMatrix_UAT'
END
ELSE
BEGIN  
	SELECT 'SportBettypeSettingMatrix_UAT not exists !!!'
END
GO
