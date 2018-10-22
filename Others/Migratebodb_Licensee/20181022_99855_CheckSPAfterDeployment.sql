DECLARE @SEARCHSTRING VARCHAR(255), @notcontain Varchar(255)

SELECT @SEARCHSTRING = '_UAT4', @notcontain = ''

SELECT DISTINCT o.name AS [Object Name] 
INTO #SPList
FROM sysobjects o
	INNER JOIN syscomments c ON o.id = c.id
AND o.type = 'P'
AND o.category = 0
AND CHARINDEX(@SEARCHSTRING,c.text)> 0
AND ((CHARINDEX(@notcontain,c.text)= 0 OR CHARINDEX(@notcontain,c.text)<>0))  
AND o.name NOT LIKE '%_UAT4'

SELECT *
FROM #SPList

DROP TABLE #SPList