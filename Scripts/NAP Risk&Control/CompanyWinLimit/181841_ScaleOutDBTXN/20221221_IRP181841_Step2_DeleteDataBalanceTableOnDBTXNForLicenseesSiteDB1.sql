/*<info serverAlias="DBCTG-bodb02"></info>*/
/*
	Created: 20221221@Johnson
	Task: delete data for balance game tables after migrate data for SITEDB11 [#RedmineID:#181841]
	DB: DBCTG/bodb02 
*/
IF NOT EXISTS (SELECT TOP (1) 1 FROM dbo.BalancePendingCreditGame WITH(NOLOCK))
	AND NOT EXISTS (SELECT TOP (1) 1 FROM dbo.BalancePendingDebitGame WITH(NOLOCK))
BEGIN
	DELETE dbo.Winlimit_CreditGame WITH(ROWLOCK)
	WHERE custid IN (SELECT custid 
					FROM custdb.dbo.custinfo ci WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM custdb.dbo.Dep_custsuper WITH(NOLOCK)
										WHERE site IN ('ZFRT152','ZFRT166SW','4300','aws03','MTechCV','Fabbet','GSCFTWCV','Betway')
						AND roleid = 1				
					)
				)		

	DELETE Winlimit_DebitGame WITH(ROWLOCK)
	WHERE custid IN (SELECT custid 
					FROM custdb.dbo.custinfo ci WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM custdb.dbo.Dep_custsuper WITH(NOLOCK)
										WHERE site IN ('ZFRT152','ZFRT166SW','4300','aws03','MTechCV','Fabbet','GSCFTWCV','Betway')
						AND roleid = 1				
					)		
				)			
END		   