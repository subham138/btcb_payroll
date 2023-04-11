  <div class="main-panel">
      <div class="content-wrapper">
          <div class="card">
              <div class="card-body">
                  <div class="row">
                      <div class="col-10">
                          <h3>User List</h3>
                          <?php if ($this->session->flashdata('msg')) { ?>
                              <div class="alert <?= $this->session->flashdata('style') ?>" role="alert">
                                  <?php echo $this->session->flashdata('msg'); ?>
                              </div>
                          <?php } ?>
                      </div>
                      <div class="col-2">
                          <small>
                              <a href="<?= site_url(); ?>/useredit?id" class="btn btn-warning text-white customFloat_Uts">Add</a>
                          </small>
                      </div>
                  </div>
                  <br>
                  <div class="row">
                      <div class="col-12">
                          <div class="table-responsive">
                              <table id="order-listing" class="table">
                                  <thead>
                                      <tr>
                                          <th>Sl No</th>
                                          <th>Name</th>
                                          <th>UserID</th>
                                          <th>Status</th>
                                          <th>Action</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      <?php

                                        if ($user_list) {
                                            $i = 0;
                                            foreach ($user_list as $dt) {
                                        ?>
                                              <tr>

                                                  <td><?= ++$i; ?></td>
                                                  <td><?= $dt->user_name; ?></td>
                                                  <td><?= $dt->user_id; ?></td>
                                                  <td><?= $dt->user_status != 'A' ? 'De-Active' : 'Active'; ?></td>
                                                  <td>
                                                      <a href="<?= site_url(); ?>/useredit?id=<?= $dt->user_id; ?>" data-toggle="tooltip" data-placement="bottom" title="Edit">
                                                          <i class="fa fa-edit fa-2x text-warning"></i>
                                                      </a>
                                                      <!-- <a href="<?= site_url(); ?>/edept?id=<?= $dt->user_id; ?>" data-toggle="tooltip" data-placement="bottom" title="Delete">
                                                          <i class="fa fa-trash fa-2x text-danger"></i>
                                                      </a> -->
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
  </script>