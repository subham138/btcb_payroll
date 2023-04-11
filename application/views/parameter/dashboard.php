<div class="main-panel">
        <div class="content-wrapper">
          <div class="card">
            <div class="card-body">
              <h3>Salary Parameters</h3>
              <div class="row">
                <div class="col-12">
                  <div class="table-responsive">
                    <table id="order-listing" class="table">
                      <thead>
                        <tr>
                            <th>Sl. No.</th>
                            <th>Description</th>
                            <th>Value</th>
                            
                            <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                      <?php  foreach($parameter as $key) {  ?>
                        <tr>
                            <td><?php echo $key->sl_no; ?></td>
                            <td><?php echo $key->param_desc; ?></td>
                            <td><?php echo $key->param_value; ?></td>
                            <td>
                                <a href="vlsedt?sl_no=<?php echo $key->sl_no; ?>" 
                                    data-toggle="tooltip"
                                    data-placement="bottom" 
                                    title="Edit">
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