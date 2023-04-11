<div class="main-panel">
        <div class="content-wrapper">
          <div class="card">
            <div class="card-body">
              <h3>Department Edit</h3>
              <div class="row">
                <div class="col-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                        <form method="POST" id="form" action="<?php echo base_url();?>index.php/edept" >
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-6">
                                    <label for="exampleInputName1">Employee Name:</label>
                                    <input type='hidden' name='id' value='<?php echo $dept_dtls->id; ?>' />
                                    <input type="text" name="name" class="form-control required" id="name" value="<?php echo $dept_dtls->name; ?>" />
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
        </div>