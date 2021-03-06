USE [event_db]
GO
/****** Object:  StoredProcedure [dbo].[usp_dashboard]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_dashboard]
as
Begin
	select count(*) as [Count] from mstStudent
	union all
	select count(*) as [Count] from mstEvent
	union all
	select count(*) as [Count] from trnParticipation
End
GO
/****** Object:  StoredProcedure [dbo].[usp_generate_certificate]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_generate_certificate]
(
	@iParticipationID [int]
)
as
Begin
		select 
				p.[ParticipationID], s.[Name], s.[MobileNo], e.[Name] as [Event],
				et.[Description] as [EventType],
				format(e.[StartDate],'dd-MMM-yyyy') as [StartDate],
				format(e.[EndDate],'dd-MMM-yyyy') as [EndDate],
				d.[DepartmentName], y.[Description] as [AcademicYear],
				art.[Description] as [Status]
			from 
				trnParticipation p
			inner join mstStudent s
				on p.[StudentID] = s.[StudentID]
			inner join mstEvent e
				on p.[EventID] = e.[EventID]
			inner join Auto_EventType et
				on e.[EventTypeID] = et.[EventTypeID]
			inner join Auto_Department d
				on e.[DepartmentID] = d.[DepartmentID]
			inner join Auto_Year y
				on s.[YearID] = y.[YearID]
			inner join Auto_ApproveRejectType art
				on p.[ApproveRejectTypeID] = art.[ApproveRejectTypeID]
			where p.[ParticipationID] = @iParticipationID
End
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCrystalReportName]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_GetCrystalReportName]
(
	@iParticipationID [int]
	/* usp_GetCrystalReportName 50001*/
)
as
Begin
	select 
		cm.[CrystalReport] 
	from 
		mstEvent_CertificateMapping cm
	Inner Join mstEvent e
		on e.[EventTypeID] = cm.[EventTypeID]
	Inner Join trnParticipation t
		on t.[EventID] = e.[EventID]
	where 
		t.[ParticipationID] = @iParticipationID
End

GO
/****** Object:  StoredProcedure [dbo].[usp_save_trnParticipation]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_save_trnParticipation]
(	
	@iParticipationID [int],
	@iStudentID [int], 
	@iEventID [int],
	@iApproveRejectTypeID [tinyint]
	/* usp_save_trnParticipation 0,212,1,1 */
)
as
Begin
	declare @Status [smallint] = 200 , @Message [nvarchar](50), @dParticipationID [varchar](max)

	if(@iParticipationID = 0)
		Begin
			if exists (
				select top 1 [ParticipationID] 
				from trnParticipation 
				where [StudentID] = @iStudentID
				and [EventID] = @iEventID
			)
				Begin
					set @Status = 409;
					set @Message = 'You have already participated in this event'
				End
			else
				Begin

					insert into trnParticipation values (@iStudentID,@iEventID,@iApproveRejectTypeID,0)

					set @dParticipationID = SCOPE_IDENTITY()

					update trnParticipation
					set [ParticipationHash] = HASHBYTES('SHA',CONVERT(VARCHAR(50),@dParticipationID))
					where [ParticipationID] = @dParticipationID

					select @dParticipationID
					set @Status = 200;
					set @Message = 'You have successfully enrolled for this event'

					SELECT HASHBYTES('SHA',CONVERT(VARCHAR(50),@dParticipationID)) 
				End
		End
	else
		Begin
			set @Status = 200;
			set @Message = 'Status updated'
			update trnParticipation
			set [ApproveRejectTypeID] = @iApproveRejectTypeID
			where 
				[ParticipationID] = @iParticipationID
		End

	select @Status as [Status], @Message as [Message]
End
GO
/****** Object:  StoredProcedure [dbo].[usp_select_mstEvent]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_select_mstEvent]
(
	@iEventID [int]
)
as
Begin

	if(@iEventID <> 0)
		Begin
			select 
				e.[EventID], e.[Name], e.[Description], format(e.[StartDate],'dd-MMM-yyyy') as [StartDate], 
				format(e.[EndDate],'dd-MMM-yyyy') as [EndDate], e.[DepartmentID], e.[EventTypeID]
			from 
				mstEvent e
			where e.[EventID] = @iEventID
		End
	else
		Begin
			select 
				e.[EventID], e.[Name], e.[Description], format(e.[StartDate],'dd-MMM-yyyy') as [StartDate], 
				format(e.[EndDate],'dd-MMM-yyyy') as [EndDate],
				ad.[DepartmentName], et.[Description] as [EventType]
			from 
				mstEvent e
			Inner Join Auto_Department ad
				on e.[DepartmentID] = ad.[DepartmentID]
			Inner Join Auto_EventType et 
				on e.[EventTypeID] = et.[EventTypeID]
		End
End
GO
/****** Object:  StoredProcedure [dbo].[usp_select_mstEvent_upcoming]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_select_mstEvent_upcoming]
(
	@iStudentID [int]
	/* usp_select_mstEvent_upcoming 3 */
)
as
Begin
	select 
		e.[EventID], e.[Name], e.[Description], format(e.[StartDate],'dd-MMM-yyyy') as [StartDate], 
		format(e.[EndDate],'dd-MMM-yyyy') as [EndDate], ad.[DepartmentName] as [Department],
		et.[Description] as [EventType]
	from 
		mstEvent e
	Inner Join Auto_Department ad
		on e.[DepartmentID] = ad.[DepartmentID]
	Inner Join mstStudent s
		on ((s.[DepartmentID] = e.[DepartmentID])
		or (e.[DepartmentID] = 0))
	Inner Join Auto_EventType et 
		on e.[EventTypeID] = et.[EventTypeID]
	where convert(date,getdate()) < e.[StartDate]
		and s.[StudentID] = @iStudentID
		--and ((e.[DepartmentID] = 1) or (e.[DepartmentID] = ad.[DepartmentID]))
End
GO
/****** Object:  StoredProcedure [dbo].[usp_select_mstStudent]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_select_mstStudent]
(
	@iStudentID [int]
)
as
Begin

	if(@iStudentID <> 0)
		Begin
			select 
				[StudentID], [Name], [EmailID], [Password], [MobileNo], [DepartmentID],
				[YearID]
			from 
				mstStudent 
			where [StudentID] = @iStudentID
		End
	else
		Begin
			select 
				s.[StudentID], s.[Name], s.[EmailID], s.[Password], s.[MobileNo],
				ad.[DepartmentName], y.[Description] as [AcademicYear]
			from 
				mstStudent s
			Inner Join Auto_Department ad
				on s.[DepartmentID] = ad.[DepartmentID]
			Inner Join Auto_Year y 
				on s.[YearID] = y.[YearID]
		End
End
GO
/****** Object:  StoredProcedure [dbo].[usp_select_trnParticipation]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_select_trnParticipation]
(
	@iLoginUserID [int]
	/* usp_select_trnParticipation 2 */
)
as
Begin
	if (@iLoginUserID = 0)
		Begin
			select 
				p.[ParticipationID], s.[Name], s.[MobileNo], e.[Name] as [Event],
				et.[Description] as [EventType],
				format(e.[StartDate],'dd-MMM-yyyy') as [StartDate],
				format(e.[EndDate],'dd-MMM-yyyy') as [EndDate],
				d.[DepartmentName], y.[Description] as [AcademicYear]
			from 
				trnParticipation p
			inner join mstStudent s
				on p.[StudentID] = s.[StudentID]
			inner join mstEvent e
				on p.[EventID] = e.[EventID]
			inner join Auto_EventType et
				on e.[EventTypeID] = et.[EventTypeID]
			inner join Auto_Department d
				on e.[DepartmentID] = d.[DepartmentID]
			inner join Auto_Year y
				on s.[YearID] = y.[YearID]
			where p.[ApproveRejectTypeID] = 1
		End
	else
		Begin
			select 
				p.[ParticipationID], s.[Name], s.[MobileNo], e.[Name] as [Event],
				et.[Description] as [EventType],
				format(e.[StartDate],'dd-MMM-yyyy') as [StartDate],
				format(e.[EndDate],'dd-MMM-yyyy') as [EndDate],
				d.[DepartmentName], y.[Description] as [AcademicYear],
				art.[Description] as [Status]
			from 
				trnParticipation p
			inner join mstStudent s
				on p.[StudentID] = s.[StudentID]
			inner join mstEvent e
				on p.[EventID] = e.[EventID]
			inner join Auto_EventType et
				on e.[EventTypeID] = et.[EventTypeID]
			inner join Auto_Department d
				on e.[DepartmentID] = d.[DepartmentID]
			inner join Auto_Year y
				on s.[YearID] = y.[YearID]
			inner join Auto_ApproveRejectType art
				on p.[ApproveRejectTypeID] = art.[ApproveRejectTypeID]
			where s.[StudentID] = @iLoginUserID
					--p.[ApproveRejectTypeID] = 2
				  --and s.[StudentID] = @iLoginUserID
		End
End
GO
/****** Object:  Table [dbo].[Auto_ApproveRejectType]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Auto_ApproveRejectType](
	[ApproveRejectTypeID] [tinyint] NULL,
	[Description] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Auto_Department]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auto_Department](
	[DepartmentID] [tinyint] NULL,
	[DepartmentName] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Auto_EventType]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auto_EventType](
	[EventTypeID] [tinyint] NULL,
	[Description] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Auto_Year]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auto_Year](
	[YearID] [tinyint] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mstAdmin]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mstAdmin](
	[Username] [varchar](100) NULL,
	[Password] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mstEvent]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mstEvent](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](1000) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[DepartmentID] [tinyint] NULL,
	[EventTypeID] [tinyint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mstEvent_CertificateMapping]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mstEvent_CertificateMapping](
	[EventCertificateMappingID] [int] IDENTITY(1,1) NOT NULL,
	[EventTypeID] [tinyint] NULL,
	[CrystalReport] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mstStudent]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mstStudent](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[EmailID] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[MobileNo] [varchar](100) NULL,
	[DepartmentID] [tinyint] NULL,
	[YearID] [tinyint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[trnParticipation]    Script Date: 05-03-2022 15:38:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[trnParticipation](
	[ParticipationID] [int] IDENTITY(50000,1) NOT NULL,
	[StudentID] [int] NULL,
	[EventID] [int] NULL,
	[ApproveRejectTypeID] [tinyint] NULL,
	[ParticipationHash] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Auto_ApproveRejectType] ([ApproveRejectTypeID], [Description]) VALUES (1, N'Pending')
INSERT [dbo].[Auto_ApproveRejectType] ([ApproveRejectTypeID], [Description]) VALUES (2, N'Approved')
INSERT [dbo].[Auto_ApproveRejectType] ([ApproveRejectTypeID], [Description]) VALUES (3, N'Rejected')
INSERT [dbo].[Auto_Department] ([DepartmentID], [DepartmentName]) VALUES (0, N'All')
INSERT [dbo].[Auto_Department] ([DepartmentID], [DepartmentName]) VALUES (1, N'IT')
INSERT [dbo].[Auto_Department] ([DepartmentID], [DepartmentName]) VALUES (2, N'Comps')
INSERT [dbo].[Auto_Department] ([DepartmentID], [DepartmentName]) VALUES (3, N'Electronics')
INSERT [dbo].[Auto_EventType] ([EventTypeID], [Description]) VALUES (1, N'Webinar/Seminar')
INSERT [dbo].[Auto_EventType] ([EventTypeID], [Description]) VALUES (2, N'Competitions')
INSERT [dbo].[Auto_EventType] ([EventTypeID], [Description]) VALUES (3, N'Workshops')
INSERT [dbo].[Auto_Year] ([YearID], [Description]) VALUES (1, N'FE')
INSERT [dbo].[Auto_Year] ([YearID], [Description]) VALUES (2, N'SE')
INSERT [dbo].[Auto_Year] ([YearID], [Description]) VALUES (3, N'TE')
INSERT [dbo].[Auto_Year] ([YearID], [Description]) VALUES (4, N'BE')
INSERT [dbo].[mstAdmin] ([Username], [Password]) VALUES (N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[mstEvent] ON 

INSERT [dbo].[mstEvent] ([EventID], [Name], [Description], [StartDate], [EndDate], [DepartmentID], [EventTypeID]) VALUES (2, N'Test 1', N'Commanding deep respect across Europe and beyond, DGTLs underground blend of house and techno are at home in the NDSM Docklands on Amsterdams waterfront, as well as Barcelonas infamous beachside Parc del Fòrum, making the brand an integral part of both citys electronic music calendars.', CAST(0x0000ADC700000000 AS DateTime), CAST(0x0000ADCA00000000 AS DateTime), 0, 2)
INSERT [dbo].[mstEvent] ([EventID], [Name], [Description], [StartDate], [EndDate], [DepartmentID], [EventTypeID]) VALUES (3, N'Test 2', N'Commanding deep respect across Europe and beyond, DGTLs underground blend of house and techno are at home in the NDSM Docklands on Amsterdams waterfront, as well as Barcelonas infamous beachside Parc del Fòrum, making the brand an integral part of both citys electronic music calendars.', CAST(0x0000AE210115445A AS DateTime), CAST(0x0000AE230115445A AS DateTime), 0, 3)
INSERT [dbo].[mstEvent] ([EventID], [Name], [Description], [StartDate], [EndDate], [DepartmentID], [EventTypeID]) VALUES (4, N'Test 3', N'Test', CAST(0x0000AE2100000000 AS DateTime), CAST(0x0000AE4E00000000 AS DateTime), 3, 1)
SET IDENTITY_INSERT [dbo].[mstEvent] OFF
SET IDENTITY_INSERT [dbo].[mstEvent_CertificateMapping] ON 

INSERT [dbo].[mstEvent_CertificateMapping] ([EventCertificateMappingID], [EventTypeID], [CrystalReport]) VALUES (1, 1, N'CrystalReport.rpt')
INSERT [dbo].[mstEvent_CertificateMapping] ([EventCertificateMappingID], [EventTypeID], [CrystalReport]) VALUES (2, 2, N'CrystalReport2.rpt')
INSERT [dbo].[mstEvent_CertificateMapping] ([EventCertificateMappingID], [EventTypeID], [CrystalReport]) VALUES (3, 3, N'CrystalReport3.rpt')
SET IDENTITY_INSERT [dbo].[mstEvent_CertificateMapping] OFF
SET IDENTITY_INSERT [dbo].[mstStudent] ON 

INSERT [dbo].[mstStudent] ([StudentID], [Name], [EmailID], [Password], [MobileNo], [DepartmentID], [YearID]) VALUES (2, N'Charan', N'charan@gmail.com', N'123456', N'9769559943', 1, 1)
INSERT [dbo].[mstStudent] ([StudentID], [Name], [EmailID], [Password], [MobileNo], [DepartmentID], [YearID]) VALUES (3, N'Nipul', N'nipul@gmail.com', N'123456', N'9769559943', 3, 3)
INSERT [dbo].[mstStudent] ([StudentID], [Name], [EmailID], [Password], [MobileNo], [DepartmentID], [YearID]) VALUES (4, N'Test', N'charanbirdi10@gmail.com', N'sXIpOr', N'8769008876', 1, 1)
INSERT [dbo].[mstStudent] ([StudentID], [Name], [EmailID], [Password], [MobileNo], [DepartmentID], [YearID]) VALUES (5, N'Test', N'charanbirdi10@gmail.com', N'M0XDsP', N'8769008876', 1, 1)
SET IDENTITY_INSERT [dbo].[mstStudent] OFF
SET IDENTITY_INSERT [dbo].[trnParticipation] ON 

INSERT [dbo].[trnParticipation] ([ParticipationID], [StudentID], [EventID], [ApproveRejectTypeID], [ParticipationHash]) VALUES (50000, 5, 2, 1, N'ÂÔÅE/YÏõ—=ÙÐù_‹TÊÙ•')
SET IDENTITY_INSERT [dbo].[trnParticipation] OFF
