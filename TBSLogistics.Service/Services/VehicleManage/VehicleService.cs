﻿using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using TBSLogistics.Data.TMS;
using TBSLogistics.Model.CommonModel;
using TBSLogistics.Model.Filter;
using TBSLogistics.Model.Model.VehicleModel;
using TBSLogistics.Model.TempModel;
using TBSLogistics.Model.Wrappers;
using TBSLogistics.Service.Repository.Common;

namespace TBSLogistics.Service.Repository.VehicleManage
{
    public class VehicleService : IVehicle
    {
        private readonly ICommon _common;
        private readonly TMSContext _context;

        public VehicleService(ICommon common, TMSContext context)
        {
            _common = common;
            _context = context;
        }

        public async Task<BoolActionResult> CreateVehicle(CreateVehicleRequest request)
        {
            try
            {
                var checkExists = await _context.XeVanChuyen.Where(x => x.MaSoXe == request.MaSoXe).FirstOrDefaultAsync();

                if (checkExists != null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Xe này đã tồn tại trong dữ liệu" };
                }
                string ErrorValidate = await ValiateCreat(request.MaSoXe, request.MaLoaiPhuongTien, request.MaTaiXeMacDinh, request.TrongTaiToiThieu, request.TrongTaiToiDa, request.MaGps, request.MaGpsmobile, request.MaTaiSan, request.ThoiGianKhauHao, request.NgayHoatDong );
                if (ErrorValidate != "")
                {
                    return new BoolActionResult { isSuccess = false, Message = ErrorValidate };
                }

                await _context.XeVanChuyen.AddAsync(new XeVanChuyen()
                {
                    MaSoXe = request.MaSoXe,
                    MaLoaiPhuongTien = request.MaLoaiPhuongTien,
                    MaTaiXeMacDinh = request.MaTaiXeMacDinh,
                    TrongTaiToiThieu = request.TrongTaiToiThieu,
                    TrongTaiToiDa = request.TrongTaiToiDa,
                    MaGps = request.MaGps,
                    MaGpsmobile = request.MaGpsmobile,
                    MaTaiSan = request.MaTaiSan,
                    ThoiGianKhauHao = request.ThoiGianKhauHao,
                    NgayHoatDong = request.NgayHoatDong,
                    TrangThai =1,
                    UpdatedTime = DateTime.Now,
                    CreatedTime = DateTime.Now,
                });

                var result = await _context.SaveChangesAsync();

                if (result > 0)
                {
                    await _common.Log("VehicleManage", "UserId: " + TempData.UserID + " create new vehicle with id:" + request.MaSoXe);
                    return new BoolActionResult { isSuccess = true, Message = "Tạo mới xe thành công" };
                }
                else
                {
                    return new BoolActionResult { isSuccess = false, Message = "Tạo mới xe thất bại" };
                }
            }
            catch (Exception ex)
            {
                await _common.Log("VehicleManage", "UserId: " + TempData.UserID + " create new vehicle with ERROR:" + ex.ToString());
                return new BoolActionResult { isSuccess = false, Message = ex.ToString(), DataReturn = "Exception" };
            }
        }
        public async Task<BoolActionResult> EditVehicle(string vehicleId, EditVehicleRequest request)
        {
            try
            {
                var getVehicle = await _context.XeVanChuyen.Where(x => x.MaSoXe == vehicleId).FirstOrDefaultAsync();

                if (getVehicle == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Xe này không tồn tại trong dữ liệu" };
                }
                
                getVehicle.MaLoaiPhuongTien = request.MaLoaiPhuongTien;
                getVehicle.MaTaiXeMacDinh = request.MaTaiXeMacDinh;
                getVehicle.TrongTaiToiThieu = request.TrongTaiToiThieu;
                getVehicle.TrongTaiToiDa = request.TrongTaiToiDa;
                getVehicle.MaGps = request.MaGps;
                getVehicle.MaGpsmobile = request.MaGpsmobile;
                getVehicle.MaTaiSan = request.MaTaiSan;
                getVehicle.ThoiGianKhauHao = request.ThoiGianKhauHao;
                getVehicle.NgayHoatDong = request.NgayHoatDong;
                getVehicle.TrangThai = request.TrangThai;
                getVehicle.UpdatedTime = DateTime.Now;

                _context.Update(getVehicle);

                var result = await _context.SaveChangesAsync();

                if (result > 0)
                {
                    await _common.Log("VehicleManage", "UserId: " + TempData.UserID + " Update vehicle with id:" + vehicleId);
                    return new BoolActionResult { isSuccess = true, Message = "Cập nhật xe thành công" };
                }
                else
                {
                    return new BoolActionResult { isSuccess = false, Message = "Cập nhật xe thất bại" };
                }
            }
            catch (Exception ex)
            {
                await _common.Log("VehicleManage", "UserId: " + TempData.UserID + " Update vehicle with ERROR:" + ex.ToString());
                return new BoolActionResult { isSuccess = false, Message = "Cập nhật xe thất bại" };
            }
        }
        public async Task<BoolActionResult> DeleteVehicle(string vehicleId)
        {
            try
            {
                var getVehicle = await _context.XeVanChuyen.Where(x => x.MaSoXe == vehicleId).FirstOrDefaultAsync();

                if (getVehicle == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Xe này không tồn tại trong dữ liệu" };
                }
                var checktt = await _context.XeVanChuyen.Where(x => x.TrangThai == 1).FirstOrDefaultAsync();

                if (checktt == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Xe phải ở trạng thái hoạt động" };
                }
                getVehicle.TrangThai = 2;
                _context.Update(getVehicle);

                var result = await _context.SaveChangesAsync();

                if (result > 0)
                {
                    await _common.Log("VehicleManage", "UserId: " + TempData.UserID + " Delete vehicle with id:" + vehicleId);
                    return new BoolActionResult { isSuccess = true, Message = "Delete xe thành công" };
                }
                else
                {
                    return new BoolActionResult { isSuccess = false, Message = "Delete xe thất bại" };
                }
            }
            catch (Exception ex)
            {
                await _common.Log("VehicleManage", "UserId: " + TempData.UserID + " Delete vehicle with ERROR:" + ex.ToString());
                return new BoolActionResult { isSuccess = false, Message = "Delete xe thất bại" };
            }
        }
        public async Task<PagedResponseCustom<ListVehicleRequest>> getListVehicle(PaginationFilter filter)
        {
            try
            {
                var validFilter = new PaginationFilter(filter.PageNumber, filter.PageSize);

                var listData = from vehicle in _context.XeVanChuyen
                               orderby vehicle.CreatedTime descending
                               select new { vehicle };

                if (!string.IsNullOrEmpty(filter.Keyword))
                {
                    listData = listData.Where(x => x.vehicle.MaSoXe.Contains(filter.Keyword));
                }

                if (!string.IsNullOrEmpty(filter.fromDate.ToString()) && !string.IsNullOrEmpty(filter.toDate.ToString()))
                {
                    listData = listData.Where(x => x.vehicle.CreatedTime.Date >= filter.fromDate && x.vehicle.CreatedTime.Date <= filter.toDate);
                }

                var totalCount = await listData.CountAsync();

                var pagedData = await listData.Skip((validFilter.PageNumber - 1) * validFilter.PageSize).Take(validFilter.PageSize).Select(x => new ListVehicleRequest()
                {
                    MaSoXe = x.vehicle.MaSoXe,
                    MaLoaiPhuongTien = x.vehicle.MaLoaiPhuongTien,
                    MaTaiXeMacDinh = x.vehicle.MaTaiXeMacDinh,
                    TrongTaiToiThieu = x.vehicle.TrongTaiToiThieu,
                    TrongTaiToiDa = x.vehicle.TrongTaiToiDa,
                    MaGps = x.vehicle.MaGps,
                    MaGpsmobile = x.vehicle.MaGpsmobile,
                    MaTaiSan = x.vehicle.MaTaiSan,
                    ThoiGianKhauHao = x.vehicle.ThoiGianKhauHao,
                    NgayHoatDong = x.vehicle.NgayHoatDong,
                    TrangThai = x.vehicle.TrangThai,
                    UpdateTime = x.vehicle.UpdatedTime,
                    Createdtime = x.vehicle.CreatedTime,
                }).ToListAsync();

                return new PagedResponseCustom<ListVehicleRequest>()
                {
                    dataResponse = pagedData,
                    totalCount = totalCount,
                    paginationFilter = validFilter
                };
            }
            catch (Exception ex)
            {
                return new PagedResponseCustom<ListVehicleRequest>();
            }
        }
        public async Task<GetVehicleRequest> GetVehicleById(string vehicleId)
        {
            var vehicle = await _context.XeVanChuyen.Where(x => x.MaSoXe == vehicleId).Select(x => new GetVehicleRequest()
            {
                MaSoXe = x.MaSoXe,
                MaLoaiPhuongTien = x.MaLoaiPhuongTien,
                MaTaiXeMacDinh = x.MaTaiXeMacDinh,
                TrongTaiToiThieu = x.TrongTaiToiThieu,
                TrongTaiToiDa = x.TrongTaiToiDa,
                MaGps = x.MaGps,
                MaGpsmobile = x.MaGpsmobile,
                MaTaiSan = x.MaTaiSan,
                ThoiGianKhauHao = x.ThoiGianKhauHao,
                NgayHoatDong = x.NgayHoatDong,
                TrangThai = x.TrangThai,
                UpdateTime = x.UpdatedTime,
                Createdtime = x.CreatedTime,
            }).FirstOrDefaultAsync();

            return vehicle;
        } 
      private async Task<string> ValiateCreat(string MaSoXe, string MaLoaiPhuongTien, string MaTaiXeMacDinh, double? TrongTaiToiThieu, double? TrongTaiToiDa, string MaGps, string MaGpsmobile, string? MaTaiSan, int? ThoiGianKhauHao, DateTime? NgayHoatDong, string ErrorRow = "")
        {
            string ErrorValidate = "";
            if (MaSoXe.Length > 10 || MaSoXe.Length < 6)
            {
                ErrorValidate += "Lỗi Dòng >>> " + ErrorRow + " -Biển số xe phải từ 6-10 kí tự \r\n" + System.Environment.NewLine;
            }
            if (!Regex.IsMatch(MaSoXe, "^(?![_.])(?![_.])(?!.*[_.]{2})[a-zA-Z0-9 aAàÀảẢãÃáÁạẠăĂằẰẳẲẵẴắẮặẶâÂầẦẩẨẫẪấẤậẬbBcCdDđĐeEèÈẻẺẽẼéÉẹẸêÊềỀểỂễỄếẾệỆ fFgGhHiIìÌỉỈĩĨíÍịỊjJkKlLmMnNoOòÒỏỎõÕóÓọỌôÔồỒổỔỗỖốỐộỘơƠờỜởỞỡỠớỚợỢpPqQrRsStTu UùÙủỦũŨúÚụỤưƯừỪửỬữỮứỨựỰvVwWxXyYỳỲỷỶỹỸýÝỵỴzZ]+(?<![_.])$", RegexOptions.IgnoreCase))
            {
                ErrorValidate += "Lỗi Dòng >>> " + ErrorRow + " - Mã số xe không được chứa ký tự đặc biệt \r\n" + System.Environment.NewLine;
            }
            if (!Regex.IsMatch(MaSoXe, "^(?![_.])(?![_.])(?!.*[_.]{2})[A-Z0-9]+(?<![_.])$"))
            {
                ErrorValidate += " - Mã số xe phải viết hoa   \r\n";
            }
            var checkMapt = await _context.LoaiPhuongTien.Where(x => x.MaLoaiPhuongTien == MaLoaiPhuongTien).FirstOrDefaultAsync();

            if (checkMapt == null)
            {
                ErrorValidate += "Lỗi Dòng >>> " + ErrorRow + " - Mã Loại Phương Tiện: " + MaLoaiPhuongTien + " không tồn tại \r\n" + System.Environment.NewLine;
            }

            if (!string.IsNullOrEmpty(MaTaiXeMacDinh))
            {
                var checkMaTaiXe = await _context.TaiXe.Where(x => x.MaTaiXe == MaTaiXeMacDinh).FirstOrDefaultAsync();

                if (checkMaTaiXe == null)
                {
                    ErrorValidate += "Lỗi Dòng >>> " + ErrorRow + " - Mã Tài Xế: " + MaTaiXeMacDinh + " không tồn tại \r\n" + System.Environment.NewLine;
                }
            }
           
            if (NgayHoatDong != null)
            {
                if (!Regex.IsMatch(NgayHoatDong.Value.ToString("dd/MM/yyyy"), "^(((0[1-9]|[12][0-9]|30)[-/]?(0[13-9]|1[012])|31[-/]?(0[13578]|1[02])|(0[1-9]|1[0-9]|2[0-8])[-/]?02)[-/]?[0-9]{4}|29[-/]?02[-/]?([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00))$", RegexOptions.IgnoreCase))
                {
                    ErrorValidate += "Lỗi Dòng >>> " + ErrorRow + " - Sai định dạng ngày\r\n" + System.Environment.NewLine;
                }
            }
        

            return ErrorValidate;


       
        }
    }
}
