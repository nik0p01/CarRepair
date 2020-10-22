USE [CarRepair]
GO

/****** Object:  Table [dbo].[RepairProblem]    Script Date: 22.10.2020 15:50:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RepairProblem](
	[IDRepair] [int] NOT NULL,
	[IDProblem] [int] NOT NULL,
 CONSTRAINT [PK_RepairProblem] PRIMARY KEY CLUSTERED 
(
	[IDRepair] ASC,
	[IDProblem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RepairProblem]  WITH CHECK ADD  CONSTRAINT [FK_RepairProblem_Problems] FOREIGN KEY([IDProblem])
REFERENCES [dbo].[Problems] ([ID])
GO

ALTER TABLE [dbo].[RepairProblem] CHECK CONSTRAINT [FK_RepairProblem_Problems]
GO

ALTER TABLE [dbo].[RepairProblem]  WITH CHECK ADD  CONSTRAINT [FK_RepairProblem_Repaires] FOREIGN KEY([IDRepair])
REFERENCES [dbo].[Repaires] ([ID])
GO

ALTER TABLE [dbo].[RepairProblem] CHECK CONSTRAINT [FK_RepairProblem_Repaires]
GO

