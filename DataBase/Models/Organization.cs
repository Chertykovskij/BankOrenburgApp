using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankOrenburgApp.DataBase.Models
{
    public class Organization
    {
        public int ID { get; set; }

        [Required]
        [StringLength(100)]
        public string NameOrganization { get; set; } = string.Empty;

        public List<ContractsWithOrganization> ContractsWithOrganizations { get; set; } = new List<ContractsWithOrganization>();
    }
}
