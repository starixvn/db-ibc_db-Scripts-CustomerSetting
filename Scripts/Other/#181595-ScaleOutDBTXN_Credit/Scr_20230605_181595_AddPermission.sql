/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20230522@Eden
	Task: add permission [#RedmineID:#181595]
	DB: DBTXN/bodb02 
*/

USE bodb02
GO

GRANT EXECUTE ON [dbo].[Acc_CustomerTotalAmountSel] TO [bodbDownlineNet]
GO
GRANT EXECUTE ON [dbo].[Acc_CustomerTotalAmountSel] TO [bodbDownlineNetView]
GO