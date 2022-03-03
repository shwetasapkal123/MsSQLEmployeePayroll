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
        public int BasicPay { get; set; }
        public int Start_Date { get; set; }
        public char Gender { get; set; }
        public int Phone { get; set; }
        public string Address { get; set; }
        public string Department { get; set; }
        public float Deductions { get; set; }
        public float Taxable { get; set; }
        public float IncomeTax { get; set; }
        public float NetPay { get; set; }
    }
}
