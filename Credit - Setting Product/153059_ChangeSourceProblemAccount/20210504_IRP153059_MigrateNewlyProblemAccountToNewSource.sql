/*
	Created: 20210429@Johnson
	Task: migrate data from ProblemAccount to new source
	DB: DBCUST-CustDB
*/
--import PA from CTS & RobotUsers which not have in ProblemAccount table
--will get lastest when release
;WITH t AS (
	--List PA not robot users
	SELECT 39053653 as custid, '2021-05-03 22:35:52.580' as CreatedDate--TP115
	--List robot users
	UNION ALL SELECT 49062100,	'2021-03-15 12:07:00'--	MVPD821086
)
INSERT INTO ProblemAccountClassification(custid,IsReviewed,ModifiedDate)
SELECT custid, 0, CreatedDate
FROM t
WHERE NOT EXISTS (SELECT 1 FROM ProblemAccountClassification pc WITH(NOLOCK) WHERE pc.custid = t.custid)
