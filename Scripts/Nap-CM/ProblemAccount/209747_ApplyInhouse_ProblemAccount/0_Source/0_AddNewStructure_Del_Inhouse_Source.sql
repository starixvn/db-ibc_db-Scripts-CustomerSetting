/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Helios
	Date: 9/9/2024 2:24:04 
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Create new structure Del_InHouse in Source [Redmine: #209747]
	DB: DBCUST-CustDB
*/

USE CustDB

CREATE TABLE [dbo].[ProblemAccount_Del_InHouse]
(
	[CustID]		INT NOT NULL,
	[RepUpdateTime]	[datetime2](7) NOT NULL
) ON [DATA]
GO


CREATE TABLE [dbo].[ProblemAccountAction_Del_InHouse]
(
	[ActionID]		 TINYINT NOT NULL,
	[RepUpdateTime]	[datetime2](7) NOT NULL
) ON [DATA]
GO

CREATE TABLE [dbo].[ProblemAccountClassification_Del_InHouse]
(
	[CustID]		INT NOT NULL,
	[RepUpdateTime]	[datetime2](7) NOT NULL
) ON [DATA]
GO

CREATE TABLE [dbo].[ProblemAccountLimitDownline_Del_InHouse]
(
	[CustID]		INT NOT NULL,
	[RepUpdateTime]	[datetime2](7) NOT NULL
) ON [DATA]
GO

CREATE TABLE [dbo].[ProblemAccountReason_Del_InHouse]
(
	[ReasonID]		TINYINT NOT NULL,
	[RepUpdateTime]	[datetime2](7) NOT NULL
) ON [DATA]
GO