<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>BTCB Payroll</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="<?= base_url() ?>assets/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="<?= base_url() ?>assets/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="<?= base_url() ?>assets/css/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="<?= base_url() ?>assets/images/favicon.ico" />
</head>

<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="main-panel">
        <div class="content-wrapper d-flex align-items-center auth px-0">
          <div class="row w-100 mx-0">
            <div class="col-lg-4 mx-auto">
              <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                <div class="brand-logo">
                  <img src="<?= base_url() ?>assets/images/benfed.png" alt="logo" style="height: 80px;width: 80px;" />
                </div>
                <!-- <h4>Hello! let's get started</h4> -->
                <h6 class="font-weight-light">Sign in to continue.</h6>
                <form class="pt-3" method="post" action='<?= base_url() ?>index.php/payroll_Login/'>
                  <div class="form-group">
                    <span id='error'></span>
                    <input class="form-control form-control-lg" type="text" name="user_id" id="user_id" required>

                  </div>
                  <div class="form-group">
                    <input type="password" class="form-control form-control-lg" id="exampleInputPassword1" name="user_pwd" required>
                  </div>
                  <div class="mt-3">
                    <button type="submit" class="btn btn-primary mr-2">SIGN IN</button>
                  </div>
                  <!-- <div class="my-2 d-flex justify-content-between align-items-center">
                    <div class="form-check">
                      <label class="form-check-label text-muted">
                        <input type="checkbox" class="form-check-input">
                        Keep me signed in
                      </label>
                    </div>
                    <a href="#" class="auth-link text-black">Forgot password?</a>
                  </div> -->
                  <!-- <div class="mb-2">
                    <button type="button" class="btn btn-block btn-facebook auth-form-btn">
                      <i class="mdi mdi-facebook mr-2"></i>Connect using facebook
                    </button>
                  </div>
                  <div class="text-center mt-4 font-weight-light">
                    Don't have an account? <a href="register.html" class="text-primary">Create</a>
                  </div> -->
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  <!-- plugins:js -->
  <script src="<?= base_url() ?>assets/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="<?= base_url() ?>assets/js/off-canvas.js"></script>
  <script src="<?= base_url() ?>assets/js/hoverable-collapse.js"></script>
  <script src="<?= base_url() ?>assets/js/template.js"></script>
  <script src="<?= base_url() ?>assets/js/settings.js"></script>
  <script src="<?= base_url() ?>assets/js/todolist.js"></script>
  <!-- endinject -->
</body>

</html>
<script>
  $("#user_id").change(function() {
    $.ajax({
      url: "<?= base_url() ?>index.php/payroll_Login/check_user",
      type: "POST",
      data: {
        user_id: $(this).val()
      },
      success: function(result) {
        if (result == 0) {
          $('#error').delay(5000).show();
          $('#error').html('User id is not correct').css("color", "red");
          $('#error').delay(5000).fadeOut('slow');
        }

      }
    });
  });
</script>