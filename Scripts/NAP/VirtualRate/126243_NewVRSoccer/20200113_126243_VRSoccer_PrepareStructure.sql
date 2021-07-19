/*
    Created: Elodie
    Date: 2020-01-17
    Task : Add new table VRLeague
    DB: DB02/bodb02
*/
USE bodb02
GO

CREATE TABLE VRLeague
(
	LeagueId		INT NOT NULL,
	IsApplied		BIT NOT NULL
CONSTRAINT [PK_VRLeague] PRIMARY KEY CLUSTERED 
(
	LeagueId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Event_table]
) ON [Event_table]
GO