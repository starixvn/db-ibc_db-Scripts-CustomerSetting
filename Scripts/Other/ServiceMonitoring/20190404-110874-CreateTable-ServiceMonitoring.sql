/*	Creator: 20190328@Robert
	Task:  Auto Email Services - Detect hang services
	DB: DBMA/bodb_Maintenance	
	Revisions: 
		 - 20190328@Robert: #110874 - Auto Email Services - Detect hang services
		
*/

IF OBJECT_ID(N'dbo.ServiceMonitoring', N'U') IS NOT NULL
    BEGIN
	   DROP TABLE dbo.ServiceMonitoring;
    END;

IF OBJECT_ID(N'dbo.ServiceMonitoringDetail', N'U') IS NOT NULL
    BEGIN
	   DROP TABLE dbo.ServiceMonitoringDetail;
    END;

CREATE TABLE dbo.ServiceMonitoring(
	ServiceId      INT IDENTITY(1, 1) NOT NULL
   , ServiceName    VARCHAR(50) NOT NULL
   , Interval       INT NOT NULL
   , IsActive       BIT NOT NULL
   , OrderBy        TINYINT NOT NULL
   , IPServer       VARCHAR(50) NULL
   , LastUpdate     DATETIME NULL
   , CONSTRAINT PK_ServiceMonitoring PRIMARY KEY CLUSTERED(ServiceId ASC)
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA])
ON [DATA];

GO

CREATE NONCLUSTERED INDEX IDX_ServiceMonitoring ON dbo.ServiceMonitoring(ServiceName ASC, IsActive ASC)
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];
GO

CREATE TABLE dbo.ServiceMonitoringDetail(
	ServiceId      INT NOT NULL
   , RestartTime    DATETIME NOT NULL);
GO

CREATE CLUSTERED INDEX IDX_ServiceID ON dbo.ServiceMonitoringDetail(ServiceId ASC)
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];
GO