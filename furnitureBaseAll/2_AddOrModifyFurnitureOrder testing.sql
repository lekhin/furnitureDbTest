
truncate table [staff].[departments]
truncate table [order].orders
delete from [staff].persons


;DECLARE @json NVARCHAR(max)
SET @json = 
N'{
"furnitureOrderId": 123,
"applicant": {
"id": "6E4AD64E-43D0-4096-8E03-58952E5B4221",
"name": "Василий",
"surname": "Петров",
"department": "Департамент ИТ"
},
"applicationReason": "поломка",
"coordinatingManager": {
"id": "FB6B6558-C767-477A-A2E1-1ADCFECA0460",
"name": "Владимир",
"surname": "Александров",
"department": "Департамент хозяйственной деятельности",
"division": "отдел эксплуатации здания",
"position": "заведующий хозяйством"
},
"resolution": "одобрено",
"resolutionPeriod": 1,
"resolutionSolution": "замена",
"status": "в работе"
}'

exec AddOrModifyFurnitureOrder @json 
