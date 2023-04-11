<div class="main-panel">
        <div class="content-wrapper">
          <div class="card">
            <div class="card-body">
              <h3>Salary Parameters</h3>
              <div class="row">
                <div class="col-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                        <form action='<?php echo base_url();?>index.php/vlsedt' method='post' >
                        <input type="hidden" name="sl_no" class="form-control" id="sl_no" value= "<?php echo $param_dtls->sl_no; ?>" />
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-6">
                                    <label for="exampleInputName1">Description:</label>
                                    <input type="text" class="form-control" id="exampleInputName1" name="param_desc" id="param_desc" value= "<?php echo $param_dtls->param_desc; ?>" readonly/>
                                    </div>
                                    <div class="col-6">
                                    <label for="exampleInputName1">Value:</label>
                                    <input type="text" name="param_value" class="form-control" id="param_value" value= "<?php echo $param_dtls->param_value; ?>" />
                                    </div>
                                </div>
                            </div>
                            
                        <button type="submit" class="btn btn-primary mr-2">Submit</button>
                            <button class="btn btn-light">Cancel</button>
                        </form>
                      </div>
                    </div>
                </div>
              </div>
            </div>
</div>