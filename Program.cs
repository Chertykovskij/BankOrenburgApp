using BankOrenburgApp;
using BankOrenburgApp.DataBase;

DateTime currentDate = DateTime.Now;
if (ClassWithStaticMethods.IsWorkingDay(currentDate))
{
    DateTime endDateIn7Days = currentDate.AddDays(7);
    DateTime endDateIn14Days = currentDate.AddDays(14);

    using (var dbContext = new BankDbContext())
    {
        // Получение договоров, срок окончания которых через 7 или 14 дней от текущей даты 
        var contracts = dbContext.ContractsWithOrganizations
            .Where(c => c.DateEnd == endDateIn7Days || c.DateEnd == endDateIn14Days)
            .ToList();

        foreach (var contract in contracts)
        {
            // Отправка уведомления на адрес электронной почты ответственного сотрудника 
            string employeeEmail = contract.ResponsibleForExecution.E_mail;

            // Формирование текста уведомления 
            string subject = "Уведомление о договоре";
            string message = $"Номер договора: {contract.ContractNumber}\n" +
                             $"Дата начала договора: {contract.DateStart}\n" +
                             $"Дата окончания договора: {contract.DateEnd}";

            // Отправка письма 
            ClassWithStaticMethods.SendEmail(employeeEmail, subject, message);
        }
    }
}