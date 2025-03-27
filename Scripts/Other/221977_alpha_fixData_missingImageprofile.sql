/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: 20250327@Helios
	Task: Alpha - Fix missing profile pictures  [Redmine:#221977]  
	DB:	DBCust-CustDB
*/


CREATE TABLE #Temp_Cust (
    CustID INT,
    SiteLabel NVARCHAR(50)
);

INSERT INTO #Temp_Cust (CustID, SiteLabel)
SELECT cpp.CustId, s.SiteLabel
FROM CustProfilePicture cpp WITH (NOLOCK)
INNER JOIN Customer c WITH (NOLOCK) ON cpp.CustId = c.CustId
INNER JOIN Site s WITH (NOLOCK) ON c.Site = s.Site
WHERE NOT EXISTS (
    SELECT 1 
    FROM ProfilePicture pp WITH (NOLOCK) 
    WHERE pp.ImageId = cpp.ImageId
)
UNION ALL

SELECT 999797 , 'MBC'
;

-- Check data
--SELECT * FROM #Temp_Cust


DECLARE @ImageID_789y INT , @ImageID_MBC INT

SELECT @ImageID_789y = (SELECT TOP 1 ImageID FROM ProfilePicture pp WITH (NOLOCK) WHERE pp.ImageId > 10000 AND pp.IsDeleted = 0)

SELECT @ImageID_MBC  = (SELECT TOP 1 ImageID FROM ProfilePicture pp WITH (NOLOCK) WHERE pp.ImageId < 200 AND pp.IsDeleted = 0)


-- Update data
UPDATE cpp
SET ImageID = CASE 
                 WHEN t.SiteLabel = '789y' THEN @ImageID_789y		-- Random Image From library for Site 789y, ImageID > 10000
                 ELSE @ImageID_MBC							-- Random Image From library for Site MBC,IBC:  ImageID [1...200]
              END,
    Modified = GETDATE(),
    RepUpdateTime = SYSDATETIME ()
FROM CustProfilePicture cpp WITH (ROWLOCK, UPDLOCK)
INNER JOIN #Temp_Cust t ON cpp.CustID = t.CustID;

DROP TABLE #Temp_Cust;
