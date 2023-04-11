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
  $tot_pf = 0;
  $tot_adv_agst_hb_prin = 0;
  $tot_adv_agst_hb_int = 0;
  $tot_adv_agst_hb_const_prin = 0;
  $tot_adv_agst_hb_const_int = 0;
  $tot_adv_agst_hb_staff_prin = 0;
  $tot_adv_agst_hb_staff_int = 0;
  $tot_gross_hb_int = 0;
  $tot_adv_agst_of_staff_prin = 0;
  $tot_adv_agst_of_staff_int = 0;
  $tot_staff_adv_ext_prin = 0;
  $tot_staff_adv_ext_int = 0;
  $tot_motor_cycle_prin = 0;
  $tot_motor_cycle_int = 0;
  $tot_p_tax = 0;
  $tot_gici = 0;
  $tot_puja_adv = 0;
  $tot_income_tax_tds = 0;
  $tot_union_subs = 0;
  $tot_tot_diduction = 0;
?>
  <div class="main-panel">
    <div class="content-wrapper">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-1"><a href="javascript:void()"><img src="<?= base_url() ?>assets/images/benfed.png" alt="logo" /></a></div>
            <div class="col-10">
              <div style="text-align:center;">
                <h3>The Bishnupur Town Co-Operative Bank</h3>
                <h4>38JC+226, Kalindibandh, Bishnupur, West Bengal 722122</h4>
                <h4>Total deduction of Regular employees From <?php echo date('d/m/Y', strtotime($this->input->post('from_date'))) . ' To ' . date('d/m/Y', strtotime($this->input->post('to_date'))); ?>
                  <!-- <h4>Pay Slip for <?php echo date($this->input->post('sal_month'), "d/m/Y") . '-' . $this->input->post('year'); ?></h4> -->
                  <!-- <?php echo $year->param_value; ?> -->
                </h4>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="table-responsive">
                <table class="table table-bordered table-hover">

                  <thead>

                    <tr>
                      <th rowspan="2">Sl No.</th>
                      <th rowspan="2">Name of Emplyees</th>
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

                    if ($total_deduct) {

                      $i  =   1;

                      $tot_ins = $tot_css = $tot_hbl = $tot_tel = $tot_med_adv = $tot_fa = $tot_tf = $tot_med_ins = $tot_comp_loan = $tot_ptax = $tot_itax = $tot_gpf = $tot_epf = $tot_other_deduction = 0;

                      foreach ($total_deduct as $td_list) {

                        $tot_pf += $td_list->pf;
                        $tot_adv_agst_hb_prin += $td_list->adv_agst_hb_prin;
                        $tot_adv_agst_hb_int += $td_list->adv_agst_hb_int;
                        $tot_adv_agst_hb_const_prin += $td_list->adv_agst_hb_const_prin;
                        $tot_adv_agst_hb_const_int += $td_list->adv_agst_hb_const_int;
                        $tot_adv_agst_hb_staff_prin += $td_list->adv_agst_hb_staff_prin;
                        $tot_adv_agst_hb_staff_int += $td_list->adv_agst_hb_staff_int;
                        $tot_gross_hb_int += $td_list->gross_hb_int;
                        $tot_adv_agst_of_staff_prin += $td_list->adv_agst_of_staff_prin;
                        $tot_adv_agst_of_staff_int += $td_list->adv_agst_of_staff_int;
                        $tot_staff_adv_ext_prin += $td_list->staff_adv_ext_prin;
                        $tot_staff_adv_ext_int += $td_list->staff_adv_ext_int;
                        $tot_motor_cycle_prin += $td_list->motor_cycle_prin;
                        $tot_motor_cycle_int += $td_list->motor_cycle_int;
                        $tot_p_tax += $td_list->p_tax;
                        $tot_gici += $td_list->gici;
                        $tot_puja_adv += $td_list->puja_adv;
                        $tot_income_tax_tds += $td_list->income_tax_tds;
                        $tot_union_subs += $td_list->union_subs;
                        $tot_tot_diduction += $td_list->tot_diduction;
                    ?>

                        <tr>

                          <td><?= $i++; ?></td>

                          <td><?= $td_list->emp_name; ?></td>
                          <td><?= $td_list->pf; ?></td>
                          <td><?= $td_list->adv_agst_hb_prin; ?></td>
                          <td><?= $td_list->adv_agst_hb_int; ?></td>
                          <td><?= $td_list->adv_agst_hb_const_prin; ?></td>
                          <td><?= $td_list->adv_agst_hb_const_int; ?></td>
                          <td><?= $td_list->adv_agst_hb_staff_prin; ?></td>
                          <td><?= $td_list->adv_agst_hb_staff_int; ?></td>
                          <td><?= $td_list->gross_hb_int; ?></td>
                          <td><?= $td_list->adv_agst_of_staff_prin; ?></td>
                          <td><?= $td_list->adv_agst_of_staff_int; ?></td>
                          <td><?= $td_list->staff_adv_ext_prin; ?></td>
                          <td><?= $td_list->staff_adv_ext_int; ?></td>
                          <td><?= $td_list->motor_cycle_prin; ?></td>
                          <td><?= $td_list->motor_cycle_int; ?></td>
                          <td><?= $td_list->p_tax; ?></td>
                          <td><?= $td_list->gici; ?></td>
                          <td><?= $td_list->puja_adv; ?></td>
                          <td><?= $td_list->income_tax_tds; ?></td>
                          <td><?= $td_list->union_subs; ?></td>
                          <td><?= $td_list->tot_diduction; ?></td>
                        </tr>

                      <?php

                      }

                      ?>


                      <tr>

                        <td colspan="2">Total Amount</td>
                        <td><?= $tot_pf; ?></td>
                        <td><?= $tot_adv_agst_hb_prin; ?></td>
                        <td><?= $tot_adv_agst_hb_int; ?></td>
                        <td><?= $tot_adv_agst_hb_const_prin; ?></td>
                        <td><?= $tot_adv_agst_hb_const_int; ?></td>
                        <td><?= $tot_adv_agst_hb_staff_prin; ?></td>
                        <td><?= $tot_adv_agst_hb_staff_int; ?></td>
                        <td><?= $tot_gross_hb_int; ?></td>
                        <td><?= $tot_adv_agst_of_staff_prin; ?></td>
                        <td><?= $tot_adv_agst_of_staff_int; ?></td>
                        <td><?= $tot_staff_adv_ext_prin; ?></td>
                        <td><?= $tot_staff_adv_ext_int; ?></td>
                        <td><?= $tot_motor_cycle_prin; ?></td>
                        <td><?= $tot_motor_cycle_int; ?></td>
                        <td><?= $tot_p_tax; ?></td>
                        <td><?= $tot_gici; ?></td>
                        <td><?= $tot_puja_adv; ?></td>
                        <td><?= $tot_income_tax_tds; ?></td>
                        <td><?= $tot_union_subs; ?></td>
                        <td><?= $tot_tot_diduction; ?></td>
                      </tr>

                    <?php

                    } else {

                      echo "<tr><td colspan='9' style='text-align:center;'>No Data Found</td></tr>";
                    }
                    ?>

                  </tbody>

                </table>
                <br>
                <div>

                </div>

                <div class="bottom">

                  <p style="display: inline;">Prepared By</p>

                  <p style="display: inline; margin-left: 8%;">Establishment, Sr. Asstt.</p>

                  <p style="display: inline; margin-left: 8%;">Assistant Manager-II</p>

                  <p style="display: inline; margin-left: 8%;">Chief Executive officer</p>

                </div>


              </div>
            </div>
          </div>
        </div>
      </div>
    </div>



  <?php
} else if ($_SERVER['REQUEST_METHOD'] == 'GET') {

  ?>

    <div class="main-panel">
      <div class="content-wrapper">
        <div class="card">
          <div class="card-body">
            <h3>Deduction Report</h3>
            <div class="row">
              <div class="col-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <form method="POST" id="form" action="<?php echo site_url("reports/totaldeduction"); ?>">
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