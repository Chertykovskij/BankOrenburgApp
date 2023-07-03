using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankOrenburgApp.DataBase.Models
{
    public class EmployeeDepartment
    {
        public int ID { get; set; }

        public int EmployeeID { get; set; }
        public Employee Employee { get; set; } = new Employee();

        public int DepartmentID { get; set; }
        public Department Department { get; set; } = new Department();

        public DateTime StartDate { get; set; }
    }
}
