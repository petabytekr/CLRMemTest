
select survived_memory_kb, total_allocated_memory_kb, * from sys.dm_clr_appdomains;

select * from sys.dm_os_memory_clerks where type='MEMORYCLERK_SQLCLR';

SELECT pages_kb, virtual_memory_committed_kb, shared_memory_committed_kb, awe_allocated_kb, virtual_memory_reserved_kb, shared_memory_reserved_kb, page_size_in_bytes FROM sys.dm_os_memory_clerks where type = 'MEMORYCLERK_SQLCLR';


SELECT memory_node_id, type, name, pages_kb, virtual_memory_committed_kb, virtual_memory_reserved_kb, awe_allocated_kb,
shared_memory_committed_kb, shared_memory_reserved_kb, page_size_in_bytes
FROM sys.dm_os_memory_clerks
where type = 'MEMORYCLERK_SQLCLR';

-- what's happening inside my buffer pool?
SELECT counter_name, instance_name, mb = cntr_value/1024.0
  FROM sys.dm_os_performance_counters 
  WHERE (counter_name = N'Cursor memory usage' and instance_name <> N'_Total')
  OR (instance_name = N'' AND counter_name IN 
       (N'Connection Memory (KB)', N'Granted Workspace Memory (KB)', 
        N'Lock Memory (KB)', N'Optimizer Memory (KB)', N'Stolen Server Memory (KB)', 
        N'Log Pool Memory (KB)', N'Free Memory (KB)')
  ) ORDER BY mb DESC;

  -- which db's are using memory and how much. 
SELECT
    (CASE WHEN ([database_id] = 32767)
        THEN N'Resource Database'
        ELSE DB_NAME ([database_id]) END) AS [DatabaseName],
    COUNT (*) * 8 / 1024 AS [MBUsed],
    SUM (CAST ([free_space_in_bytes] AS BIGINT)) / (1024 * 1024) AS [MBEmpty]
FROM sys.dm_os_buffer_descriptors
GROUP BY [database_id];



select physical_memory_in_use_kb, large_page_allocations_kb from sys.dm_os_process_memory;
select * from sys.dm_os_process_memory;


select * from sys.dm_os_memory_objects;

SELECT SUM (pages_in_bytes) as 'Bytes Used', type   FROM sys.dm_os_memory_objects  where type like '%CLR%' GROUP BY type ORDER BY 'Bytes Used' DESC;  

SELECT * FROM sys.dm_os_memory_objects WHERE type = 'MEMOBJ_SQLCLR_CLR_EE';


  