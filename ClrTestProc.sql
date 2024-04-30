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

    INSERT INTO dbo.ProcLog(LogMsg) VALUES ('Starting, Loop=' + CAST(@LoopCount as nvarchar(10)));

    BEGIN TRY
        -- Test 함수 호출
        SELECT dbo.TestLoopConnection_CommandNoUsing(@LoopCount);

    END TRY
    BEGIN CATCH
        -- 에러 발생시 로깅
        INSERT INTO dbo.ProcErrorLog (ErrorNumber, ErrorMessage, ErrorProcedure, ErrorLine, ErrorTime)
        VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_LINE(), SYSDATETIME());
    END CATCH;

    -- 프로시저 종료 시간과 소요 시간 기록
    SET @EndTime = SYSDATETIME();  
    SET @ElapsedMilliseconds = DATEDIFF(MILLISECOND, @StartTime, @EndTime);

    INSERT INTO dbo.ProcLog(LogMsg) VALUES ('End, Loop=' + CAST(@LoopCount as nvarchar(10)) + ', Elapsed=' + CAST(@ElapsedMilliseconds AS nvarchar(10)) + ' ms');

END;
GO
