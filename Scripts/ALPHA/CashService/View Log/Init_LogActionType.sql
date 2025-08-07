/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250804@Helios
	Task: View Log - Initial New LogActionType - [Redmine: #233474]  
	DB: DBLOG-bodb_CustomerLog
*/
 
IF NOT EXISTS (SELECT TOP 1 1 FROM LogActionType lat WITH (NOLOCK) WHERE lat.ActionTypeID IN (100,101,102,103,104,105))
BEGIN
	INSERT INTO LogActionType 
		(
			ActionTypeID
		    , ActionTypeNameEN
		    , ActionTypeNameCH
		    , ActionTypeNameCS
		    , ActionTypeNameJP
		    , ActionTypeNameIT
		    , ActionTypeNameTH
		    , ActionTypeNameKO
		    , ActionTypeNameVI
		    , ActionTypeNameCN
		)
	VALUES
	(100, N'General Info', N'', N'', N'', N'', N'', N'', NULL, N''),
	(101, N'Bank Account', N'银行账户', N'银行账户', N'Bank Account', N'Bank Account', N'บัญชีธนาคาร', N'Bank Account', NULL, N'银行账户'),
	(102, N'Payment Gateway', N'支付网关', N'支付网关', N'Payment Gateway', N'Payment Gateway', N'ช่องทางการชำระเงิน', N'Payment Gateway', NULL, N'支付网关'),
	(103, N'Promotion', N'优惠', N'优惠', N'Promotion', N'Promotion', N'โปรโมชั่น', N'Promotion', NULL, N'优惠'),
	(104, N'Deposit', N'存款', N'存款', N'Deposit', N'Deposit', N'ฝากเงิน', N'Deposit', NULL, N'存款'),
	(105, N'Withdrawal', N'提款', N'提款', N'Withdrawal', N'Withdrawal', N'ถอนเงิน', N'Withdrawal', NULL, N'提款')
END

