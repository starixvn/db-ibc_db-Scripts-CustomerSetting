/*<info serverAlias="DBBOT-bodb_chatbot"></info>*/
/*
	Created: 20231002@Johnson
	Task: Add Bot System for 777
	DB: DBBOT/bodb_chatbot
*/

INSERT INTO [dbo].[Bot]
           ([username]
           ,[System]
           ,[Accesstoken]
           ,[Status]
           ,[IsTest]
           ,[DisplayName])
SELECT 'AlphaUAT4Bot', '777', '6410012004:AAFfayDPBPaW09xvs0O-cfNyL6CDo7rlJKg', 1, 1, '777'
UNION SELECT 'Tara88AgBot', '777', '6509323177:AAG4ItPnYkiyAWqQNo8pOlCRilKWzCeXUKE', 1, 0, '777'

