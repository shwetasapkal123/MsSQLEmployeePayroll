using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmployeePayrollServiceADONet
{
    public class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("WELCOME to EmployeePayroll in ADO.Net");
            EmployeeModel model = new EmployeeModel();
            model.Address = "Benglore";
            model.Name = "Suresh";
            EmployeeRepository employeeRepository = new EmployeeRepository();
            
            employeeRepository.GetAllEmployee();

            Console.ReadLine();
        }
    }
}
