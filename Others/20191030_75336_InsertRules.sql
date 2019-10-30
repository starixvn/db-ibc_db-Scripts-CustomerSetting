/*
	Created: 20191030@Winnie
	DB: DBCHECK/CheckResultDB
	Task: Insert Rules
*/

INSERT INTO Rule_Credit(RuleID,RuleName,ModifiedDate)
SELECT 401	,'Super level: custid <> sreccomend',GETDATE() UNION ALL
SELECT 402	,'Master level: custid <> mrecommend',GETDATE() UNION ALL
SELECT 403	,'Master level: custid=srecommend',GETDATE() UNION ALL
SELECT 404	,'Master level: Master has wrong srecommend ( roleid of srecommend<>4 )',GETDATE() UNION ALL
SELECT 405	,'Master level: custid <> mrecommend',GETDATE() UNION ALL
SELECT 406	,'Agent  level: custid=srecommend OR custid=mrecommend',GETDATE() UNION ALL
SELECT 407	,'Agent  level: Agent has wrong srecommend ( roleid of srecommend<>4 )',GETDATE() UNION ALL
SELECT 408	,'Agent  level: Agent has wrong mrecommend ( roleid of mrecommend<>3 )',GETDATE() UNION ALL
SELECT 409	,'Agent level: srecommend of master <> srecommend of super',GETDATE() UNION ALL
SELECT 410	,'Member level: custid=srecommend OR custid=mrecommend OR custid=recommend' ,GETDATE() UNION ALL
SELECT 411	,'Member level: Member has wrong srecommend ( roleid of srecommend<>4 )' ,GETDATE() UNION ALL
SELECT 412	,'Member level: Member has wrong mrecommend ( roleid of mrecommend<>3 )' ,GETDATE() UNION ALL
SELECT 413	,'Member level: Member has wrong recommend ( roleid of recommend<>2 )' ,GETDATE() UNION ALL
SELECT 414	,'Member level: srecommend of master <> srecommend of super OR srecommend of agent <> srecommend of master OR srecommend of agent <> srecommend of super' ,GETDATE() UNION ALL
SELECT 415	,'Member level: mrecommend of agent <> mrecommend of master' ,GETDATE() UNION ALL
SELECT 416	,'Customer.recommend<>Custinfo.recommend OR Customer.mrecommend<>Custinfo.mrecommend OR Customer.srecommend<>Custinfo.srecommend' ,GETDATE() UNION ALL
SELECT 417	,'Super existed in Custsuper' ,GETDATE() UNION ALL
SELECT 418	,'Master existed in Custmaster' ,GETDATE() UNION ALL
SELECT 419	,'Agent existed in CustAgent' ,GETDATE() UNION ALL
SELECT 420	,'Duplicate Username2' ,GETDATE() UNION ALL
SELECT 421	,'Master level: Currency <> Currency of super' ,GETDATE() UNION ALL
SELECT 422	,'Agent level: Currency <> Currency of super OR Currency <> Currency of master' ,GETDATE() UNION ALL
SELECT 423	,'Member level: Currency <> Currency of super OR Currency <> Currency of master OR Currency <> Currency of agent' ,GETDATE() UNION ALL
SELECT 424	,'Check dummy account is existed in acc_custdirect' ,GETDATE() UNION ALL
SELECT 425	,'Check direct account is existed in CustDirectAccount' ,GETDATE() 