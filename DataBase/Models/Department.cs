using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankOrenburgApp.DataBase.Models
{
    public class Department
    {
        public int ID { get; set; }

        [Required]
        [StringLength(100)]
        public string NameDepartment { get; set; } = string.Empty;
        public List<EmployeeDepartment> EmployeeDepartments { get; set; } = new List<EmployeeDepartment>();
    }
}
