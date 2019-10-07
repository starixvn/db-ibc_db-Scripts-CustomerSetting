/*	
	Created: 20191007@Eden
	Task: Rename all unused SP in DB052/DB053
	Redmine: https://redmine.nexcel.vn/issues/118413
	DB: DB052/DB053
*/

USE bodb02
GO 


EXEC sp_rename 'NAP_SMATurnover_CountrySel','DEL_NAP_SMATurnover_CountrySel'
GO
EXEC sp_rename 'NAP_SMATurnover_LeagueSel','DEL_NAP_SMATurnover_LeagueSel'
GO
EXEC sp_rename 'NAP_SMATurnover_MatchSel','DEL_NAP_SMATurnover_MatchSel'
GO
EXEC sp_rename 'NAP_SMATurnover_SpecialLeagueSel','DEL_NAP_SMATurnover_SpecialLeagueSel'
GO
EXEC sp_rename 'NAP_SMATurnover_SportSel','DEL_NAP_SMATurnover_SportSel'
GO

-----------------------
USE bodb_CustomerLog
GO 

EXEC sp_rename 'NAP_WinLimit_GameHistorySel','DEL_NAP_WinLimit_GameHistorySel'
GO