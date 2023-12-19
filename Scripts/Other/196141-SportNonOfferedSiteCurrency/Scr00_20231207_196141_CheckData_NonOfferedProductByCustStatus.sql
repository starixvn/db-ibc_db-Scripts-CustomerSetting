/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: Tacy@20231207 
	Task: check data [redmine: #196141]
	DB: DBAGE-bodb02
*/
USE bodb02
GO
IF OBJECT_ID(N'tempdb..#SportBettypeFilter_s') IS NOT NULL
	DROP TABLE #SportBettypeFilter_s

IF OBJECT_ID(N'tempdb..#ProductSettingType_s') IS NOT NULL
	DROP TABLE #ProductSettingType_s

IF OBJECT_ID(N'tempdb..#supers') IS NOT NULL
	DROP TABLE #supers

IF OBJECT_ID(N'tempdb..#Customer') IS NOT NULL
	DROP TABLE #Customer

IF OBJECT_ID(N'tempdb..#OfferedProducts_s') IS NOT NULL
	DROP TABLE #OfferedProducts_s

CREATE TABLE #SportBettypeFilter_s (RealProductId TINYINT, SportType SMALLINT,Bettype SMALLINT,IsLive BIT, SettingType TINYINT)
CREATE TABLE #ProductSettingType_s(
	SettingType	tinyint,
	SettingName	varchar(30)
)
CREATE TABLE #supers (custid int PRIMARY KEY)
CREATE TABLE #Customer (custid int, currency nvarchar(50), exchangeID TINYINT, site varchar(10))

CREATE TABLE #OfferedProducts_s (ProductID TINYINT, ProductName VARCHAR(50), IsHidden BIT,Currency TINYINT, Site VARCHAR(10), EndOfSupportDate date)

DECLARE @TmpSiteCurrency_s TABLE(OrderID INT IDENTITY (1,1),currency TINYINT, Site VARCHAR(10))

DECLARE @CheckEnableProduct_s TABLE (ProductID TINYINT, ProductName VARCHAR(50), EndOfSupportDate date, IsHidden BIT,[Type] tinyint,OrderNo int)

-----------------------------------------------------------
INSERT INTO #supers(custid)
SELECT DISTINCT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custinfo C WITH(NOLOCK) ON c.CustID = ci.custid 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN Exchange e WITH (NOLOCK) ON e.ExchangeId=ci.currency
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.isActive=1 AND s.islicensee = 0 
		AND e.IsActive=1 AND e.OfferSite IN (0,1)
		AND ci.Site<>'CN88'
		AND c.Enabled = 1
		AND ci.currency NOT IN (20,72) --UUS

INSERT INTO #Customer(custid, currency, exchangeID, site)
SELECT C.custid, E.currency, e.ExchangeId, C.site
FROM Customer c WITH (NOLOCK)
	INNER JOIN custinfo Ci WITH(NOLOCK) ON c.CustID = ci.custid 
	INNER JOIN #supers s ON s.custid=c.srecommend
	INNER JOIN Exchange e WITH (NOLOCK) ON e.ExchangeId=ci.currency
WHERE c.roleid in (1,2,3,4) AND ci.Enabled=1

INSERT INTO @TmpSiteCurrency_s(Site, currency)
SELECT DISTINCT site, exchangeID
FROM #Customer


-----------------------------------------------------------
--get Headline: 10 headlines (SDRMB, 266HK, M863HK, SBSR, YKH, S188RM, PYY, POT, SF8, S80R)
-----------------------------------------------------------
IF OBJECT_ID(N'tempdb..#tmp_HL') IS NOT NULL
	DROP TABLE #tmp_HL

create table #tmp_HL (custid int, roleid tinyint, groupid smallint, headline varchar(30), Is10Headlines bit)

;with Headline as (
        select hl.CustID, hl.GroupID, c.username headline,
			case when c.username in ('SDRMB', '266HK', 'M863HK', 'SBSR', 'YKH', 'S188RM', 'PYY', 'POT', 'SF8', 'S80R') then  1 else 0 end Is10Headlines
        from CustGroupHeadline hl with (nolock)
        inner join vw_Customer  c with (nolock) on c.custid=hl.custid     
		--where c.username in ('SDRMB', '266HK', 'M863HK', 'SBSR', 'YKH', 'S188RM', 'PYY', 'POT', 'SF8', 'S80R')
)
insert into #tmp_HL (custid, roleid, groupid, headline, Is10Headlines)
select ca.custid, c.roleid, h.GroupID, h.headline, h.Is10Headlines
from custAccount ca WITH (NOLOCK)                                        
    INNER JOIN vw_Customer  c WITH (NOLOCK) ON c.custid=ca.custid  
    INNER JOIN Headline h WITH (NOLOCK) ON h.GroupID = ca.groupID

-----------------------------------------------------------
-----------------------------------------------------------
INSERT INTO #ProductSettingType_s(SettingType,SettingName)
SELECT SettingType,SettingName 
FROM DBCUST.CUSTDB.dbo.ProductSettingType WITH(NOLOCK) 
WHERE SettingName IN('Product Status')

INSERT INTO #SportBettypeFilter_s (RealProductId,SportType,Bettype,IsLive, SettingType)
SELECT p.RealProductId,p.SportType,p.Bettype,p.IsLive, p.SettingType   
FROM dbo.f_CustSetting_ProductSettingDetailSel(3) p
	INNER JOIN #ProductSettingType_s t ON p.SettingType = t.SettingType
-----------------------------------------------------------
----------------------------DCS---------------------------
DECLARE @Site VARCHAR(10), @Currency TINYINT, @ID INT= 1
	 
WHILE EXISTS (SELECT 1 FROM	@TmpSiteCurrency_s WHERE OrderID = @ID)
BEGIN 
	SELECT	@Currency = c.currency,
			@site = c.Site
	FROM	@TmpSiteCurrency_s  c
	WHERE	OrderID = @ID
	
	--SELECT @Site, @Currency, @ID

	--PRINT CAST (@ID AS VARCHAR)

	INSERT INTO @CheckEnableProduct_s (ProductID, ProductName, IsHidden, EndOfSupportDate, OrderNo, [Type])
	EXEC dbo.Age_GetOfferedProductBySiteCurrency_xpre @Site = @Site, @Currency = @Currency, @SettingStatus = 3

	INSERT INTO  #OfferedProducts_s (ProductID, ProductName, IsHidden, Site, Currency, EndOfSupportDate)
	SELECT DISTINCT ProductID, ProductName, IsHidden, @Site, @Currency, EndOfSupportDate
	FROM @CheckEnableProduct_s

	SET @ID = @ID + 1

	DELETE FROM @CheckEnableProduct_s
END	 

-------------------------------------------
IF OBJECT_ID(N'tempdb..#T') IS NOT NULL
	DROP TABLE #T

CREATE TABLE #T (custid INT, ProductID TINYINT, ProductName VARCHAR(50),IsDisabled BIT)

INSERT INTO #T (custid, ProductID, ProductName, IsDisabled)
SELECT C.custid, T.ProductID, p.ProductName
, dbo.f_GetProductStatus(cps.bitmapIsDisabled , t.bitmapOrder) IsDisabled
FROM
	dbo.CustProductStatus cps  WITH (NOLOCK)  
	CROSS APPLY
	(
		SELECT p.bitmapOrder , 
				RealProductID AS ProductID 
		FROM #SportBettypeFilter_s c
			INNER JOIN dbo.ProductStatusProfile p WITH (NOLOCK)
				ON c.Sporttype = p.SportType AND p.Bettype = c.BetType
	) t
	INNER JOIN #Customer c ON c.CustID = cps.CustID
	INNER JOIN #OfferedProducts_s p on p.Site=c.site AND p.Currency=c.exchangeID AND p.ProductID=t.ProductID
WHERE dbo.f_GetProductStatus(cps.bitmapIsHidden , t.bitmapOrder)=1
AND p.IsHidden=0 AND isnull(p.EndOfSupportDate, GETDATE())>= CAST(GETDATE() AS date)

---------------------------------------------------------------------------------------------------
select count(1) TotalActiveCust
from #Customer

select count(distinct custid) TotalHiddenCust
from #T

select ProductID, ProductName
	, case when c.roleid in (2,3,4) then 'SMA' else 'Member' end Level
	, count(1) cnt_TotalHiddenByProduct
from #T t
inner join vw_Customer c with (nolock) on c.custid=t.custid
group by ProductID, ProductName
, case when c.roleid in (2,3,4) then 'SMA' else 'Member' end

select c.site, ProductName, count(1) cnt_TotalHiddenBySiteCurrency
from #T t
inner join #Customer c on c.custid=t.custid
group by c.site, ProductName

---------------------------------------------------------------------------------------------------
--SMA
IF OBJECT_ID(N'tempdb..#Result') IS NOT NULL
	DROP TABLE #Result

create table #Result (site varchar(10), headline varchar(30), custid int, username varchar(30), roleid tinyint, exchangeID tinyint, currency nvarchar(30)
						, productID tinyint, productname varchar(50), lastlogged smalldatetime, super varchar(30), [master] varchar(30), agent varchar(30)
						, IsDisabled bit, Is10Headlines bit
						, primary key clustered (custid, productid))

INSERT INTO #Result (
	site, headline, custid, username
	, roleid, ExchangeID, currency
	, ProductID, ProductName, lastlogged
	, IsDisabled, Is10Headlines)
SELECT c.site, hs.headline, t.custid, c.username, c.roleid, c.currency as ExchangeID, cc.currency
	, t.ProductID, t.ProductName, c.lastlogged
	, t.IsDisabled, Is10Headlines
FROM #T T
INNER JOIN #Customer cc on cc.custid=t.custid
INNER JOIN vw_Customer c with (nolock) on c.custid=t.custid
OUTER APPLY (SELECT TOP 1 hs.headline, Is10Headlines
			 FROM #tmp_HL hs WHERE hs.custid=c.srecommend AND hs.roleid=4) hs
WHERE c.roleid=4
UNION
SELECT c.site
	, case when hs.headline is null then hm.headline
		when hs.headline is not null then hs.headline
		end headline
	, t.custid, c.username, c.roleid, c.currency as ExchangeID, cc.currency
	, t.ProductID, t.ProductName, c.lastlogged
	, t.IsDisabled
	, case when hs.headline is null then hm.Is10Headlines
		when hs.headline is not null then hs.Is10Headlines
		end Is10Headlines
FROM #T T
INNER JOIN #Customer cc on cc.custid=t.custid
INNER JOIN vw_Customer c with (nolock) on c.custid=t.custid
OUTER APPLY (SELECT TOP 1 hs.headline, Is10Headlines
			 FROM #tmp_HL hs WHERE hs.custid=c.srecommend AND hs.roleid=4) hs
OUTER APPLY (SELECT TOP 1 hm.headline, Is10Headlines
			 FROM #tmp_HL hm WHERE hm.custid=c.mrecommend AND hm.roleid=3) hm
WHERE c.roleid=3
UNION
SELECT c.site
	, case when hs.headline is null and hm.headline is null then hr.headline
		when hs.headline is null and hm.headline is not null then hm.headline
		when hs.headline is not null  then hs.headline
		end headline
	, t.custid, c.username, c.roleid, c.currency as ExchangeID, cc.currency
	, t.ProductID, t.ProductName, c.lastlogged
	, t.IsDisabled
	, case when hs.headline is null and hm.headline is null then hr.Is10Headlines
		when hs.headline is null and hm.headline is not null then hm.Is10Headlines
		when hs.headline is not null  then hs.Is10Headlines
		end Is10Headlines
FROM #T T
INNER JOIN #Customer cc on cc.custid=t.custid
INNER JOIN vw_Customer c with (nolock) on c.custid=t.custid
OUTER APPLY (SELECT TOP 1 hs.headline, Is10Headlines
			 FROM #tmp_HL hs WHERE hs.custid=c.srecommend AND hs.roleid=4) hs
OUTER APPLY (SELECT TOP 1 hm.headline, Is10Headlines
			 FROM #tmp_HL hm WHERE hm.custid=c.mrecommend AND hm.roleid=3) hm
OUTER APPLY (SELECT TOP 1 hr.headline, Is10Headlines
			 FROM #tmp_HL hr WHERE hr.custid=c.recommend AND hr.roleid=2) hr
WHERE c.roleid=2

---------------------------------------------------------------------------------------------------
--Member
INSERT INTO #Result (
	site, headline, custid, username
	, roleid, ExchangeID, currency
	, ProductID, ProductName, lastlogged
	, Super, [Master], agent, IsDisabled, Is10Headlines)
SELECT c.site
	, case when hs.headline is null and hm.headline is null and hr.headline is null then h.Is10Headlines
		when hs.headline is null and hm.headline is null and hr.headline is not null then hr.Is10Headlines
		when hs.headline is null and hm.headline is not null then hm.Is10Headlines
		when hs.headline is not null  then hs.Is10Headlines
		end headline
	, t.custid, c.username, c.roleid, c.currency as ExchangeID, cc.currency
	, t.ProductID, t.ProductName, c.lastlogged
	, srecommend Super, mrecommend as 'Master', c.recommend Agent
	, t.IsDisabled
	, case when hs.headline is null and hm.headline is null and hr.headline is null then h.Is10Headlines
		when hs.headline is null and hm.headline is null and hr.headline is not null then hr.Is10Headlines
		when hs.headline is null and hm.headline is not null then hm.Is10Headlines
		when hs.headline is not null  then hs.Is10Headlines
		end Is10Headlines
FROM #T T
INNER JOIN #Customer cc on cc.custid=t.custid
INNER JOIN vw_Customer c with (nolock) on c.custid=t.custid
OUTER APPLY (SELECT TOP 1 hs.headline, Is10Headlines
			 FROM #tmp_HL hs WHERE hs.custid=c.srecommend AND hs.roleid=4) hs
OUTER APPLY (SELECT TOP 1 hm.headline, Is10Headlines
			 FROM #tmp_HL hm WHERE hm.custid=c.mrecommend AND hm.roleid=3) hm
OUTER APPLY (SELECT TOP 1 hr.headline, Is10Headlines
			 FROM #tmp_HL hr WHERE hr.custid=c.recommend AND hr.roleid=2) hr
OUTER APPLY (SELECT TOP 1 h.headline, Is10Headlines
			 FROM #tmp_HL h WHERE h.custid=c.custid AND h.roleid=1) h
WHERE c.roleid=1


--update super/master/agent
update r
set r.super=sup.username, r.master=mas.username, r.agent=ag.username
from #Result r
inner join vw_Customer ci with (nolock) on ci.custid=r.custid
outer apply (select top 1 username from vw_Customer c with (nolock)
			 where c.custid=ci.srecommend) sup
outer apply (select top 1 username from vw_Customer c with (nolock)
			 where c.custid=ci.mrecommend) mas
outer apply (select top 1 username from vw_Customer c with (nolock)
			 where c.custid=ci.recommend) ag

--get data SMA
; with TmpCount as (
	select r.custid, r.productID, COUNT(1) MemberCount
	from #Result r
	inner join #Result rd on r.username=rd.super and r.productID=rd.productID
	where r.roleid=4
	group by r.custid, r.productID
	union
	select r.custid, r.productID, COUNT(1) MemberCount
	from #Result r
	inner join #Result rd on r.username=rd.master and r.productID=rd.productID
	where r.roleid=3
	group by r.custid, r.productID
	union
	select r.custid, r.productID, COUNT(1) MemberCount
	from #Result r
	inner join #Result rd on r.username=rd.agent and r.productID=rd.productID
	where r.roleid=2
	group by r.custid, r.productID
)
select site, headline, r.custid, username
	, roleid, ExchangeID, currency
	, r.ProductID, ProductName, lastlogged
	, Super, [Master], IsDisabled
	, t.MemberCount
	, Is10Headlines
from #Result r
LEFT JOIN TmpCount t on t.custid=r.custid and t.productID=r.productID
where roleid<>1
order by headline, site, roleid desc, productID

--get data Member
select site, headline, custid, username
	, ExchangeID, currency
	, ProductID, ProductName
	, Super, [Master], agent
	, IsDisabled, Is10Headlines
from #Result
where roleid =1
order by headline, site, productID

---------------------------------------------------------------

---------------------------------------------------------------
--Sum data:
select r.site, productname,
	case when Is10Headlines=1 then '10 headlines'
		 when Is10Headlines=0 then 'Other headlines'
		 else '-' 
	end as Headline,
	count(1) as 'sum'
from #Result r
where roleid <> 1
group by r.site, productname,
	case when Is10Headlines=1 then '10 headlines'
		 when Is10Headlines=0 then 'Other headlines'
		 else '-'
		 end
order by r.site, productname,
	case when Is10Headlines=1 then '10 headlines'
		 when Is10Headlines=0 then 'Other headlines'
		 else '-'
		 end 
--member
select r.site, productname,
	case when Is10Headlines=1 then '10 headlines'
		 when Is10Headlines=0 then 'Other headlines'
		 else '-' 
	end as Headline,
	count(1) as 'sum'
from #Result r
where roleid = 1
group by r.site, productname,
	case when Is10Headlines=1 then '10 headlines'
		 when Is10Headlines=0 then 'Other headlines'
		 else '-'
		 end
order by r.site, productname,
	case when Is10Headlines=1 then '10 headlines'
		 when Is10Headlines=0 then 'Other headlines'
		 else '-'
		 end 

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--tmp_OfferedCust
;with tmp_OfferedCust as (
SELECT c.site,t.ProductID, p.ProductName
,	case when vc.roleid=4 then hs.Is10Headlines
		when vc.roleid=3 then 
			case when hs.headline is null then hm.Is10Headlines
				 when hs.headline is not null then hs.Is10Headlines
			end
		when vc.roleid=2 then
			case when hs.headline is null and hm.headline is null then hr.Is10Headlines
				when hs.headline is null and hm.headline is not null then hm.Is10Headlines
				when hs.headline is not null  then hs.Is10Headlines
			end
		when vc.roleid=1 then
			case when hs.headline is null and hm.headline is null and hr.headline is null then h.Is10Headlines
				when hs.headline is null and hm.headline is null and hr.headline is not null then hr.Is10Headlines
				when hs.headline is null and hm.headline is not null then hm.Is10Headlines
				when hs.headline is not null  then hs.Is10Headlines
			end
		end Is10Headlines
		, COUNT(1) totalOfferedCust
FROM
	dbo.CustProductStatus cps  WITH (NOLOCK)  
	CROSS APPLY
	(
		SELECT p.bitmapOrder , 
				RealProductID AS ProductID 
		FROM #SportBettypeFilter_s c
			INNER JOIN dbo.ProductStatusProfile p WITH (NOLOCK)
				ON c.Sporttype = p.SportType AND p.Bettype = c.BetType
	) t
	INNER JOIN #Customer c ON c.CustID = cps.CustID
	INNER JOIN #OfferedProducts_s p on p.Site=c.site AND p.Currency=c.exchangeID AND p.ProductID=t.ProductID
	
	--get headline
	INNER JOIN vw_Customer vc with (nolock) on vc.custid=cps.CustID
	OUTER APPLY (SELECT TOP 1 hs.headline, Is10Headlines
				 FROM #tmp_HL hs WHERE hs.custid=vc.srecommend AND hs.roleid=4) hs
	OUTER APPLY (SELECT TOP 1 hm.headline, Is10Headlines
				 FROM #tmp_HL hm WHERE hm.custid=vc.mrecommend AND hm.roleid=3) hm
	OUTER APPLY (SELECT TOP 1 hr.headline, Is10Headlines
				 FROM #tmp_HL hr WHERE hr.custid=vc.recommend AND hr.roleid=2) hr
	OUTER APPLY (SELECT TOP 1 h.headline, Is10Headlines
				 FROM #tmp_HL h WHERE h.custid=c.custid AND h.roleid=1) h

WHERE dbo.f_GetProductStatus(cps.bitmapIsHidden , t.bitmapOrder)=0 and t.ProductID in (3,5,6,8,40,66,69,70)
AND p.IsHidden=0 AND isnull(p.EndOfSupportDate, GETDATE())>= CAST(GETDATE() AS date)
and c.site in ('222223', '611111', '722222', '733333', '766666', 'BEST-ODDS', 'IBCIndo', 'indo', 'XYZBET', 'yOther')
group by c.site,t.ProductID, p.ProductName
,	case when vc.roleid=4 then hs.Is10Headlines
		when vc.roleid=3 then 
			case when hs.headline is null then hm.Is10Headlines
				 when hs.headline is not null then hs.Is10Headlines
			end
		when vc.roleid=2 then
			case when hs.headline is null and hm.headline is null then hr.Is10Headlines
				when hs.headline is null and hm.headline is not null then hm.Is10Headlines
				when hs.headline is not null  then hs.Is10Headlines
			end
		when vc.roleid=1 then
			case when hs.headline is null and hm.headline is null and hr.headline is null then h.Is10Headlines
				when hs.headline is null and hm.headline is null and hr.headline is not null then hr.Is10Headlines
				when hs.headline is null and hm.headline is not null then hm.Is10Headlines
				when hs.headline is not null  then hs.Is10Headlines
			end
		end
)
select site, productname,
	case when Is10Headlines=1 then '10 headlines'
		 when Is10Headlines=0 then 'Other headlines'
		 else '-' 
	end as Headline,
	sum(totalOfferedCust) as 'totalOfferedCust'
from tmp_OfferedCust
group by site, ProductName
, case when Is10Headlines=1 then '10 headlines'
		 when Is10Headlines=0 then 'Other headlines'
		 else '-' 
	end
order by site, ProductName

--Drop table #Customer, #OfferedProducts_s, #ProductSettingType_s, #SportBettypeFilter_s, #T, #supers