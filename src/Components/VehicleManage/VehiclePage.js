import { useMemo, useState, useEffect, useCallback, useRef } from "react";
import { getData, getDataCustom } from "../Common/FuncAxios";
import DataTable from "react-data-table-component";
import moment from "moment";
import { Modal } from "bootstrap";
import { ToastWarning } from "../Common/FuncToast";
import CreateVehicle from "./CreateVehicle";
import UpdateVehicle from "./UpdateVehicle";

const VehiclePage = () => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(false);
  const [totalRows, setTotalRows] = useState(0);
  const [perPage, setPerPage] = useState(10);
  const [keySearch, setKeySearch] = useState("");

  const [ShowModal, SetShowModal] = useState("");
  const [modal, setModal] = useState(null);
  const parseExceptionModal = useRef();

  const [selectedRows, setSelectedRows] = useState([]);
  const [selectIdClick, setSelectIdClick] = useState({});
  const [listStatus, setListStatus] = useState([]);

  const columns = useMemo(() => [
    {
      cell: (val) => (
        <button
          onClick={() => handleEditButtonClick(val, SetShowModal("Edit"))}
          type="button"
          className="btn btn-title btn-sm btn-default mx-1"
          gloss="Cập Nhật Thông Tin"
        >
          <i className="far fa-edit"></i>
        </button>
      ),
      ignoreRowClick: true,
      allowOverflow: true,
      button: true,
    },
    {
      name: "Mã Số Xe",
      selector: (row) => row.maSoXe,
    },
    {
      name: "Tài Xế Mặc Định",
      selector: (row) => row.maTaiXeMacDinh,
    },
    {
      name: "Phân Loại Xe",
      selector: (row) => row.maLoaiPhuongTien,
    },
    {
      name: "Trọng Tải Tối Thiểu",
      selector: (row) => row.trongTaiToiThieu,
    },
    {
      name: "Trọng Tải Tối Đa",
      selector: (row) => row.trongTaiToiDa,
    },
    {
      name: "Mã GPS",
      selector: (row) => row.maGps,
    },
    {
      name: "Mã GPS Mobile",
      selector: (row) => row.maGpsmobile,
    },
    {
      name: "Thời Gian cập nhật",
      selector: (row) => row.updatedtime,
      sortable: true,
    },
    {
      name: "Thời Gian tạo mới",
      selector: (row) => row.createdtime,
      sortable: true,
    },
  ]);

  const showModalForm = () => {
    const modal = new Modal(parseExceptionModal.current, {
      keyboard: false,
      backdrop: "static",
    });
    setModal(modal);
    modal.show();
  };

  const handleChange = useCallback((state) => {
    setSelectedRows(state.selectedRows);
  }, []);

  const handleEditButtonClick = async (val) => {
    showModalForm();
    var getById = await getData(
      `Vehicle/GetVehicleById?vehicleId=${val.maSoXe}`
    );
    setSelectIdClick(getById);
  };

  const fetchData = async (page, KeyWord = "") => {
    setLoading(true);

    if (KeyWord !== "") {
      KeyWord = keySearch;
    }

    const dataCus = await getData(
      `Vehicle/GetListVehicle?PageNumber=${page}&PageSize=${perPage}&KeyWord=${KeyWord}`
    );

    formatTable(dataCus.data);
    setTotalRows(dataCus.totalRecords);
    setLoading(false);
  };

  const handlePageChange = async (page) => {
    await fetchData(page);
  };

  const handlePerRowsChange = async (newPerPage, page) => {
    setLoading(true);

    const dataCus = await getData(
      `Vehicle/GetListVehicle?PageNumber=${page}&PageSize=${newPerPage}&KeyWord=${keySearch}`
    );

    formatTable(dataCus.data);
    setPerPage(newPerPage);
    setLoading(false);
  };

  const hideModal = () => {
    modal.hide();
  };

  useEffect(() => {
    setLoading(true);
    (async () => {
      let dataCus = await getData(
        `Vehicle/GetListVehicle?PageNumber=1&PageSize=10`
      );
      formatTable(dataCus.data);
      setTotalRows(dataCus.totalRecords);

      let getStatusList = await getDataCustom(`Common/GetListStatus`, [
        "common",
      ]);
      setListStatus(getStatusList);
    })();

    setLoading(false);
  }, []);

  function formatTable(data) {
    data.map((val) => {
      val.createdtime = moment(val.createdtime).format("DD/MM/YYYY HH:mm:ss");
      val.updatedtime = moment(val.updatedtime).format("DD/MM/YYYY HH:mm:ss");
    });
    setData(data);
  }

  const handleSearchClick = async () => {
    if (keySearch === "") {
      ToastWarning("Vui lòng nhập thông tin tìm kiếm");
      return;
    }
    await fetchData(1, keySearch);
  };

  const handleRefeshDataClick = async () => {
    setKeySearch("");
    await fetchData(1);
  };

  return (
    <>
      <section className="content-header">
        <div className="container-fluid">
          <div className="row mb-2">
            <div className="col-sm-6">
              <h1>Quản Lý Phương Tiện</h1>
            </div>
            {/* <div className="col-sm-6">
              <ol className="breadcrumb float-sm-right">
                <li className="breadcrumb-item">
                  <a href="#">Home</a>
                </li>
                <li className="breadcrumb-item active">Blank Page</li>
              </ol>
            </div> */}
          </div>
        </div>
      </section>

      <section className="content">
        <div className="card">
          <div className="card-header">
            <div className="container-fruid">
              <div className="row">
                <div className="col-sm-3">
                  <button
                    type="button"
                    className="btn btn-title btn-sm btn-default mx-1"
                    gloss="Tạo Mới Phương Tiện"
                    onClick={() => showModalForm(SetShowModal("Create"))}
                  >
                    <i className="fas fa-plus-circle"></i>
                  </button>
                </div>
                <div className="col-sm-3"></div>
                <div className="col-sm-3"></div>
                <div className="col-sm-3 ">
                  <div className="input-group input-group-sm">
                    <input
                      type="text"
                      className="form-control"
                      value={keySearch}
                      onChange={(e) => setKeySearch(e.target.value)}
                    />
                    <span className="input-group-append">
                      <button
                        type="button"
                        className="btn btn-sm btn-default"
                        onClick={() => handleSearchClick()}
                      >
                        <i className="fas fa-search"></i>
                      </button>
                    </span>
                    <button
                      type="button"
                      className="btn btn-sm btn-default mx-2"
                      onClick={() => handleRefeshDataClick()}
                    >
                      <i className="fas fa-sync-alt"></i>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div className="card-body">
            <div className="container-datatable" style={{ height: "50vm" }}>
              <DataTable
                title="Danh sách Phương Tiện"
                columns={columns}
                data={data}
                progressPending={loading}
                pagination
                paginationServer
                paginationTotalRows={totalRows}
                onSelectedRowsChange={handleChange}
                onChangeRowsPerPage={handlePerRowsChange}
                onChangePage={handlePageChange}
                highlightOnHover
                striped
                direction="auto"
                responsive
              />
            </div>
          </div>
          <div className="card-footer">
            <div className="row">
              <div className="col-sm-3">
                {/* <a
                  href={ExcelAddNewRoad}
                  download="Template Thêm mới cung đường.xlsx"
                  className="btn btn-sm btn-default mx-1"
                >
                  <i className="fas fa-download"></i>
                </a>
                <div className="upload-btn-wrapper">
                  <button className="btn btn-sm btn-default mx-1">
                    <i className="fas fa-upload"></i>
                  </button>
                  <input
                    type="file"
                    name="myfile"
                    onChange={(e) => handleExcelImportClick(e)}
                  />
                </div> */}
              </div>
            </div>
          </div>
        </div>
        <div
          className="modal fade"
          id="modal-xl"
          data-backdrop="static"
          ref={parseExceptionModal}
          aria-labelledby="parseExceptionModal"
          backdrop="static"
        >
          <div
            className="modal-dialog modal-dialog-scrollable"
            style={{ maxWidth: "80%" }}
          >
            <div className="modal-content">
              <div className="modal-header">
                <button
                  type="button"
                  className="close"
                  data-dismiss="modal"
                  onClick={() => hideModal()}
                  aria-label="Close"
                >
                  <span aria-hidden="true">×</span>
                </button>
              </div>
              <div className="modal-body">
                <>
                  {ShowModal === "Edit" && (
                    <UpdateVehicle
                      selectIdClick={selectIdClick}
                      listStatus={listStatus}
                      getListVehicle={fetchData}
                      hideModal={hideModal}
                    />
                  )}
                  {ShowModal === "Create" && (
                    <CreateVehicle
                      getListVehicle={fetchData}
                      listStatus={listStatus}
                    />
                  )}
                </>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default VehiclePage;