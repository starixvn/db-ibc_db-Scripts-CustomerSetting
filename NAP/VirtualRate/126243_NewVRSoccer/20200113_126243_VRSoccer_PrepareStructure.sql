/*
    Created: Elodie
    Date: 2020-01-17
    Task : Add new table VRLeague
    DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE VRLeague
(
	LeagueId		INT NOT NULL,
	IsApplied		BIT NOT NULL
CONSTRAINT [PK_VRLeague] PRIMARY KEY CLUSTERED 
(
	LeagueId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [virtualrate_table]
) ON [virtualrate_table]
GO