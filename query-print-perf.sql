/*
select top 200 * from log_memory_clerks
--where type = 'MEMORYCLERK_SQLCLR' and logmsg = 'START' and memory_node_id = 0
where type = 'MEMORYCLERK_SQLBUFFERPOOL' and logmsg = 'START' and memory_node_id = 0
order by checktime
;
*/

/*
select top 200 * from log_perf_counters
--where counter_name = 'Stolen Server Memory (KB)'
-- where counter_name = 'Free Memory (KB)' and logmsg = 'START'
--where logmsg = 'START' --and counter_name = 'Log Pool Memory (KB)                                                                                                            '
order by checktime desc
;
*/

WITH cte AS (
    SELECT 
        checktime,
        counter_name,
        mb
    FROM 
        log_perf_counters
    WHERE 
        logmsg = 'START'
        AND counter_name IN ('Stolen Server Memory (KB)', 'Free Memory (KB)')
)
SELECT 
    c.checktime,
    MAX(CASE WHEN c.counter_name = 'Free Memory (KB)' THEN c.mb END) AS 'Free Memory (MB)',
    MAX(CASE WHEN c.counter_name = 'Stolen Server Memory (KB)' THEN c.mb END) AS 'Stolen Server Memory (MB)'
FROM 
    cte c
GROUP BY 
    c.checktime
ORDER BY 
    c.checktime DESC;
