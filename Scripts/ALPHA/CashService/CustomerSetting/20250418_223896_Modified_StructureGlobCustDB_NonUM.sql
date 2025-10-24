/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250415@Elodie
	Task: Alpha - Agency Cash Service - modified Structure [#223896] 
	DB: DBCust/GlobCustDB 
*/
USE GlobCustDB
GO

DECLARE @__messageInfo VARCHAR(200)
__tryAgain:
IF (dbo.f_dba_check_long_holding_locks ('DomainManagement' /*tableName*/, getdate() /*current time*/, 1000 /*long query exceeded 1s*/, 1 /*retry in 1 min*/)) = 1
BEGIN
	SELECT @__messageInfo = 'curdt: ' + convert(varchar(50), getdate(), 121) + ' | Too many long running operations on the table. Retry attempt again ...'
	RAISERROR(@__messageInfo, 0, 1) WITH NOWAIT
	WAITFOR DELAY '00:00:00:333' --wait for alter schema
	GOTO __tryAgain
END

SET LOCK_TIMEOUT 1024
SET DEADLOCK_PRIORITY LOW

IF OBJECT_ID ('DomainManagement') IS NOT NULL
BEGIN
	ALTER TABLE [dbo].[DomainManagement]
	ADD [OfferType] [tinyint] NOT NULL CONSTRAINT [DF_DomainManagement_OfferType] DEFAULT (0);
END
GO


