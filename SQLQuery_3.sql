select [dbo].TestEmpty(1000);
select physical_memory_in_use_kb, large_page_allocations_kb from sys.dm_os_process_memory;
select [dbo].TestCallGC(1);

select physical_memory_in_use_kb, large_page_allocations_kb from sys.dm_os_process_memory;
SELECT SUM (pages_in_bytes) as 'Bytes Used', type   FROM sys.dm_os_memory_objects  where type like '%CLR%' GROUP BY type ORDER BY 'Bytes Used' DESC;  

select [dbo].TestLoopConnection_CommandMultiNoUsing(100000);

select physical_memory_in_use_kb, large_page_allocations_kb from sys.dm_os_process_memory;
SELECT SUM (pages_in_bytes) as 'Bytes Used', type   FROM sys.dm_os_memory_objects  where type like '%CLR%' GROUP BY type ORDER BY 'Bytes Used' DESC;  
select [dbo].TestLoopConnection_CommandMultiNoUsing(100000);

select physical_memory_in_use_kb, large_page_allocations_kb from sys.dm_os_process_memory;
SELECT SUM (pages_in_bytes) as 'Bytes Used', type   FROM sys.dm_os_memory_objects  where type like '%CLR%' GROUP BY type ORDER BY 'Bytes Used' DESC;  
select [dbo].TestLoopConnection_CommandMultiNoUsing(100000);

select physical_memory_in_use_kb, large_page_allocations_kb from sys.dm_os_process_memory;
SELECT SUM (pages_in_bytes) as 'Bytes Used', type   FROM sys.dm_os_memory_objects  where type like '%CLR%' GROUP BY type ORDER BY 'Bytes Used' DESC;  
select [dbo].TestLoopConnection_CommandMultiNoUsing(100000);

select physical_memory_in_use_kb, large_page_allocations_kb from sys.dm_os_process_memory;
SELECT SUM (pages_in_bytes) as 'Bytes Used', type   FROM sys.dm_os_memory_objects  where type like '%CLR%' GROUP BY type ORDER BY 'Bytes Used' DESC;  
select [dbo].TestLoopConnection_CommandMultiNoUsing(100000);

select physical_memory_in_use_kb, large_page_allocations_kb from sys.dm_os_process_memory;
SELECT SUM (pages_in_bytes) as 'Bytes Used', type   FROM sys.dm_os_memory_objects  where type like '%CLR%' GROUP BY type ORDER BY 'Bytes Used' DESC;  
