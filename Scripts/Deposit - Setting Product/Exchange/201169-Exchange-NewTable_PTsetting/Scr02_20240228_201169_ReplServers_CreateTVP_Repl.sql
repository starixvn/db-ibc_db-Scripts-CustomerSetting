/*<info serverAlias="DBTP-bodb02, DBAGE-bodb02, DBTXN-CustDB"></info>*/
/*
	Created by: Tacy@20240228
	Task: in-house -[Dep_ChargeInfoSetting] [Redmine:#200454] 
	DB:	DBTP-bodb02, DBAGE-bodb02, DBTXN-CustDB
*/
--CHECK IF: ADD NEW COLUMN INTO EXISTED TABLE
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutDep_ChargeInfoSetting')
AND EXISTS (SELECT 1 FROM RepInfo WITH (NOLOCK)
			WHERE [name]='Dep_ChargeInfoSetting' AND active=0)
BEGIN
	DROP PROCEDURE Repl_PutDep_ChargeInfoSetting;

	IF EXISTS(SELECT 1 FROM sys.types 
			  WHERE name = 'TVP_ReplDep_ChargeInfoSetting' 
			  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
	BEGIN
		DROP TYPE [dbo].[TVP_ReplDep_ChargeInfoSetting];
	END
END

CREATE TYPE [dbo].[TVP_ReplDep_ChargeInfoSetting] AS TABLE (
	[ChargeId] [int] NOT NULL,
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[PT] [smallmoney] NOT NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplDep_ChargeInfoSetting] TO [repl_ap] AS [dbo]
GO

--Grant permission to set IDENTITY_INSERT on/off
GRANT ALTER ON [dbo].[Dep_ChargeInfoSetting] TO [repl_ap];
GO
