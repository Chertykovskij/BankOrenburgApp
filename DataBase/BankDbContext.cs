using BankOrenburgApp.DataBase.Models;
using Microsoft.EntityFrameworkCore;


namespace BankOrenburgApp.DataBase
{
    public class BankDbContext : DbContext
    {
        public DbSet<Position>? Positions { get; set; }
        public DbSet<Department>? Departments { get; set; }
        public DbSet<Organization>? Organizations { get; set; }
        public DbSet<Employee>? Employees { get; set; }
        public DbSet<EmployeePosition>? EmployeePositions { get; set; }
        public DbSet<EmployeeDepartment>? EmployeeDepartments { get; set; }
        public DbSet<ContractsWithOrganization>? ContractsWithOrganizations { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Строка подключения");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Employee>()
                .HasMany(e => e.EmployeePositions)
                .WithOne(ep => ep.Employee)
                .HasForeignKey(ep => ep.EmployeeID);

            modelBuilder.Entity<Employee>()
                .HasMany(e => e.EmployeeDepartments)
                .WithOne(ep => ep.Employee)
            .HasForeignKey(ep => ep.EmployeeID);

            modelBuilder.Entity<Employee>()
                .HasMany(e => e.ContractsWithOrganizations)
                .WithOne(c => c.ResponsibleForExecution)
                .HasForeignKey(c => c.ResponsibleForExecutionID);

            modelBuilder.Entity<Employee>()
                .HasMany(e => e.ContractsWithOrganizations)
                .WithOne(c => c.Accountant)
                .HasForeignKey(c => c.AccountantID);

            modelBuilder.Entity<Position>()
                .HasMany(p => p.EmployeePositions)
                .WithOne(ep => ep.Position)
                .HasForeignKey(ep => ep.PositionID);

            modelBuilder.Entity<Department>()
                .HasMany(d => d.EmployeeDepartments)
                .WithOne(ed => ed.Department)
                .HasForeignKey(ed => ed.DepartmentID);

            modelBuilder.Entity<Organization>()
                .HasMany(o => o.ContractsWithOrganizations)
                .WithOne(c => c.Organization)
                .HasForeignKey(c => c.OrganizationID);

            modelBuilder.Entity<Employee>()
                .HasIndex(e => e.E_mail)
                .IsUnique();

            modelBuilder.Entity<Employee>()
                .HasIndex(e => e.ServiceNumber)
                .IsUnique();

            modelBuilder.Entity<ContractsWithOrganization>()
                .HasIndex(e => e.ContractNumber)
                .IsUnique();
        }


    }
}
