  <div class="main-panel">
      <div class="content-wrapper">
          <div class="card">
              <div class="card-body">
                  <div class="row">
                      <div class="col-10">
                          <h3>Deductions</h3>
                          <?php if ($this->session->flashdata('msg')) { ?>
                              <div class="alert alert-danger" role="alert">
                                  <?php echo $this->session->flashdata('msg'); ?>
                              </div>
                          <?php } ?>
                      </div>
                      <div class="col-2">
                          <small><a href="<?php echo site_url("slrydedad"); ?>" class="btn btn-primary customFloat_Uts">Add</a></small>
                      </div>
                  </div>
                  <br>
                  <div class="row">
                      <div class="col-12">
                          <div class="table-responsive" id='permanent'>
                              <table id="order-listing" class="table">
                                  <thead>
                                      <tr>
                                          <th>#</th>
                                          <th>Date</th>
                                          <th>Category</th>
                                          <th>Net Salary</th>
                                          <th>Action</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      <?php $i = 1;
                                        foreach ($deduction_list as $ded) { ?>
                                          <tr>
                                              <td><?= $i ?></td>
                                              <td><?= $ded->effective_date ?></td>
                                              <td><?= $ded->category ?></td>
                                              <td><?= $ded->net_sal ?></td>
                                              <td><a href="slrydedad?catg_id=<?= $ded->catg_id ?>&sys_dt=<?= $ded->effective_date ?>&flag=1" data-toggle="tooltip" data-placement="bottom" title="Edit">
                                                      <i class="fa fa-edit fa-2x" style="color: #007bff"></i>
                                                  </a></td>
                                          </tr>

                                      <?php $i++;
                                        } ?>
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
  </script>