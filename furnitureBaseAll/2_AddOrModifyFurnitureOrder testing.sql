
truncate table [staff].[departments]
truncate table [order].orders
delete from [staff].persons


;DECLARE @json NVARCHAR(max)
SET @json = 
N'{
"furnitureOrderId": 123,
"applicant": {
"id": "6E4AD64E-43D0-4096-8E03-58952E5B4221",
"name": "�������",
"surname": "������",
"department": "����������� ��"
},
"applicationReason": "�������",
"coordinatingManager": {
"id": "FB6B6558-C767-477A-A2E1-1ADCFECA0460",
"name": "��������",
"surname": "�����������",
"department": "����������� ������������� ������������",
"division": "����� ������������ ������",
"position": "���������� ����������"
},
"resolution": "��������",
"resolutionPeriod": 1,
"resolutionSolution": "������",
"status": "� ������"
}'

exec AddOrModifyFurnitureOrder @json 
