using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankOrenburgApp.DataBase.Models
{
    public class ContractsWithOrganization
    {
        public int ID { get; set; }

        public DateTime DateStart { get; set; }

        public DateTime? DateEnd { get; set; }

        [Required]
        [StringLength(100)]
        public string ContractNumber { get; set; } = string.Empty;

        public decimal Price { get; set; }

        public int OrganizationID { get; set; }
        public Organization Organization { get; set; } = new Organization();

        public int ResponsibleForExecutionID { get; set; }
        public Employee ResponsibleForExecution { get; set; } = new Employee();

        public int AccountantID { get; set; }
        public Employee Accountant { get; set; } = new Employee();
    }
}
