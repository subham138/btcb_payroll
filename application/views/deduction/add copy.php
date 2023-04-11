      <div class="main-panel">
        <div class="content-wrapper">
          <div class="card">
            <div class="card-body">
              <h3>Add Deductions</h3>
              <div class="row">
                <div class="col-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                        <form method="POST" id="form" action="<?php echo site_url("slrydedad");?>" >
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-6">
                                    <label for="exampleInputName1">Name:</label>
                                    <select
                                class="form-control required"
                                name="emp_code"
                                id="emp_code"
                        >

                        <option value="">Select Employee</option>

                        <?php  

                        if($emp_list) {

                            foreach ($emp_list as $e_list) {

                                foreach ($category  as $catg) {

                                    if($e_list->emp_catg == $catg->category_code) {

                        ?>        
                                <!--<option value='{"empid":"<?php echo $e_list->emp_code ?>","empname":"<?php echo $e_list->emp_name; ?>"}'

                                catg="<?php echo $catg->category_type; ?>"            
                                ><?php echo $e_list->emp_name; ?></option>-->

                                <option value="<?php echo $e_list->emp_code ?>"
                                catg="<?php echo $catg->category_type; ?>"            
                                ><?php echo $e_list->emp_name; ?></option>

                        <?php
                                    }

                                }    

                            }

                        }

                        ?>
                            
                        </select>
                                    </div>
                                    <div class="col-6">
                                    <label for="exampleInputName1">Category:</label>
                                    <input type = "text"
                            class= "form-control"
                            name = "category"
                            id   = "category"
                            readonly required
                        />

                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-6">
                                    <label for="exampleInputName1">District:</label>
                                    <input type = "text"
                            class= "form-control"
                            name = "dist"
                            id   = "dist"
                            readonly required
                        />

                  </div>
                  
                  <div class="col-6">
                        <label for="exampleInputName1">Salary Linked Insurance:</label>
                        <input type="text"
                            class= "form-control"
                            name = "sal_ins"
                            id   = "sal_ins"
                            value = 0.00	
                        />
                    </div>
                 
                    </div>
            </div>
            <!-- <div class="form-group">
                <div class="row">
                     div class="col-6">
                        <label for="exampleInputName1">Year:</label>
                        <input type="text" class="form-control" name="year" id="year" 
				                    value="<?php //echo date('Y');?>" readonly/>
                    </div> 
                </div>
            </div> -->
            <div class="form-group">
                <div class="row">
                    <div class="col-6">
                        <label for="exampleInputName1">Co-operative Credit Society:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "ccs"
                            id   = "ccs"
                            value = 0.00 
                        />

                    </div>
                    <div class="col-6">
                        <label for="exampleInputName1">House Building Loan:</label>
                        <input type = "text"
                                class= "form-control"
                                name = "hbl"
                                id   = "hbl"
                                value = 0.00 
                            />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-6">
                        <label for="exampleInputName1">Telephone:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "phone"
                            id   = "phone"
                            value = 0.00
                        />
                    </div>
                    <div class="col-6">
                        <label for="exampleInputName1">Medical Advance::</label>
                        <input type = "text"
                            class= "form-control"
                            name = "med_adv"
                            id   = "med_adv"
                            value = 0.00
                        />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-6">
                        <label for="exampleInputName1">Festival Advance:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "fest_adv"
                            id   = "fest_adv"
                            value = 0.00
                        />
                    </div>
                    <div class="col-6">
                        <label for="exampleInputName1">Thrift Fund:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "tf"
                            id   = "tf"
                            value = 0.00
                        />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-6">
                        <label for="exampleInputName1">Medical Insurance:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "med_ins"
                            id   = "med_ins"
                            value = 0.00
                        />
                    </div>
                    <div class="col-6">
                        <label for="exampleInputName1">Computer Loan:</label>
                           <input type = "text"
                                class= "form-control"
                                name = "comp_loan"
                                id   = "comp_loan"
                                value = 0.00
                            />

                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-6">
                        <label for="exampleInputName1">Itax:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "itax"
                            id   = "itax"
                            value = 0.00
                        />
                    </div>
                    <div class="col-6">
                        <label for="exampleInputName1">GPF</label>
                        <input type = "text"
                            class= "form-control"
                            name = "gpf"
                            id   = "gpf"
                            value = 0.00
                        />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-4">
                        <label for="exampleInputName1">EPF:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "epf"
                            id   = "epf"
                            value = 0.00
                        />
                    </div>
                    <div class="col-4">
                        <label for="exampleInputName1">Other Deductions:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "other_ded"
                            id   = "other_ded"
                            value = 0.00
                        />
                    </div>
                    <div class="col-4">
                        <label for="exampleInputName1">PTax:</label>
                        <input type = "text"
                            class= "form-control"
                            name = "ptax"
                            id   = "ptax"
                            value = 0.00
                        />
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

        <script>

    // $("#form").validate({
    //     rules: {
    //         sal_yr: "required",
    //     },
    //     messages: {
    //         sal_yr: "Please enter valid input"
    //     }
        
    // });


</script>

<script>

    $(document).ready(function(){

        $('#emp_code').change(function(){

            $('#category').val($(this).find(':selected').attr('catg'));

            $.get(
                '<?php echo site_url("Salary/f_emp_dtls"); ?>',
                {
                    emp_code: $(this).val() 
                }
            )

            .done(function(data){
                var parseData = JSON.parse(data);
				// basic=$('#basic').val() 
                console.log(parseData );
                $('#dist').val(parseData.district_name) 

            });

        });

    });
    
</script>


<script>
	
	$(document).ready(function(){
	
	
		var basic  = 0.00;
		
		$('#emp_code').change(function(){
	
			$.get( 
	
				'<?php echo site_url("Salary/f_sal_dtls");?>',
				{ 
	
					emp_code: $(this).val()
                    // rbt_add =$('#rbt_add').val() 	
				}
	
			)
			.done(function(data){
				var parseData = JSON.parse(data);
				// basic=$('#basic').val() 
                console.log(parseData );
                $('#basic').val(parseData.basic_pay) 
                $('#da').val(parseData.da) 
                $('#hra').val(parseData.hra) 
                $('#ma').val(parseData.ma);
               
                var epfrate = "<?php echo epfrate() ?>";
                
                var netsal = (parseData.basic_pay+parseData.da+parseData.hra+parseData.ma); 
                $('#epf').val(parseFloat((netsal)*epfrate).toFixed());
                if(netsal >= 10000 && netsal <= 15000){
                    $('#ptax').val(110);
                }else if(netsal >= 15001 && netsal <= 25000){
                    $('#ptax').val(130);
                }else if(netsal >= 25001 && netsal <= 40000){
                    $('#ptax').val(150);
                }else if(netsal >= 40001){
                    $('#ptax').val(200);
                }

			});
            
	
		});
	
	});
	
</script>
