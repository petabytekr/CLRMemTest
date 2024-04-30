using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
    public static SqlString TestEmpty(SqlInt32 loopCount)
    {
        return "OK : Loop=" + loopCount;
    }

    [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
    public static SqlString TestEmptyAlloc(SqlInt32 loopCount)
    {
        Random random = new Random();
        byte[] block = new byte[loopCount.Value];

        for (int i = 0; i < block.Length; i++)
        {
            block[i] = (byte)random.Next();
        }

        return "OK : Random=" + block.GetHashCode();
    }

    [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
    public static SqlString TestCallGC(SqlInt32 loopCount)
    {
        // Call GC
        GC.Collect();
        return "OK : GC";
    }

    [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
    public static SqlString TestGetTotalMemory(SqlInt32 loopCount)
    {
        long result = GC.GetTotalMemory(loopCount == 0 ? false : true);
        return "OK : GetTotalMemory=" + result;
    }

    [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
    public static SqlString TestLoopConnection(SqlInt32 loopCount)
    {
        int ret = 0;

        for (int i = 0; i < loopCount; i++)
        {
            using (SqlConnection conn = new SqlConnection("context connection=true"))
            {
                conn.Open();

                ret += i;
            }
        }

        return "OK : Connections=" + ret.ToString();
    }

    [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
    public static SqlString TestLoopConnection_CommandNoUsing(SqlInt32 loopCount)
    {
        int ret = 0;

        for (int i = 0; i < loopCount; i++)
        {
            using (SqlConnection conn = new SqlConnection("context connection=true"))
            {
                conn.Open();

                SqlCommand sqlCommand = conn.CreateCommand();

                string sql = "select 1 as v;";
                sqlCommand.Connection = conn;
                sqlCommand.CommandText = sql;


                using (SqlDataReader reader = sqlCommand.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        int v = reader.GetInt32(0);

                        ret += v;
                    }
                }

                // Intentionally not using Dispose
            }
        }

        return "OK : Loop=" + ret.ToString();
    }

    [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
    public static SqlString TestLoopConnection_CommandMultiNoUsing(SqlInt32 loopCount)
    {
        int ret = 0;

        for (int i = 0; i < loopCount; i++)
        {
            using (SqlConnection conn = new SqlConnection("context connection=true"))
            {
                conn.Open();

                SqlCommand sqlCommand = conn.CreateCommand();
                sqlCommand.Connection = conn;

                string sql = "select 1 as v;";
                sqlCommand.CommandText = sql;

                using (SqlDataReader reader = sqlCommand.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        int v = reader.GetInt32(0);

                        ret += v;
                    }
                }

                string sql2 = "select 2 as v;";
                sqlCommand.CommandText = sql2;

                using (SqlDataReader reader = sqlCommand.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        int v = reader.GetInt32(0);

                        ret += v;
                    }
                }

                // Intentionally not using Dispose
            }
        }

        return "OK : Loop=" + ret.ToString();
    }

    [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
    public static SqlString TestLoopConnection_CommandUsing(SqlInt32 loopCount)
    {
        int ret = 0;
        string sql = "select 1 as v;";


        for (int i = 0; i < loopCount; i++)
        {
            using (SqlConnection conn = new SqlConnection("context connection=true"))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int v = reader.GetInt32(0);

                            ret += v;
                        }
                    }

                }

            }
        }

        return "OK : Loop=" + ret.ToString();
    }

    [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
    public static SqlString TestLoopConnection_CommandMultiUsing(SqlInt32 loopCount)
    {
        int ret = 0;
        string sql = "select 1 as v;";
        string sql2 = "select 2 as v;";


        for (int i = 0; i < loopCount; i++)
        {
            using (SqlConnection conn = new SqlConnection("context connection=true"))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int v = reader.GetInt32(0);

                            ret += v;
                        }
                    }

                }

                using (SqlCommand cmd = new SqlCommand(sql2, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int v = reader.GetInt32(0);

                            ret += v;
                        }
                    }

                }

            }
        }

        return "OK : Loop=" + ret.ToString();
    }

}

