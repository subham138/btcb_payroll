      <div class="main-panel">
          <div class="content-wrapper">
              <div class="card">
                  <div class="card-body">
                      <div class="row" style="margin-bottom:10px">
                          <div class="col-10">
                              <h3>Earnings</h3>
                          </div>
                          <div class="col-2"> <a href="<?php echo site_url("slryad"); ?>" class="btn btn-primary" style="width: 100px;">Add</a></div>
                          <span class="confirm-div" style="float:right; color:green;"></span>
                      </div>
                      <div class="row">
                          <div class="col-12">
                              <div class="table-responsive">
                                  <table id="order-listing" class="table">
                                      <thead>
                                          <tr>
                                              <th>Sl No.</th>
                                              <!-- <th>Date</th> -->
                                              <th>Employee code</th>
                                              <th>Name</th>
                                              <th>District</th>
                                              <th>Edit</th>
                                              <th>Delete</th>
                                          </tr>
                                      </thead>
                                      <tbody>
                                          <?php

                                            if ($earning_dtls) {

                                                $i = 1;
                                                foreach ($earning_dtls as $e_dtls) {
                                            ?>
                                                  <tr>
                                                      <td><?php echo $i++; ?></td>
                                                      <!-- <td><?php //echo date("d-m-Y", strtotime($e_dtls->effective_date)); 
                                                                ?></td> -->
                                                      <td><?php echo $e_dtls->emp_code; ?></td>
                                                      <td><?php echo $e_dtls->emp_name; ?></td>
                                                      <td><?php echo $e_dtls->district_name; ?></td>
                                                      <td>
                                                          <a href="slryed?emp_code=<?php echo $e_dtls->emp_code; ?>&date=<?php echo $e_dtls->effective_date; ?>" data-toggle="tooltip" data-placement="bottom" title="Edit">
                                                              <i class="fa fa-edit fa-2x" style="color: #007bff"></i>

                                                          </a>
                                                      </td>
                                                      <td>
                                                          <span class="delete" id="<?php echo $e_dtls->emp_code; ?>" date="<?php echo $e_dtls->effective_date; ?>" data-toggle="tooltip" data-placement="bottom" title="Delete">
                                                              <i class="fa fa-trash-o fa-2x"></i>
                                                          </span>
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
          <script>
              $(document).ready(function() {
                  $('.delete').click(function() {

                      var id = $(this).attr('id'),
                          date = $(this).attr('date');
                      var result = confirm("Do you really want to delete this record?");
                      if (result) {

                          window.location = "<?php echo site_url('salary/earning_delete?emp_code="+id+"&effective_date="+date+"'); ?>";
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