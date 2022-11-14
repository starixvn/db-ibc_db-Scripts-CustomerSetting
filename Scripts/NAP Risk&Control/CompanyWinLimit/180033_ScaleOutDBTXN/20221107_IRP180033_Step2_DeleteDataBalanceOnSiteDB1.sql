/*<info serverAlias="DBSIG-bodb02"></info>*/
/*
	Created: 20221107@Johnson
	Task: delete data for balance game tables after migrate data on SITEDB1 [#RedmineID:#180033]
	DB: DBSIG/bodb02 (SiteDB1)
*/

DELETE dbo.Winlimit_CreditGame WITH(ROWLOCK)
WHERE custid IN (SELECT custid 
				FROM custdb.dbo.custinfo ci WITH(NOLOCK)
				WHERE srecommend IN (SELECT custid FROM custdb.dbo.Dep_custsuper WITH(NOLOCK)
									WHERE site IN ('Betway'
												)	
								)						
					AND roleid = 1				
				)	

DELETE Winlimit_DebitGame WITH(ROWLOCK)
WHERE custid IN (SELECT custid 
				FROM custdb.dbo.custinfo ci WITH(NOLOCK)
				WHERE srecommend IN (SELECT custid FROM custdb.dbo.Dep_custsuper WITH(NOLOCK)
									WHERE site IN ('Betway'
												)	
									)			
					AND roleid = 1				
				)				
 