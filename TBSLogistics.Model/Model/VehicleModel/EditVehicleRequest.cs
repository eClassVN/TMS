﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TBSLogistics.Model.Model.VehicleModel
{
   public class EditVehicleRequest
    {
        public string MaNhaCungCap { get; set; }
        public string MaLoaiPhuongTien { get; set; }
        public string MaTaiXeMacDinh { get; set; }
        public double TrongTaiToiThieu { get; set; }
        public double TrongTaiToiDa { get; set; }
        public string MaGps { get; set; }
        public string MaGpsmobile { get; set; }
        public string LoaiVanHanh { get; set; }
        public string MaTaiSan { get; set; }
        public int? ThoiGianKhauHao { get; set; }
        public DateTime? NgayHoatDong { get; set; }
        public string PhanLoaiXeVanChuyen { get; set; }
        public string TrangThai { get; set; }
    }
}