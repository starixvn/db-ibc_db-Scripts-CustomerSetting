--run at dbcust/custdb

--input start time
declare @timestart datetime = '2023-12-19'

;with _allcust as(
	select distinct custid
	from dblog.bodb_customerlog.dbo.userlog_runsp with (NOLOCK)
	where (actionid = 95086 OR ActionID between 95097 and 95115)
		and logdate >= @timestart
),
_log as(
	select custid, actionid, trackingvalue, logdate
	from dblog.bodb_customerlog.dbo.userlog_runsp with (NOLOCK)
	where (ActionID = 95086 OR ActionID between 95097 and 95115)
		and logdate >= @timestart
)
,_trackingvalue as(
	select a.custid, t.trackingvalue
	from _allcust a
		cross apply(
			select top 1 trackingvalue 
			from _log s
			where s.custid = a.custid
			order by logdate desc
		) t
)

select a.FromCustID
		, a.ToCustID
		, a.ScheduleOption AS ScheduleOption_DB
		, dbo.f_AutoTransferSchedule_NumericToChar_xtest(ScheduleOption) ScheduleOption_DB_List
		, TrackingValue
		, case ISNULL(charindex('"'+dbo.f_AutoTransferSchedule_NumericToChar_xtest(ScheduleOption)+'"',trackingvalue),-1) when -1 then 'disable'
																										when 0 then 'UNMATCH!!!'
																										else 'match' end as checkflag
from _trackingvalue t left join Age_ClearBalanceCust_Setting a with (NOLOCK) ON t.custid = a.ToCustID
order by checkflag

