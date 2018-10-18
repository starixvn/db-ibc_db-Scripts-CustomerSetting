/*
	Created: Winnie
	Task: Delete redundant setting Deposit RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181015
*/ 
USE CustDB
GO

DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.Enabled=1
	AND cs.site IN('Avia','GamingSoft','DBP','HL8','TLC','368Cash','Senibet','HonorW','Vwin','W88','12Bet','alog','asiabet88','mansion88','MayFair','OLE777','Salon365','SunGame'
					,'HAIFA','Bodog','Boma365','Happy1668','Hengcai88','KeenOcean','Unobet','ISC888','3star88','Newhonbet','Zzun88','Abcasino','Hecbet','iBET','Royal'
					,'XTD3','IBO','Liga','88Macao','9Club','Ae88','AG','HONBET','NBCbet','Aoncash','BE7','ITCBet','M8bola','Macaubet','Q8bola','9bet','TGO'
					,'WeBet168','KhmerG','365online','IONclub','Mayayule','Sun988','DEWA','Gampag','sbcbet','Bolanation','HuangMa','Webet138','Boying','webet88','MrCat','PKbet','BigGaming'
					,'NextBet','VCBA','Ty777','Taipanbet','Dawoo','BetStar','FLC','Sunrise','Uwoniwin','ECLBET','PanguGame','TGame','818Bet','Heaven','IGPTech','SSSSEA','K8VN'
					,'GPIGAME','Jinyazhou','Swin','Brown888','396Club','e8casino','HongChow','Lucky88','spondemo','MAX88','OPEBET','BBIN2','Bobo88','GMASTER','Opal88','Sunriseb2b'
					,'YongBao','ALPHA88','11bet','Aplus','Fugui','zt828','ENTAPLAY','MICL','Tripleone','Yibo','TangChao','WBS','CGame','Xinbo','24TECH'
					,'FB88','9wickets','YBTech','jinmangguo','Monaco','GWORLD','BETSUN','Mybet88','JIBET','Gameroom','Fabet','WINCLUB88','Callmeboss')


DELETE cg
FROM Dep_CustPTSetting_Agent cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType =43 AND cg.custid > @maxcustID
						
DELETE cg
FROM Dep_CustPTSetting_Member cg WITH(UPDLOCK,ROWLOCK)		
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType =43 AND cg.custid > @maxcustID
		
DELETE cg
FROM Dep_CustPTGroupSetting_Member cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType =43 AND c.custid > @maxcustID
				
DELETE cg
FROM Dep_CustBetSetting_Agent cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType =43 AND c.custid > @maxcustID

DELETE cg
FROM Dep_CustBetSetting_Member cg WITH(UPDLOCK,ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType =43 AND c.custid > @maxcustID

