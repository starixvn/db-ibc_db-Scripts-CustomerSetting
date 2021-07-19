/*
	Created: 20200526@Johnson
	Task : add MsgError & LogAction for indirect login account [redmine:#132782]
	
*/
--Step 1: add MsgError @DBCUST/CustDB

INSERT INTO [dbo].[MsgError]
           ([MsgID]
           ,[MsgGroupID]
           ,[MsgNameEN]
           ,[MsgNameCT]
           ,[MsgNameCS]
           ,[MsgNameJP]
           ,[MsgNameTH]
           ,[MsgNameKO]
           ,[MsgNameES]
           ,[MsgNameVI]
           ,[IsActive]
           ,[MsgNameCN])
SELECT 	40052,5,'Invalid account or it is not your downline.','Invalid account or it is not your downline.','Invalid account or it is not your downline.','Invalid account or it is not your downline.','Invalid account or it is not your downline.','Invalid account or it is not your downline.','Invalid account or it is not your downline.','Invalid account or it is not your downline.',1,'Invalid account or it is not your downline.'	   
UNION SELECT 40053,5,'You cannot indirectly log in to member account.','You cannot indirectly log in to member account.','You cannot indirectly log in to member account.','You cannot indirectly log in to member account.','You cannot indirectly log in to member account.','You cannot indirectly log in to member account.','You cannot indirectly log in to member account.','You cannot indirectly log in to member account.',1,'You cannot indirectly log in to member account.'
UNION SELECT 40054,5,'The account has already been connected.','The account has already been connected.','The account has already been connected.','The account has already been connected.','The account has already been connected.','The account has already been connected.','The account has already been connected.','The account has already been connected.',1,'The account has already been connected.'
UNION SELECT 60036,7,'This account is closed or disabled, please open it and try again.','This account is closed or disabled, please open it and try again.','This account is closed or disabled, please open it and try again.','This account is closed or disabled, please open it and try again.','This account is closed or disabled, please open it and try again.','This account is closed or disabled, please open it and try again.','This account is closed or disabled, please open it and try again.','This account is closed or disabled, please open it and try again.',1,'This account is closed or disabled, please open it and try again.'
UNION SELECT 80011,9,'Wrong password.','Wrong password.','Wrong password.','Wrong password.','Wrong password.','Wrong password.','Wrong password.','Wrong password.',1,'Wrong password.'

--Step 2: add logaction
--run at @DBLOG/bodb_CustomerLog
INSERT INTO [dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]           
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT 	s.[ActionID]
	   ,[ActionTypeID]
	   ,s.[SPName]
	   ,[ActionNameEN]
	   ,[ActionNameCH]
	   ,[ActionNameCS]
	   ,[ActionNameJP]
	   ,[ActionNameIT]
	   ,[ActionNameTH]
	   ,[ActionNameKO]           
	   ,[IsInternal]
	   ,[ActionNameVI]
	   ,[ActionNameCN]
FROM LogAction l WITH(NOLOCK)
	CROSS APPLY (SELECT 946 as ActionID,'Age_CustomerIndirectLoginAccountIns' as SPName
				UNION SELECT 947 as ActionID,'Age_CustomerIndirectLoginAccountPwdCheck' as SPName
				)s
where l.ActionID = 910

INSERT INTO [dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]           
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT 95019,4,'Age_CustomerIndirectLoginAccountIns','Connect Indirect Login Account','Connect Indirect Login Account','Connect Indirect Login Account','Connect Indirect Login Account','Connect Indirect Login Account','Connect Indirect Login Account','Connect Indirect Login Account',0,'Connect Indirect Login Account','Connect Indirect Login Account'
UNION SELECT 95020,4,'Age_CustomerIndirectLoginAccountDel','Disconnect Indirect Login Account','Disconnect Indirect Login Account','Disconnect Indirect Login Account','Disconnect Indirect Login Account','Disconnect Indirect Login Account','Disconnect Indirect Login Account','Disconnect Indirect Login Account',0,'Disconnect Indirect Login Account','Disconnect Indirect Login Account'
UNION SELECT 95021,4,'Age_CustomerIndirectLoginAccountPwdCheck','Verify password','Verify password','Verify password','Verify password','Verify password','Verify password','Verify password',0,'Verify password','Verify password'
UNION SELECT 95022,4,'Age_CustomerIndirectLoginAccountUpd','Verify password','Verify password','Verify password','Verify password','Verify password','Verify password','Verify password',0,'Verify password','Verify password'
UNION SELECT 1335,NULL,'Age_CustomerIndirectLoginAccountIns','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site',0,'Indirect Login via Agent''s Site','Indirect Login via Agent''s Site'
UNION SELECT 1336,NULL,'Age_CustomerIndirectLoginAccountPwdCheck','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site',0,'Indirect Login via Agent''s Site','Indirect Login via Agent''s Site'
UNION SELECT 1337,NULL,'Age_IndirectLoginClaimDownline','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site','Indirect Login via Agent''s Site',0,'Indirect Login via Agent''s Site','Indirect Login via Agent''s Site'



