﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TBSLogistics.Model.Model.BillOfLadingModel
{
    public class CreateHandlingLess
    {
        public List<arrTransport> arrTransports { get; set; }
        public string MaPTVC { get; set; }
        public string PTVanChuyen { get; set; }
        public int? DiemLayTraRong { get; set; }
        public string DonViVanTai { get; set; }
        public string XeVanChuyen { get; set; }
        public string TaiXe { get; set; }
        public string GhiChu { get; set; }
        public string Romooc { get; set; }
        public string CONTNO { get; set; }
        public string SEALHQ { get; set; }
        public string SEALNP { get; set; }
        public DateTime? TGLayHang { get; set; }
        public DateTime? TGTraHang { get; set; }
        public DateTime? TGLayTraRong { get; set; }
        public DateTime? TGHanLenh { get; set; }
        public DateTime? TGHaCang { get; set; }
    }

    public class arrTransport
    {
        public string TransportId { get; set; }
        public string MaLoaiHangHoa { get; set; }
        public string MaDVT { get; set; }
    }
}
