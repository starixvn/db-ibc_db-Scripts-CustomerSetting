/*<info serverAlias="DBCUST-CustDB"></info>*/
/*	
	Created: 20221207@Tacy
	Task: ROLLBACK - Rename unused columns on Custinfo
	Redmine: https://redmine.nexcel.vn/issues/179132
	DB: DBCUST-CustDB
*/
USE CustDB
GO 

EXEC sp_rename 'Custinfo.DEL_DisableColossusBet','DisableColossusBet', 'COLUMN'
EXEC sp_rename 'Custinfo.DEL_HideColossusBet','HideColossusBet', 'COLUMN'