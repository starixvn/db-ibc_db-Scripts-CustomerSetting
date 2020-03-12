/*
	Created: 20200312@Tiara
	Date: 20200312
	Task: Update Max Discount ProductSettingDetail [Redmine: #128058]
	DB: DBCUST/CustDB
*/

UPDATE P
SET P.MaxDiscount = 0.01
FROM ProductSettingDetail P WITH (ROWLOCK, UPDLOCK)
WHERE P.ProductID = 41 AND P.SettingType = 3