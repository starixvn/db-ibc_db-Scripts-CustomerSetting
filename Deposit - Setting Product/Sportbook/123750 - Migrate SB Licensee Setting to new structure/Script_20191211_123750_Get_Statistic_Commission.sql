/*
	Created by: Eden
	Date: 2019-12-11
	Task: get Statistic of Commission setting for SB
	Database: DBCUST/CUSTDB
*/ 
--> Get Statistic of  SB
;WITH tmp as(
SELECT c.recommend,count(1) as GroupCount, row_number() OVER (partition by c.recommend order by count(1) DESC ) AS GroupCountOrder
FROM Dep_CustSetting a WITH(NOLOCK)
	INNER JOIN custinfo c WITH(NOLOCK) On a.custid = c.custid AND c.roleid = 1
WHERE (a.SportType = 1 and a.bettype = 1 and a.islive = 0) 
GROUP by c.recommend,a.playerdiscount
)
SELECT SUM(GroupCount) - SUM(CASE WHEN GroupCountOrder = 1 THEN GroupCount ELSE 0  END ) AS DifferrentCommCount
	 , SUM(GroupCount) AS TotalMember
	 ,(SUM(GroupCount) - SUM(CASE WHEN GroupCountOrder = 1 THEN GroupCount ELSE 0  END ) ) * 100.00 / SUM(GroupCount) AS AVG_DiffCommPercent
FROM tmp
