﻿using System;
using System.Collections.Generic;

#nullable disable

namespace TBSLogistics.Data.TMS
{
    public partial class Romooc
    {
        public Romooc()
        {
            VanDons = new HashSet<VanDon>();
        }

        public string MaRomooc { get; set; }
        public string KetCauSan { get; set; }
        public string SoGuRomooc { get; set; }
        public string ThongSoKyThuat { get; set; }
        public string MaLoaiRomooc { get; set; }
        public DateTime UpdateTime { get; set; }
        public DateTime Createdtime { get; set; }

        public virtual LoaiRomooc MaLoaiRomoocNavigation { get; set; }
        public virtual ICollection<VanDon> VanDons { get; set; }
    }
}