SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log_appdomains](
	[checktime] [datetime] NOT NULL,
	[logmsg] [varchar](100) NOT NULL,
	[appdomain_address] [varbinary](8) NULL,
	[appdomain_id] [int] NULL,
	[appdomain_name] [nvarchar](386) NULL,
	[creation_time] [datetime] NULL,
	[db_id] [int] NULL,
	[user_id] [int] NULL,
	[state] [nvarchar](128) NULL,
	[strong_refcount] [int] NULL,
	[weak_refcount] [int] NULL,
	[cost] [int] NULL,
	[value] [int] NULL,
	[compatibility_level] [int] NULL,
	[total_processor_time_ms] [bigint] NULL,
	[total_allocated_memory_kb] [bigint] NULL,
	[survived_memory_kb] [bigint] NULL
) ON [PRIMARY]
GO
