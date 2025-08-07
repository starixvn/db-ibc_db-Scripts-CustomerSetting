/*<info serverAlias="IRS_DBSIC-CustDB"></info>*/
/*
  Created: 20250807@Eden
  Task: In-House setup by GitHub Copilot
  DB: IRS_DBSIC-CustDB
  
  Revisions:
    - 20250609@Eden: Initial [RedmineID: #235012]
*/
/**************************************************************************
                        custSub
**************************************************************************/
IF EXISTS (SELECT TOP 1 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custSub')
BEGIN
    UPDATE RepInfo
    SET active = 1
    WHERE [name] =  'custSub'
END
ELSE
BEGIN  
    SELECT 'custSub not exists !!!'
END
GO