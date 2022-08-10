﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TBSLogistics.Model.CommonModel;
using TBSLogistics.Model.Filter;
using TBSLogistics.Model.Model.CustomerModel;
using TBSLogistics.Model.Model.CustommerModel;
using TBSLogistics.Model.Wrappers;

namespace TBSLogistics.Service.Repository.CustommerManage
{
    public interface ICustomer
    {
        Task<BoolActionResult> CreateCustomer(CreateCustomerRequest request);
        Task<BoolActionResult> EditCustomer(string CustomerId, EditCustomerRequest request);
        Task<GetCustomerRequest> GetCustomerById(string CustomerId);
        Task<List<GetCustomerRequest>> GetListCustomer();

        Task<PagedResponseCustom<ListCustommerRequest>> getListCustommer(PaginationFilter filter);

    }
}
