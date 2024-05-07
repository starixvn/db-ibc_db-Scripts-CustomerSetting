/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20240415@Eden
	Task: add rep In-House config  [#201733]
		WLMonitored_Global
		WLMonitored_Player
		WLMonitored_SMA
	DB: DBAGE-bodb02
*/
USE bodb02
GO

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix)
SELECT 1,'WLMonitored_Global',0,'RepUpdateTime',0,'AgentID|Sporttype','Repl_GetWLMonitored_Global','Repl_PutWLMonitored_Global',1000,10,60000 UNION ALL
SELECT 1,'WLMonitored_Player',0,'RepUpdateTime',0,'CustID|Sporttype','Repl_GetWLMonitored_Player','Repl_PutWLMonitored_Player',1000,10,60000 UNION ALL
SELECT 1,'WLMonitored_SMA',0,'RepUpdateTime',0,'CustID|Sporttype','Repl_GetWLMonitored_SMA','Repl_PutWLMonitored_SMA',1000,10,60000 

GO
--GRANT ALTER ON [dbo].WLMonitored_Global TO [repl_ap]
--GRANT ALTER ON [dbo].WLMonitored_Player TO [repl_ap]
--GRANT ALTER ON [dbo].WLMonitored_SMA TO [repl_ap]
--GO

