SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClrTestProc]
AS
BEGIN
    DECLARE @StartTime DATETIME2;
    DECLARE @EndTime DATETIME2;
    DECLARE @ElapsedMilliseconds INT;
    DECLARE @LoopCount INT;

    SET @LoopCount = 10000000;

    SET @StartTime = SYSDATETIME();

    INSERT INTO dbo.log_appdomains SELECT getdate() as checktime, 'START' as logmsg, * FROM sys.dm_clr_appdomains;

    INSERT INTO dbo.ProcLog(LogMsg) VALUES ('Starting, Loop=' + CAST(@LoopCount as nvarchar(10)));

    INSERT dbo.log_memory_clerks SELECT GETDATE() as checktime, *, 'START' as logmsg FROM sys.dm_os_memory_clerks
    -- WHERE type IN ('MEMORYCLERK_SQLBUFFERPOOL','MEMORYCLERK_SQLCLR');

    INSERT INTO log_perf_counters SELECT getdate() as checktime, 'START' as logmsg, counter_name, instance_name, mb = cntr_value/1024.0
    FROM sys.dm_os_performance_counters 
    -- WHERE (counter_name = N'Cursor memory usage' and instance_name <> N'_Total')
    -- OR (instance_name = N'' AND counter_name IN 
    --     (N'Connection Memory (KB)', N'Granted Workspace Memory (KB)', 
    --         N'Lock Memory (KB)', N'Optimizer Memory (KB)', N'Stolen Server Memory (KB)', 
    --         N'Log Pool Memory (KB)', N'Free Memory (KB)')
    -- ) ORDER BY mb DESC; 

    BEGIN TRY
        -- Test 함수 호출
        SELECT dbo.TestLoopConnection_CommandUsing(@LoopCount);

    END TRY
    BEGIN CATCH
        -- 에러 발생시 로깅
        INSERT INTO dbo.ProcLog(LogMsg) VALUES ('ERROR, Loop=' + CAST(@LoopCount as nvarchar(10)) + ', ' + ERROR_MESSAGE());
    END CATCH;

    -- 프로시저 종료 시간과 소요 시간 기록
    SET @EndTime = SYSDATETIME();  
    SET @ElapsedMilliseconds = DATEDIFF(MILLISECOND, @StartTime, @EndTime);

    INSERT INTO dbo.ProcLog(LogMsg) VALUES ('End, Loop=' + CAST(@LoopCount as nvarchar(10)) + ', Elapsed=' + CAST(@ElapsedMilliseconds AS nvarchar(10)) + ' ms');

    INSERT INTO dbo.log_appdomains SELECT getdate() as checktime, 'START' as logmsg, * FROM sys.dm_clr_appdomains;

    INSERT dbo.log_memory_clerks SELECT GETDATE() as checktime, *, 'END' as logmsg FROM sys.dm_os_memory_clerks
    -- WHERE type IN ('MEMORYCLERK_SQLBUFFERPOOL','MEMORYCLERK_SQLCLR');

    INSERT INTO log_perf_counters SELECT getdate() as checktime, 'END' as logmsg, counter_name, instance_name, mb = cntr_value/1024.0
    FROM sys.dm_os_performance_counters 
    -- WHERE (counter_name = N'Cursor memory usage' and instance_name <> N'_Total')
    -- OR (instance_name = N'' AND counter_name IN 
    --     (N'Connection Memory (KB)', N'Granted Workspace Memory (KB)', 
    --         N'Lock Memory (KB)', N'Optimizer Memory (KB)', N'Stolen Server Memory (KB)', 
    --         N'Log Pool Memory (KB)', N'Free Memory (KB)')
    -- ) ORDER BY mb DESC; 

END;
GO
