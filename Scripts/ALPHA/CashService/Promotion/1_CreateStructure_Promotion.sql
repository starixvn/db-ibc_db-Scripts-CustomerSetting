/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20250707@Elodie
	Task: Alpha - Agency Cash Service - Caculate bonus - [232347]  
	DB: DBAGE-bodb02
*/
USE bodb02
GO

IF OBJECT_ID('CashPromotionCal', 'U') IS NOT NULL
BEGIN
    DROP TABLE CashPromotionCal
END

CREATE TABLE CashPromotionCal (
		TransDate DATE NOT NULL,
        CustId INT NOT NULL,
		AgentId	INT,
		SiteDBGroupID TINYINT,
        ProductCategoryId TINYINT NOT NULL,        
        Bonus MONEY,
		ExtraInfo NVARCHAR(1000),
		PromotionID INT NOT NULL,
		CONSTRAINT PK_CashPromotionCal PRIMARY KEY (TransDate, CustId, ProductCategoryId, PromotionID)
    ) ON [DATA]