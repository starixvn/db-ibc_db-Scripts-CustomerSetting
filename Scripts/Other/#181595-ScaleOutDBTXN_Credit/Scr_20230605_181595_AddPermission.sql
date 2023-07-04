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

GRANT EXECUTE ON [dbo].Dot_BalanceCreditRemove TO bodbDownlineNet
GO
GRANT EXECUTE ON [dbo].Dot_BalanceCreditRemove TO bodbAdminNet
GO
GRANT EXECUTE ON [dbo].Dot_BalanceCreditRemove TO bodbExtAccNet
GO

GRANT EXECUTE ON [dbo].Dot_BalanceDebitRemove TO bodbDownlineNet
GO
GRANT EXECUTE ON [dbo].Dot_BalanceDebitRemove TO bodbAdminNet
GO
GRANT EXECUTE ON [dbo].Dot_BalanceDebitRemove TO bodbExtAccNet
GO
