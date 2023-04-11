<div class="container-fluid page-body-wrapper">
  <div class="main-panel">
    <div class="content-wrapper">

      <div class="row">
        <div class="col-md-4 grid-margin stretch-card">
          <div class="card border-0 border-radius-2 bg-success">
            <div class="card-body">
              <div class="d-flex flex-md-column flex-xl-row flex-wrap  align-items-center justify-content-between">
                <div class="icon-rounded-inverse-success icon-rounded-lg">
                  <i class="mdi mdi-calendar"></i>
                </div>
                <div class="text-white">
                  <p class="font-weight-medium mt-md-2 mt-xl-0 text-md-center text-xl-left">Salary Paid Upto</p>
                  <div class="d-flex flex-md-column flex-xl-row flex-wrap align-items-baseline align-items-md-center align-items-xl-baseline">
                    <h3 class="mb-0 mb-md-1 mb-lg-0 mr-1"><?= $last_paid_dt ? date('M, Y', strtotime('01-' . $last_paid_dt->sal_month . '-' . $last_paid_dt->sal_year)) : '' ?></h3>
                    <!--                        <small class="mb-0">This month</small>-->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4 grid-margin stretch-card">
          <div class="card border-0 border-radius-2 bg-danger">
            <div class="card-body">
              <div class="d-flex flex-md-column flex-xl-row flex-wrap  align-items-center justify-content-between">
                <div class="icon-rounded-inverse-danger icon-rounded-lg">
                  <i class="mdi mdi-account-multiple-plus"></i>
                </div>
                <div class="text-white">
                  <p class="font-weight-medium mt-md-2 mt-xl-0 text-md-center text-xl-left">Add Employee</p>
                  <div class="d-flex flex-md-column flex-xl-row flex-wrap align-items-baseline align-items-md-center align-items-xl-baseline">
                    <button class="btn btnCustomAdd" id="add_emp">Add</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4 grid-margin stretch-card">
          <div class="card border-0 border-radius-2 bg-warning">
            <div class="card-body">
              <div class="d-flex flex-md-column flex-xl-row flex-wrap  align-items-center justify-content-between">
                <div class="icon-rounded-inverse-warning icon-rounded-lg">
                  <i class="mdi mdi-account-multiple"></i>
                </div>
                <div class="text-white">
                  <p class="font-weight-medium mt-md-2 mt-xl-0 text-md-center text-xl-left">Total Employee</p>
                  <div class="d-flex flex-md-column flex-xl-row flex-wrap align-items-baseline align-items-md-center align-items-xl-baseline">
                    <h3 class="mb-0 mb-md-1 mb-lg-0 mr-1"><?= $tot_emp->tot_emp > 0 ? $tot_emp->tot_emp : 0 ?></h3>
                    <!--                        <small class="mb-0">This month</small>-->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="row">

        <div class="col-md-6 grid-margin">
          <div class="card">
            <div class="card-body">
              <p class="card-title">Total Earning</p>
              <div class="d-flex flex-wrap align-items-baseline">
                <h2 class="mr-3">Rs. <?= $sal_state->tot_ear > 0 ? number_format($sal_state->tot_ear, 0) : 0 ?></h2>
                <!--                          <i class="mdi mdi-arrow-up mr-1 text-danger"></i><span><p class="mb-0 text-danger font-weight-medium">+2.12%</p></span>-->
              </div>
              <!--                      <p class="mb-0 text-muted">Total users world wide</p>-->
            </div>
            <!--                    <canvas id="users-chart"></canvas>-->
          </div>
        </div>
        <div class="col-md-6 grid-margin">
          <div class="card">
            <div class="card-body">
              <p class="card-title">Total Deduction </p>
              <div class="d-flex flex-wrap align-items-baseline">
                <h2 class="mr-3">Rs. <?= $sal_state->tot_deduct > 0 ? number_format($sal_state->tot_deduct, 0) : 0 ?></h2>
                <!--                        <i class="mdi mdi-arrow-up mr-1 text-success"></i><span><p class="mb-0 text-success font-weight-medium">+9.12%</p></span>                          -->
              </div>
              <!--                      <p class="mb-0 text-muted">Total users world wide</p>-->
            </div>
            <!--                    <canvas id="projects-chart"></canvas>-->
          </div>
        </div>

        <div class="col-md-6 grid-margin">
          <div class="card">
            <div class="card-body">
              <p class="card-title"> Last Month Paid Amount <strong>(Parmanent) </strong></p>
              <div class="d-flex flex-wrap align-items-baseline">

                <h2 class="mr-3">Rs. <?= $p_net_sal->tot_sal > 0 ? number_format($p_net_sal->tot_sal, 0) : 0 ?></h2>
                <!--                          <i class="mdi mdi-arrow-up mr-1 text-danger"></i><span><p class="mb-0 text-danger font-weight-medium">Parmanent</p></span>-->
              </div>
              <!--                      <p class="mb-0 text-muted">Total users world wide</p>-->
            </div>
            <!--                    <canvas id="users-chart"></canvas>-->
          </div>
        </div>
        <div class="col-md-6 grid-margin">
          <div class="card">
            <div class="card-body">
              <p class="card-title"> Last Month Paid Amount <strong>(Temporary)</strong> </p>
              <div class="d-flex flex-wrap align-items-baseline">
                <h2 class="mr-3">Rs. <?= $t_net_sal->tot_sal > 0 ? number_format($t_net_sal->tot_sal, 0) : 0 ?></h2>
                <!--                        <i class="mdi mdi-arrow-up mr-1 text-success"></i><span><p class="mb-0 text-success font-weight-medium">+9.12%</p></span>                          -->
              </div>
              <!--                      <p class="mb-0 text-muted">Total users world wide</p>-->
            </div>
            <!--                    <canvas id="projects-chart"></canvas>-->
          </div>
        </div>



        <div class="col-md-12 grid-margin">
          <div class="card border-radius-2 bg-danger">
            <div class="card-body">
              <button class="btn btnCustomAdd btnCustomAddMarRig" id="payslip">Payslip</button>
              <button class="btn btnCustomAdd btnCustomAddMarRig" id="salState">Monthwise Salary Statement</button>
            </div>
          </div>
        </div>

      </div>

    </div>
    <!-- content-wrapper ends -->

    <script>
      $('#add_emp').on('click', function() {
        window.location.href = "<?= site_url(); ?>/stfemp";
      })
      $('#payslip').on('click', function() {
        window.location.href = "<?= site_url(); ?>/reports/payslipreport";
      })
      $('#salState').on('click', function() {
        window.location.href = "<?= site_url(); ?>/reports/paystatementreport";
      })
    </script>