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
IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custSub')
BEGIN
    INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
    SELECT 13,'custSub',0,'repupdatetime',0,'subaccid','Repl_GetcustSub_Dist','Repl_PutcustSub',1000,10,60000,0
END
ELSE
BEGIN  
    SELECT 'custSub exists !!!'
END
GO
-- SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] IN( 'custSub','Custinfo')

-- SELECT TOP 10 * FROM custSub (NOLOCK)