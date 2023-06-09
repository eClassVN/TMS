﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TBSLogistics.Model.Filter;
using TBSLogistics.Model.Model.VehicleModel;
using TBSLogistics.Service.Helpers;
using TBSLogistics.Service.Panigation;
using TBSLogistics.Service.Services.VehicleManage;
using TBSLogistics.Service.Services.Common;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace TBSLogistics.ApplicationAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class VehicleController : ControllerBase
    {
        private readonly IVehicle _vehicle;
        private readonly IPaginationService _uriService;
        private readonly ICommon _common;

        public VehicleController(IVehicle vehicle, IPaginationService uriService, ICommon common)
        {
            _common = common;
            _uriService = uriService;
            _vehicle = vehicle;
        }

        [HttpPost]
        [Route("[action]")]
        public async Task<IActionResult> CreateVehicle(CreateVehicleRequest request)
        {
            var checkPermission = await _common.CheckPermission("N0003");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var create = await _vehicle.CreateVehicle(request);

            if (create.isSuccess == true)
            {
                return Ok(create.Message);
            }
            else
            {
                return BadRequest(create.Message);
            }
        }

        [HttpPost]
        [Route("[action]")]
        public async Task<IActionResult> EditVehicle(string vehicleId, EditVehicleRequest request)
        {
            var checkPermission = await _common.CheckPermission("N0002");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var Edit = await _vehicle.EditVehicle(vehicleId, request);

            if (Edit.isSuccess == true)
            {
                return Ok(Edit.Message);
            }
            else
            {
                return BadRequest(Edit.Message);
            }
        }

        [HttpPut]
        [Route("[action]")]
        public async Task<IActionResult> DeleteVehicle(string vehicleId)
        {
            var Edit = await _vehicle.DeleteVehicle(vehicleId);

            if (Edit.isSuccess == true)
            {
                return Ok(Edit.Message);
            }
            else
            {
                return BadRequest(Edit.Message);
            }
        }

        [HttpGet]
        [Route("[action]")]
        public async Task<IActionResult> GetVehicleById(string vehicleId)
        {
            var checkPermission = await _common.CheckPermission("N0002");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var vehicle = await _vehicle.GetVehicleById(vehicleId);
            return Ok(vehicle);
        }

        [HttpGet]
        [Route("[action]")]
        public async Task<IActionResult> GetListVehicleSelect()
        {
            var list = await _vehicle.GetListVehicleSelect();
            return Ok(list);
        }

        [HttpGet]
        [Route("[action]")]
        public async Task<IActionResult> GetListVehicle([FromQuery] PaginationFilter filter)
        {
            var checkPermission = await _common.CheckPermission("N0001");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var route = Request.Path.Value;
            var pagedData = await _vehicle.getListVehicle(filter);

            var pagedReponse = PaginationHelper.CreatePagedReponse<ListVehicleRequest>(pagedData.dataResponse, pagedData.paginationFilter, pagedData.totalCount, _uriService, route);
            return Ok(pagedReponse);
        }

    }
}
