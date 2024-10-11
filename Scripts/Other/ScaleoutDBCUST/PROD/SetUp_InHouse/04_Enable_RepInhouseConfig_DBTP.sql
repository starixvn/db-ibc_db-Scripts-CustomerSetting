/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20241010@Helios
	Task: Scale out DBCUST - Enable RepInHouse [RedmineID: #206823]
	DB: IRS_DBTP-bodb02
*/

USE bodb02
GO

/***************************************************************************/
IF EXISTS (SELECT 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustInfoMini')
BEGIN
	UPDATE r 
		SET ACTIVE = 1
	FROM RepInfo r WITH (ROWLOCK , UPDLOCK)
	WHERE  [name] = 'CustInfoMini'
END
ELSE
BEGIN  
	SELECT 'CustInfoMini not exists !!!'
END
/***************************************************************************/
IF EXISTS (SELECT 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSubMini')
BEGIN
	UPDATE r 
		SET ACTIVE = 1
	FROM RepInfo r WITH (ROWLOCK , UPDLOCK)
	WHERE  [name] = 'CustSubMini'
END
ELSE
BEGIN  
	SELECT 'CustSubMini not exists !!!'
END
GO