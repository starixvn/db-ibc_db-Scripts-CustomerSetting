
drop table if exists #__result 
create table #__result (dbName varchar(200), tableName varchar(200), obj_name varchar(200), type_desc varchar(200), recompileCode int)

drop table if exists #__dbList
create table #__dbList (dbName varchar(200))
insert into #__dbList(dbName)
select name from sys.databases with(nolock) where database_id > 4 and is_read_only = 0 and state_desc not in ('RESTORING')
	and name not in ('BKtableDB', 'DEL_LasDB_Archive', 'mondb')

drop table if exists #__tableList
create table #__tableList (rowId int, tableName varchar(200))

insert into #__tableList(tableName, rowId)
	    select 'ProblemAccount',1
union all select 'ProblemAccountAction',2
union all select 'ProblemAccountClassification',3
union all select 'ProblemAccountLimitDownline',4
union all select 'ProblemAccountReason',5

set nocount on
declare @__sqlcommand nvarchar(4000), @__cmd nvarchar(4000)
set @__sqlcommand = 'select distinct ''{{db}}'' as dbName, ''{{table_name}}'' as tableName, o.name as obj_name, o.type_desc, charindex(''recompile'', m.definition, 0)
from {{db}}.sys.sql_modules m with(nolock)
inner join {{db}}.sys.objects o with(nolock) on m.object_id = o.object_id
where (m.definition Like ''%.bodb02.dbo.{{table_name}}%'' 
		
			) 
		and o.name not like ''sp_MS%''
		and o.name not like ''%_xtest'' and o.name not like ''%_xpre'' and o.name not like ''%_uat1'' and o.name not like ''%_uat2'' and o.name not like ''%_uat3'' and o.name not like ''%_uat4'' '

declare @__dbName varchar(200), @__rowId int = 1, @__tableName varchar(200)
while 1 = 1 --loop db name
begin
	select top(1) @__dbName = dbName from #__dbList
	if @@rowcount = 0
		break

	set @__rowId = 1
	while 1 = 1 --loop table name
	begin
		select @__tableName = tableName from #__tableList where rowId = @__rowId
		if @@rowcount = 0
			break

		set @__rowId += 1

		set @__cmd = replace(replace(@__sqlcommand, '{{table_name}}', @__tableName), '{{db}}', @__dbName)
		print @__cmd
		insert into #__result(dbName, tableName, obj_name, type_desc, recompileCode)
		exec(@__cmd)
		
	end
	delete from #__dbList where dbName = @__dbName
	
end

select @@servername servername, r.dbName, tableName, obj_name, case when recompileCode = 0 then 'No' else 'Yes' end hasRecompile
	, case when o.name is not null then 'Yes' else 'No' end hasExecRepSP
from #__result r
left join (
	select * from DBCUST.custdb.sys.objects with(nolock)
	union all
	select * from DBCUST.bodb_licensee.sys.objects with(nolock)
) o on o.is_published = 1 and r.obj_name = o.name

