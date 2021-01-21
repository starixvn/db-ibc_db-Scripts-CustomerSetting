/*
	Created: 20210121@Johnson
	Task: Setting new CNY players to odds group "c"
	DB: DBCUST/CustDB
*/
INSERT INTO Dep_DefaultOddGroup(AgentID,Ugroup,UpdatedDate,UserId,IsActive)
SELECT 3141720,'c',GETDATE(),10278938,1	--TLCRMB01
UNION SELECT 932255,'c',GETDATE(),10278938,1	--AB88RMB01