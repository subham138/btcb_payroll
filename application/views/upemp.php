  <div class="wraper">      

	<div class="col-md-6 container form-wraper">

		<div class="form-header">
                
            <h4>Upload Employee Details</h4>
             
        </div>

		    <div class="form-group row">				

			<label for="sample_file" class="col-sm-2 col-form-label">Sample File:</label>	
			
			<div class="col-sm-10">
			    <a name="sample_file" href="<?php echo site_url('payroll/download');?>">Download</a>
		    	</div>
		     </div>
				
		     <form method="POST" action="<?php site_url("payroll/addemp"); ?>" enctype="multipart/form-data">
			
		       <div class="form-group row">

		       <label for="upemp" class="col-sm-2 col-form-label">Select CSV File:</label>

		        <div class="col-sm-10">
		   	    <input type="file" name="upemp">
		        </div>
		       </div>

		       <div class="form-group row">

		       <div class="col-sm-10">				 
			   <input type="submit" class="btn btn-info" name="importSubmit" value="Save" >
	               </div>
		       </div>
		     </form>

	</div>

</div>	







	

