<div class="main-panel">
    <div class="content-wrapper">
        <div class="card">
            <div class="card-body">
                <h3>Employee Edit</h3>
                <div class="row">
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <form method="POST" id="myform" action="<?php echo site_url("estem"); ?>">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Employee Code:<span class="requiredfield">*</span></label>
                                                <input type="text" name="emp_code" class="form-control" id="emp_code" value="<?php echo $employee_dtls->emp_code; ?>" readonly />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">Employee Name:<span class="requiredfield">*</span></label>
                                                <input type="text" name="emp_name" class="form-control required" id="emp_name" value="<?php echo $employee_dtls->emp_name; ?>" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Category:<span class="requiredfield">*</span></label>
                                                <select class="form-control required" name="emp_catg" id="emp_catg">

                                                    <option value="">Select Category</option>

                                                    <?php foreach ($category_dtls as $c_list) {

                                                    ?>
                                                        <option value="<?php echo $c_list->id ?>" <?php echo ($employee_dtls->emp_catg == $c_list->id) ? 'selected' : ''; ?>>
                                                            <?php echo $c_list->category; ?>
                                                        </option>

                                                    <?php

                                                    }

                                                    ?>

                                                </select>
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">District:</label>
                                                <select class="form-control required" name="emp_dist" id="emp_dist">

                                                    <option value="">Select District</option>

                                                    <?php foreach ($dist_dtls as $dist) {
                                                    ?>
                                                        <option value="<?php echo $dist->district_code ?>" <?php echo ($employee_dtls->emp_dist == $dist->district_code) ? 'selected' : ''; ?>>
                                                            <?php echo $dist->district_name; ?>
                                                        </option>

                                                    <?php

                                                    }

                                                    ?>

                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Date of Birth:<span class="requiredfield">*</span></label>
                                                <input type="date" class="form-control" name="dob" id="dob" value="<?php if (isset($employee_dtls->dob)) {
                                                                                                                        echo $employee_dtls->dob;
                                                                                                                    }
                                                                                                                    ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">Joining Date:<span class="requiredfield">*</span></label>
                                                <input type="date" class="form-control" name="join_dt" id="join_dt" value="<?php if (isset($employee_dtls->join_dt)) {
                                                                                                                                echo $employee_dtls->join_dt;
                                                                                                                            }
                                                                                                                            ?>" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Retirement Date:</label>
                                                <input type="date" class="form-control" name="ret_dt" id="ret_dt" value="<?php if (isset($employee_dtls->ret_dt)) {
                                                                                                                                echo $employee_dtls->ret_dt;
                                                                                                                            } ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">Email:</label>
                                                <input type="email" class="form-control" name="email" id="email" value="<?php echo $employee_dtls->email; ?>" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Phone No.<span class="requiredfield">*</span></label>
                                                <input type="text" class="form-control" name="phn_no" id="phn_no" value="<?php echo $employee_dtls->phn_no; ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">Designation:</label>
                                                <input type="text" class="form-control required" name="designation" id="designation" value="<?php echo $employee_dtls->designation; ?>" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Department:</label>
                                                <select class="form-control" name="department" id="department">
                                                    <option value="">Select Department</option>
                                                    <?php
                                                    foreach ($dept as $dep) {
                                                        $selected = '';
                                                        if ($dep->id == $employee_dtls->department) {
                                                            $selected = 'selected';
                                                        } ?>
                                                        <option value="<?php echo $dep->id; ?>" <?= $selected ?>><?php echo $dep->name; ?></option>
                                                    <?php } ?>
                                                </select>
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">Address:</label>
                                                <textarea type="text" class="form-control required" name="emp_addr" id="emp_addr"><?php echo $employee_dtls->emp_addr; ?></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-header">

                                        <h4>Basic Pay</h4>

                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Basic Pay:<span class="requiredfield">*</span></label>
                                                <input type="text" class="form-control required" name="basic_pay" id="basic_pay" value="<?php echo $employee_dtls->basic_pay; ?>" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-header">
                                        <h4>Bank & Other Details</h4>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Bank Name:</label>
                                                <input type="text" class="form-control" name="bank_name" id="bank_name" value="<?php echo $employee_dtls->bank_name; ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">A/C No.:</label>
                                                <input type="text" class="form-control" name="bank_ac_no" id="bank_ac_no" value="<?php echo $employee_dtls->bank_ac_no; ?>" />
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">PF A/C No.:</label>
                                                <input type="text" class="form-control" name="pf_ac_no" id="pf_ac_no" value="<?php echo $employee_dtls->pf_ac_no; ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">UAN.:</label>
                                                <input type="text" class="form-control" name="uan" id="uan" value="<?php echo $employee_dtls->uan; ?>" />
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Pan No.:</label>
                                                <input type="text" class="form-control" name="pan_no" id="pan_no" value="<?php echo $employee_dtls->pan_no; ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">Aadhar No.:</label>
                                                <input type="text" class="form-control required" name="aadhar" id="aadhar" value="<?php echo $employee_dtls->aadhar_no; ?>" />
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">

                                            <div class="col-6">
                                                <label for="exampleInputName1">Status:</label>
                                                <select name='emp_status' class='form-control'>
                                                    <option value="A" <?php if ($employee_dtls->emp_status == 'A') echo 'selected'; ?>>Active</option>
                                                    <option value="R" <?php if ($employee_dtls->emp_status == 'R') echo 'selected'; ?>>Retired</option>
                                                    <option value="S" <?php if ($employee_dtls->emp_status == 'S') echo 'selected'; ?>>Suspended</option>
                                                    <option value="RG" <?php if ($employee_dtls->emp_status == 'RG') echo 'selected'; ?>>Resigned</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-12">
                                                <label for="exampleInputName1">Remarks:</label>
                                                <textarea class='form-control' name="remarks"></textarea>
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

    <script type="text/javascript">
        <?php if ($employee_dtls->emp_status == 'R' or $employee_dtls->emp_status == 'RG') { ?>
            $(document).ready(function() {
                $("#myform :input").prop("disabled", true);
            });
        <?php } ?>
    </script>