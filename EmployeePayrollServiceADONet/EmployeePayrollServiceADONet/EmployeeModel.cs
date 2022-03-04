using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmployeePayrollServiceADONet
{
    public class EmployeeModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public double BasicPay { get; set; }
        public DateTime Start_Date { get; set; }
        public char Gender { get; set; }
        public long Phone { get; set; }
        public string Address { get; set; }
        public string Department { get; set; }
        public double Deductions { get; set; }
        public double Taxable { get; set; }
        public double IncomeTax { get; set; }
        public double NetPay { get; set; }
    }
}
