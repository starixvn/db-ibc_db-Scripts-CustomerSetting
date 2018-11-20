/*
	CreatedDate: 20181120@Elodie
	Task: Add new column into eaGroup, add new table eaGroupConfiguration
	DB: DBEAS/bodb_EAS
*/


USE [bodb_EAS]
GO

ALTER TABLE eaGroup Add Currency VARCHAR(300) NULL
GO
ALTER TABLE eaGroup Add CurrencyCode VARCHAR(300) NULL
GO
ALTER TABLE eaGroup Add Site VARCHAR(300) NULL
GO

CREATE TABLE [dbo].[eaGroupConfiguration](
	ProductId TINYINT NOT NULL,
	GroupId INT NOT NULL,
	IsShow BIT CONSTRAINT [DF_eaGroupConfiguration_IsShow] DEFAULT ((0)) NOT NULL,
 CONSTRAINT [PK_eaGroupConfiguration] PRIMARY KEY CLUSTERED 
(
	ProductId ASC, 
	GroupId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [eaUserControl]
) ON [eaUserControl]
GO