/*
	Created: Johnson
	Date: 20181211
	Task: hide VIP Baccarat for Allbet and adjust global settings for Allbet
	DB: DBCUST/CUSTDB
*/

USE CustDB
GO
/*
UPDATE ProductSettingDetail WITH(UPDLOCK,ROWLOCK)
SET SettingStatus = 2--hide vip baccarat
WHERE SportType = 211 
	AND bettype = 2402
	AND SettingType IN (7,13)--stakelevel & status
GO*/

--remove stakelevel has resourceid = 244 for currencies: 
--'$US', 'NTD', 'US$', 'UT', 'Yen', 'IRR', 'EURO', 'SD$', 'GBP', 'TH'
DELETE StakeLevel
WHERE  GameTypeID = 2401 	
	AND ExchangeId IN (1,3,6,12,16,17,35,40,64,74) 
	AND ResourceId = 244
	AND MinStake = 250
	AND MaxStake = 10000
GO

--remove stakelevel has resourceid = 245 for currencies: 
--RM,HKK
DELETE StakeLevel
WHERE  GameTypeID = 2401 	
	AND ExchangeId IN (2,67)
	AND ResourceId = 245
	AND MinStake = 500
	AND MaxStake = 25000
GO

--Adjust stakelevel has resourceid = 245 for currencies:
--HK$,RMB
UPDATE st	
SET st.MaxStake = '20000',	
	st.MaxLabel = '20,000',
	resourceid = 184
FROM StakeLevel st WITH(UPDLOCK,ROWLOCK)
WHERE GameTypeID = 2401 	
	AND ExchangeId IN (5,13)
	AND ResourceId = 245
	AND MinStake = 500
	AND MaxStake = 25000	
GO						

	
	