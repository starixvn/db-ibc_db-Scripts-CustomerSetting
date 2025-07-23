/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 2025050626@Johnson	
	Task: Log for service reset accum winloss [redmine:#226060]
	DB: DBCUST-CustDB
*/

CREATE TABLE [dbo].[ResetAccumWinLossServiceLog]
(   
    ID INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    LogDate SMALLDATETIME,
    TotalMemberReset INT,    
    LogData NVARCHAR(MAX)
) ON [DATA];
GO

-- Add clustered index on LogDate
CREATE NONCLUSTERED INDEX IX_ResetAccumWinLossServiceLog_LogDate
ON [dbo].[ResetAccumWinLossServiceLog](LogDate);
GO
