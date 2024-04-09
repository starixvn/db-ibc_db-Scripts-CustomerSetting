/*<info serverAlias="DBHIS-bodb_CustHistory"></info>*/
/*	
	Created: 20221207@Tacy
	Task: ROLLBACK - Rename unused columns on Custinfo_History
	Redmine: https://redmine.nexcel.vn/issues/179132
	DB: DBHIS-bodb_CustHistory
*/
USE bodb_CustHistory
GO 

EXEC sp_rename 'Custinfo_History.DEL_DisableColossusBet','DisableColossusBet', 'COLUMN'
EXEC sp_rename 'Custinfo_History.DEL_HideColossusBet','HideColossusBet', 'COLUMN'