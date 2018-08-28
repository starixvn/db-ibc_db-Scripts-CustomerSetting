declare @maxcustid int = 32229217--max custid so far

select  c.custid, c.roleid, ds.site,ds.username, srecommend, ds.currency,c.ugroup, c.creatdate, l.LicenseeID 
into #tmpCust
from bodb02.dbo.Customer c with(nolock)
inner join bodb02.dbo.dep_custsuper ds with(nolock)on c.srecommend=ds.custid
inner join Licensees l with(nolock) on l.LicenseeName=ds.site
where c.roleid=1
and l.IsActive = 1
and c.creatdate>='20180823'
and l.LicenseeID in (select licenseeid from LicenseeGroupComm with  (nolock) 
where IsDefault = 1 
and isactive = 1)
and c.custid not in (select custid from  LicenseeCustComm with  (nolock) )


select ci.syncasino,t.* 
from #tmpCust t 
	INNER JOIN bodb02.dbo.custinfo ci (NOLOCK) ON t.custid = ci.custid
where licenseeid IN (
select licenseeid from LicenseeGroupComm with  (nolock) 
where IsDefault = 1 
and isactive = 1
AND RnGComm > 0)
order by site

