USE furniture;
GO
CREATE PROCEDURE DeleteFurnitureOrder
    @id INT
AS

--�������� ������
DELETE o
--SELECT o.id
FROM [order].[orders] o
WHERE o.id = @id
