      <div class="main-panel">
          <div class="content-wrapper">
              <div class="card">
                  <div class="card-body">
                      <div class="row" style="margin-bottom:10px">
                          <div class="col-10">
                              <h3>Unapproved Generation List</h3>
                          </div>
                          <div class="col-2"><a href="<?php echo site_url("addgen"); ?>" class="btn btn-primary customFloat_Uts">Add</a></div>
                          <span class="confirm-div" style="float:right; color:green;"></span>
                      </div>
                      <div class="row">
                          <div class="col-12">
                              <div class="table-responsive">
                                  <table id="order-listing" class="table">
                                      <thead>
                                          <tr>
                                              <th>Date</th>
                                              <th>Category</th>
                                              <th>Year</th>
                                              <th>Month</th>
                                              <th>Total Salay</th>
                                              <th>Edit</th>
                                              <th>Delete</th>
                                          </tr>
                                      </thead>
                                      <tbody>

                                          <?php
                                            if ($generation_dtls) {
                                                foreach ($generation_dtls as $d_dtls) {
                                            ?>
                                                  <tr>
                                                      <td><?php echo date('d-m-Y', strtotime($d_dtls->trans_date)); ?></td>
                                                      <td><?php echo $d_dtls->category; ?></td>
                                                      <td><?php echo $d_dtls->sal_year; ?></td>
                                                      <td><?php echo date("F", mktime(0, 0, 0, $d_dtls->sal_month, 10)); ?></td>
                                                      <td><?php echo $d_dtls->tot_sal; ?></td>
                                                      <td>
                                                          <a href="vigen?trans_dt=<?= $d_dtls->trans_date ?>&trans_no=<?= $d_dtls->trans_no; ?>&month=<?= $d_dtls->sal_month; ?>&year=<?= $d_dtls->sal_year; ?>&catg_id=<?= $d_dtls->catg_cd ?>" data-toggle="tooltip" data-placement="bottom" title="Edit">
                                                              <i class="fa fa-eye fa-2x" style="color: #007bff"></i>
                                                          </a>
                                                      </td>
                                                      <td>
                                                          <span type="button" class="delete" date="<?php echo $d_dtls->trans_date; ?>" id="<?php echo $d_dtls->trans_no; ?>" month="<?php echo $d_dtls->sal_month; ?>" year="<?php echo $d_dtls->sal_year; ?>" catg_id="<?= $d_dtls->catg_cd ?>" data-toggle="tooltip" data-placement="bottom" title="Delete">
                                                              <i class="fa fa-trash-o fa-2x" style="color: #bd2130"></i>
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

                      var date = $(this).attr('date'),
                          id = $(this).attr('id'),
                          month = $(this).attr('month'),
                          year = $(this).attr('year'),
                          catg_id = $(this).attr('catg_id');

                      var result = confirm("Do you really want to delete this record?");

                      if (result) {

                          window.location = "<?php echo site_url('unapslipdel?date="+date+"&trans_no="+id+"&month="+month+"&year="+year+"&catg_id="+catg_id+"'); ?>";
                          // window.location = "<?php echo site_url('dstf?empcd="+id+"'); ?>";

                      }

                  });

              });
          </script>

          <script>
              $(document).ready(function() {

                  $('.confirm-div').hide();

                  <?php if ($this->session->flashdata('msg')) { ?>

                      $('.confirm-div').html('<?php echo $this->session->flashdata('msg'); ?>').show();

              });

              <?php } ?>
          </script>