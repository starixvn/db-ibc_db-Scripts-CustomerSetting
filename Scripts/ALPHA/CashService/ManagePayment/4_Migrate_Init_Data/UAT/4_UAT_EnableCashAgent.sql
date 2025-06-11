/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST-CustDB
*/

DECLARE @AgentList TABLE (UserName VARCHAR(30) , AgentID INT)

INSERT INTO @AgentList ( UserName , AgentID)
VALUES
-- UAT 
('SUPERTESTSH277I10000', 0),
('SUPERTESTTE070000', 0),
('SUPERTESTTE070001', 0),
('SUPERTESTTE070100', 0),
('SupertestTE070101', 0),
('SUPERTESTTE070200', 0),
('SUPERTESTTE080000', 0),
('Supertestte080101', 0),
('SUPERTESTTE080100', 0),
('SUPERTESTTE080102', 0),
('SUPERTESTTE080103', 0);


UPDATE al SET al.AgentID = c.custid
FROM @AgentList al
INNER JOIN dbo.Customer c WITH (NOLOCK) ON al.UserName = c.username

IF NOT EXISTS (SELECT TOP 1 1 FROM @AgentList)
BEGIN
	SELECT N'AgentID input validate' AS ErrMsg
	RETURN
END

IF NOT EXISTS (SELECT TOP 1 1 FROM CustProductStatus_UAT cpsu WITH (NOLOCK) 
					INNER JOIN @AgentList al ON cpsu.CustID = al.AgentID)
BEGIN
	INSERT INTO CustProductStatus_UAT	 
	(
		CustID
	    , bitmapHasSynced
	    , bitmapIsHidden
	    , bitmapIsDisabled
	    , SuspendInfo
	    , Locked
	    , CloseInfo
	    , RepUpdateTime
	    , ServiceType
	)
	SELECT
		CustID
	    , bitmapHasSynced
	    , bitmapIsHidden
	    , bitmapIsDisabled
	    , SuspendInfo
	    , Locked
	    , CloseInfo
	    , SYSDATETIME () AS  RepUpdateTime
	    , 1 AS ServiceType
	FROM CustProductStatus cs WITH (NOLOCK)
	INNER JOIN @AgentList al ON cs.CustID = al.AgentID
END