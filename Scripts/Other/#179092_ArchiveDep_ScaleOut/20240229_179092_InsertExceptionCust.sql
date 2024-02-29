/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
Created: 20240229@Eden
Task: Insert exception customer to Dep_Customer_Archived_Exception [#179092]
DB: DBCUST.CustDB
*/
USE CustDB
GO
INSERT INTO Dep_Customer_Archived_Exception (CustID,Remark)
SELECT 28540570,'Customer use for service'
WHERE NOT EXISTS(	SELECT 1 
					FROM Dep_Customer_Archived_Exception WITH(NOLOCK) 
					WHERE custid IN (28540570)
				)
