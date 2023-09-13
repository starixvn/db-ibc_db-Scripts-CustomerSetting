
CREATE TABLE #TempTbl (Ref_SP VARCHAR(max) , referenced_entity_name VARCHAR(max) ) 



INSERT INTO #TempTbl (Ref_SP , referenced_entity_name)

-- Collect DisableEsports

SELECT distinct OBJECT_NAME(referencing_id) AS [Ref_SP] , referenced_entity_name
FROM sys.sql_expression_dependencies with(nolock)
WHERE referenced_entity_name  like ('DisableEsports')
  and OBJECT_NAME(referencing_id) not like '%UAT_'
  and OBJECT_NAME(referencing_id) not like '%xtest'
  and OBJECT_NAME(referencing_id) not like '%xpre'
  and OBJECT_NAME(referencing_id) not like '%test'
  and OBJECT_NAME(referencing_id) not like '%test_'

UNION
select object_name(object_id) Ref_SP, 'DisableEsports' as referenced_entity_name
from sys.sql_modules
where definition like '%DisableEsports%'
and object_name(object_id) not like '%UAT_'
and object_name(object_id) not like '%xtest'
and object_name(object_id) not like '%xpre'
and object_name(object_id) not like '%test'
and object_name(object_id) not like '%test_'

select * from #TempTbl

DROP TABLE #TempTbl
