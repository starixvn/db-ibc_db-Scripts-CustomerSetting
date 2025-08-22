/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created by: 20250813@Dave
	Task: Alpha - Implement compact feedback [RedmineID: #234817]
	DB: DBBOT.bodb_ChatBot
*/
USE bodb_ChatBot
GO

DELETE FROM dbo.Age_FeedbackFunc WHERE FuncID IN (33,34,35,36,37,38,39,40);

SET IDENTITY_INSERT dbo.Age_FeedbackFunc ON;

INSERT INTO dbo.Age_FeedbackFunc (FuncID,Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
VALUES
(33,2,'Manage Payments',N'Manage Payments',N'管理支付',N'管理支付',N'จัดการการชำระเงิน',N'支払い管理',N'결제 관리'),
(34,2,'Pending Deposit',N'Pending Deposit',N'待处理存款',N'待處理存款',N'ฝากเงินรอดำเนินการ',N'入金保留中',N'입금 대기'),
(35,2,'Pending Withdrawal',N'Pending Withdrawal',N'待处理提款',N'待處理提款',N'ถอนเงินรอดำเนินการ',N'出金保留中',N'출금 대기'),
(36,2,'Transaction History',N'Transaction History',N'交易历史',N'交易歷史',N'ประวัติการทำธุรกรรม',N'取引履歴',N'거래 내역'),
(37,2,'Member Site Management',N'Member Site Management',N'会员网站管理',N'會員網站管理',N'การจัดการเว็บไซต์สมาชิก',N'メンバーサイト管理',N'회원 사이트 관리'),
(38,2,'Manage Promotion',N'Manage Promotion',N'',N'',N'',N'',N'프로모션 관리'),
(39,2,'Pending Promotion',N'Pending Promotion',N'',N'',N'',N'',N'대기 중인 프로모션'),
(40,2,'Promotion Report',N'Promotion Report',N'',N'',N'',N'',N'프로모션 보고서');

SET IDENTITY_INSERT dbo.Age_FeedbackFunc OFF;

DBCC CHECKIDENT ('Age_FeedbackFunc', RESEED, 40);

select * from Age_FeedbackFunc;
