/*<info serverAlias="DBHIS-bodb_CustHistory"></info>*/
/*	
	Created: 20221207@Tacy
	Task: Rename unused columns on Custinfo_History
	Redmine: https://redmine.nexcel.vn/issues/179132
	DB: DBHIS-bodb_CustHistory
*/
USE bodb_CustHistory
GO 

EXEC sp_rename 'Custinfo_History.DisableColossusBet','DEL_DisableColossusBet', 'COLUMN'
EXEC sp_rename 'Custinfo_History.HideColossusBet','DEL_HideColossusBet', 'COLUMN'