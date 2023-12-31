﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankOrenburgApp.DataBase.Models
{
    public class Position
    {
        public int ID { get; set; }

        [Required]
        [StringLength(100)]
        public string NamePosition { get; set; } = string.Empty;

        public List<EmployeePosition> EmployeePositions { get; set; } = new List<EmployeePosition>();
    }
}
