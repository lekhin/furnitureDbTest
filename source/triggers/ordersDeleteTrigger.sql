USE [furniture]
GO

/****** Object:  Trigger [order].[OrderDelete]    Script Date: 04.07.2024 21:39:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [order].[OrderDelete]
ON [order].[orders]
AFTER DELETE
AS
INSERT INTO [log].ordersLog (orderId, actionName)
SELECT id, N'Deleted'
FROM DELETED

GO

ALTER TABLE [order].[orders] ENABLE TRIGGER [OrderDelete]
GO


