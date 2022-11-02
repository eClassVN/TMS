import { useMemo, useState, useEffect, useRef } from "react";
import { getData, getDataCustom, postData } from "../Common/FuncAxios";
import DataTable from "react-data-table-component";
import moment from "moment";
import { Modal } from "bootstrap";
import DatePicker from "react-datepicker";
import CreateSubFee from "./CreateSubFee";
import ApproveSubFee from "./ApproveSubFee";
import ConfirmDialog from "../Common/Dialog/ConfirmDialog";
import { ToastError } from "../Common/FuncToast";

const SubFeePage = () => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(false);
  const [totalRows, setTotalRows] = useState(0);
  const [perPage, setPerPage] = useState(10);
  const [keySearch, setKeySearch] = useState("");

  const [ShowModal, SetShowModal] = useState("");
  const [modal, setModal] = useState(null);
  const parseExceptionModal = useRef();

  const [fromDate, setFromDate] = useState("");
  const [toDate, setToDate] = useState("");
  const [toggledClearRows, setToggleClearRows] = useState(false);
  const [selectedRows, setSelectedRows] = useState([]);
  const [selectIdClick, setSelectIdClick] = useState({});
  const [listStatus, setListStatus] = useState([]);
  const [status, setStatus] = useState();

  const [ShowConfirm, setShowConfirm] = useState(false);
  const [functionSubmit, setFunctionSubmit] = useState("");

  const columns = useMemo(() => [
    {
      name: "Mã phụ phí",
      selector: (row) => row.priceId,
      sortable: true,
    },
    {
      name: "Loại Phụ Phí",
      selector: (row) => row.sfName,
      sortable: true,
    },
    {
      name: "Mã Hợp Đồng",
      selector: (row) => row.contractId,
      sortable: true,
    },
    {
      name: "Tên Hợp Đồng",
      selector: (row) => row.contractName,
    },
    {
      name: "Điểm 1",
      selector: (row) => row.firstPlace,
    },
    {
      name: "Điểm 2",
      selector: (row) => row.secondPlace,
    },
    {
      name: "Loại Hàng Hóa",
      selector: (row) => row.goodsType,
    },
    {
      name: "Đơn Giá",
      selector: (row) =>
        row.unitPrice.toLocaleString("vi-VI", {
          style: "currency",
          currency: "VND",
        }),
    },
    {
      name: "Thời gian Áp Dụng",
      selector: (row) => row.approvedDate,
      sortable: true,
    },
    {
      name: "Thời gian Hết Hiệu Lực",
      selector: (row) => row.deactiveDate,
      sortable: true,
    },
    {
      name: "Trạng Thái",
      selector: (row) => row.status,
      sortable: true,
    },
    {
      name: "Người Duyệt",
      selector: (row) => row.approver,
    },
    {
      name: "Thời gian Tạo",
      selector: (row) => moment(row.createdTime).format("DD-MM-YYYY HH:mm:ss"),
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

  const hideModal = () => {
    modal.hide();
  };

  const handleChange = (state) => {
    setSelectedRows(state.selectedRows);
  };
  const handleClearRows = () => {
    setToggleClearRows(!toggledClearRows);
  };

  const fetchData = async (
    page,
    KeyWord = "",
    fromDate = "",
    toDate = "",
    status = ""
  ) => {
    setLoading(true);

    if (KeyWord !== "") {
      KeyWord = keySearch;
    }
    fromDate = fromDate === "" ? "" : moment(fromDate).format("YYYY-MM-DD");
    toDate = toDate === "" ? "" : moment(toDate).format("YYYY-MM-DD");
    const dataCus = await getData(
      `SubFeePrice/GetListSubFeePrice?PageNumber=${page}&PageSize=${perPage}&KeyWord=${KeyWord}&fromDate=${fromDate}&toDate=${toDate}&statusId=${status}`
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
      `SubFeePrice/GetListSubFeePrice?PageNumber=${page}&PageSize=${newPerPage}&KeyWord=${keySearch}&fromDate=${fromDate}&toDate=${toDate}&statusId=${status}`
    );
    setPerPage(newPerPage);
    formatTable(dataCus.data);
    setTotalRows(dataCus.totalRecords);
    setLoading(false);
  };

  useEffect(() => {
    setLoading(true);
    (async () => {
      let getStatusList = await getDataCustom(`Common/GetListStatus`, [
        "SubFee",
      ]);
      setListStatus(getStatusList);
    })();

    fetchData(1);
    setLoading(false);
  }, []);

  function formatTable(data) {
    data.map((val) => {
      !val.approvedDate
        ? (val.approvedDate = "")
        : (val.approvedDate = moment(val.approvedDate).format("DD/MM/YYYY"));
      !val.deactiveDate
        ? (val.deactiveDate = "")
        : (val.deactiveDate = moment(val.deactiveDate).format("DD/MM/YYYY"));
    });
    setData(data);
  }

  const ShowConfirmDialog = () => {
    if (selectedRows.length < 1) {
      ToastError("Vui lòng chọn phụ phí trước đã");
      return;
    } else {
      setShowConfirm(true);
    }
  };

  const DisableSubFee = async () => {
    if (
      selectedRows &&
      selectedRows.length > 0 &&
      Object.keys(selectedRows).length > 0
    ) {
      let arr = [];
      selectedRows.map((val) => {
        arr.push(val.priceId);
      });

      const SetApprove = await postData(`SubFeePrice/DisableSubFeePrice`, arr);

      if (SetApprove === 1) {
        fetchData(1);
      }
      setSelectedRows([]);
      handleClearRows();
      setShowConfirm(false);
    }
  };

  const DeleteSubFee = async () => {
    if (
      selectedRows &&
      selectedRows.length > 0 &&
      Object.keys(selectedRows).length > 0
    ) {
      let arr = [];
      selectedRows.map((val) => {
        arr.push(val.priceId);
      });

      const SetApprove = await postData(`SubFeePrice/DeleteSubFeePrice`, arr);

      if (SetApprove === 1) {
        fetchData(1);
      }
      setSelectedRows([]);
      handleClearRows();
      setShowConfirm(false);
    }
  };

  const funcAgree = () => {
    if (functionSubmit && functionSubmit.length > 0) {
      switch (functionSubmit) {
        case "Disable":
          return DisableSubFee();
        case "Delete":
          return DeleteSubFee();
      }
    }
  };

  const handleSearchClick = () => {
    fetchData(1, keySearch, fromDate, toDate, status);
  };

  const handleOnChangeStatus = (value) => {
    setLoading(true);
    setStatus(value);
    fetchData(1, keySearch, fromDate, toDate, value);
    setLoading(false);
  };

  const handleRefeshDataClick = () => {
    setKeySearch("");
    setFromDate("");
    setToDate("");
    setPerPage(10);
    fetchData(1);
  };

  return (
    <>
      <section className="content-header">
        <div className="container-fluid">
          <div className="row mb-2">
            <div className="col-sm-6">
              <h1>Quản Lý Phụ Phí</h1>
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
                <div className="col col-sm">
                  <button
                    title="Thêm mới"
                    type="button"
                    className="btn btn-sm btn-default mx-1"
                    onClick={() =>
                      showModalForm(
                        SetShowModal("Create"),
                        setSelectIdClick({})
                      )
                    }
                  >
                    <i className="fas fa-plus-circle"></i>
                  </button>
                  <button
                    title="Approve List"
                    type="button"
                    className="btn btn-sm btn-default mx-1"
                    onClick={() =>
                      showModalForm(
                        SetShowModal("ApproveSubFee"),
                        setSelectIdClick({})
                      )
                    }
                  >
                    <i className="fas fa-check-double"></i>
                  </button>
                  <button
                    title="Bỏ Hiệu Lực"
                    type="button"
                    className="btn btn-sm btn-default mx-1"
                    onClick={() => {
                      setFunctionSubmit("Disable");
                      ShowConfirmDialog();
                    }}
                  >
                    <i className="fas fa-eye-slash"></i>
                  </button>
                  <button
                    title="Xóa"
                    type="button"
                    className="btn btn-sm btn-default mx-1"
                    onClick={() => {
                      setFunctionSubmit("Delete");
                      ShowConfirmDialog();
                    }}
                  >
                    <i className="fas fa-trash-alt"></i>
                  </button>
                </div>
                <div className="col col-sm">
                  <div className="row">
                    <div className="col col-sm"></div>
                    <div className="col col-sm">
                      <div className="input-group input-group-sm">
                        <select
                          className="form-control form-control-sm"
                          onChange={(e) => handleOnChangeStatus(e.target.value)}
                          value={status}
                        >
                          <option value="">Tất Cả Trạng Thái</option>
                          {listStatus &&
                            listStatus.map((val) => {
                              return (
                                <option value={val.statusId} key={val.statusId}>
                                  {val.statusContent}
                                </option>
                              );
                            })}
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="col col-sm">
                  <div className="row">
                    <div className="col col-sm">
                      <div className="input-group input-group-sm">
                        <DatePicker
                          selected={fromDate}
                          onChange={(date) => setFromDate(date)}
                          dateFormat="dd/MM/yyyy"
                          className="form-control form-control-sm"
                          placeholderText="Từ ngày"
                          value={fromDate}
                        />
                      </div>
                    </div>
                    <div className="col col-sm">
                      <div className="input-group input-group-sm">
                        <DatePicker
                          selected={toDate}
                          onChange={(date) => setToDate(date)}
                          dateFormat="dd/MM/yyyy"
                          className="form-control form-control-sm"
                          placeholderText="Đến Ngày"
                          value={toDate}
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <div className="col col-sm ">
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
                title="Danh sách Phụ Phí"
                columns={columns}
                data={data}
                progressPending={loading}
                pagination
                paginationServer
                selectableRows
                clearSelectedRows={toggledClearRows}
                paginationTotalRows={totalRows}
                onSelectedRowsChange={handleChange}
                onChangeRowsPerPage={handlePerRowsChange}
                onChangePage={handlePageChange}
                highlightOnHover
              />
            </div>
          </div>
          <div className="card-footer">
            <div className="row"></div>
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
            style={{ maxWidth: "95%" }}
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
                  {ShowModal === "Create" && (
                    <CreateSubFee getListSubFee={fetchData} />
                  )}
                  {ShowModal === "ApproveSubFee" && (
                    <ApproveSubFee getListSubFee={fetchData} />
                  )}
                </>
              </div>
            </div>
          </div>
        </div>
      </section>
      {ShowConfirm === true && (
        <ConfirmDialog
          setShowConfirm={setShowConfirm}
          title={"Bạn có chắc chắn với quyết định này?"}
          content={
            "Khi thực hiện hành động này sẽ không thể hoàn tác lại được nữa."
          }
          funcAgree={funcAgree}
        />
      )}
    </>
  );
};

export default SubFeePage;
