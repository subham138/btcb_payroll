    <div class="wraper">      

        <div class="col-md-6 container form-wraper">

            <div class="form-header">
                
                <h4>Add Deductions</h4>
             
            </div>

            <form method="POST" 
                id="form"
                action="<?php echo site_url("slrydedad");?>" >

                <div class="form-group row">

                    <label for="emp_cd" class="col-sm-2 col-form-label">Name:</label>

                    <div class="col-sm-10">

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

                </div>

                <div class="form-group row">

                    <label for="category" class="col-sm-2 col-form-label">Category:</label>

                    <div class="col-sm-10">

                        <input type = "text"
                            class= "form-control"
                            name = "category"
                            id   = "category"
                            readonly required
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="dist" class="col-sm-2 col-form-label">District:</label>

                    <div class="col-sm-10">

                        <input type = "text"
                            class= "form-control"
                            name = "dist"
                            id   = "dist"
                            readonly required
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="month" class="col-sm-2 col-form-label">Month:</label>

                        <div class="col-sm-4">

                            <select class="form-control required" name="month" id="month" required>

                                <option value="">Select Month</option>

                                <?php foreach($month_list as $m_list) {?>

                                    <option value="<?php echo $m_list->id ?>" ><?php echo $m_list->month_name; ?></option>

                                <?php
                                }
                                ?>

                            </select>

                        </div>   

                    <label for="year" class="col-sm-2 col-form-label">Year:</label>

                    	<div class="col-sm-4">

			                <input type="text" class="form-control" name="year" id="year" 
				                    value="<?php echo date('Y');?>" readonly/>
			
			            </div>

                </div>


                <div class="form-group row">

                    <label for="gen_adv" class="col-sm-2 col-form-label">Salary Linked Insurance:</label>

                    <div class="col-sm-4">

                        <input type="text"
                            class= "form-control"
                            name = "sal_ins"
                            id   = "sal_ins"
                            value = 0.00	
                        />

                    </div>

                   <label for="gen_intt" class="col-sm-2 col-form-label">Co-operative Credit Society:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "ccs"
                            id   = "ccs"
                            value = 0.00 
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="gen_intt" class="col-sm-2 col-form-label">House Building Loan:</label>

                        <div class="col-sm-4">

                            <input type = "text"
                                class= "form-control"
                                name = "hbl"
                                id   = "hbl"
                                value = 0.00 
                            />

                        </div>

                
                    <label for="lic" class="col-sm-2 col-form-label">Telephone:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "phone"
                            id   = "phone"
                            value = 0.00
                        />

                    </div>

                </div>


                <div class="form-group row">

                    <label for="itax" class="col-sm-2 col-form-label">Medical Advance:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "med_adv"
                            id   = "med_adv"
                            value = 0.00
                        />

		            </div>

                    <label for="itax" class="col-sm-2 col-form-label">Festival Advance:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "fest_adv"
                            id   = "fest_adv"
                            value = 0.00
                        />

		            </div>

                </div>    

                <div class="form-group row">

                    <label for="tf" class="col-sm-2 col-form-label">Thrift Fund:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "tf"
                            id   = "tf"
                            value = 0.00
                        />

                    </div>

                    <label for="itax" class="col-sm-2 col-form-label">Medical Insurance:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "med_ins"
                            id   = "med_ins"
                            value = 0.00
                        />

                    </div>

                </div>    

                <div class="form-group row">

                    <label for="tf" class="col-sm-2 col-form-label">Computer Loan:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "comp_loan"
                            id   = "comp_loan"
                            value = 0.00
                        />

                    </div>

                    <label for="itax" class="col-sm-2 col-form-label">Itax:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "itax"
                            id   = "itax"
                            value = 0.00
                        />

                    </div>

                </div>   

                <div class="form-group row">

                    <label for="tf" class="col-sm-2 col-form-label">GPF:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "gpf"
                            id   = "gpf"
                            value = 0.00
                        />

                    </div>

                    <label for="itax" class="col-sm-2 col-form-label">EPF:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "epf"
                            id   = "epf"
                            value = 0.00
                        />

                    </div>

                </div>    

                <div class="form-group row">

                    <label for="tf" class="col-sm-2 col-form-label">Other Deductions:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "other_ded"
                            id   = "other_ded"
                            value = 0.00
                        />

                    </div>

                    <label for="itax" class="col-sm-2 col-form-label">PTax:</label>

                    <div class="col-sm-4">

                        <input type = "text"
                            class= "form-control"
                            name = "ptax"
                            id   = "ptax"
                            value = 0.00
                        />

                    </div>

                </div>    
	
		        <div class="form-group row">

                    <div class="col-sm-10">

                        <input type="submit" class="btn btn-info" value="Save" />

                    </div>

                </div>

            </form>

        </div>

    </div>

<script>

    $("#form").validate({
        rules: {

            sal_yr: "required",

        },
        messages: {
            
            sal_yr: "Please enter valid input"
        }
        
    });


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
                //console.log(parseData );
                $('#dist').val(parseData.district_name) 

            });

            $.get( 
	
                '<?php echo site_url("Salary/f_sal_dtls");?>',
                { 

                    emp_code: $(this).val()	
                }

            )

            .done(function(data){
				var parseData = JSON.parse(data);
                //console.log(parseData );
                var basic = parseData.basic_pay; 
                var da    = parseData.da;
                var epf   = (basic + da)*(parseData.epf/100);

                console.log(basic);

                console.log(da);

                console.log(epf.toFixed(2));

                $('#epf').val(epf.toFixed(2));

			});

        });

    });
    
</script>
