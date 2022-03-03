using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmployeePayrollServiceADONet
{
    public class EmployeeRepository
    {
        public static string ConnectionString = @"Data Source=DESKTOP-8CGQJGB;Initial Catalog=Payroll_Service;Integrated Security=True";
        SqlConnection connection= null;
        public  void GetAllEmployee()
        {
            try
            {
                using (connection= new SqlConnection(ConnectionString))
                {

                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}
