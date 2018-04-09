/*
    Created: Vicky.phan
    Date: 2018-04-09
    Task : Update AdjustDate to current date
    DB: DBLOG/[bodb_CustomerLog]
*/

UPDATE userlog_virtualrateSettings WITH (ROWLOCK,UPDLOCK)
SET AdjustDate = '2018-04-09 3:24:00' , ReportDate = '2018-04-09'
WHERE CreatorID = 862400 and AdjustDate = '2018-04-05 00:15:00' and ServiceName = 'Soccer' AND OldVirtualRate = 3.00 AND NewVirtualRate = 1.00
