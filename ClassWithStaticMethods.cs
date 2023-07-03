using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace BankOrenburgApp
{
    public class ClassWithStaticMethods
    {
        /// <summary>
        /// Проверка, является ли дата рабочим днём
        /// </summary>
        public static bool IsWorkingDay (DateTime date)
        {
            DayOfWeek currentDayOfWeek = date.DayOfWeek;

            if (currentDayOfWeek == DayOfWeek.Saturday || currentDayOfWeek == DayOfWeek.Sunday)
                return false;
            else
                return true;
            
        }


        public static void SendEmail(string toEmail, string subject, string message)
        {
            // Настройка SMTP-клиента для отправки электронной почты 
            SmtpClient smtpClient = new SmtpClient("smtp.example.com");
            smtpClient.Port = 587;
            smtpClient.EnableSsl = true;
            smtpClient.Credentials = new System.Net.NetworkCredential("your-email@example.com", "your-password");

            // Создание объекта MailMessage с информацией о письме 
            MailMessage mailMessage = new MailMessage();
            mailMessage.From = new MailAddress("your-email@example.com");
            mailMessage.To.Add(toEmail);
            mailMessage.Subject = subject;
            mailMessage.Body = message;

            // Отправка письма 
            smtpClient.Send(mailMessage);
        }
    }
}
