﻿using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using TBSLogistics.Data.TMS;
using TBSLogistics.Model.CommonModel;
using TBSLogistics.Model.Filter;
using TBSLogistics.Model.Model.BillOfLadingModel;
using TBSLogistics.Model.TempModel;
using TBSLogistics.Model.Wrappers;
using TBSLogistics.Service.Repository.Common;

namespace TBSLogistics.Service.Repository.BillOfLadingManage
{
    public class BillOfLadingService : IBillOfLading
    {
        private readonly ICommon _common;
        private readonly TMSContext _context;

        public BillOfLadingService(ICommon common, TMSContext context)
        {
            _common = common;
            _context = context;
        }

        public async Task<LoadDataHandling> LoadDataHandling(string RoadId)
        {
            var getListRoad = from cd in _context.CungDuong
                              join bg in _context.BangGia
                              on cd.MaCungDuong equals bg.MaCungDuong
                              join hd in _context.HopDongVaPhuLuc
                              on bg.MaHopDong equals hd.MaHopDong
                              join kh in _context.KhachHang
                              on hd.MaKh equals kh.MaKh
                              where
                                 cd.TrangThai == 1 &&
                                 bg.NgayApDung.Date <= DateTime.Now.Date
                                 && bg.NgayHetHieuLuc.Date >= DateTime.Now.Date
                                 && bg.TrangThai == 4
                                 && cd.MaCungDuong == RoadId
                              orderby bg.Id descending
                              select new { cd, bg, hd, kh };

            var gr = from t in getListRoad
                     group t by new { t.bg.MaCungDuong, t.bg.MaDvt, t.bg.MaLoaiHangHoa, t.bg.MaLoaiPhuongTien, t.bg.MaPtvc, t.bg.MaLoaiDoiTac, t.kh.MaKh }
                    into g
                     select new
                     {
                         MaCungDuong = g.Key.MaCungDuong,
                         MaDvt = g.Key.MaDvt,
                         MaLoaiHangHoa = g.Key.MaLoaiHangHoa,
                         MaLoaiPhuongTien = g.Key.MaLoaiPhuongTien,
                         MaPtvc = g.Key.MaPtvc,
                         MaLoaiDoiTac = g.Key.MaLoaiDoiTac,
                         MaKH = g.Key.MaKh,
                         Id = (from t2 in g select t2.bg.Id).Max(),
                     };

            getListRoad = getListRoad.Where(x => gr.Select(y => y.Id).Contains(x.bg.Id));

            var listRomooc = from rm in _context.Romooc join lrm in _context.LoaiRomooc on rm.MaLoaiRomooc equals lrm.MaLoaiRomooc select new { rm, lrm };

            var result = new LoadDataHandling()
            {
                ListNhaPhanPhoi = await getListRoad.Where(x => x.bg.MaLoaiDoiTac == "NCC").GroupBy(x => new { x.kh.MaKh, x.kh.TenKh }).Select(x => new NhaPhanPhoiSelect()
                {
                    MaNPP = x.Key.MaKh,
                    TenNPP = x.Key.TenKh
                }).ToListAsync(),
                ListKhachHang = await getListRoad.Where(x => x.bg.MaLoaiDoiTac == "KH").GroupBy(x => new { x.kh.MaKh, x.kh.TenKh }).Select(x => new KhachHangSelect()
                {
                    MaKH = x.Key.MaKh,
                    TenKH = x.Key.TenKh
                }).ToListAsync(),
                BangGiaVanDon = await getListRoad.Select(x => new BangGiaVanDon
                {
                    MaBangGia = x.bg.Id,
                    MaDoiTac = x.kh.MaKh,
                    PhanLoaiDoiTac = x.kh.MaLoaiKh,
                    PTVC = x.bg.MaPtvc,
                    DVT = x.bg.MaDvt,
                    PTVanChuyen = x.bg.MaLoaiPhuongTien,
                    LoaiHangHoa = x.bg.MaLoaiHangHoa,
                    Price = x.bg.DonGia,
                    MaCungDuong = x.bg.MaCungDuong
                }).ToListAsync(),
                ListTaiXe = await _context.TaiXe.Select(x => new DriverTransport()
                {
                    MaTaiXe = x.MaTaiXe,
                    TenTaiXe = x.HoVaTen,
                }).ToListAsync(),
                ListXeVanChuyen = await _context.XeVanChuyen.Select(x => new VehicleTransport()
                {
                    MaLoaiPhuongTien = x.MaLoaiPhuongTien,
                    MaSoXe = x.MaSoXe
                }).ToListAsync(),
                ListRomooc = await listRomooc.Select(x => new RomoocTransport()
                {
                    MaRomooc = x.rm.MaRomooc,
                    TenLoaiRomooc = x.lrm.TenLoaiRomooc
                }).ToListAsync()
            };
            return result;
        }

        public async Task<BoolActionResult> CreateHandling(CreateHandling request)
        {
            try
            {
                var transport = await _context.VanDon.Where(x => x.MaVanDon == request.MaVanDon).FirstOrDefaultAsync();

                if (transport == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Mã vận đơn không tồn tại" };
                }

                var checkRoad = await _context.CungDuong.Where(x => x.MaCungDuong == request.MaCungDuong).FirstOrDefaultAsync();

                if (checkRoad == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Cung đường không tồn tại" };
                }

                string ErrorValidate = "";
                int truck = 0;
                foreach (var item in request.DieuPhoi)
                {
                    truck += 1;
                    if (string.IsNullOrEmpty(item.NhaCungCap))
                    {
                        ErrorValidate += "Thùng hàng số " + truck + " Không được để trống Đơn vị vận tải";
                    }

                    if (item.NhaCungCap.Length != 8)
                    {
                        ErrorValidate += "Thùng hàng số " + truck + " Đơn vị vận tải phải dài 8 ký tự \r\n";
                    }

                    if (!Regex.IsMatch(item.NhaCungCap, "^(?![_.])(?![_.])(?!.*[_.]{2})[a-zA-Z0-9]+(?<![_.])$", RegexOptions.IgnoreCase))
                    {
                        ErrorValidate += "Thùng hàng số " + truck + " Đơn vị vận tải không được chứa ký tự đặc biệt \r\n";
                    }

                    if (string.IsNullOrEmpty(item.MaKh))
                    {
                        ErrorValidate += "Thùng hàng số " + truck + " Không được để trống đơn vị vận tải";
                    }

                    if (item.MaKh.Length != 8)
                    {
                        ErrorValidate += "Thùng hàng số " + truck + " Mã khách hàng phải dài 8 ký tự \r\n";
                    }

                    if (!Regex.IsMatch(item.MaKh, "^(?![_.])(?![_.])(?!.*[_.]{2})[a-zA-Z0-9]+(?<![_.])$", RegexOptions.IgnoreCase))
                    {
                        ErrorValidate += "Thùng hàng số " + truck + " Mã khách hàng không được chứa ký tự đặc biệt \r\n";
                    }

                    if (string.IsNullOrEmpty(item.GiaThamChieu.ToString()) || string.IsNullOrEmpty(item.GiaThucTe.ToString()))
                    {
                        ErrorValidate += "Thùng hàng số " + truck + " Phải có giá tham chiếu và giá thực tế \r\n";
                    }

                    if (!Regex.IsMatch(item.GiaThamChieu.ToString(), "^(?![_.])(?![_.])(?!.*[_.]{2})[0-9]+(?<![_.])$") ||
                        !Regex.IsMatch(item.GiaThucTe.ToString(), "^(?![_.])(?![_.])(?!.*[_.]{2})[0-9]+(?<![_.])$"))
                    {
                        ErrorValidate += "Thùng hàng số " + truck + " Giá tham chiếu hoặc giá thực tế không đúng định dạng \r\n";
                    }

                    if (string.IsNullOrEmpty(item.MaTaiXe) || string.IsNullOrEmpty(item.MaSoXe))
                    {
                        ErrorValidate += "Thùng hàng số " + truck + " Giá tham chiếu hoặc giá thực tế không đúng định dạng \r\n";
                    }

                    if (transport.LoaiVanDon == "xuat" && item.PTVanChuyen.Contains("Cont"))
                    {
                        if (string.IsNullOrEmpty(item.HangTau) || string.IsNullOrEmpty(item.TenTau))
                        {
                            ErrorValidate += "Thùng hàng số " + truck + " không được để trống hãng tàu và tên tàu \r\n";
                        }

                        if (string.IsNullOrEmpty(item.ThoiGianCatMang.ToString()))
                        {
                            ErrorValidate += "Thùng hàng số " + truck + " không được để trống thời gian cắt máng \r\n";
                        }
                    }

                    if (string.IsNullOrEmpty(ErrorValidate))
                    {
                        var checkNcc = await _context.KhachHang.Where(x => x.MaKh == item.NhaCungCap).FirstOrDefaultAsync();

                        if (checkNcc == null)
                        {
                            ErrorValidate += "Thùng hàng số " + truck + " Nhà cung cấp không tồn tại \r\n";
                        }

                        var checkKh = await _context.KhachHang.Where(x => x.MaKh == item.MaKh).FirstOrDefaultAsync();
                        if (checkKh == null)
                        {
                            ErrorValidate += "Thùng hàng số " + truck + " Khách hàng không tồn tại \r\n";
                        }

                        var checkDriver = await _context.TaiXe.Where(x => x.MaTaiXe == item.MaTaiXe).FirstOrDefaultAsync();
                        if (checkDriver == null)
                        {
                            ErrorValidate += "Thùng hàng số " + truck + " Tài xế không tồn tại \r\n";
                        }

                        var checkVehicle = await _context.XeVanChuyen.Where(x => x.MaSoXe == item.MaSoXe).FirstOrDefaultAsync();
                        if (checkVehicle == null)
                        {
                            ErrorValidate += "Thùng hàng số " + truck + " Xe vận chuyển không tồn tại \r\n";
                        }

                        if (checkVehicle.MaLoaiPhuongTien != item.PTVanChuyen)
                        {
                            ErrorValidate += "Thùng hàng số " + truck + " Loại xe không khớp với xe vận chuyển \r\n";
                        }

                        var checkPriceTable = await _context.BangGia.Where(x => x.Id == item.IdbangGia).FirstOrDefaultAsync();
                        if (checkPriceTable == null)
                        {
                            ErrorValidate += "Thùng hàng số " + truck + " Xe vận chuyển không tồn tại \r\n";
                        }
                    }
                }

                if (!string.IsNullOrEmpty(ErrorValidate))
                {
                    return new BoolActionResult { isSuccess = false, Message = ErrorValidate };
                }

                transport.TrangThai = 9;
                _context.VanDon.Update(transport);

                var handling = request.DieuPhoi.Select(x => new DieuPhoi()
                {
                    MaVanDon = request.MaVanDon,
                    MaSoXe = x.MaSoXe,
                    MaTaiXe = x.MaTaiXe,
                    DonViVanTai = x.NhaCungCap,
                    MaKh = x.MaKh,
                    HangTau = x.HangTau,
                    Tau = x.TenTau,
                    IdbangGia = x.IdbangGia,
                    GiaThamChieu = x.GiaThamChieu,
                    GiaThucTe = x.GiaThucTe,
                    MaRomooc = x.MaRomooc,
                    ContNo = x.ContNo,
                    SealNp = x.SealNp,
                    SealHq = x.SealHq,
                    KhoiLuong = x.KhoiLuong,
                    TheTich = x.TheTich,
                    GhiChu = x.GhiChu,
                    ThoiGianLayRong = x.ThoiGianLayRong,
                    ThoiGianHaCong = x.ThoiGianHaCong,
                    ThoiGianKeoCong = x.ThoiGianKeoCong,
                    ThoiGianHanLenh = x.ThoiGianHanLenh,
                    ThoiGianCoMat = x.ThoiGianCoMat,
                    ThoiGianCatMang = x.ThoiGianCatMang,
                    ThoiGianTraRong = x.ThoiGianTraRong,
                    ThoiGianLayHang = x.ThoiGianLayHang,
                    ThoiGianTraHang = x.ThoiGianTraHang,
                    TrangThai = 9,
                    CreatedTime = DateTime.Now,
                }).ToList();
                await _context.DieuPhoi.AddRangeAsync(handling);

                var result = await _context.SaveChangesAsync();

                if (result > 0)
                {
                    return new BoolActionResult { isSuccess = true, Message = "Tạo mới vận đơn thành công" };
                }
                else
                {
                    return new BoolActionResult { isSuccess = false, Message = "Tạo mới vận đơn thất bại" };
                }
            }
            catch (Exception ex)
            {
                return new BoolActionResult { isSuccess = false, Message = ex.ToString() };
            }
        }

        public async Task<BoolActionResult> CreateTransport(CreateTransport request)
        {
            try
            {
                if (request.MaCungDuong.Length != 10)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Mã cung đường không đúng" };
                }

                if (!Regex.IsMatch(request.MaCungDuong, "^(?![_.])(?![_.])(?!.*[_.]{2})[a-zA-Z0-9]+(?<![_.])$", RegexOptions.IgnoreCase))
                {
                    return new BoolActionResult { isSuccess = false, Message = "Mã cung đường không đúng" };
                }

                if (request.TongThungHang < 1 || request.TongKhoiLuong < 1 || request.TongTheTich < 1)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Tổng thùng hàng, tổng thể thích, tổng trọng lượng phải lớn hơn 0" };
                }

                if (!Regex.IsMatch(request.TongKhoiLuong.ToString(), "^(?:0\\.(?:0[0-9]|[0-9]\\d?)|[0-9]\\d*(?:\\.\\d{1,2})?)(?:e[+-]?\\d+)?$", RegexOptions.IgnoreCase)
                    || !Regex.IsMatch(request.TongTheTich.ToString(), "^(?:0\\.(?:0[0-9]|[0-9]\\d?)|[0-9]\\d*(?:\\.\\d{1,2})?)(?:e[+-]?\\d+)?$", RegexOptions.IgnoreCase))
                {
                    return new BoolActionResult { isSuccess = false, Message = "Tổng thể thích, Tổng trọng lượng không đúng định dạng" };
                }

                if (!Regex.IsMatch(request.TongThungHang.ToString(), "^[0-9]*$", RegexOptions.IgnoreCase))
                {
                    return new BoolActionResult { isSuccess = false, Message = "Tổng thùng hàng không đúng định dạng" };
                }

                var checkRoad = await _context.CungDuong.Where(x => x.MaCungDuong == request.MaCungDuong).FirstOrDefaultAsync();
                if (checkRoad == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Cung đường không tồn tại" };
                }

                var getMaxTransportID = await _context.VanDon.OrderByDescending(x => x.MaVanDon).Select(x => x.MaVanDon).FirstOrDefaultAsync();
                string transPortId = "";

                if (string.IsNullOrEmpty(getMaxTransportID))
                {
                    transPortId = DateTime.Now.ToString("yy") + "00000001";
                }
                else
                {
                    transPortId = DateTime.Now.ToString("yy") + (int.Parse(getMaxTransportID.Substring(2, getMaxTransportID.Length - 2)) + 1).ToString("00000000");
                }

                await _context.VanDon.AddRangeAsync(new VanDon()
                {
                    MaVanDon = transPortId,
                    LoaiVanDon = request.LoaiVanDon,
                    MaCungDuong = request.MaCungDuong,
                    TongThungHang = request.TongThungHang,
                    TongKhoiLuong = request.TongKhoiLuong,
                    TongTheTich = request.TongTheTich,
                    ThoiGianLayHang = request.ThoiGianLayHang,
                    ThoiGianTraHang = request.ThoiGianTraHang,
                    TrangThai = 8,
                    ThoiGianTaoDon = DateTime.Now,
                    CreatedTime = DateTime.Now
                });

                var result = await _context.SaveChangesAsync();

                if (result > 0)
                {
                    return new BoolActionResult { isSuccess = true, Message = "Tạo vận đơn thành công" };
                }
                else
                {
                    return new BoolActionResult { isSuccess = false, Message = "Tạo vận đơn thất Bại" };
                }
            }
            catch (Exception ex)
            {
                return new BoolActionResult { isSuccess = false, Message = ex.ToString() };
            }
        }

        public async Task<GetTransport> GetTransportById(string transportId)
        {
            try
            {
                var getTransport = from transport in _context.VanDon
                                   join road in _context.CungDuong
                                   on transport.MaCungDuong equals road.MaCungDuong
                                   where transport.MaVanDon == transportId
                                   select new { transport, road };

                return await getTransport.Select(x => new GetTransport()
                {
                    MaVanDon = x.transport.MaVanDon,
                    LoaiVanDon = x.transport.LoaiVanDon,
                    CungDuong = x.road.MaCungDuong,
                    DiemLayRong = _context.DiaDiem.Where(y => y.MaDiaDiem == x.road.DiemLayRong).Select(y => y.TenDiaDiem).FirstOrDefault(),
                    DiemLayHang = _context.DiaDiem.Where(y => y.MaDiaDiem == x.road.DiemDau).Select(y => y.TenDiaDiem).FirstOrDefault(),
                    DiemTraHang = _context.DiaDiem.Where(y => y.MaDiaDiem == x.road.DiemCuoi).Select(y => y.TenDiaDiem).FirstOrDefault(),
                    TongThungHang = x.transport.TongThungHang,
                    TongTrongLuong = x.transport.TongKhoiLuong,
                    ThoiGianLayHang = x.transport.ThoiGianLayHang,
                    ThoiGianTraHang = x.transport.ThoiGianTraHang,
                    ThoiGianTaoDon = x.transport.ThoiGianTaoDon,
                }).FirstOrDefaultAsync();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public async Task<BoolActionResult> UpdateTransport(string transPortId, UpdateTransport request)
        {
            try
            {
                var checkTransport = await _context.VanDon.Where(x => x.MaVanDon == transPortId).FirstOrDefaultAsync();

                if (checkTransport == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Mã vận đơn không tồn tại" };
                }

                var checkRoad = await _context.CungDuong.Where(x => x.MaCungDuong == request.MaCungDuong).FirstOrDefaultAsync();
                if (checkRoad == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Cung đường không tồn tại" };
                }

                if (checkTransport.TrangThai != 8)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Vận đơn này không thể sửa nữa" };
                }

                checkTransport.LoaiVanDon = request.LoaiVanDon;
                checkTransport.MaCungDuong = request.MaCungDuong;
                checkTransport.TongThungHang = request.TongThungHang;
                checkTransport.TongKhoiLuong = request.TongKhoiLuong;
                checkTransport.TongTheTich = request.TongTheTich;
                checkTransport.ThoiGianLayHang = request.ThoiGianLayHang;
                checkTransport.ThoiGianTraHang = request.ThoiGianTraHang;

                _context.VanDon.Update(checkTransport);

                var result = await _context.SaveChangesAsync();

                if (result > 0)
                {
                    return new BoolActionResult { isSuccess = true, Message = "Cập nhật vận đơn thành công" };
                }
                else
                {
                    return new BoolActionResult { isSuccess = false, Message = "Tạo vận đơn thất Bại" };
                }
            }
            catch (Exception ex)
            {
                return new BoolActionResult { isSuccess = false, Message = ex.ToString() };
            }
        }

        public async Task<PagedResponseCustom<ListTransport>> GetListTransport(PaginationFilter filter)
        {
            var validFilter = new PaginationFilter(filter.PageNumber, filter.PageSize);

            var listData = from transport in _context.VanDon
                           join
                          status in _context.StatusText
                          on
                          transport.TrangThai equals status.StatusId
                           join road in _context.CungDuong
                           on
                           transport.MaCungDuong equals road.MaCungDuong
                           where status.LangId == TempData.LangID
                           orderby transport.ThoiGianTaoDon descending
                           select new { transport, status, road };

            if (!string.IsNullOrEmpty(filter.Keyword))
            {
                listData = listData.Where(x => x.transport.MaVanDon.Contains(filter.Keyword));
            }

            if (!string.IsNullOrEmpty(filter.Status))
            {
                listData = listData.Where(x => x.status.StatusId == int.Parse(filter.Status));
            }

            if (!string.IsNullOrEmpty(filter.fromDate.ToString()) && !string.IsNullOrEmpty(filter.toDate.ToString()))
            {
                listData = listData.Where(x => x.transport.ThoiGianTaoDon.Date >= filter.fromDate.Value.Date && x.transport.ThoiGianTaoDon.Date <= filter.toDate.Value.Date);
            }

            var totalCount = await listData.CountAsync();

            var pagedData = await listData.Skip((validFilter.PageNumber - 1) * validFilter.PageSize).Take(validFilter.PageSize).Select(x => new ListTransport()
            {
                MaVanDon = x.transport.MaVanDon,
                LoaiVanDon = x.transport.LoaiVanDon,
                MaCungDuong = x.road.MaCungDuong,
                TenCungDuong = x.road.TenCungDuong,
                DiemLayRong = _context.DiaDiem.Where(y => y.MaDiaDiem == x.road.DiemLayRong).Select(y => y.TenDiaDiem).FirstOrDefault(),
                DiemLayHang = _context.DiaDiem.Where(y => y.MaDiaDiem == x.road.DiemDau).Select(y => y.TenDiaDiem).FirstOrDefault(),
                DiemTraHang = _context.DiaDiem.Where(y => y.MaDiaDiem == x.road.DiemCuoi).Select(y => y.TenDiaDiem).FirstOrDefault(),
                TongThungHang = x.transport.TongThungHang,
                TongKhoiLuong = x.transport.TongKhoiLuong,
                TongTheTich = x.transport.TongTheTich,
                ThoiGianLayHang = x.transport.ThoiGianLayHang,
                ThoiGianTraHang = x.transport.ThoiGianTraHang,
                TrangThai = x.status.StatusContent,
                MaTrangThai = x.status.StatusId,
                ThoiGianTaoDon = x.transport.ThoiGianTaoDon,
            }).ToListAsync();

            return new PagedResponseCustom<ListTransport>()
            {
                dataResponse = pagedData,
                totalCount = totalCount,
                paginationFilter = validFilter
            };
        }

        public async Task<List<ListHandling>> GetListHandlingByTransportId(string transPortId)
        {
            try
            {
                var data = from vd in _context.VanDon
                           join
                           dp in _context.DieuPhoi
                           on vd.MaVanDon equals dp.MaVanDon
                           join bg in _context.BangGia
                           on dp.IdbangGia equals bg.Id
                           join tt in _context.StatusText
                           on dp.TrangThai equals tt.StatusId
                           where vd.MaVanDon == transPortId
                           && tt.LangId == TempData.LangID
                           orderby dp.ThoiGianLayHang descending, dp.ThoiGianTraHang descending
                           select new { vd, dp, bg, tt };

                return await data.Select(x => new ListHandling()
                {
                    MaVanDon = x.dp.MaVanDon,
                    PhanLoaiVanDon = x.vd.LoaiVanDon,
                    MaDieuPhoi = x.dp.Id,
                    MaSoXe = x.dp.MaSoXe,
                    TenTaiXe = _context.TaiXe.Where(y => y.MaTaiXe == x.dp.MaTaiXe).Select(y => y.HoVaTen).FirstOrDefault(),
                    PTVanChuyen = x.bg.MaLoaiPhuongTien,
                    TenTau = x.dp.Tau,
                    HangTau = x.dp.HangTau,
                    GiaThucTe = x.dp.GiaThucTe,
                    MaRomooc = x.dp.MaRomooc,
                    ContNo = x.dp.ContNo,
                    KhoiLuong = x.dp.KhoiLuong,
                    TheTich = x.dp.TheTich,
                    ThoiGianLayRong = x.dp.ThoiGianLayRong,
                    ThoiGianKeoCong = x.dp.ThoiGianKeoCong,
                    ThoiGianHanLenh = x.dp.ThoiGianHanLenh,
                    ThoiGianCoMat = x.dp.ThoiGianCoMat,
                    ThoiGianCatMang = x.dp.ThoiGianCatMang,
                    ThoiGianTraRong = x.dp.ThoiGianTraRong,
                    ThoiGianLayHang = x.dp.ThoiGianLayHang,
                    ThoiGianTraHang = x.dp.ThoiGianTraHang,
                    TrangThai = x.tt.StatusContent
                }).ToListAsync();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public async Task<GetHandling> GetHandlingById(int id)
        {
            try
            {
                var getHandling = from vd in _context.VanDon
                                  join
                                  dp in _context.DieuPhoi
                                  on vd.MaVanDon equals dp.MaVanDon
                                  join bg in _context.BangGia
                                  on dp.IdbangGia equals bg.Id
                                  where dp.Id == id
                                  select new { vd, dp, bg };

                var data = await getHandling.FirstOrDefaultAsync();

                var getRoad = await _context.CungDuong.Where(x => x.MaCungDuong == data.bg.MaCungDuong).FirstOrDefaultAsync();

                var RoadDetail = new RoadDetail()
                {
                    MaCungDuong = getRoad.MaCungDuong,
                    TenCungDuong = getRoad.TenCungDuong,
                    DiemLayRong = await _context.DiaDiem.Where(x => x.MaDiaDiem == getRoad.DiemLayRong).Select(x => x.TenDiaDiem).FirstOrDefaultAsync(),
                    DiemLayHang = await _context.DiaDiem.Where(x => x.MaDiaDiem == getRoad.DiemDau).Select(x => x.TenDiaDiem).FirstOrDefaultAsync(),
                    DiemTraHang = await _context.DiaDiem.Where(x => x.MaDiaDiem == getRoad.DiemCuoi).Select(x => x.TenDiaDiem).FirstOrDefaultAsync()
                };

                return new GetHandling()
                {
                    CungDuong = RoadDetail,
                    PhanLoaiVanDon = data.vd.LoaiVanDon,
                    MaVanDon = data.vd.MaVanDon,
                    MaCungDuong = data.vd.MaCungDuong,
                    MaSoXe = data.dp.MaSoXe,
                    MaTaiXe = data.dp.MaTaiXe,
                    NhaCungCap = data.dp.DonViVanTai,
                    PTVanChuyen = data.bg.MaLoaiPhuongTien,
                    MaKh = data.dp.MaKh,
                    TenTau = data.dp.Tau,
                    HangTau = data.dp.HangTau,
                    IdbangGia = data.bg.Id,
                    GiaThamChieu = data.dp.GiaThamChieu,
                    GiaThucTe = data.dp.GiaThucTe,
                    LoaiHangHoa = data.bg.MaLoaiHangHoa,
                    MaRomooc = data.dp.MaRomooc,
                    ContNo = data.dp.ContNo,
                    SealNp = data.dp.SealNp,
                    SealHq = data.dp.SealHq,
                    KhoiLuong = data.dp.KhoiLuong,
                    TheTich = data.dp.TheTich,
                    GhiChu = data.dp.GhiChu,
                    ThoiGianLayRong = data.dp.ThoiGianLayRong,
                    ThoiGianHaCong = data.dp.ThoiGianHaCong,
                    ThoiGianKeoCong = data.dp.ThoiGianKeoCong,
                    ThoiGianHanLenh = data.dp.ThoiGianHanLenh,
                    ThoiGianCoMat = data.dp.ThoiGianCoMat,
                    ThoiGianCatMang = data.dp.ThoiGianCatMang,
                    ThoiGianTraRong = data.dp.ThoiGianTraRong,
                    ThoiGianLayHang = data.dp.ThoiGianLayHang,
                    ThoiGianTraHang = data.dp.ThoiGianTraHang,
                };
            }
            catch (Exception)
            {
                throw;
            }
        }

        public async Task<BoolActionResult> UpdateHandling(int id, UpdateHandling request)
        {
            try
            {
                if (request.KhoiLuong == null || request.TheTich == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Không được để trống Khối Lượng, Thể Tích" };
                }

                if (string.IsNullOrEmpty(request.SealNp))
                {
                    return new BoolActionResult { isSuccess = false, Message = "Không được để trống  SealNP" };
                }

                if (request.PTVanChuyen.Contains("Cont"))
                {
                    if (string.IsNullOrEmpty(request.ContNo) || string.IsNullOrEmpty(request.SealHq))
                    {
                        return new BoolActionResult { isSuccess = false, Message = "Không được để trống ContNo, Seal HQ" };
                    }

                    if (string.IsNullOrEmpty(request.ThoiGianLayRong.ToString()) || string.IsNullOrEmpty(request.ThoiGianKeoCong.ToString())
                  || string.IsNullOrEmpty(request.ThoiGianHanLenh.ToString()) || string.IsNullOrEmpty(request.ThoiGianCoMat.ToString())
                  || string.IsNullOrEmpty(request.ThoiGianTraRong.ToString()) || string.IsNullOrEmpty(request.ThoiGianLayHang.ToString())
                  || string.IsNullOrEmpty(request.ThoiGianTraHang.ToString()))
                    {
                        return new BoolActionResult { isSuccess = false, Message = "Không được để trống các trường thời gian" };
                    }
                }
                else
                {
                    if (string.IsNullOrEmpty(request.ThoiGianCoMat.ToString())
                 || string.IsNullOrEmpty(request.ThoiGianLayHang.ToString())
                 || string.IsNullOrEmpty(request.ThoiGianTraHang.ToString()))
                    {
                        return new BoolActionResult { isSuccess = false, Message = "Không được để trống các trường thời gian" };
                    }
                }

                var checkById = await _context.DieuPhoi.Where(x => x.Id == id).FirstOrDefaultAsync();

                if (checkById == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Mã điều phối không tồn tại" };
                }

                var transport = await _context.VanDon.Where(x => x.MaVanDon == checkById.MaVanDon).FirstOrDefaultAsync();

                if (transport.LoaiVanDon == "xuat" && request.PTVanChuyen.Contains("Cont"))
                {
                    if (string.IsNullOrEmpty(request.HangTau) || string.IsNullOrEmpty(request.TenTau))
                    {
                        return new BoolActionResult { isSuccess = false, Message = "Không được để trống hãng tàu và tên tàu \r\n" };
                    }

                    if (string.IsNullOrEmpty(request.ThoiGianCatMang.ToString()))
                    {
                        return new BoolActionResult { isSuccess = false, Message = "Không được để trống thời gian cắt máng \r\n" };
                    }
                }

                var checkDriver = await _context.TaiXe.Where(x => x.MaTaiXe == request.MaTaiXe).FirstOrDefaultAsync();
                if (checkDriver == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = " Tài xế không tồn tại \r\n" };
                }

                var checkVehicle = await _context.XeVanChuyen.Where(x => x.MaSoXe == request.MaSoXe).FirstOrDefaultAsync();
                if (checkVehicle == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = " Xe vận chuyển không tồn tại \r\n" };
                }

                if (checkVehicle.MaLoaiPhuongTien != request.PTVanChuyen)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Loại xe không khớp với xe vận chuyển \r\n" };
                }

                checkById.MaSoXe = request.MaSoXe;
                checkById.MaTaiXe = request.MaTaiXe;
                checkById.SealNp = request.SealNp;
                checkById.KhoiLuong = request.KhoiLuong;
                checkById.TheTich = request.TheTich;
                checkById.GhiChu = request.GhiChu;
                checkById.ThoiGianCoMat = request.ThoiGianCoMat;
                checkById.ThoiGianLayHang = request.ThoiGianLayHang;
                checkById.ThoiGianTraHang = request.ThoiGianTraHang;

                var checkTransportType = await _context.VanDon.Where(x => x.MaVanDon == checkById.MaVanDon).FirstOrDefaultAsync();
                if (checkTransportType.LoaiVanDon == "xuat")
                {
                    checkById.Tau = request.TenTau;
                    checkById.HangTau = request.HangTau;
                    checkById.ThoiGianCatMang = request.ThoiGianCatMang;
                }

                var checkVehicleType = await _context.BangGia.Where(x => x.Id == checkById.IdbangGia).FirstOrDefaultAsync();
                if (checkVehicleType.MaLoaiPhuongTien.Contains("CONT"))
                {
                    checkById.MaRomooc = request.MaRomooc;
                    checkById.ContNo = request.ContNo;
                    checkById.SealHq = request.SealHq;
                    checkById.ThoiGianLayRong = request.ThoiGianLayRong;
                    checkById.ThoiGianTraRong = request.ThoiGianTraRong;
                    checkById.ThoiGianHaCong = request.ThoiGianHaCong;
                    checkById.ThoiGianKeoCong = request.ThoiGianKeoCong;
                    checkById.ThoiGianHanLenh = request.ThoiGianHanLenh;
                }

                _context.DieuPhoi.Update(checkById);

                var result = await _context.SaveChangesAsync();

                if (result > 0)
                {
                    return new BoolActionResult { isSuccess = true, Message = "Cập nhật thành công" };
                }
                else
                {
                    return new BoolActionResult { isSuccess = true, Message = "Cập nhật thất bại" };
                }
            }
            catch (Exception ex)
            {
                return new BoolActionResult { isSuccess = true, Message = ex.ToString() };
            }
        }

        public async Task<List<Attachment>> GetListImageByHandlingId(int handlingId)
        {
            var list = await _context.Attachment.Where(x => x.DieuPhoiId == handlingId).ToListAsync();
            return list.Select(x => new Attachment()
            {
                Id = x.Id,
                FileName = x.FileName,
                FileType = x.FileType,
                FilePath = Path.Combine(Directory.GetCurrentDirectory(), x.FilePath),
                UploadedTime = x.UploadedTime
            }).ToList();
        }

        public async Task<BoolActionResult> DeleteImageById(int imageId)
        {
            try
            {
                var image = await _context.Attachment.Where(x => x.Id == imageId).FirstOrDefaultAsync();

                if (image == null)
                {
                    return new BoolActionResult { isSuccess = false, Message = "Hình ảnh không tồn tại" };
                }

                await _common.DeleteFileAsync(image.FileName, image.FilePath);

                _context.Attachment.Remove(image);

                var result = await _context.SaveChangesAsync();

                if (result > 0)
                {
                    return new BoolActionResult { isSuccess = true, Message = "Xóa hình ảnh thành công" };
                }
                else
                {
                    return new BoolActionResult { isSuccess = false, Message = "Xóa hình ảnh thất bại" };
                }
            }
            catch (Exception ex)
            {
                return new BoolActionResult { isSuccess = false, Message = ex.ToString() };
            }
        }

        public async Task<BoolActionResult> UploadFile(UploadImagesHandling request)
        {
            var PathFolder = $"/Transport/{request.transportId}/{request.handlingId}";

            if (request.files.Files.Count < 1)
            {
                return new BoolActionResult { isSuccess = false, Message = "Không có file nào" };
            }

            var checkTrasnport = await _context.DieuPhoi.Where(x => x.MaVanDon == request.transportId && x.Id == request.handlingId).FirstOrDefaultAsync();

            if (checkTrasnport == null)
            {
                return new BoolActionResult { isSuccess = false, Message = "Điều phối không tồn tại trong vận đơn" };
            }

            foreach (var fileItem in request.files.Files)
            {
                var originalFileName = ContentDispositionHeaderValue.Parse(fileItem.ContentDisposition).FileName.Trim('"');
                var supportedTypes = new[] { "jpg", "jpeg", "png" };
                var fileExt = System.IO.Path.GetExtension(originalFileName).Substring(1);
                if (!supportedTypes.Contains(fileExt))
                {
                    return new BoolActionResult { isSuccess = false, Message = "File không được hỗ trợ" };
                }

                var reNameFile = originalFileName.Replace(originalFileName.Substring(0, originalFileName.LastIndexOf('.')), Guid.NewGuid().ToString());
                var fileName = $"{reNameFile.Substring(0, reNameFile.LastIndexOf('.'))}{Path.GetExtension(reNameFile)}";

                var attachment = new Attachment()
                {
                    FileName = fileName,
                    FilePath = _common.GetFileUrl(fileName, PathFolder),
                    FileSize = fileItem.Length,
                    FileType = Path.GetExtension(fileName),
                    FolderName = "Transport",
                    DieuPhoiId = request.handlingId,
                    UploadedTime = DateTime.Now
                };

                var add = await _common.AddAttachment(attachment);

                if (add.isSuccess == false)
                {
                    return new BoolActionResult { isSuccess = false, Message = add.Message };
                }
                await _common.SaveFileAsync(fileItem.OpenReadStream(), fileName, PathFolder);
            }

            return new BoolActionResult { isSuccess = true,Message="Upload hình ảnh thành công" };
        }
    }
}