<div class="main-panel">
        <div class="content-wrapper">
          <div class="card">
            <div class="card-body">
              <h3>Professional Tax Slab Rate</h3>
              <div class="row">
                <div class="col-12">
                  <div class="table-responsive">
                    <table id="order-listing" class="table">
                      <thead>
                        <tr>
                            <th>Sl. No.</th>
                            <th>From</th>
                            <th>Upto</th>
                            <th>Tax amount</th>
                            <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                      <?php  $i=0; foreach($ptax as $key) {  ?>
                        <tr>
                            <td><?php echo ++$i; ?></td>
                            <td><?php echo $key->st; ?></td>
                            <td><?php echo $key->end; ?></td>
                            <td><?php echo $key->ptax; ?></td>
                            <td>
                                <a href="pedit?sl_no=<?php echo base64_encode($key->id); ?>" data-toggle="tooltip"
                                    data-placement="bottom" title="Edit">
                                    <i class="fa fa-edit fa-2x" style="color: #007bff"></i>
                                </a>
                            </td>
                        </tr>
                        <?php } ?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
</div>