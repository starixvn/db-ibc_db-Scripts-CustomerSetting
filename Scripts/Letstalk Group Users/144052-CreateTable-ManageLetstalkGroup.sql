
/*<info serverAlias="DBMMS-bodb_MMS"></info>*/

/*Creator: 20201026@Robert
	Task:  mSite - Manage Letstalk Group Users in Reports
	DB: DBMMS/bodb_MMS	
	Revisions: 
		 - 20201026@Robert: #144052 - mSite - Manage Letstalk Group Users in Reports
		
*/

IF OBJECT_ID(N'dbo.LetstalkUser', N'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.LetstalkUser;
    END;
CREATE TABLE dbo.LetstalkUser
(
             LetstalkId      INT IDENTITY(1, 1) NOT NULL, 
             LetstalkAccount VARCHAR(50) NOT NULL, 
             CONSTRAINT PK_LetstalkUser PRIMARY KEY CLUSTERED(LetstalkId ASC)
);


GO
CREATE NONCLUSTERED INDEX IDX_LetstalkUser ON dbo.LetstalkUser(LetstalkAccount ASC); 

GO
IF OBJECT_ID(N'dbo.LetstalkGroup', N'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.LetstalkGroup;
    END;

CREATE TABLE dbo.LetstalkGroup
(
             GroupId   INT IDENTITY(1, 1) NOT NULL, 
             GroupName NVARCHAR(100) NOT NULL, 
             RoomToken VARCHAR(100) NOT NULL, 
             CONSTRAINT PK_LetstalkGroup PRIMARY KEY CLUSTERED(GroupId ASC)
);


GO
CREATE NONCLUSTERED INDEX IDX_LetstalkGroup ON dbo.LetstalkGroup(GroupName ASC); 
       
GO
IF OBJECT_ID(N'dbo.LetstalkGroupUser', N'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.LetstalkGroupUser;
    END;
CREATE TABLE dbo.LetstalkGroupUser
(
             Id         INT IDENTITY(1, 1) NOT NULL, 
             GroupId    INT NOT NULL, 
             LetstalkId INT NOT NULL, 
             CONSTRAINT PK_LetstalkGroupUser PRIMARY KEY CLUSTERED(Id ASC)
);


GO
CREATE NONCLUSTERED INDEX IDX_LetstalkGroupUser ON dbo.LetstalkGroupUser(GroupId ASC, LetstalkId ASC); 
CREATE NONCLUSTERED INDEX IDX_LetstalkGroupUser_GroupId ON dbo.LetstalkGroupUser(GroupId ASC); 
CREATE NONCLUSTERED INDEX IDX_LetstalkGroupUser_LetstalkId ON dbo.LetstalkGroupUser(LetstalkId ASC); 
       
