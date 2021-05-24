/*
	Created: 20210513@Johnson
	Task: add new problem account reason
	DB: DBCUST/CustDB
*/

insert into ProblemAccountReason(ReasonId,ReasonName,IsCredit,IsLicensee,IsCN88)
select 110, 'Info Bet(M)',1,1,1

/*
update ProblemAccountReason WITH(ROWLOCK)
set IsCN88 = 0,
	IsCredit = 0,
	IsLicensee = 0
WHERE ReasonID IN(27,101,255)
*/