/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBMSG.bodb_message
*/

USE bodb_message
GO
INSERT INTO CustArchiveMessage (StageID, GroupLevelName, Content_en
		--, Content_vn, Content_ch, Content_cs, Content_th
		)
VALUES 
-----------------------Stage 1 --------------------------
--- S1, S2, S3
(1, 'S1'
		,N'Dear valued agents,

Please be informed that some of your agents have just been closed from system due to inactivity in the last 3 months. You can take back their master''s given credit before the accounts become disabled.
In 1 month after being closed, Those accounts'' given credit will be cleared. Your credit will be decreased by the sum amount of those accounts''s.

Thank you.')
,(1, 'S2'
		,N'Dear valued agents,

Please be informed that some of your agents have just been closed from system due to inactivity in the last 3 months. You can take back their master''s given credit before the accounts become disabled.
In 1 month after being closed, Those accounts'' given credit will be cleared. Your credit will be decreased by the sum amount of those accounts''s.

Thank you.')
,(1, 'S3'
		,N'Dear valued agents,

Please be informed that some of your agents have just been closed from system due to inactivity in the last 3 months. You can take back their master''s given credit before the accounts become disabled.
In 1 month after being closed, Those accounts'' given credit will be cleared. Your credit will be decreased by the sum amount of those accounts''s.

Thank you.')
--- M1, M2
,(1, 'M1'
		,N'Dear valued agents,

Please be informed that some of your agents have just been closed from system due to inactivity in the last 3 months. You can re-open them if you wish to keep their businesses or taking back their given credit before the accounts become disabled.

In 1 month after being closed,

 - Those accounts'' given credit will be cleared. Your credit will be decreased by the sum amount of those accounts''s.
 - Accounts will be disabled. You cannot recover a disabled account

Thank you.')

,(1, 'M2'
		,N'Dear valued agents,

Please be informed that some of your agents have just been closed from system due to inactivity in the last 3 months. You can re-open them if you wish to keep their businesses or taking back their given credit before the accounts become disabled.

In 1 month after being closed,

 - Those accounts'' given credit will be cleared. Your credit will be decreased by the sum amount of those accounts''s.
 - Accounts will be disabled. You cannot recover a disabled account

Thank you.')
-----------------------Stage 2 --------------------------
-- S1,S2,S3
,(2, 'S1'
		,N'Dear valued agents,
Please be informed that some of your agents were disabled because their members have had no activity in the last 4 months. Their credit has been cleared and your given credit has been decreased by the total cleared amounts. You cannot recover a disabled account.
Thank you.')
,(2, 'S2'
		,N'Dear valued agents,
Please be informed that some of your agents were disabled because their members have had no activity in the last 4 months. Their credit has been cleared and your given credit has been decreased by the total cleared amounts. You cannot recover a disabled account.
Thank you.')
,(2, 'S3'
		,N'Dear valued agents,
Please be informed that some of your agents were disabled because their members have had no activity in the last 4 months. Their credit has been cleared and your given credit has been decreased by the total cleared amounts. You cannot recover a disabled account.
Thank you.')

-- M1, M2
,(2, 'M1'
		,N'Dear valued agents,
Please be informed that some of your agents were disabled because their members have had no activity in the last 4 months. Their credit has been cleared and your given credit has been decreased by the total cleared amounts. You cannot recover a disabled account.
Thank you.')
,(2, 'M2'
		,N'Dear valued agents,
Please be informed that some of your agents were disabled because their members have had no activity in the last 4 months. Their credit has been cleared and your given credit has been decreased by the total cleared amounts. You cannot recover a disabled account.
Thank you.')

-----------------------Stage 1 --------------------------
-- M1, M2
,(3, 'M1'
		,N'Dear valued agents,
Please be informed that some of your disabled agents have had no activity in the last 7 months, Their balances have been transferred to yours. You cannot recover a disabled account.
Thank you.')
,(3, 'M3'
		,N'Dear valued agents,
Please be informed that some of your disabled agents have had no activity in the last 7 months, Their balances have been transferred to yours. You cannot recover a disabled account.
Thank you.')