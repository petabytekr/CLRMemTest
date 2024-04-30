SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log_memory_clerks](
	[checktime] [datetime] NOT NULL,
	[memory_clerk_address] [varbinary](8) NOT NULL,
	[type] [nvarchar](60) NOT NULL,
	[name] [nvarchar](256) NOT NULL,
	[memory_node_id] [smallint] NOT NULL,
	[pages_kb] [bigint] NOT NULL,
	[virtual_memory_reserved_kb] [bigint] NOT NULL,
	[virtual_memory_committed_kb] [bigint] NOT NULL,
	[awe_allocated_kb] [bigint] NOT NULL,
	[shared_memory_reserved_kb] [bigint] NOT NULL,
	[shared_memory_committed_kb] [bigint] NOT NULL,
	[page_size_in_bytes] [bigint] NOT NULL,
	[page_allocator_address] [varbinary](8) NOT NULL,
	[host_address] [varbinary](8) NOT NULL,
	[parent_memory_broker_type] [nvarchar](60) NULL,
	[logmsg] [nvarchar](256) NULL
) ON [PRIMARY]
GO
