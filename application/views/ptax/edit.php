<div class="main-panel">
        <div class="content-wrapper">
          <div class="card">
            <div class="card-body">
              <h3>Ptax Slab</h3>
              <div class="row">
                <div class="col-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                        <form action='<?php echo base_url();?>index.php/pedit' method='post' >
                        <input type="hidden" name="id" class="form-control" id="id" value= "<?php echo $ptax_dtls->id; ?>" />
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-4">
                                    <label for="exampleInputName1">Start From:</label>
                                    <input type="text" class="form-control"  name="st" id="st" value="<?php echo $ptax_dtls->st; ?>" readonly/>
                                    </div>
                                    <div class="col-4">
                                    <label for="exampleInputName1">End:</label>
                                    <input type="text" name="end" class="form-control" id="end" value= "<?php echo $ptax_dtls->end; ?>" readonly/>
                                    </div>
                                    <div class="col-4">
                                    <label for="exampleInputName1">Tax:</label>
                                    <input type="text" name="ptax" class="form-control" id="ptax" value= "<?php echo $ptax_dtls->ptax; ?>" />
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