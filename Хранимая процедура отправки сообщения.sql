CREATE PROCEDURE SendContractNotifications AS
BEGIN 
    DECLARE @CurrentDate DATE; 
    SET @CurrentDate = GETDATE(); 
     
    -- ��������, �������� �� ������� ���� ������� ���� 
    IF DATENAME(WEEKDAY, @CurrentDate) IN ('�������', '�����������') 
        RETURN; 
     
    -- ������������ ������ ���������, ��������������� �������� 
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
        --DATEDIFF(DAY, @CurrentDate, c.DateEnd) IN (7, 14) -- ������ �� �������,
		-- �� ������� ��� ����, ����� ������, ���� ����������� �����������
         
    DECLARE 
        @ContractNumber VARCHAR(50), 
        @StartDate DATE, 
        @EndDate DATE, 
		@FIO VARCHAR(100),
        @Email VARCHAR(100), 
        @Subject VARCHAR(100), 
        @Body VARCHAR(MAX); 
    
	-- �������� ����������� �� ����������� ����� �������������� ����������
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
        SET @Subject = '����������� � �������� ' + @ContractNumber; 
        SET @Body = '��������� ���������,' + @FIO 
                    + ' � ��� ���� ������� � ������� ' + @ContractNumber + ',' 
                    + ' ������� ���������� ' + CONVERT(VARCHAR, @StartDate, 104) 
                    + ' � ������������� ' + CONVERT(VARCHAR, @EndDate, 104) + '.' 
                    + ' ����������, ������� ����������� ����.'; 
         
		 --SELECT @Body

        -- ����� ������ ���� ��� �������� ����������� �� ����������� �����. 
		-- ��� �� ���� �� ��������� e-mail �� SQL Server, ��������� � ���������, ����� ����� �������,
		-- �� �������������� ���� ���������� ��������� ���������� Database Mail � Microsoft SQL Server
         
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



	-- ����� ���������� ��������� ����������
	DECLARE contract_cursor CURSOR FOR 
    SELECT 
        s.ContractNumber, 
        s.DateStart, 
        s.DateEnd, 
        e.LastName+ ' ' + LEFT(e.FirstName, 1) + '.' + LEFT(e.PatronymicName, 1) + '.',
		e.E_mail
    FROM 
        #ContractsToSend s
        INNER JOIN Employees e ON s.Accountant = e.ID; -- ����� ��������� ������ � ����������
     
    OPEN contract_cursor; 
     
    FETCH NEXT FROM contract_cursor INTO 
        @ContractNumber, 
        @StartDate, 
        @EndDate,
		@FIO,
        @Email; 
     
    WHILE @@FETCH_STATUS = 0 
    BEGIN 
        SET @Subject = '����������� � �������� ' + @ContractNumber; 
        SET @Body = '��������� ���������,' + @FIO 
                    + ' � ��� ���� ������� � ������� ' + @ContractNumber + ',' 
                    + ' ������� ���������� ' + CONVERT(VARCHAR, @StartDate, 104) 
                    + ' � ������������� ' + CONVERT(VARCHAR, @EndDate, 104) + '.' 
                    + ' ����������, ������� ����������� ����.'; 
         
		 -- ��� �������� ���������
         
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
����������:
�� ����� ����� ������ � ���������� ����� �� ��������� � ��������. ��� ����� �������� ��� ���������� �������������� ������. 
��������� ��������� ���� ���� ����� ����������� ��� ��������.
���� �������� ���� ������ � �������� ����� � ������� ��, ����� ������ ����������� ������� � �������� ���
� ��������� �������� �� ���� ���� ����������� ��� ��������, ��� ��� ����� � ��� ����������� � ������� ������� ���.
*/
