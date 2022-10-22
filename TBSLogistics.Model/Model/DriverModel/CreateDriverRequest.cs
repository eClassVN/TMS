﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TBSLogistics.Model.Model.DriverModel
{
    public class CreateDriverRequest
    {
        public string MaTaiXe { get; set; }
        public string Cccd { get; set; }
        public string HoVaTen { get; set; }
        public string SoDienThoai { get; set; }
        public DateTime? NgaySinh { get; set; }
        public string GhiChu { get; set; }
        public string MaNhaCC { get; set; }
        public string MaLoaiPhuongTien { get; set; }
        public bool TaiXeTBS { get; set; }
        public int TrangThai { get; set; }
    }
}
