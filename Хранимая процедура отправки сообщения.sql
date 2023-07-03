CREATE PROCEDURE SendContractNotifications AS
BEGIN 
    DECLARE @CurrentDate DATE; 
    SET @CurrentDate = GETDATE(); 
     
    -- Проверка, является ли текущий день рабочим днем 
    IF DATENAME(WEEKDAY, @CurrentDate) IN ('суббота', 'воскресенье') 
        RETURN; 
     
    -- Формирование списка договоров, удовлетворяющих условиям 
    SELECT 
        c.ContractNumber, 
        c.DateStart, 
        c.DateEnd,
		c.ResponsibleForExecution,
		c.Accountant
    INTO #ContractsToSend 
    FROM 
        ContractsWithOrganizations c
    --WHERE 
        --DATEDIFF(DAY, @CurrentDate, c.DateEnd) IN (7, 14) -- Сделал по заданию,
		-- но решение так себе, будут ошибки, надо продумывать посерьёзней
         
    DECLARE 
        @ContractNumber VARCHAR(50), 
        @StartDate DATE, 
        @EndDate DATE, 
		@FIO VARCHAR(100),
        @Email VARCHAR(100), 
        @Subject VARCHAR(100), 
        @Body VARCHAR(MAX); 
    
	-- Отправка уведомлений на электронную почту ответственному сотруднику
    DECLARE contract_cursor CURSOR FOR 
    SELECT 
        s.ContractNumber, 
        s.DateStart, 
        s.DateEnd, 
        e.LastName+ ' ' + LEFT(e.FirstName, 1) + '.' + LEFT(e.PatronymicName, 1) + '.',
		e.E_mail
    FROM 
        #ContractsToSend s
        INNER JOIN Employees e ON s.ResponsibleForExecution = e.ID; 
     
    OPEN contract_cursor; 
     
    FETCH NEXT FROM contract_cursor INTO 
        @ContractNumber, 
        @StartDate, 
        @EndDate,
		@FIO,
        @Email; 
     
    WHILE @@FETCH_STATUS = 0 
    BEGIN 
        SET @Subject = 'Уведомление о договоре ' + @ContractNumber; 
        SET @Body = 'Уважаемый сотрудник,' + @FIO 
                    + ' У вас есть договор с номером ' + @ContractNumber + ',' 
                    + ' который начинается ' + CONVERT(VARCHAR, @StartDate, 104) 
                    + ' и заканчивается ' + CONVERT(VARCHAR, @EndDate, 104) + '.' 
                    + ' Пожалуйста, примите необходимые меры.'; 
         
		 --SELECT @Body

        -- Здесь должен быть код отправки уведомления на электронную почту. 
		-- Сам ни разу не отправлял e-mail из SQL Server, покапался в интернете, нашёл такое решение,
		-- но предварительно надо произвести настройку компонента Database Mail в Microsoft SQL Server
         
        -- EXEC msdb.dbo.sp_send_dbmail 
        --     @recipients = @Email, 
        --     @subject = @Subject, 
        --     @body = @Body; 
         
        FETCH NEXT FROM contract_cursor INTO 
            @ContractNumber, 
            @StartDate, 
            @EndDate, 
			@FIO,
            @Email; 
    END 
     
    CLOSE contract_cursor; 
    DEALLOCATE contract_cursor; 



	-- Здесь отправляем сообщение бухгалтеру
	DECLARE contract_cursor CURSOR FOR 
    SELECT 
        s.ContractNumber, 
        s.DateStart, 
        s.DateEnd, 
        e.LastName+ ' ' + LEFT(e.FirstName, 1) + '.' + LEFT(e.PatronymicName, 1) + '.',
		e.E_mail
    FROM 
        #ContractsToSend s
        INNER JOIN Employees e ON s.Accountant = e.ID; -- Здесь цепляемся теперь к бухгалтеру
     
    OPEN contract_cursor; 
     
    FETCH NEXT FROM contract_cursor INTO 
        @ContractNumber, 
        @StartDate, 
        @EndDate,
		@FIO,
        @Email; 
     
    WHILE @@FETCH_STATUS = 0 
    BEGIN 
        SET @Subject = 'Уведомление о договоре ' + @ContractNumber; 
        SET @Body = 'Уважаемый сотрудник,' + @FIO 
                    + ' У вас есть договор с номером ' + @ContractNumber + ',' 
                    + ' который начинается ' + CONVERT(VARCHAR, @StartDate, 104) 
                    + ' и заканчивается ' + CONVERT(VARCHAR, @EndDate, 104) + '.' 
                    + ' Пожалуйста, примите необходимые меры.'; 
         
		 -- Код отправки сообщения
         
        FETCH NEXT FROM contract_cursor INTO 
            @ContractNumber, 
            @StartDate, 
            @EndDate, 
			@FIO,
            @Email; 
    END 
     
    CLOSE contract_cursor; 
    DEALLOCATE contract_cursor; 
     
    DROP TABLE #ContractsToSend; 
END

/*
Примечание:
Не очень понял момент с окончанием срока на праздники и выходные. Они будут попадать без реализации дополнительной логики. 
Сложность возникнет если надо будет празднечные дни отсекать.
Если работать надо только с рабочими днями и считать их, тогда считаю потребуется таблица с записями дат
и указанием является ли этот день празднечным или выходным, там уже можно к ней прицепиться и считать рабочие дни.
*/
