-- 함수 삭제
DROP FUNCTION IF EXISTS [dbo].TestEmpty;
DROP FUNCTION IF EXISTS [dbo].TestCallGC;
DROP FUNCTION IF EXISTS [dbo].TestLoopConnection;
DROP FUNCTION IF EXISTS [dbo].TestLoopConnection_CommandNoUsing;
DROP FUNCTION IF EXISTS [dbo].TestLoopConnection_CommandMultiNoUsing;
DROP FUNCTION IF EXISTS [dbo].TestLoopConnection_CommandUsing;
DROP FUNCTION IF EXISTS [dbo].TestLoopConnection_CommandMultiUsing;
DROP FUNCTION IF EXISTS [dbo].TestEmptyAlloc;


-- 어셈블리 삭제 (필요한 경우)
DROP ASSEMBLY IF EXISTS [CLRMemTest];
