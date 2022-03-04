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
                    EmployeeModel model = new EmployeeModel();
                    string query = "select * from EPLOYEE_PAYROLL"; //in the query variable all data from Employeepayroll table
                    SqlCommand command= new SqlCommand(query, connection);
                    connection.Open();
                    var reader=command.ExecuteReader();
                    if(reader.HasRows)
                    {
                        while(reader.Read())
                        {
                            model.Id=Convert.ToInt32(reader["ID"]==DBNull.Value ? default : reader["Id"]);
                            //model.Id = Convert.ToInt32(reader[0]);
                            model.Name=reader["Name"]==DBNull.Value ? default: reader["Name"].ToString();
                            model.BasicPay = Convert.ToDouble(reader["BasicPay"] == DBNull.Value ? default : reader["BasicPay"]);  //error cs0266 cannot convert double to int hence used type cast bcz salary declared as float bt value assign is int
                            model.Start_Date = (DateTime)(reader["Start_Date"] == DBNull.Value ? default(DateTime) : reader["Start_Date"]);
                            model.Gender = Convert.ToChar(reader["Gender"] == DBNull.Value ? " " : reader["Gender"].ToString()) ;
                            model.Phone = Convert.ToInt64(reader["Phone"] == DBNull.Value ? default : reader["Phone"]);
                            model.Department=reader["Department"]==DBNull.Value ? default : reader["Department"].ToString();
                            model.Address = reader["Address"] == DBNull.Value ? default : reader["Address"].ToString();
                            model.Taxable=Convert.ToDouble(reader["Taxable"]==DBNull.Value ? default : reader["Taxable"].ToString());
                            model.Deductions=Convert.ToDouble(reader["Deductions"]==DBNull.Value ? default : reader["Deductions"].ToString());
                            model.IncomeTax = Convert.ToDouble(reader["IncomeTax"] == DBNull.Value ? default : reader["IncomeTax"].ToString());
                            model.NetPay = Convert.ToDouble(reader["NetPay"] == DBNull.Value ? default : reader["NetPay"].ToString());
                            Console.WriteLine("{0},{1},{2},{3},{4},{5},{6},{7},{8}",model.Id,model.Name,model.Gender,model.Address,model.Start_Date,model.BasicPay,model.Phone,model.IncomeTax,model.NetPay);

                        }
                    }

                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
