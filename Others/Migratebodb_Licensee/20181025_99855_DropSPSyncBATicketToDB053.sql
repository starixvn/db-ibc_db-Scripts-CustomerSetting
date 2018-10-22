
--DB053 
--20181025@Sophia: Revert SPs not to sync BA ticket to DB053, due to DB053 has the job Gen BA ticket by itself (PRO) [Redmine #99855]	
Use bodb_Licensee 
GO

DROP PROC Task_BATransaction_Copy_Ticket