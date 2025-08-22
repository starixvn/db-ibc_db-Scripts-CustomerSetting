/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250822@Dave
	Task: Performance - SQL issue [Redmine: #236597]
	DB: DBCUST-AgencyCashService
*/

USE [AgencyCashService]
GO


IF DATABASE_PRINCIPAL_ID('wsv_alp') IS NULL
BEGIN
	CREATE USER wsv_alp FOR LOGIN wsv_alp;
	GRANT CONNECT TO wsv_alp;
	GRANT SELECT ON dbo.CashBankConfig TO wsv_alp;
	SELECT 'wsv_alp';
END

IF DATABASE_PRINCIPAL_ID('wsv_alpv') IS NULL
BEGIN
	CREATE USER wsv_alpv FOR LOGIN wsv_alpv;
	GRANT CONNECT TO wsv_alpv;
	GRANT SELECT ON dbo.CashBankConfig TO wsv_alpv;
	SELECT 'wsv_alpv';
END



IF DATABASE_PRINCIPAL_ID('wsv_nap') IS NULL
BEGIN
	CREATE USER wsv_nap FOR LOGIN wsv_nap;
	GRANT CONNECT TO wsv_nap;
	GRANT SELECT ON dbo.CashBankConfig TO wsv_nap;
	SELECT 'wsv_nap';
END

IF DATABASE_PRINCIPAL_ID('wsv_xnap') IS NULL
BEGIN
	CREATE USER wsv_xnap FOR LOGIN wsv_xnap;
	GRANT CONNECT TO wsv_xnap;
	GRANT SELECT ON dbo.CashBankConfig TO wsv_xnap;
	SELECT 'wsv_xnap';
END



