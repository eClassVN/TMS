﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using TBSLogistics.Model.Model.BillOfLadingModel;
using TBSLogistics.Model.Model.SFeeByTcommandModel;
using TBSLogistics.Service.Panigation;
using TBSLogistics.Service.Services.BillOfLadingManage;
using TBSLogistics.Service.Services.Common;
using TBSLogistics.Service.Services.MobileManager;
using TBSLogistics.Service.Services.SFeeByTcommandManage;
using TBSLogistics.Service.Services.SubFeePriceManage;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace TBSLogistics.ApplicationAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MobileController : ControllerBase
    {
        private readonly ISubFeePrice _subFeePrice;
        private readonly IBillOfLading _billOfLading;
        private readonly ISFeeByTcommand _SFeeByTcommand;
        private readonly IMobile _mobile;
        private readonly ICommon _common;

        public MobileController(IBillOfLading billOfLading, IPaginationService paginationService, ICommon common, IMobile mobile, ISFeeByTcommand sFeeByTcommand, ISubFeePrice subFeePrice)
        {
            _billOfLading = billOfLading;
            _mobile = mobile;
            _common = common;
            _SFeeByTcommand = sFeeByTcommand;
            _subFeePrice = subFeePrice;
        }

        [HttpGet]
        [Route("[action]")]
        public async Task<IActionResult> GetListSubFeeSelect()
        {
            var list = await _subFeePrice.GetListSubFeeSelect();
            return Ok(list);
        }

        [HttpGet]
        [Route("[action]")]
        public async Task<IActionResult> GetDataTransport(string driver, bool isCompleted)
        {
            var data = await _mobile.GetDataTransportForMobile(driver, isCompleted);
            return Ok(data);
        }

        [HttpPost]
        [Route("[action]")]
        public async Task<IActionResult> UploadImage([FromForm] UploadImagesHandling request)
        {
            var checkPermission = await _common.CheckPermission("F0006");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var uploadFile = await _billOfLading.UploadFile(request);

            if (uploadFile.isSuccess)
            {
                return Ok(uploadFile.Message);
            }
            else
            {
                return BadRequest(uploadFile.Message);
            }
        }

        [HttpPost]
        [Route("[action]")]
        public async Task<IActionResult> CreateSFeeByTCommand(List<CreateSFeeByTCommandRequest> request)
        {
            var checkPermission = await _common.CheckPermission("F0009");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var Create = await _SFeeByTcommand.CreateSFeeByTCommand(request);
            if (Create.isSuccess == true)
            {
                return Ok(Create.Message);
            }
            else
            {
                return BadRequest(Create.Message);
            }
        }

        [HttpPost]
        [Route("[action]")]
        public async Task<IActionResult> SetRuningTypeFull(int handlingId)
        {
            var checkPermission = await _common.CheckPermission("F0007");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var update = await _billOfLading.SetRunning(handlingId);

            if (update.isSuccess)
            {
                return Ok(update);
            }
            else
            {
                return BadRequest(update);
            }
        }

        [HttpPost]
        [Route("[action]")]
        public async Task<IActionResult> SetRuningLessType(string maChuyen)
        {
            var checkPermission = await _common.CheckPermission("F0007");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var update = await _billOfLading.SetRunningLess(maChuyen);

            if (update.isSuccess)
            {
                return Ok(update);
            }
            else
            {
                return BadRequest(update);
            }
        }
    }
}