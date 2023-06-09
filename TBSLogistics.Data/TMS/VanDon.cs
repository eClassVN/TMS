﻿using System;
using System.Collections.Generic;

namespace TBSLogistics.Data.TMS
{
    public partial class VanDon
    {
        public VanDon()
        {
            DieuPhoi = new HashSet<DieuPhoi>();
        }

        public string MaVanDon { get; set; }
        public string MaVanDonKh { get; set; }
        public string HangTau { get; set; }
        public string Tau { get; set; }
        public string MaKh { get; set; }
        public string LoaiVanDon { get; set; }
        public string MaPtvc { get; set; }
        public int TongThungHang { get; set; }
        public double? TongKhoiLuong { get; set; }
        public double? TongTheTich { get; set; }
        public double? TongSoKien { get; set; }
        public DateTime? ThoiGianCoMat { get; set; }
        public DateTime? ThoiGianHanLenh { get; set; }
        public DateTime? ThoiGianHaCang { get; set; }
        public DateTime? ThoiGianLayRong { get; set; }
        public DateTime? ThoiGianLayHang { get; set; }
        public DateTime? ThoiGianTraHang { get; set; }
        public DateTime ThoiGianTaoDon { get; set; }
        public DateTime? ThoiGianHoanThanh { get; set; }
        public string GhiChu { get; set; }
        public int TrangThai { get; set; }
        public DateTime? UpdatedTime { get; set; }
        public DateTime CreatedTime { get; set; }
        public string Updater { get; set; }
        public string Creator { get; set; }
        public DateTime? ThoiGianTraRong { get; set; }
        public int DiemDau { get; set; }
        public int DiemCuoi { get; set; }
        public string MaAccount { get; set; }

        public virtual ICollection<DieuPhoi> DieuPhoi { get; set; }
    }
}
