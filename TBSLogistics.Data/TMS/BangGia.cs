﻿using System;
using System.Collections.Generic;

#nullable disable

namespace TBSLogistics.Data.TMS
{
    public partial class BangGia
    {
        public int Id { get; set; }
        public string MaHopDong { get; set; }
        public string MaPtvc { get; set; }
        public string MaCungDuong { get; set; }
        public string MaLoaiPhuongTien { get; set; }
        public decimal DonGia { get; set; }
        public string MaDvt { get; set; }
        public string MaLoaiHangHoa { get; set; }
        public string MaLoaiDoiTac { get; set; }
        public DateTime NgayApDung { get; set; }
        public int TrangThai { get; set; }
        public DateTime UpdatedTime { get; set; }
        public DateTime CreatedTime { get; set; }

        public virtual CungDuong MaCungDuongNavigation { get; set; }
        public virtual HopDongVaPhuLuc MaHopDongNavigation { get; set; }
    }
}
