USE [CarRepair]
GO

/****** Object:  Table [dbo].[Repaires]    Script Date: 22.10.2020 15:50:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Repaires](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Price] [money] NOT NULL,
	[DateStart] [date] NOT NULL,
	[DataEnd] [date] NULL,
	[IDCar] [int] NOT NULL,
	[IDMaster] [int] NOT NULL,
 CONSTRAINT [PK_Repaires] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Repaires] ADD  CONSTRAINT [DF_GetDate_DateStart]  DEFAULT (getdate()) FOR [DateStart]
GO

ALTER TABLE [dbo].[Repaires]  WITH CHECK ADD  CONSTRAINT [FK_Repaires_Cars] FOREIGN KEY([IDCar])
REFERENCES [dbo].[Cars] ([ID])
GO

ALTER TABLE [dbo].[Repaires] CHECK CONSTRAINT [FK_Repaires_Cars]
GO

ALTER TABLE [dbo].[Repaires]  WITH CHECK ADD  CONSTRAINT [FK_Repaires_Masrers] FOREIGN KEY([IDMaster])
REFERENCES [dbo].[Masters] ([ID])
GO

ALTER TABLE [dbo].[Repaires] CHECK CONSTRAINT [FK_Repaires_Masrers]
GO

