SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log_perf_counters](
	[checktime] [datetime] NOT NULL,
	[logmsg] [varchar](5) NOT NULL,
	[counter_name] [nchar](128) NOT NULL,
	[instance_name] [nchar](128) NULL,
	[mb] [numeric](26, 6) NULL
) ON [PRIMARY]
GO
