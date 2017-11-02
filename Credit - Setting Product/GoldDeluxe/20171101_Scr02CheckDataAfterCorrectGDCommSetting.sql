/*
	Created: 20171101@Johnson
	Task : Check comm setting for un-sync customers for GD after running script correct setting
	DB:  DBCUST/CustDB
*/

CREATE TABLE #Supers(CustID INT)

CREATE TABLE #CheckCommResult_Credit (RuleId SMALLINT, BetType SMALLINT, SportType SMALLINT, CustIdA INT, CustIdB INT, ValueA smallmoney, ValueB smallmoney) 
	
INSERT INTO #Supers(custid)
SELECT custid 
FROM dbo.custInfo WITH (Nolock) 
WHERE roleid = 4
	AND custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND enabled = 1

SELECT cs.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.sdiscount AS SuperDiscount, cs.adiscount AS MasterDiscount, cs.discount AS AgentDiscount, cs.PlayerDiscount
INTO #MemberComm
FROM dbo.CustInfo ci WITH(NOLOCK)
	INNER JOIN dbo.Custsettinggame cs WITH (NOLOCK) ON ci.CustID = cs.CustID
WHERE ci.srecommend in (select custid from #supers)  
		AND ci.roleid = 1  
		AND ci.Enabled = 1          
		AND cs.SportType = 255	
		

SELECT cs.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.Discount
INTO #AgentComm
FROM CustInfo ci
	INNER JOIN Custsettinggame cs WITH (NOLOCK) ON ci.CustID = cs.CustID		
WHERE ci.srecommend in (select custid from #supers)
		AND ci.roleid = 2  
		AND ci.Enabled = 1      		
		AND cs.SportType = 255

SELECT cs.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.adiscount AS Discount
INTO #MasterComm
FROM dbo.CustInfo ci
	INNER JOIN dbo.Custsettinggame cs WITH (NOLOCK) ON ci.CustID = cs.CustID	
WHERE ci.srecommend IN (SELECT custid from #supers)
		AND ci.roleid = 3  
		AND ci.Enabled = 1      		    
		AND cs.SportType = 255		
		
SELECT cs.CustID, cs.SportType,cs.BetType,cs.sdiscount AS Discount
INTO #SuperComm
FROM dbo.CustInfo ci WITH(NOLOCK)
	INNER JOIN dbo.Custsettinggame cs WITH (NOLOCK) ON ci.CustID = cs.CustID		
WHERE ci.srecommend IN (SELECT custid from #supers)
		AND ci.roleid = 4  
		AND ci.Enabled = 1      		    
		AND cs.SportType = 255		

		DECLARE @Ruleid SMALLINT
SET @Ruleid = 0

-- Starting check Comm Rule
----42. SuperDiscount <> SuperDiscount on member level
IF @RuleId IN (0,42)  
BEGIN   
	----PRINT '42. SuperDiscount <> SuperDiscount on member level'
	INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
	SELECT 42 as RuleId, csmem.BetType, csmem.SportType, css.CustId, csmem.CustId, css.Discount, csmem.SuperDiscount
	FROM #MemberComm csmem
		INNER JOIN #SuperComm css ON css.BetType = csmem.BetType AND css.SportType = csmem.SportType AND csmem.srecommend = css.custid
	WHERE css.Discount <> csmem.SuperDiscount

END  

----43. MasterDiscount <> MasterDiscount on member level
IF @RuleId IN (0,43)  
BEGIN   
	----PRINT '43. MasterDiscount <> MasterDiscount on member level'
	INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
	SELECT 43 as RuleId, csmem.BetType, csmem.SportType, csm.CustId, csmem.CustId, csm.Discount, csmem.MasterDiscount
	FROM #MemberComm csmem
		INNER JOIN #MasterComm csm ON csm.BetType = csmem.BetType AND csm.SportType = csmem.SportType AND csmem.mrecommend = csm.custid
	WHERE csm.Discount <> csmem.MasterDiscount
END  

----44. AgentDiscount <> AgentDiscount on member level
IF @RuleId IN (0,44)  
BEGIN   
	----PRINT '44. AgentDiscount <> AgentDiscount on member level'
	INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
	SELECT 44 as RuleId, csmem.BetType, csmem.SportType, csa.CustId, csmem.CustId, csa.Discount, csmem.AgentDiscount
	FROM #MemberComm csmem
		INNER JOIN #AgentComm csa ON csa.BetType = csmem.BetType AND csa.SportType = csmem.SportType AND csmem.recommend = csa.custid
	WHERE csa.Discount <> csmem.AgentDiscount
END  


SELECT --s.Headline, s.HeadlineID,
	 Case when b.roleid = 1 then ab.site
		else b.site
		end Site
	, b.currency
	, b.srecommend as SuperID, sb.username as Super
	, b.mrecommend as MasterID, mb.username as Master
	, b.recommend as AgentID, ab.username as Agent
	, a.custid as CustIdA, a.username as usernameA, a.roleid as roleIdA
			, CASE  WHEN ai.HideGoldDeluxe = 1 then 'Not synced' 
					when ai.HideGoldDeluxe = 0 and ai.HideGoldDeluxe = 0 then 'Synced and Enabled' 
					when ai.HideGoldDeluxe = 0 and ai.HideGoldDeluxe = 1 then 'Synced and Disabled'
					End as StatusA
	, b.custid as CustIdB, b.username as usernameB, b.roleid as roleIdB
			, case  when bi.HideGoldDeluxe = 1 then 'Not synced' 
					when bi.HideGoldDeluxe = 0 and bi.HideGoldDeluxe = 0 then 'Synced and Enabled' 
					when bi.HideGoldDeluxe = 0 and bi.HideGoldDeluxe = 1 then 'Synced and Disabled'
					End as StatusB
	, com. * 
from #CheckCommResult_Credit com
inner join Customer a with (nolock) on com.CustIdA = a.custid
inner join Custinfo ai with (nolock) on com.CustIdB = ai.custid
--left join Customer sa with (nolock) on a.srecommend = sa.custid
--left join Customer ma with (nolock) on a.mrecommend = ma.custid
--left join Customer aa with (nolock) on a.recommend = aa.custid
inner join Custinfo bi with (nolock) on com.CustIdB = bi.custid
inner join Customer b with (nolock) on com.CustIdB = b.custid
left join Customer sb with (nolock) on b.srecommend = sb.custid
left join Customer mb with (nolock) on b.mrecommend = mb.custid
left join Customer ab with (nolock) on b.recommend = ab.custid
inner join #supers s on s.custid = b.srecommend
order by b.srecommend, b.mrecommend, b.recommend, com.CustIdA, com.CustIdB
		