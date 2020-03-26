/*
	Created: 20200326@Elodie 
	Task: Initial data for Table Games
			Get MaxCustID AND Release Date.
	DB: DB06/bodb02
*/

USE bodb02 
GO

SELECT MAX(custid) as MaxCustID FROM custInfo WITH(NOLOCK)

SELECT GETDATE()
GO
