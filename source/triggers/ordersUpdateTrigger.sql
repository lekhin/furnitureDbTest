USE [furniture]
GO

/****** Object:  Trigger [order].[OrderUpdate]    Script Date: 04.07.2024 21:40:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [order].[OrderUpdate]
ON [order].[orders]
AFTER UPDATE
AS
INSERT INTO [log].ordersLog (orderId, actionName)
SELECT id, N'Updated'
FROM INSERTED

GO

ALTER TABLE [order].[orders] ENABLE TRIGGER [OrderUpdate]
GO


