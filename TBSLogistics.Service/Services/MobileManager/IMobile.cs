﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TBSLogistics.Model.CommonModel;
using TBSLogistics.Model.Model.MobileModel;
using TBSLogistics.Model.Model.SFeeByTcommandModel;

namespace TBSLogistics.Service.Services.MobileManager
{
    public interface IMobile
    {
        Task<List<GetDataTransportMobile>> GetDataTransportForMobile(string maTaiXe, bool isCompleted);
        Task<BoolActionResult> UpdateContNo(string maChuyen, string ContNo);
        Task<BoolActionResult> WriteNoteHandling(int handlingId, string note);
        Task<BoolActionResult> CreateSFeeByTCommand(List<CreateSFeeByTCommandRequest> request, string maChuyen = null);
    }
}
