﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Runtime.InteropServices;
using Excel = Microsoft.Office.Interop.Excel;   

namespace CarRepairExcelAddIn
{
    [ComVisible(true)]
    public interface IAddInUtilities
    {
        void ImportData(int month);
        void FillDBTestDatas();
    }
}
