<script>
    function printDiv() {

        var divToPrint = document.getElementById('divToPrint');
        var WindowObject = window.open('', 'Print-Window');
        WindowObject.document.open();
        WindowObject.document.writeln('<!DOCTYPE html>');
        WindowObject.document.writeln('<html><head><title></title><style type="text/css">');
        WindowObject.document.writeln('@media print { .center { text-align: center;} .underline { text-decoration: underline; } p { display:inline; } .left { margin-left: 315px; text-align="left" display: inline; } .right { margin-right: 375px; display: inline; } td.left_algn { text-align: left; } td.right_algn { text-align: right; } .t2 td, th { border: 1px solid black; } td.hight { hight: 15px; } table.width { width: 100%; } table.noborder { border: 0px solid black; } th.noborder { border: 0px solid black; } .border { border: 1px solid black; } .bottom { position: absolute; bottom: 5px; width: 100%;} .payslip_logo_Desc_Uts h3{font-size: 18px; margin: 0 0 6px 0; font-family: "Roboto", sans-serif;} .payslip_logo_Desc_Uts h4{font-size: 14px; margin: 0 0 5px 0; font-family: "Roboto", sans-serif;}  table.table_1_Uts{font-family: "Roboto", sans-serif; font-size: 14px;}  table.table_1_Uts{font-family: "Roboto", sans-serif; font-size: 14px;} .payslip_logo_Uts{float:left; max-width: 16.66667%; padding-right:15px;} .payslip_logo_Desc_Uts{float:left; max-width: 83.33333%;} table.payslipTable_Uts tbody tr td {font-size: 13px; padding:5px 15px;} .table_1_Uts{width:100%;} .table_1_Uts td td{padding:2px 15px;} .table_2_Uts td td{padding:2px 15px;} .table_1_Uts{font-family: "Roboto", sans-serif; font-size: 13px;} .table_2_Uts{font-family: "Roboto", sans-serif; font-size: 13px;} } </style>');
        WindowObject.document.writeln('</head><body onload="window.print()">');
        WindowObject.document.writeln(divToPrint.innerHTML);
        WindowObject.document.writeln('</body></html>');
        WindowObject.document.close();
        setTimeout(function() {
            WindowObject.close();
        }, 10);

    }
</script>

<?php
if ($_SERVER['REQUEST_METHOD'] == "POST" && isset($payslip_dtls)) {
?>
    <div class="main-panel">
        <div class="content-wrapper">
            <div class="card">
                <div class="card-body" id='divToPrint'>
                    <div class="row">
                        <div class="col-2 payslip_logo_Uts"><a href="javascript:void()"><img src="<?= base_url() ?>assets/images/benfed.png" alt="logo" /></a></div>
                        <div class="col-10 payslip_logo_Desc_Uts">
                            <h3>The Bishnupur Town Co-Operative Bank</h3>
                            <h4>Thanagora, Bishnupur, Bankura, West Bengal 722122</h4>
                            <h4>Pay Slip for <?php echo MONTHS[$this->input->post('sal_month')] . '-' . $this->input->post('year'); ?></h4>
                            <h4><?php echo $payslip_dtls->emp_name; ?></h4>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="order-listing" class="table table_1_Uts">
                                    <thead>
                                        <tr>
                                            <th class="noborder" width="25%"></th>
                                            <th class="noborder" width="1%"></th>
                                            <th class="noborder" width="25%"></th>
                                            <th class="noborder" width="1%"></th>
                                            <th class="noborder" width="30%"></th>
                                            <th class="noborder" width="1%"></th>
                                            <th class="noborder" width="20%"></th>
                                            <th class="noborder" width="20%"></th>
                                        </tr>
                                    </thead>
                                    <tbody class="payslipTbodyFast_Uts">

                                        <tr>
                                            <td>Employee Name</td>
                                            <td class="left_algn">:</td>
                                            <td class="left_algn"><?php echo $payslip_dtls->emp_name; ?></td>
                                            <td></td>
                                            <td>Employee Code
                                                <!-- <td></td> -->
                                            <td class="left_algn">:</td>
                                            <td><?php echo $payslip_dtls->emp_code; ?></td>
                                        </tr>
                                        <tr>
                                            <td>Date of Joining</td>
                                            <td class="left_algn">:</td>
                                            <td class="left_algn"><?php if (($emp_dtls->join_dt != "0000-00-00") && ($emp_dtls->join_dt != NULL)) {
                                                                        echo date('d-m-Y', strtotime($emp_dtls->join_dt));
                                                                    } ?></td>
                                            <td></td>
                                            <td>Date of Retirement
                                                <!-- <td></td> -->
                                            <td class="left_algn">:</td>
                                            <td><?php date('d-m-Y', strtotime($emp_dtls->ret_dt)); ?></td>
                                        </tr>
                                        <tr>
                                            <td>Phone Number</td>
                                            <td class="left_algn">:</td>
                                            <td class="left_algn"><?php echo $payslip_dtls->phn_no; ?></td>
                                            <td></td>
                                            <td>Designation</td>
                                            <td class="left_algn">:</td>
                                            <td><?php echo $payslip_dtls->designation; ?></td>

                                        </tr>
                                        <tr>
                                            <td>Department</td>
                                            <td class="left_algn">:</td>
                                            <td class="left_algn"><?php echo $payslip_dtls->department; ?></td>
                                            <td></td>
                                            <td>Pan No</td>
                                            <td class="left_algn">:</td>
                                            <td><?php echo $payslip_dtls->pan_no; ?></td>

                                        </tr>

                                    </tbody>
                                </table>
                                <br>
                                <table class="width table_2_Uts payslipTable_Uts" cellpadding="6" style="width:100%;">

                                    <thead>
                                        <tr class="t2">
                                            <th colspan="2">Earning</th>
                                            <th colspan="3">Deductions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="left_algn">Basic Pay</td>
                                            <td class="right_algn"><?= $payslip_dtls->basic; ?></td>
                                            <td class="left_algn">Provident Fund</td>
                                            <td></td>
                                            <td class="right_algn"><?= $payslip_dtls->pf; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">D.A.</td>
                                            <td class="right_algn"><?= $payslip_dtls->da; ?></td>
                                            <td class="left_algn">Adv. Agst. H.B.</td>
                                            <td>Prin.</td>
                                            <td class="right_algn"><?= $payslip_dtls->adv_agst_hb_prin; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">S.A.</td>
                                            <td class="right_algn"><?= $payslip_dtls->sa; ?></td>
                                            <td class="left_algn"></td>
                                            <td>Int.</td>
                                            <td class="right_algn"><?= $payslip_dtls->adv_agst_hb_int; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">H.R.A.</td>
                                            <td class="right_algn"><?= $payslip_dtls->hra; ?></td>
                                            <td class="left_algn">Adv. Agst. H.B. Construction</td>
                                            <td>Prin.</td>
                                            <td class="right_algn"><?= $payslip_dtls->adv_agst_hb_const_prin; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">T.A.</td>
                                            <td class="right_algn"><?= $payslip_dtls->ta; ?></td>
                                            <td class="left_algn"></td>
                                            <td>Int.</td>
                                            <td class="right_algn"><?= $payslip_dtls->adv_agst_hb_const_int; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">D.A. on S.A.</td>
                                            <td class="right_algn"><?= $payslip_dtls->da_on_sa; ?></td>
                                            <td class="left_algn">Adv. Agst. Staff H.B. Extension</td>
                                            <td>Prin.</td>
                                            <td class="right_algn"><?= $payslip_dtls->adv_agst_hb_staff_prin; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">D.A. on T.A.</td>
                                            <td class="right_algn"><?= $payslip_dtls->da_on_ta; ?></td>
                                            <td class="left_algn"></td>
                                            <td>Int.</td>
                                            <td class="right_algn"><?= $payslip_dtls->adv_agst_hb_staff_int; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">M.A.</td>
                                            <td class="right_algn"><?= $payslip_dtls->ma; ?></td>
                                            <td class="left_algn">Gross H.B. Interest</td>
                                            <td></td>
                                            <td class="right_algn"><?= $payslip_dtls->gross_hb_int; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">Cash / S.W. Allowance</td>
                                            <td class="right_algn"><?= $payslip_dtls->cash_swa; ?></td>
                                            <td class="left_algn">Staff Advance</td>
                                            <td>Prin.</td>
                                            <td class="right_algn"><?= $payslip_dtls->adv_agst_of_staff_prin; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn"></td>
                                            <td class="right_algn"></td>
                                            <td class="left_algn"></td>
                                            <td>Int.</td>
                                            <td class="right_algn"><?= $payslip_dtls->adv_agst_of_staff_int; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn"></td>
                                            <td class="right_algn"></td>
                                            <td class="left_algn">Staff Advance Extension</td>
                                            <td>Prin.</td>
                                            <td class="right_algn"><?= $payslip_dtls->staff_adv_ext_prin; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn"></td>
                                            <td class="right_algn"></td>
                                            <td class="left_algn"></td>
                                            <td>Int.</td>
                                            <td class="right_algn"><?= $payslip_dtls->staff_adv_ext_int; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn"></td>
                                            <td class="right_algn"></td>
                                            <td class="left_algn">Motor Cycle, T.V. etc. Loan</td>
                                            <td>Prin.</td>
                                            <td class="right_algn"><?= $payslip_dtls->motor_cycle_prin; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn"></td>
                                            <td class="right_algn"></td>
                                            <td class="left_algn"></td>
                                            <td>Int.</td>
                                            <td class="right_algn"><?= $payslip_dtls->motor_cycle_int; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn"></td>
                                            <td class="right_algn"></td>
                                            <td class="left_algn">Prof. Tax</td>
                                            <td></td>
                                            <td class="right_algn"><?= $payslip_dtls->p_tax; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn"></td>
                                            <td class="right_algn"></td>
                                            <td class="left_algn">G.I.C.I.</td>
                                            <td></td>
                                            <td class="right_algn"><?= $payslip_dtls->gici; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn"></td>
                                            <td class="right_algn"></td>
                                            <td class="left_algn">Puja Adv.</td>
                                            <td></td>
                                            <td class="right_algn"><?= $payslip_dtls->puja_adv; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">Total Gross</td>
                                            <td class="right_algn"><?= number_format((float)($payslip_dtls->final_gross + $payslip_dtls->lwp), 2, '.', ''); ?></td>
                                            <td class="left_algn">Income Tax TDS</td>
                                            <td></td>
                                            <td class="right_algn"><?= $payslip_dtls->income_tax_tds; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">LWP</td>
                                            <td class="right_algn"><?= $payslip_dtls->lwp ?></td>
                                            <td class="left_algn">Union Subscription</td>
                                            <td></td>
                                            <td class="right_algn"><?= $payslip_dtls->union_subs; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn">Total Gross<br>After Deduction</td>
                                            <td class="right_algn"><?= $payslip_dtls->final_gross ?></td>
                                            <td class="left_algn">Total Deduction</td>
                                            <td></td>
                                            <td class="right_algn"><?= $payslip_dtls->tot_diduction; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="left_algn"><b>Gross Amount Payable</b></td>
                                            <td class="right_algn"><?= $payslip_dtls->final_gross; ?></td>
                                            <td class="left_algn" colspan="2"><b>Net Amount Payable</b></td>
                                            <td class="right_algn"><?= $payslip_dtls->net_sal; ?></td>
                                        </tr>

                                    </tbody>


                                </table>
                                <div>
                                    <p style="display: inline;">Amount (<small>in words</small>):
                                        <b> <?php echo getIndianCurrency($payslip_dtls->net_sal); ?>
                                    </p></b>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type='button' id='btn' value='Print' onclick='printDiv();'>
            </div>

        </div>


    <?php
} else if ($_SERVER['REQUEST_METHOD'] == 'GET') {

    ?>
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="card">
                    <div class="card-body">
                        <h3>Payslip Report</h3>
                        <div class="row">
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <form method="POST" id="form" action="<?php echo site_url("reports/payslipreport"); ?>">
                                            <div class="form-group">
                                                <div class="row">

                                                    <div class="col-4">
                                                        <label for="exampleInputName1">Month:</label>
                                                        <select class="form-control" name="sal_month" id="sal_month">
                                                            <option value="">Select Month</option>
                                                            <?php foreach ($month_list as $m_list) { ?>
                                                                <option value="<?php echo $m_list->id ?>"><?php echo $m_list->month_name; ?></option>

                                                            <?php
                                                            }
                                                            ?>
                                                        </select>
                                                    </div>
                                                    <div class="col-4">
                                                        <label for="exampleInputName1">Input Year:</label>
                                                        <input type="text" class="form-control" name="year" id="year" value="<?php echo date('Y'); ?>" />
                                                    </div>
                                                    <div class="col-4">
                                                        ` <label for="exampleInputName1">Emplyee Name:</label>
                                                        <select class="form-control required" name="emp_cd" id="emp_cd">
                                                            <option value="">Select Employee</option>
                                                            <?php

                                                            if ($emp_list) {
                                                                foreach ($emp_list as $e_list) {
                                                            ?>
                                                                    <option value='<?php echo $e_list->emp_code ?>'>
                                                                        <?php echo $e_list->emp_name; ?></option>
                                                            <?php
                                                                }
                                                            }    ?>
                                                        </select>
                                                    </div>`
                                                </div>
                                            </div>

                                            <input type="submit" class="btn btn-info" value="Proceed" />
                                            <button class="btn btn-light">Cancel</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        <?php

    } else {

        echo "<h1 style='text-align: center;'>No Data Found</h1>";
    }

        ?>