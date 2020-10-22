using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Runtime.InteropServices;
using Excel = Microsoft.Office.Interop.Excel;
using System.Windows.Forms;
using System.Data.SqlClient;
using CarRepairExcelAddIn.DTO;
using System.IO;

namespace CarRepairExcelAddIn
{
    [ComVisible(true)]
    [ClassInterface(ClassInterfaceType.None)]
    public class AddInUtilities : IAddInUtilities
    {

        public void FillDBTestDatas()
        { 
                DAL dal = new DAL(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CarRepair;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");


                List<CarRepairReportDTO> rows;
                try
                {
                   dal.FillDBTestDatas();
                }
                catch (SqlException e)
                {
                    MessageBox.Show("Error with SQL server");
                    return;
                }
                catch (IOException e)
                {
                    MessageBox.Show("Error accessing SQL server");
                    return;
                }
        }

        public void ImportData( int month)
        {
            if (month>12 || month <1)
            {
                MessageBox.Show("It is not month");
                return;
            }

            Excel.Worksheet sheet = Globals.ThisAddIn.Application.ActiveSheet as Excel.Worksheet;

            if (sheet != null)
            {
             
                sheet.Cells[1, 1] = "Номер машины";
                sheet.Cells[1, 2] = "Модель машины";
                sheet.Cells[1, 3] = "Цена ремонта для машины";
                sheet.Cells[1, 4] = "Имя мастера";
                sheet.Cells[1, 5] = "Цена ремонта для этой машины у мастера";
                sheet.Cells[1, 6] = "Процент занятости мастера";

                DAL dal = new DAL(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=CarRepair;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");


                List<CarRepairReportDTO> rows;
                try
                {
                   rows = dal.GetDataForReportCarRepair(month);
                }
                catch (SqlException e)
                {
                    MessageBox.Show("Error with SQL server");
                    return;
                }
                catch (IOException e)
                {
                    MessageBox.Show("Error accessing SQL server");
                    return;
                }

                int i = 1;
                foreach (var row in rows)
                {
                    i++;
                    sheet.Cells[i, 1] = row.numberCar;
                    sheet.Cells[i, 2] = row.modelCar;
                    sheet.Cells[i, 3] = row.priceCar;
                    sheet.Cells[i, 4] = row.nameMaster;
                    sheet.Cells[i, 5] = row.priceCar;
                    sheet.Cells[i, 6] = row.masterPercent;
                }
            }
        }
    }
}
