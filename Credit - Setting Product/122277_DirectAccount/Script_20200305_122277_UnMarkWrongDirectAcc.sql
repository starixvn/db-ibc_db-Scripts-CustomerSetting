/*
	Created: 20200305@Eden
	Task: Unmark as wrong Direct account from CustDirectAccount table
	Redmine: #122277
	DB: DBCust/CustDB
*/

DELETE a
FROM CustDirectAccount a WITH(ROWLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON a.CustID=c.CustID
WHERE c.Username IN(  'OLD-RM'
					, '339BHK'
					, '271SD'
					, '009RM'
					, 'M195RMB'
					, 'M46RM'
					, 'M68RMB'
					, 'MJHK'
					, 'MMYBSD'
					, 'MYKRM'
					, 'S33R91'
					, 'ATUS'
					, 'AWC'
					, 'BMW1'
					, '7899HK'
					)


