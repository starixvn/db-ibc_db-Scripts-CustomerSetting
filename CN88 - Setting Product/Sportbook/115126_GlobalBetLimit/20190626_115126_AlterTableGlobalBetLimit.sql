/*
	Created by: Elodie
	Date: 20190627
	Task: Recreate table CS_ProductBetSetting
	DB: DBCUST/CustDB and all replicated servers of CustDB_custSetting pub
*/
USE CustDB
GO

DROP TABLE dbo.CS_ProductBetSetting
GO

CREATE TABLE CS_ProductBetSetting
(
	SportType		SMALLINT NOT NULL,
	BetType			SMALLINT NOT NULL,
	IsLive			BIT NOT NULL,
	Currency		INT,
	MinBet			MONEY,
	MaxBet			MONEY,
	MaxPerEvent		MONEY,
CONSTRAINT [PK_CS_ProductBetSetting] PRIMARY KEY CLUSTERED 
(
	SportType ASC,
	BetType ASC,
	IsLive ASC,
	Currency ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO