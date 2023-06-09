﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TBSLogistics.Model.Model.BillOfLadingModel
{
    public class CreateTransportLess
    {
        public string AccountId { get; set; }
        public string DonViTinh { get; set; }
        public int DiemDau { get; set; }
        public int DiemCuoi { get; set; }
        public string MaKH { get; set; }
        public string MaVanDonKH { get; set; }
        public string LoaiVanDon { get; set; }
        public string HangTau { get; set; }
        public string TenTau { get; set; }
        public double? TongKhoiLuong { get; set; }
        public double? TongTheTich { get; set; }
        public double? TongSoKien { get; set; }
        public string GhiChu { get; set; }
        public string MaPTVC { get; set; }

        public DateTime? ThoiGianLayHang { get; set; }
        public DateTime? ThoiGianTraHang { get; set; }
    }

    public class UpdateTransportLess
    {
        public string MaKH { get; set; }
        public string AccountId { get; set; }
        public int DiemDau { get; set; }
        public int DiemCuoi { get; set; }
        public string MaVanDonKH { get; set; }
        public string LoaiVanDon { get; set; }
        public string HangTau { get; set; }
        public string TenTau { get; set; }
        public int DiemLayHang { get; set; }
        public int DiemTraHang { get; set; }
        public double? TongKhoiLuong { get; set; }
        public double? TongTheTich { get; set; }
        public double? TongSoKien { get; set; }
        public string GhiChu { get; set; }
        public string MaPTVC { get; set; }

        public DateTime? ThoiGianLayHang { get; set; }
        public DateTime? ThoiGianTraHang { get; set; }
    }
}
