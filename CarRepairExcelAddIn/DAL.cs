using CarRepairExcelAddIn.DTO;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace CarRepairExcelAddIn
{
    public class DAL
    {
        private string _connectionString;
        public DAL(string connectionString)
        {
            _connectionString = connectionString;
        }

        public List<CarRepairReportDTO> GetDataForReportCarRepair(int month)
        {
            string sqlExpression = "ReportRepairForMonth";
            List<CarRepairReportDTO> carRepairReportDTOs = new List<CarRepairReportDTO>();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                var monhtSqlParametr = new SqlParameter
                {
                    ParameterName = "@month",
                    Value = month
                };
                command.Parameters.Add(monhtSqlParametr);
                var reader = command.ExecuteReader();
                if (reader.HasRows)
                {

                    while (reader.Read())
                    {
                        carRepairReportDTOs.Add(new CarRepairReportDTO()
                        {
                            masterPercent = reader.GetInt32(14),
                            modelCar = reader.GetString(9),
                            nameMaster = reader.GetString(11),
                            numberCar = reader.GetString(8),
                            priceCar = reader.GetSqlMoney(6).ToDouble(),
                            priceMaster = reader.GetSqlMoney(3).ToDouble()
                        });

                    }
                }
                reader.Close();
            }

            return carRepairReportDTOs;
        }
    }
}
