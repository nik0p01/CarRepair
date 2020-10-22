USE [CarRepair]
GO

/****** Object:  Table [dbo].[Addresses]    Script Date: 22.10.2020 15:48:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Addresses](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](50) NOT NULL,
	[IDOwner] [int] NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Owners] FOREIGN KEY([IDOwner])
REFERENCES [dbo].[Owners] ([ID])
GO

ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Owners]
GO

