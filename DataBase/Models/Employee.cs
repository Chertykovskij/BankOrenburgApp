using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;


namespace BankOrenburgApp.DataBase.Models
{
    public class Employee
    {
        public int ID { get; set; }

        [Required]
        [StringLength(100)]
        public string LastName { get; set; } = string.Empty;

        [Required]
        [StringLength(100)]
        public string FirstName { get; set; } = string.Empty;

        [Required]
        [StringLength(100)]
        public string PatronymicName { get; set; } = string.Empty;

        [Required]
        [StringLength(10)]
        public string ServiceNumber { get; set; } = string.Empty;

        [Required]
        [StringLength(100)] 
        public string E_mail { get; set; } = string.Empty;

        public DateTime DateStart { get; set; }

        public DateTime? DateEnd { get; set; }

        public List<EmployeePosition> EmployeePositions { get; set; } = new List<EmployeePosition>();
        public List<EmployeeDepartment> EmployeeDepartments { get; set; } = new List<EmployeeDepartment>();
        public List<ContractsWithOrganization> ContractsWithOrganizations { get; set; } = new List<ContractsWithOrganization>();
    }
}
