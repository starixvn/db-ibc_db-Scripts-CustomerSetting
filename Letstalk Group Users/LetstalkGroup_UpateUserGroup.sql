
/*<info serverAlias="DBMMS-bodb_MMS" executers="bodbAdminNet" viewers="" isFunction="0" isNested="0"></info>*/

ALTER PROCEDURE [dbo].LetstalkGroup_UpateUserGroup 
                @xml XML
AS

/*	Creator: 20201029@Robert
	Task:  #144052 - mSite - Manage Letstalk Group Users in Reports
	DB: DBMMS/bodb_MMS
	Revisions: 
		 - 20201029@Robert: #144052 - mSite - Manage Letstalk Group Users in Reports
	Param's Explanation:
		• @xml = 		
			'<Root>
				<Group GroupName = "Group1" RoomToken = "RoomToken1">
					<User LetstalkAccount="User1"/>
					<User LetstalkAccount="User2"/>
					<User LetstalkAccount="User3"/>				
				</Group>
				<Group GroupName = "Group2" RoomToken = "RoomToken2">		
					<User LetstalkAccount="User8"/>				
				</Group>
				<Group GroupName = "Group3" RoomToken = "RoomToken3">
					<User LetstalkAccount="User9"/>				
					<User LetstalkAccount="User10"/>				
					<User LetstalkAccount="User11"/>				
				</Group>
				<Group GroupName = "Group4" RoomToken = "RoomToken4"/>
				<Group GroupName = "Group5" RoomToken = "RoomToken5"/>
			</Root>'
				
*/

    BEGIN
        SET NOCOUNT ON;

        CREATE TABLE #TempUser
        (
                     LetstalkAccount VARCHAR(50)
        );

        CREATE TABLE #TempGroup
        (
                     GroupName NVARCHAR(100), 
                     RoomToken VARCHAR(200)
        );

        CREATE TABLE #TempGroupUser
        (
                     GroupName       NVARCHAR(100), 
                     RoomToken       VARCHAR(200), 
                     LetstalkAccount VARCHAR(50)
        );

        CREATE TABLE #TempLetstalkGroupUser
        (
                     GroupId    INT, 
                     LetstalkId INT
        );

        INSERT INTO #TempGroupUser
        (
               GroupName, 
               RoomToken, 
               LetstalkAccount
        )
               SELECT 
                      g.Col.value('@GroupName', 'NVARCHAR(100)') AS GroupName, 
                      g.Col.value('@RoomToken', 'VARCHAR(500)') AS RoomToken, 
                      u.Col.value('@LetstalkAccount', 'VARCHAR(50)') AS LetstalkAccount
               FROM @xml.nodes('/Root/Group') AS g(Col)
                    CROSS APPLY g.Col.nodes('User') AS u(Col);

        IF @@ROWCOUNT = 0
            RETURN;

        /*1. LetstalkUser*/

        INSERT INTO #TempUser
        (
               LetstalkAccount
        )
               SELECT DISTINCT 
                      LetstalkAccount
               FROM #TempGroupUser;

        DELETE t
        FROM #TempUser t
             INNER JOIN dbo.LetstalkUser u ON t.LetstalkAccount = u.LetstalkAccount;

        INSERT INTO dbo.LetstalkUser
        (
               LetstalkAccount
        )
               SELECT 
                      LetstalkAccount
               FROM #TempUser;

        /*2. LetstalkGroup*/

        INSERT INTO #TempGroup
        (
               GroupName, 
               RoomToken
        )
               SELECT DISTINCT 
                      GroupName, 
                      RoomToken
               FROM #TempGroupUser;

        UPDATE g
          SET 
              g.GroupName = t.GroupName
        FROM dbo.LetstalkGroup g
             INNER JOIN #TempGroup t ON g.RoomToken = t.RoomToken;

        DELETE t
        FROM #TempGroup t
             INNER JOIN dbo.LetstalkGroup g ON t.RoomToken = g.RoomToken;

        INSERT INTO dbo.LetstalkGroup
        (
               GroupName, 
               RoomToken
        )
               SELECT 
                      GroupName, 
                      RoomToken
               FROM #TempGroup;

        /*3. LetstalkGroupUser*/

        INSERT INTO #TempLetstalkGroupUser
        (
               GroupId, 
               LetstalkId
        )
               SELECT 
                      g.GroupId, 
                      u.LetstalkId
               FROM #TempGroupUser gu
                    INNER JOIN dbo.LetstalkGroup g ON gu.RoomToken = g.RoomToken
                    INNER JOIN dbo.LetstalkUser u ON gu.LetstalkAccount = u.LetstalkAccount;

        DELETE gu
        FROM dbo.LetstalkGroupUser gu
             LEFT JOIN #TempLetstalkGroupUser t ON gu.GroupId = t.GroupId
                                                   AND gu.LetstalkId = t.LetstalkId
        WHERE 
              t.LetstalkId IS NULL;


        DELETE t
        FROM #TempLetstalkGroupUser t
             INNER JOIN dbo.LetstalkGroupUser gu ON t.GroupId = gu.GroupId
                                                    AND t.LetstalkId = gu.LetstalkId;

        INSERT INTO dbo.LetstalkGroupUser
        (
               GroupId, 
               LetstalkId
        )
               SELECT 
                      GroupId, 
                      LetstalkId
               FROM #TempLetstalkGroupUser;


        DROP TABLE #TempUser;
        DROP TABLE #TempGroup;
        DROP TABLE #TempGroupUser;
        DROP TABLE #TempLetstalkGroupUser;

    END;