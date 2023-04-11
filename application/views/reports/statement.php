<script>
    function printDiv() {

        var divToPrint = document.getElementById('divToPrint');
        var WindowObject = window.open('', 'Print-Window');
        WindowObject.document.open();
        WindowObject.document.writeln('<!DOCTYPE html>');
        WindowObject.document.writeln('<html><head><title></title><style type="text/css">');
        WindowObject.document.writeln('@media print { .center { text-align: center;}' +
            '                                         .inline { display: inline; }' +
            '                                         .underline { text-decoration: underline; }' +
            '                                         .left { margin-left: 315px;} ' +
            '                                         .right { margin-right: 375px; display: inline; }' +
            '                                          table { border-collapse: collapse; }' +
            '                                          th { text-align: center; vertical-align: middle; }' +
            '                                          th, td { border: 1px solid black; border-collapse: collapse; padding: 10px;}' +
            '                                           th, td { }' +
            '                                         .border { border: 1px solid black; } ' +
            '                                         .bottom { bottom: 5px; width: 100%; position: fixed ' +
            '                                       ' +
            '                                   } } </style>');
        WindowObject.document.writeln('</head><body onload="window.print()">');
        WindowObject.document.writeln(divToPrint.innerHTML);
        WindowObject.document.writeln('</body></html>');
        WindowObject.document.close();
        setTimeout(function() {
            WindowObject.close();
        }, 10);
    }
</script>

<style>
    th {
        text-align: center;
        vertical-align: middle !important;
    }
</style>

<?php
if ($_SERVER['REQUEST_METHOD'] == "POST") {
?>
    <div class="main-panel">
        <div class="content-wrapper">
            <div class="card">
                <div class="card-body" id='divToPrint'>
                    <div class="row">
                        <div class="col-1"><a href="javascript:void()"><img src="<?= base_url() ?>assets/images/benfed.png" alt="logo" /></a></div>
                        <div class="col-10">
                            <div style="text-align:center;">
                                <h3>The Bishnupur Town Co-Operative Bank</h3>
                                <h4>38JC+226, Kalindibandh, Bishnupur, West Bengal 722122</h4>
                                <h4>Salary summary report for the month of <?php echo MONTHS[$this->input->post('sal_month')] . ' ' . $this->input->post('year'); ?></h4>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table id="order-listing" class="table">
                                    <thead>
                                        <tr>
                                            <th rowspan="2">Sl No.</th>
                                            <th rowspan="2">Name</th>
                                            <th rowspan="2">Basic Pay</th>
                                            <th rowspan="2">D.A.</th>
                                            <th rowspan="2">S.A.</th>
                                            <th rowspan="2">H.R.A.</th>
                                            <th rowspan="2">T.A.</th>
                                            <th rowspan="2">D.A. on S.A.</th>
                                            <th rowspan="2">D.A. on T.A.</th>
                                            <th rowspan="2">M.A.</th>
                                            <th rowspan="2">Cash / S.W. <br>Allowance</th>
                                            <th rowspan="2">Provident Fund</th>
                                            <th colspan="2">Adv. Agst. H.B.</th>
                                            <th colspan="2">Adv. Agst. <br>H.B. Construction</th>
                                            <th colspan="2">Adv. Agst. Staff <br>H.B. Extension</th>
                                            <th rowspan="2">Gross <br>H.B. Interest</th>
                                            <th colspan="2">Staff Advance</th>
                                            <th colspan="2">Staff Advance <br>Extension</th>
                                            <th colspan="2">Motor Cycle, <br>T.V. etc. Loan</th>
                                            <th rowspan="2">Prof. Tax</th>
                                            <th rowspan="2">G.I.C.I.</th>
                                            <th rowspan="2">Puja Adv.</th>
                                            <th rowspan="2">Income Tax TDS</th>
                                            <th rowspan="2">Union <br>Subscription</th>
                                            <th rowspan="2">Total <br>Deduction</th>
                                            <th rowspan="2">Net Amount</th>
                                            <th rowspan="2">Bank A/C No.</th>
                                        </tr>
                                        <tr>
                                            <th>Prin.</th>
                                            <th>Int.</th>
                                            <th>Prin.</th>
                                            <th>Int.</th>
                                            <th>Prin.</th>
                                            <th>Int.</th>
                                            <th>Prin.</th>
                                            <th>Int.</th>
                                            <th>Prin.</th>
                                            <th>Int.</th>
                                            <th>Prin.</th>
                                            <th>Int.</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <?php

                                        if ($statement) {
                                            $i  =   1;
                                            $tot_net = 0;
                                            foreach ($statement as $s_list) {
                                                $tot_net += $s_list->net_sal;

                                        ?>

                                                <tr>

                                                    <td><?= $i++; ?></td>
                                                    <td><?= $s_list->emp_name; ?></td>
                                                    <td><?= $s_list->basic; ?></td>
                                                    <td><?= $s_list->da; ?></td>
                                                    <td><?= $s_list->sa; ?></td>
                                                    <td><?= $s_list->hra; ?></td>
                                                    <td><?= $s_list->ta; ?></td>
                                                    <td><?= $s_list->da_on_sa; ?></td>
                                                    <td><?= $s_list->da_on_ta; ?></td>
                                                    <td><?= $s_list->ma; ?></td>
                                                    <td><?= $s_list->cash_swa; ?></td>
                                                    <td><?= $s_list->pf; ?></td>
                                                    <td><?= $s_list->adv_agst_hb_prin; ?></td>
                                                    <td><?= $s_list->adv_agst_hb_int; ?></td>
                                                    <td><?= $s_list->adv_agst_hb_const_prin; ?></td>
                                                    <td><?= $s_list->adv_agst_hb_const_int; ?></td>
                                                    <td><?= $s_list->adv_agst_hb_staff_prin; ?></td>
                                                    <td><?= $s_list->adv_agst_hb_staff_int; ?></td>
                                                    <td><?= $s_list->gross_hb_int; ?></td>
                                                    <td><?= $s_list->adv_agst_of_staff_prin; ?></td>
                                                    <td><?= $s_list->adv_agst_of_staff_int; ?></td>
                                                    <td><?= $s_list->staff_adv_ext_prin; ?></td>
                                                    <td><?= $s_list->staff_adv_ext_int; ?></td>
                                                    <td><?= $s_list->motor_cycle_prin; ?></td>
                                                    <td><?= $s_list->motor_cycle_int; ?></td>
                                                    <td><?= $s_list->p_tax; ?></td>
                                                    <td><?= $s_list->gici; ?></td>
                                                    <td><?= $s_list->puja_adv; ?></td>
                                                    <td><?= $s_list->income_tax_tds; ?></td>
                                                    <td><?= $s_list->union_subs; ?></td>
                                                    <td><?= $s_list->tot_diduction; ?></td>
                                                    <td><?= $s_list->net_sal; ?></td>
                                                    <td><?= $s_list->bank_ac_no; ?></td>

                                                </tr>
                                            <?php
                                            }
                                            ?>
                                            <tr>
                                                <td colspan="3">Total Amount</td>
                                                <td style="text-align: right;"> Rs. <?php echo $tot_net; ?></td>
                                            </tr>
                                        <?php
                                        } else {
                                            echo "<tr><td colspan='32' style='text-align:center;'>No Data Found</td></tr>";
                                        }
                                        ?>
                                    </tbody>
                                </table>
                                <br>
                                <div>
                                    <p>Amount: <?php echo @$tot_net . ' (' . getIndianCurrency(@$tot_net > 0 ? $tot_net : 0.00) . ').'; ?></p>
                                </div>

                                <div class="bottom">
                                    <p style="display: inline;">Prepared By</p>
                                    <p style="display: inline; margin-left: 8%;"></p>
                                    <p style="display: inline; margin-left: 8%;"></p>
                                    <p style="display: inline; margin-left: 8%;">Chief Executive officer</p>
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
                        <h3>Salary Statement Report</h3>
                        <div class="row">
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <form method="POST" id="form" action="<?php echo site_url("reports/paystatementreport"); ?>">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <label for="exampleInputName1">From Date:</label>
                                                        <input type="date" name="from_date" class="form-control required" id="from_date" value="<?php echo $this->session->userdata('sys_date'); ?>" />
                                                    </div>
                                                    <div class="col-6">
                                                        <label for="exampleInputName1">Select Month:</label>
                                                        <select class="form-control" name="sal_month" id="sal_month" require>
                                                            <option value="">Select Month</option>
                                                            <?php foreach ($month_list as $m_list) { ?>

                                                                <option value="<?php echo $m_list->id ?>"><?php echo $m_list->month_name; ?></option>

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
                                                        <label for="exampleInputName1">Input Year:</label>
                                                        <input type="text" class="form-control" name="year" id="year" value="<?php echo date('Y'); ?>" require />
                                                    </div>
                                                    <div class="col-6">
                                                        <label for="exampleInputName1">Category:</label>
                                                        <select class="form-control required" name="category" id="category" require>

                                                            <option value="">Select Category</option>

                                                            <?php foreach ($category as $c_list) { ?>

                                                                <option value="<?php echo $c_list->id; ?>"><?php echo $c_list->category; ?></option>

                                                            <?php
                                                            }
                                                            ?>

                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="submit" class="btn btn-info" value="Proceed" onclick="return checkVal();" />
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

        <script>
            function checkVal() {
                var month = $('#sal_month').val();
                var catg_id = $('#category').val();
                if (month > 0 && catg_id > 0) {
                    return true;
                } else {
                    alert('Please fill all fields')
                    return false;
                }
            }
        </script>