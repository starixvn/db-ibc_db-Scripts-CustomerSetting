---------------------------
--run at DBLOG/bodb_CustomerLog

--input time for checking
declare @releaseDate datetime = '2013-12-12 09:30:30'		--the time web release _xtest on prod yyyy-mm-dd hh:MM:ss
declare @monitorDate datetime = '2023-12-12'				--monitoring date yyyy-mm-dd
declare @processingTime datetime = '2023-12-12 11:45:00'	--the processing time of monitoring date (monitoring date + setting processing time) yyyy-mm-dd hh:MM:ss

declare @dayWeek tinyint
select @dayWeek = case DATENAME(WEEKDAY,@monitorDate)   when 'Monday'		then 2
														when 'Tuesday'		then 3
														when 'Wednesday'	then 4
														when 'Thursday'		then 5
														when 'Friday'		then 6
														when 'Saturday'		then 7
														when 'Sunday'		then 1 end

--get transfer history & setting schedule
declare @history table(fromcustid int, tocustid int, schedule varchar(20), sessiondate datetime, status varchar(20))
insert into @history(fromcustid, tocustid, schedule, sessiondate, status)
	select p.FromCustID, p.ToCustID, c.scheduleoption as schedule, p.sessiondate, p.status
	from dbo.Age_ClearBalanceCust_ProcessHistory p with (NOLOCK)
		left join DBCUST.CustDB.dbo.Age_ClearBalanceCust_Setting c with (NOLOCK) ON p.fromcustid = c.FromCustID and p.tocustid = c.ToCustID
	where sessiondate >= @monitorDate	
select * from @history


--check1: unmatch schedule pair
declare @error table(fromcustid int, tocustid int, schedule varchar(20))
insert into @error(fromcustid, tocustid, schedule)
	select fromcustid, tocustid, schedule
	from @history
	where schedule & power(2,@dayWeek) = 0
select * from @error


--check log of unmatch schedule pair if any
select * from(
	select logid, custid, logdate, trackingvalue, TrackingValue2
	from dbo.UserLog_RunSP u with (NOLOCK)
		inner join @error e ON u.custid = e.tocustid
	where (actionid = 95086 OR ActionID between 95097 and 95115)
	and logdate >= @processingTime
) t
order by t.custid, t.logdate desc


--check2: pairs have changes on auto transfer function before processing time
;with _changecust as(
	select custid 
	from dbo.UserLog_RunSP l with (NOLOCK)
		inner join dbo.Age_ClearBalanceCust_ProcessHistory h with (NOLOCK) on l.custid = h.ToCustId
	where h.SessionDate = @monitorDate
)
,_log as(
	select custid, actionid, trackingvalue, logdate
	from dbo.userlog_runsp with (NOLOCK)
	where (ActionID = 95086 OR ActionID between 95097 and 95115)
		and logdate between @releaseDate and @processingTime
)
,_trackingvalue as(
	select a.custid, t.trackingvalue, logdate
	from _changecust a
		cross apply(
			select top 1 trackingvalue, logdate
			from _log s
			where s.custid = a.custid
			order by logdate desc
		) t
)
select * from _trackingvalue