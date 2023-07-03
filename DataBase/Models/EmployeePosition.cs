using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankOrenburgApp.DataBase.Models
{
    public class EmployeePosition
    {
        public int ID { get; set; }

        public int EmployeeID { get; set; }
        public Employee Employee { get; set; } = new Employee();

        public int PositionID { get; set; }
        public Position Position { get; set; } = new Position();

        public DateTime StartDate { get; set; }
    }
}
