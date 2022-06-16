﻿using System;
using System.Collections.Generic;

#nullable disable

namespace TBSLogistics.Data.TBSLogisticsDbContext
{
    public partial class TuyendungThongTinGiaDinhUv
    {
        public int Id { get; set; }
        public string HoVaTen { get; set; }
        public string QuanHe { get; set; }
        public string NamSinh { get; set; }
        public string NgheNghiep { get; set; }
        public string DiaChi { get; set; }
        public int? IdungVien { get; set; }

        public virtual TuyendungThongTinUngVien IdungVienNavigation { get; set; }
    }
}
