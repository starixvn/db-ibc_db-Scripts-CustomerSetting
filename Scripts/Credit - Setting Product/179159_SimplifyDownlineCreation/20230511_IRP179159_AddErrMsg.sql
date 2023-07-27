/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230511@Johnson
	Task: Add Error Message
	DB: DBCUST/CustDB
*/

;WITH T AS (
SELECT 20045 MsgID,3 MsgGroupID, 'This Template Name already exists.' MsgNameEN
UNION SELECT 20046 , 3, 'Invalid Position Taking(max set by upline).'
UNION SELECT 20047 , 3, 'This Template is not exists.'
UNION SELECT 20048 , 3, 'Invalid Position Taking(min/max set by upline).'
UNION SELECT 10069 , 5, 'Max Per Number must be equal to or less than Upline''s Max Per Number'
UNION SELECT 10070 , 5, 'The Parlay Max Payout value must be a positive amount.'
UNION SELECT 10071 , 5, 'Parlay Max Payout: The setting of Single Match Parlay is higher than the upline''s.'
UNION SELECT 10072 , 5, 'Parlay Max Payout: The setting of Combo 2 is higher than the upline''s.'
UNION SELECT 10073 , 5, 'Parlay Max Payout: The setting of Combo 3 - 5 is higher than the upline''s.'
UNION SELECT 10074 , 5, 'Parlay Max Payout: The setting of ComboOver6 is higher than the upline''s.'

)
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
SELECT[MsgID],[MsgGroupID],[MsgNameEN],MsgNameEN,MsgNameEN,MsgNameEN,MsgNameEN,MsgNameEN,MsgNameEN,MsgNameEN,1 as IsActive,MsgNameEN
FROM T
