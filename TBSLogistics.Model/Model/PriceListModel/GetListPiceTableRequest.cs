﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TBSLogistics.Model.Model.PriceListModel
{
    public class GetListPiceTableRequest
    {
        public string DiemLayTraRong { get; set; }
        public string AccountName { get; set; }
        public string DiemDau { get; set; }
        public string DiemCuoi { get; set; }
        public string MaBangGia { get; set; }
        public string MaLoaiDoiTac { get; set; }
        public string SoHopDongCha { get; set; }
        public string MaHopDong { get; set; }
        public string TenHopDong { get; set; }
        public string MaKh { get; set; }
        public string TenKH { get; set; }
        public string MaLoaiPhuongTien { get; set; }
        public decimal DonGia { get; set; }
        public string MaDvt { get; set; }
        public string MaLoaiHangHoa { get; set; }
        public string MaPtvc { get; set; }
        public DateTime NgayApDung { get; set; }
        public DateTime? NgayHetHieuLuc { get; set; }
        public string TrangThai { get; set; }
    }
}
