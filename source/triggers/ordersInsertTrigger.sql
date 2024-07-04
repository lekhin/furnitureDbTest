USE [furniture]
GO

/****** Object:  Trigger [order].[OrderInsert]    Script Date: 04.07.2024 21:40:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [order].[OrderInsert]
ON [order].[orders]
AFTER INSERT
AS
INSERT INTO [log].ordersLog (orderId, actionName)
SELECT id, N'Inserted'
FROM INSERTED

GO

ALTER TABLE [order].[orders] ENABLE TRIGGER [OrderInsert]
GO


