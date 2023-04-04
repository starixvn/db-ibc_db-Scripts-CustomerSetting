/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20232802@Tacy
	Task: Add new message [#171247]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO MsgError ([MsgID], [MsgGroupID], [MsgNameEN], [MsgNameCT], [MsgNameCS], [MsgNameJP], [MsgNameTH], [MsgNameKO], [MsgNameES], [MsgNameVI], [IsActive])
VALUES 
 (90018,10,'The API Key Name already exists','The API Key Name already exists','The API Key Name already exists','The API Key Name already exists','The API Key Name already exists','The API Key Name already exists','The API Key Name already exists','The API Key Name already exists',1)
,(90019,10,'The maximum number of API keys has been exceeded','The maximum number of API keys has been exceeded','The maximum number of API keys has been exceeded','The maximum number of API keys has been exceeded','The maximum number of API keys has been exceeded','The maximum number of API keys has been exceeded','The maximum number of API keys has been exceeded','The maximum number of API keys has been exceeded',1)