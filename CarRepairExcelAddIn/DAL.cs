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

        public void FillDBTestDatas()
        {
            string sqlExpressionInsertBrands = "INSERT INTO [Brands] ([Name]) VALUES ('Brand')";
            for (int i = 0; i < 10; i++)
            {
                sqlExpressionInsertBrands += $",('Brand{i}')";
            }

            string sqlExpressionInsertModels = "INSERT INTO [Models] ([Name],[IDBrand]) VALUES ('Models', 2)";
            for (int i = 0; i < 30; i++)
            {
                sqlExpressionInsertModels += $",('Model{i}', {i%8+2})";
            }
            string sqlExpressionInsertMasters = "INSERT INTO [Masters] ([FullName],[Phone], [DateStartWork] ) VALUES ('Master', '00-00-00', '2010-01-01')";
            for (int i = 0; i < 40; i++)
            {
                sqlExpressionInsertMasters += $",('Master{i}', '00-00-00{i}', '2010-0{i%7+1}-0{i % 9 + 1}')";
            }
            string sqlExpressionInsertOwners = "INSERT INTO [Owners] ([FullName],[Phone], [IDCardNumber] ) VALUES ('Owner', '00-00-00', '2010-01-01')";
            for (int i = 0; i < 40; i++)
            {
                sqlExpressionInsertOwners += $",('Owner{i}', '00-00-00{i}', '2010-{i % 12 + 1}-0{i}')";
            }
            string sqlExpressionInsertCars = "INSERT INTO [Cars] ([Nuber],[Distance], [VolumeEngine],[IDOwner],[IDModel] ) VALUES ('oo000ooo', 1000, 5,2,2)";
            for (int i = 0; i < 100; i++)
            {
                sqlExpressionInsertCars += $",('oo0{i}ooo', {i}000, {i},{i%39+2},{i % 20 + 10})";
            }
            string sqlExpressionInsertCarRepair = "INSERT INTO [Repaires] ([Price],[DateStart],[DataEnd],[IDCar],[IDMaster] ) VALUES (1000, '2020-05-01', '2020-05-01',2,4)";
            for (int i = 0; i <50; i++)
            {
                if (i%2 ==0)
                {
                    sqlExpressionInsertCarRepair += $",({(i+1)*1000}, '2020-0{i % 7 + 1}-0{i % 9 + 1}', '2020-0{i % 7 + 2}-0{i % 9 + 1}',{i % 75 + 15},{i % 36 + 4})";
                }
                else
                {
                    sqlExpressionInsertCarRepair += $",({(i+1) * 1000}, '2020-0{i % 7 + 1}-0{i % 9 + 1}', NULL,{i % 75 + 15},{i % 36 + 4})";
                }

            }

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpressionInsertBrands, connection);
                command.ExecuteNonQuery();
                command = new SqlCommand(sqlExpressionInsertModels, connection);
                command.ExecuteNonQuery();
                command = new SqlCommand(sqlExpressionInsertMasters, connection);
                command.ExecuteNonQuery();
                command = new SqlCommand(sqlExpressionInsertOwners, connection);
                command.ExecuteNonQuery();
                command = new SqlCommand(sqlExpressionInsertCars, connection);
                command.ExecuteNonQuery();
                command = new SqlCommand(sqlExpressionInsertCarRepair, connection);
                command.ExecuteNonQuery();
            }
        }
    }
}
