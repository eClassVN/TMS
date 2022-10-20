﻿using System;
using System.Collections.Generic;

#nullable disable

namespace TBSLogistics.Data.TMS
{
    public partial class VanDon
    {
        public VanDon()
        {
            DieuPhoi = new HashSet<DieuPhoi>();
        }

        public string MaVanDon { get; set; }
        public string LoaiVanDon { get; set; }
        public string MaCungDuong { get; set; }
        public int TongThungHang { get; set; }
        public double TongKhoiLuong { get; set; }
        public double TongTheTich { get; set; }
        public DateTime ThoiGianLayHang { get; set; }
        public DateTime ThoiGianTraHang { get; set; }
        public DateTime ThoiGianTaoDon { get; set; }
        public int TrangThai { get; set; }
        public DateTime? UpdatedTime { get; set; }
        public DateTime CreatedTime { get; set; }

        public virtual ICollection<DieuPhoi> DieuPhoi { get; set; }
    }
}