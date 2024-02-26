/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240108@Luke
	Task: NAP - Virtual rate - Enhance VR [Redmine: #194939]
	DB: DBLOG/bodb_CustomerLog
*/

UPDATE u 
SET u.trackingvalue2 = REPLACE(trackingvalue2, ' <s', '><s')
FROM UserLog_RunSP u WITH (ROWLOCK, UPDLOCK)
WHERE ActionID IN (95116,95117,95118,801,2803,2804,2805,2800)
	and logdate > '2024-02-25'
	and TrackingValue2 like '% <s%'
