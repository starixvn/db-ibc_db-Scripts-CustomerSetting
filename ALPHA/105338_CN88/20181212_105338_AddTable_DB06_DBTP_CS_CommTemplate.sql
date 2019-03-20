/*
	Created: 20181212@Elodie
	Task: Prepare structure for new credit site
	DB: DBCUST/CustDB
*/

/*
	DROP TABLE dbo.CS_CommTemplate
*/
USE bodb02
GO

CREATE TABLE CS_CommTemplate
(
	ValueId		TINYINT NOT NULL,
	Value		DECIMAL(9,8) NOT NULL,
CONSTRAINT [PK_CS_CommTemplate] PRIMARY KEY CLUSTERED 
(
	ValueId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX IX_CS_CommTemplate_Value ON CS_CommTemplate(Value)
