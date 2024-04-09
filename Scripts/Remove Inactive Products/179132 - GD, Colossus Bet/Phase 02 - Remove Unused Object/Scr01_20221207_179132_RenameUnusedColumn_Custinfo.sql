/*<info serverAlias="DBCUST-CustDB"></info>*/
/*	
	Created: 20221207@Tacy
	Task: Rename unused columns on Custinfo
	Redmine: https://redmine.nexcel.vn/issues/179132
	DB: DBCUST-CustDB
*/
USE CustDB
GO 

EXEC sp_rename 'Custinfo.DisableColossusBet','DEL_DisableColossusBet', 'COLUMN'
EXEC sp_rename 'Custinfo.HideColossusBet','DEL_HideColossusBet', 'COLUMN'