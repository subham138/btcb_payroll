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

<style>
  th {
    text-align: center;
    vertical-align: middle !important;
  }
</style>

<?php
if ($_SERVER['REQUEST_METHOD'] == "POST") {
  $tot_da = 0;
  $tot_sa = 0;
  $tot_hra = 0;
  $tot_ta = 0;
  $tot_da_on_sa = 0;
  $tot_da_on_ta = 0;
  $tot_ma = 0;
  $tot_cash_swa = 0;
  $tot_lwp = 0;
  $tot_final_gross = 0;
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
              <h4>Total earning of Regular employees From <?php echo date('d/m/Y', strtotime($this->input->post('from_date'))) . ' To ' . date('d/m/Y', strtotime($this->input->post('to_date'))); ?>
                <!-- <h4>Pay Slip for <?php //echo date($this->input->post('sal_month'), "d/m/Y") . '-' . $this->input->post('year'); 
                                      ?></h4> -->
              </h4>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="table-responsive">
                <table class="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <th>Sl No.</th>
                      <th>Name of Emplyees</th>
                      <th>D.A.</th>
                      <th>S.A.</th>
                      <th>H.R.A.</th>
                      <th>T.A.</th>
                      <th>D.A. on S.A.</th>
                      <th>D.A. on T.A.</th>
                      <th>M.A.</th>
                      <th>Cash / <br>S.W. Allowance</th>
                      <th>LWP</th>
                      <th>Final Gross</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php
                    if ($total_ear) {
                      $i  =   1;
                      foreach ($total_ear as $td_list) {
                        $tot_da += $td_list->da;
                        $tot_sa += $td_list->sa;
                        $tot_hra += $td_list->hra;
                        $tot_ta += $td_list->ta;
                        $tot_da_on_sa += $td_list->da_on_sa;
                        $tot_da_on_ta += $td_list->da_on_ta;
                        $tot_ma += $td_list->ma;
                        $tot_cash_swa += $td_list->cash_swa;
                        $tot_lwp += $td_list->lwp;
                        $tot_final_gross += $td_list->final_gross;

                    ?>
                        <tr>
                          <td><?= $i++; ?></td>
                          <td><?= $td_list->emp_name; ?></td>
                          <td><?= $td_list->da; ?></td>
                          <td><?= $td_list->sa; ?></td>
                          <td><?= $td_list->hra; ?></td>
                          <td><?= $td_list->ta; ?></td>
                          <td><?= $td_list->da_on_sa; ?></td>
                          <td><?= $td_list->da_on_ta; ?></td>
                          <td><?= $td_list->ma; ?></td>
                          <td><?= $td_list->cash_swa; ?></td>
                          <td><?= $td_list->lwp; ?></td>
                          <td><?= $td_list->final_gross; ?></td>
                        </tr>
                      <?php
                      }
                      ?>
                      <tr>
                        <td colspan="2">Total Amount</td>
                        <td><?= $tot_da; ?></td>
                        <td><?= $tot_sa; ?></td>
                        <td><?= $tot_hra; ?></td>
                        <td><?= $tot_ta; ?></td>
                        <td><?= $tot_da_on_sa; ?></td>
                        <td><?= $tot_da_on_ta; ?></td>
                        <td><?= $tot_ma; ?></td>
                        <td><?= $tot_cash_swa; ?></td>
                        <td><?= $tot_lwp; ?></td>
                        <td><?= $tot_final_gross; ?></td>
                      </tr>
                    <?php
                    } else {
                      echo "<tr><td colspan='9' style='text-align:center;'>No Data Found</td></tr>";
                    }
                    ?>
                  </tbody>
                </table>
                <br>
                <div class="pr_footer">
                  <div class="bottom">
                    <p style="display: inline;">Prepared By</p>
                    <p style="display: inline; margin-left: 8%;">Accountent</p>
                    <p style="display: inline; margin-left: 8%;">Manager</p>
                    <p style="display: inline; margin-left: 8%;">Secretary</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- <input type='button' id='btn' value='Print' onclick='printDiv();'> -->
      <center>
        <button type='button' class="btn btn-primary mt-3" onclick='printDiv();'>Print</button>
      </center>
    </div>



  <?php
} else if ($_SERVER['REQUEST_METHOD'] == 'GET') {

  ?>

    <div class="main-panel">
      <div class="content-wrapper">
        <div class="card">
          <div class="card-body">
            <h3>Earning Report</h3>
            <div class="row">
              <div class="col-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <form method="POST" id="form" action="<?php echo site_url("reports/totalearning"); ?>">
                      <div class="form-group">
                        <div class="row">
                          <div class="col-6">
                            <label for="exampleInputName1">From Date:</label>
                            <input type="date" name="from_date" class="form-control required" id="from_date" value="<?php echo $sys_date; ?>" />
                          </div>
                          <div class="col-6">
                            <label for="exampleInputName1">To Date:</label>
                            <input type="date" name="to_date" class="form-control required" id="to_date" value="<?php echo $sys_date; ?>" />


                          </div>
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