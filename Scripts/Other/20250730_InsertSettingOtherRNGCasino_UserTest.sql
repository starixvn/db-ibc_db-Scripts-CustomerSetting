/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250730@Dave
	Task: Insert setting Position Taking (Other RNG Casino), Win Loss Limit (Other RNG Casino)
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmp_idList table(custID int primary key, roleid tinyint);
DECLARE @BatchSize INT = 2000;


INSERT INTO @tmp_idList(custID, roleid)
SELECT custid, roleid
from Customer with (nolock) 
where username IN ('SupertestTE07','SupertestTE08','SUPERTESTAC01');

--get downline
INSERT INTO @tmp_idList(custID, roleid)
SELECT custid, roleid
from Customer with (nolock) 
where srecommend IN (select custid from @tmp_idList) and srecommend <> custid;

select * from @tmp_idList;

WHILE 1= 1
BEGIN

	WITH TMP_ID AS (
		SELECT tmp.custID
		FROM @tmp_idList as tmp
			LEFT JOIN CustPTSetting3rd_Agent as tmp_b WITH (NOLOCK)
				ON tmp.custID = tmp_b.CustID
				AND tmp_b.BetType = 4601 AND tmp_b.sporttype =9918
		WHERE tmp.roleid > 1 AND tmp_b.CustID IS NULL
	)
	insert into CustPTSetting3rd_Agent(CustID,SportType,BetType,IsLive,IsAutoMasterPT,IsAutoSuperPT,SuperPT,MasterPT,AgentPT,AutoSuperPT,AutoMasterPT,MinPT,MaxPT,RepUpdateTime)
	select TOP(@BatchSize) CustID,9918 as SportType, 4601 as BetType,IsLive,IsAutoMasterPT,IsAutoSuperPT,SuperPT,MasterPT,AgentPT,AutoSuperPT,AutoMasterPT,MinPT,MaxPT,dbo.f_GetDateTime2()
	from CustPTSetting3rd_Agent WITH (NOLOCK)
	where BetType = 4001 AND sporttype =9906
	AND CustID in (select custid from TMP_ID);
	
	IF @@ROWCOUNT < @BatchSize BREAK;

	WAITFOR DELAY '00:00:00.500';


END;

WHILE 1= 1
BEGIN
	WITH TMP_ID AS (
		SELECT tmp.custID
		FROM @tmp_idList as tmp
			LEFT JOIN CustPTSetting3rd_Member as tmp_b WITH (NOLOCK)
				ON tmp.custID = tmp_b.CustID
				AND tmp_b.BetType = 4601 AND tmp_b.sporttype =9918
		WHERE tmp.roleid = 1 AND tmp_b.CustID IS NULL
	)
	insert into CustPTSetting3rd_Member(CustID,SportType,BetType,IsLive,IsAutoMasterPT,IsAutoSuperPT,SuperPT,MasterPT,AgentPT,AutoSuperPT,AutoMasterPT,RepUpdateTime)
	SELECT TOP(@BatchSize) CustID,9918 as SportType, 4601 as BetType,IsLive,IsAutoMasterPT,IsAutoSuperPT,SuperPT,MasterPT,AgentPT,AutoSuperPT,AutoMasterPT,dbo.f_GetDateTime2()
	FROM CustPTSetting3rd_Member WITH (NOLOCK)
	WHERE BetType = 4001 AND sporttype =9906
		AND CustID in (select custid from TMP_ID);
	
	IF @@ROWCOUNT < @BatchSize BREAK;

	WAITFOR DELAY '00:00:00.500';


END;

WHILE 1= 1
BEGIN
	WITH TMP_ID AS (
		SELECT tmp.custID
		FROM @tmp_idList as tmp
			LEFT JOIN CustWinLossLimit_Agent as tmp_b WITH (NOLOCK)
				ON tmp.custID = tmp_b.CustID
				AND tmp_b.BetType = 4601 AND tmp_b.sporttype =9918
		WHERE tmp.roleid > 1 AND tmp_b.CustID IS NULL
	)
	insert into CustWinLossLimit_Agent(CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset,RepUpdateTime)
	select TOP(@BatchSize) CustId, 9918 as SportType, 4601 as BetType, MaxWinLimit, MaxLossLimit, IsAutoReset, dbo.f_GetDateTime2()
	from CustWinLossLimit_Agent WITH (NOLOCK)
	where BetType = 4001 AND sporttype =9906
	AND CustID in (select custid from TMP_ID);	
	IF @@ROWCOUNT < @BatchSize BREAK;

	WAITFOR DELAY '00:00:00.500';


END;

WHILE 1= 1
BEGIN
	WITH TMP_ID AS (
		SELECT tmp.custID
		FROM @tmp_idList as tmp
			LEFT JOIN CustWinLossLimit_Member as tmp_b WITH (NOLOCK)
				ON tmp.custID = tmp_b.CustID
				AND tmp_b.BetType = 4601 AND tmp_b.sporttype =9918
		WHERE tmp.roleid = 1 AND tmp_b.CustID IS NULL
	)
	insert into CustWinLossLimit_Member(CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset, RepUpdateTime)
	select TOP(@BatchSize) CustId, 9918 as SportType, 4601 as BetType, MaxWinLimit, MaxLossLimit, IsAutoReset, dbo.f_GetDateTime2()
	from CustWinLossLimit_Member WITH (NOLOCK)
	where BetType = 4001 AND sporttype =9906
	AND CustID in (select custid from TMP_ID);
	
	IF @@ROWCOUNT < @BatchSize BREAK;

	WAITFOR DELAY '00:00:00.500';

END;
