/*	
	Created: Elodie
	Date: 2019-05-09
	Task: Create CustomerClearCredit table
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DROP TABLE CustomerClearCredit

CREATE TABLE CustomerClearCredit (LogDate DATETIME NOT NULL, custid INT NOT NULL, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT, OldCredit MONEY, IsSend BIT CONSTRAINT DF_CustomerClearCredit_IsSend DEFAULT 0)

GO
ALTER TABLE dbo.CustomerClearCredit 
ADD CONSTRAINT PK_CustomerClearCredit PRIMARY KEY CLUSTERED (LogDate, custid)