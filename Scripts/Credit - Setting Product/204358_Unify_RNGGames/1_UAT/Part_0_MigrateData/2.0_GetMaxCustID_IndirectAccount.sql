/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 07/06/2024
	Task: Migrate RNG Keno For Headline Is Hidden - Get MaxCustID Indirect Account [#204358]				
	DB: DBCust/CustDB
*/
--Get Super Account Affect
CREATE TABLE #SuperID (SuperID INT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid 
FROM Customer c WITH (NOLOCK) 
WHERE c.username IN ('999MYR','DT','JARWRONG','KOR','CSDTEST','MIRI SD','PPO','S2C','skwrongxxx','StarixSCYEN','SuperTestTH','PRU','S188AH','S1NT','S52RMB','S688T','SBSR','SJ','SMOT','SQE','SSP','SWT','SXRS','TL1','TL6')



SELECT MAX(c.custid) AS MaxCustID
FROM Customer c WITH (NOLOCK)
INNER JOIN #SuperID si ON c.srecommend = si.SuperID
			   


DROP TABLE #SuperID