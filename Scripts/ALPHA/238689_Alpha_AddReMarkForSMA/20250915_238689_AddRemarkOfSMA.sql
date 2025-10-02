/*<info serverAlias="DBCUST-CustDB, DBAGE-bodb02"></info>*/
/*
	Created: Dave
	Date: 20250915
	Task: Alpha_Add remark field when editing info of master/Agent/member [Redmine: 238689]
	DB: DBCUST/CustDB,DBAGE-bodb02
*/
--DROP TABLE IF EXISTS dbo.CustomerRemark;
IF OBJECT_ID('dbo.CustomerRemark', 'U') IS NOT NULL
BEGIN
    SELECT 'Table dbo.CustomerRemark already exists. Skipping creation.';
    RETURN;
END
ELSE
BEGIN

    CREATE TABLE [dbo].CustomerRemark
    (
        CustID          INT             NOT NULL,
        SuperRemark     NVARCHAR(200)  NULL,
        MasterRemark    NVARCHAR(200)  NULL,
        AgentRemark     NVARCHAR(200)  NULL,
        RepUpdateTime   DATETIME2(7),
        CONSTRAINT PK_CustomerRemark PRIMARY KEY CLUSTERED (CustID ASC) 
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
    ) ON [table_customer]
    ;
    ALTER TABLE [dbo].CustomerRemark ADD CONSTRAINT DF_CustomerRemark_RepUpdateTime DEFAULT (sysdatetime()) FOR RepUpdateTime;

    CREATE NONCLUSTERED INDEX IX_CustomerRemark_RepUpdateTime ON [dbo].CustomerRemark (RepUpdateTime ASC) ON [DATA];

END
GO

