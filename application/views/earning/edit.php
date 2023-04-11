      <div class="main-panel">
        <div class="content-wrapper">
          <div class="card">
            <div class="card-body">
              <h3>Edit Earning</h3>
              <div class="row">
                <div class="col-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                        <form method="POST" action="<?php echo site_url("slryed");?>" >
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-6">
                                    <label for="exampleInputName1">Date:</label>
                                    <input type="date"
                                name="sal_date"
                                class="form-control required"
                                id="sal_date"
                                value="<?php echo $earning_dtls->effective_date;?>"
                                readonly
                        />
                                    </div>
                                    <div class="col-6">
                                    <label for="exampleInputName1">Employee code:</label>
                                    <input type="text"
                                name="emp_code"
                                class="form-control required"
                                id="emp_code"
                                value="<?php echo $earning_dtls->emp_code;?>"
                                readonly
                        />

                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-6">
                                    <label for="exampleInputName1">Name:</label>
                                    <input type="text"
                                name="empname"
                                class="form-control required"
                                id="empname"
                                value="<?php echo $earning_dtls->emp_name;?>"
                                readonly
                        >
                  </div>
                                    <div class="col-6">
                                    <label for="exampleInputName1">Category:</label>
                                    <input type = "text"
                            class= "form-control"
                            name = "category"
                            id   = "category"
                            value="<?php echo $earning_dtls->category_type;?>"
                            readonly
                        />
                                    </div>
                                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-6">
                        <label for="exampleInputName1">District:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "dist"
                            id   = "dist"
                            value="<?php echo $earning_dtls->district_name;?>"
                            readonly required
                        />
                    </div>
                    <div class="col-6">
                        <label for="exampleInputName1">Basic Pay:</label>
                        <input type = "text"
                            class="form-control required"
                            name = "basic"
                            id   = "basic"
                            value="<?php echo $earning_dtls->basic_pay;?>"
                            readonly
                        />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-6">
                        <label for="exampleInputName1">DA:</label>
                        <input type = "text"
                            class="form-control required"
                            name = "da"
                            id   = "da"
                            value="<?php echo $earning_dtls->da_amt;?>"
                        />
                    </div>
                    <div class="col-6">
                        <label for="exampleInputName1">HRA:</label>
                        <input type = "text"
                            class="form-control required"
                            name = "hra"
                            id   = "hra"
                            value="<?php echo $earning_dtls->hra_amt;?>"
                        />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-6">
                        <label for="exampleInputName1">Medical Allowance:</label>
                        <input type = "text"
                            class="form-control required"
                            name = "ma"
                            id   = "ma"
                            value="<?php echo $earning_dtls->med_allow;?>"
                        />
                    </div>
                    <div class="col-6">
                        <label for="exampleInputName1">Other Allownce:</label>
                        <input type = "text"
                            class="form-control required"
                            name = "oa"
                            id   = "oa"
                            value="<?php echo $earning_dtls->othr_allow;?>"
                        />
                    </div>
                </div>
            </div>
                <button type="submit" class="btn btn-primary mr-2">Submit</button>
                            <button class="btn btn-light">Cancel</button>
                        </form>
                        </div>
                    </div>
                </div>
              </div>
            </div>

          </div>
        </div>