﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using TBSLogistics.Model.Filter;
using TBSLogistics.Model.Model.ProductServiceModel;
using TBSLogistics.Service.Helpers;
using TBSLogistics.Service.Panigation;
using TBSLogistics.Service.Services.Common;
using TBSLogistics.Service.Services.ProductServiceManage;

namespace TBSLogistics.ApplicationAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ProductServiceController : ControllerBase
    {
        private readonly IProduct _product;
        private readonly IPaginationService _pagination;
        private readonly ICommon _common;

        public ProductServiceController(IProduct product, IPaginationService pagination,ICommon common)
        {
            _product = product;
            _common = common;
            _pagination = pagination;
        }

        [HttpPost]
        [Route("[action]")]
        public async Task<IActionResult> CreateProductService(List<CreateProductServiceRequest> request)
        {
            var checkPermission = await _common.CheckPermission("C0003");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var Create = await _product.CreateProductService(request);

            if (Create.isSuccess == true)
            {
                return Ok(Create.Message);
            }
            else
            {
                return BadRequest(Create.Message);
            }
        }

        [HttpPut]
        [Route("[action]")]
        public async Task<IActionResult> UpdateProductService([FromForm] EditProductServiceRequest request)
        {
            var checkPermission = await _common.CheckPermission("C0004");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var editProductService = await _product.EditProductServiceRequest(request);
            if (editProductService.isSuccess == true)
            {
                return Ok(editProductService.Message);
            }
            else
            {
                return BadRequest(editProductService.Message);
            }
        }
        [HttpPut]
        [Route("[action]")]
        public async Task<IActionResult> DeleteProductServiceRequest(DeleteProductServiceRequest id)
        {
            var deleteProductService = await _product.DeleteProductServiceRequest(id);
            if (deleteProductService.isSuccess == true)
            {
                return Ok(deleteProductService.Message);
            }
            else
            {
                return BadRequest(deleteProductService.Message);
            }
        }
        [HttpPut]
        [Route("[action]")]
        public async Task<IActionResult> ApproveProductServiceRequestById(List<ApproveProductServiceRequestById> id)
        {
            var checkPermission = await _common.CheckPermission("C0002");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var approveProductService = await _product.ApproveProductServiceRequestById(id);
            if (approveProductService.isSuccess == true)
            {
                return Ok(approveProductService.Message);
            }
            else
            {
                return BadRequest(approveProductService.Message);
            }
        }
        //[HttpPut]
        //[Route("[action]")]
        //public async Task<IActionResult> ApproveProductServiceRequestByMaHD([FromForm] ApproveProductServiceRequestByMaHD request , int sttID)
        //{
        //    var approveProductService = await _product.ApproveProductServiceRequestByMaHD(request, sttID);
        //    if (approveProductService.isSuccess == true)
        //    {
        //        return Ok(approveProductService.Message);
        //    }
        //    else
        //    {
        //        return BadRequest(approveProductService.Message);
        //    }
        //}
        [HttpGet]
        [Route("[action]")]
        public async Task<IActionResult> GetProductServiceByIdRequest(int id)
        {
            var getProductServiceByIdRequest = await _product.GetProductServiceByIdRequest(id);
            return Ok(getProductServiceByIdRequest);

        }
        [HttpGet]
        [Route("[action]")]
        public async Task<IActionResult> GetListProductService([FromQuery] PaginationFilter filter)
        {
            var checkPermission = await _common.CheckPermission("C0001");
            if (checkPermission.isSuccess == false)
            {
                return BadRequest(checkPermission.Message);
            }

            var route = Request.Path.Value;
            var pagedData = await _product.GetListProductService(filter);
            var pagedReponse = PaginationHelper.CreatePagedReponse<ListProductServiceRequest>(pagedData.dataResponse, pagedData.paginationFilter, pagedData.totalCount, _pagination, route);
            return Ok(pagedReponse);
        }



        //[HttpGet]
        //[Route("[action]")]
        //public async Task<IActionResult> GetListProductServiceByMaHD([FromQuery] PaginationFilter filter, string MaHD)
        //{
        //    var route = Request.Path.Value;
        //    var pagedData = await _product.GetListProductServiceByMaHD(filter, MaHD);
        //    var pagedReponse = PaginationHelper.CreatePagedReponse<ListProductServiceRequest>(pagedData.dataResponse, pagedData.paginationFilter, pagedData.totalCount, _pagination, route);
        //    return Ok(pagedReponse);
        //}
        //[HttpGet]
        //[Route("[action]")]
        //public async Task<IActionResult> GetListProductServiceBy([FromQuery] PaginationFilter filter, int trangthai=2)
        //{
        //        var route = Request.Path.Value;
        //        var pagedData = await _product.GetListProductService(filter, trangthai);
        //    if(pagedData.totalCount<1)
        //    {
        //        return BadRequest(" trạng thái: " + trangthai + " không hợp lệ hoặc chưa có bản ghi ");
        //    }
        //    else
        //    { 
        //        var pagedReponse = PaginationHelper.CreatePagedReponse<ListProductServiceRequest>(pagedData.dataResponse, pagedData.paginationFilter, pagedData.totalCount, _pagination, route);
        //        return Ok(pagedReponse);
        //    }

        //}
        //[HttpGet]
        //[Route("[action]")]
        //public async Task<IActionResult> GetListProductServiceByDate([FromQuery] PaginationFilter filter, DateTime date)
        //{
        //    var route = Request.Path.Value;
        //    var pagedData = await _product.GetListProductServiceByDate(filter, date);
        //    var pagedReponse = PaginationHelper.CreatePagedReponse<ListProductServiceRequest>(pagedData.dataResponse, pagedData.paginationFilter, pagedData.totalCount, _pagination, route);
        //    return Ok(pagedReponse);
        //}
    }
}
