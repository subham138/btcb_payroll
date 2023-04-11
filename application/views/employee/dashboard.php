  <div class="main-panel">
    <div class="content-wrapper">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-3">
              <h3>Employee List</h3>
              <?php if ($this->session->flashdata('msg')) { ?>
                <div class="alert alert-danger" role="alert">
                  <?php echo $this->session->flashdata('msg'); ?>
                </div>
              <?php } ?>
            </div>
            <div class="col-2">
              <div class="form-check">
                <label class="form-check-label">
                  <input type="radio" class="form-check-input" name="active_status" id="active_status" value="A" checked>
                  Active
                </label>
              </div>
            </div>
            <div class="col-2">
              <div class="form-check">
                <label class="form-check-label">
                  <input type="radio" class="form-check-input" name="active_status" id="active_status" value="R">
                  Retired
                </label>
              </div>
            </div>
            <div class="col-2">
              <div class="form-check">
                <label class="form-check-label">
                  <input type="radio" class="form-check-input" name="active_status" id="active_status" value="S">
                  Suspended
                </label>
              </div>
            </div>
            <div class="col-2">
              <div class="form-check">
                <label class="form-check-label">
                  <input type="radio" class="form-check-input" name="active_status" id="active_status" value="RG">
                  Resigned
                </label>
              </div>
            </div>

            <div class="col-1">
              <small><a href="<?php echo site_url("emadst"); ?>" class="btn btn-primary customFloat_Uts">Add</a></small>
            </div>
          </div>
          <br>
          <div class="row">
            <div class="col-12">
              <div class="table-responsive" id='ajaxl'>
                <table id="order-listing" class="table">
                  <thead>
                    <tr>
                      <th>Emp code</th>
                      <th>Name</th>
                      <th>Category</th>
                      <th>Department</th>
                      <th>District</th>
                      <th>Edit</th>
                      <th>Delete</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php
                    if ($employee_dtls) {
                      foreach ($employee_dtls as $e_dtls) {
                    ?>
                        <tr>
                          <td><?= $e_dtls->emp_code; ?></td>
                          <td><?= $e_dtls->emp_name; ?></td>
                          <td><?= $e_dtls->category; ?></td>
                          <td><?= $e_dtls->department; ?></td>
                          <td><?= $e_dtls->district_name; ?></td>
                          <td>
                            <a href="estem?emp_code=<?= $e_dtls->emp_code; ?>" data-toggle="tooltip" data-placement="bottom" title="Edit">
                              <i class="fa fa-edit fa-2x" style="color: #007bff"></i>
                            </a>
                          </td>
                          <td>
                            <a type="button" class="delete" id="<?= $e_dtls->emp_code; ?>" data-toggle="tooltip" data-placement="bottom" title="Delete">
                              <i class="fa fa-trash fa-2x"></i>
                            </a>
                          </td>
                        </tr>
                    <?php
                      }
                    } else {
                      echo "<tr><td colspan='10' style='text-align: center;'>No data Found</td></tr>";
                    }
                    ?>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script>
    $(document).ready(function() {

      $('.delete').click(function() {

        var id = $(this).attr('id');

        var result = confirm("Do you really want to delete this record?");

        if (result) {

          window.location = "<?php echo site_url('dstf?empcd="+id+"'); ?>";

        }

      });

    });

    $(document).ready(function() {

      $('.confirm-div').hide();

      <?php if ($this->session->flashdata('msg')) { ?>

        $('.confirm-div').html('<?php echo $this->session->flashdata('msg'); ?>').show();

      <?php } ?>

    });

    //$("#active_status").change(function(){
    $('input[type=radio][name=active_status]').on('change', function(e) {
      $('#ajaxl').html('');
      $.ajax({
        url: "<?= base_url() ?>index.php/admin/ajaxemplist",
        type: "POST",
        data: {
          active_status: $(this).val()
        },
        success: function(result) {
          $('#ajaxl').html(result);
          $('#order-listing').DataTable({
            "destroy": true, //use for reinitialize datatable
          });
        }
      });
    });
  </script>