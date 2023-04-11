    <div class="wraper">      

        <div class="col-md-6 container form-wraper">

            <form method="POST" 
                id="form"
                action="<?php echo site_url("payroll/attendance/add");?>" >

                <div class="form-header">

                    <h4>Add Attendance</h4>

                </div>

                <div class="form-group row">

                    <label for="trans_dt" class="col-sm-2 col-form-label">Date:</label>

                    <div class="col-sm-10">

                        <input type="date"
                                name="trans_dt"
                                class="form-control required"
                                id="trans_dt"
                                value="<?php echo $sys_date;?>"
                                readonly
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="sal_month" class="control-lebel col-sm-2 col-form-label">Month:</label>

                        <div class="col-sm-4">

                            <select
                                        class="form-control required"
                                        name="sal_month"
					id="sal_month"
					required
                                >

                                <option value="">Select Month</option>

                                <?php foreach($month_list as $m_list) {?>

                                    <option value="<?php echo $m_list->month_name ?>" ><?php echo $m_list->month_name; ?></option>

                                <?php
                                }
                                ?>

                            </select>   

                        </div>

                    <label for="sal_yr" class="col-sm-2 col-form-label">Year:</label>

                    <div class="col-sm-4">

                        <input type="text"
                            class="form-control"
                            name="sal_yr"
                            id="sal_yr"
			    value="<?php echo date('Y');?>"
			    readonly
                        />

                    </div>

                </div>

                <div class="form-group row">

		    <label for="emp_cd" class="col-sm-2 col-form-label">Name:</label>

                    <div class="col-sm-10">

                        <select
                                class="form-control required"
                                name="emp_cd"
                                id="emp_cd"
                        >

                        <option value="">Select Employee</option>

                        <?php  

                        if($emp_list) {

                            foreach ($emp_list as $e_list) {

                                foreach ($category  as $catg) {

                                    if($e_list->emp_catg == $catg->category_code) {

                        ?>        
                                <option value='{"empid":"<?php echo $e_list->emp_code ?>","empname":"<?php echo $e_list->emp_name; ?>"}'

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
                            readonly
                        />

                    </div>

                </div>    

                <div class="form-group row">

                    <label for="attendance" class="col-sm-2 col-form-label">Attendance:</label>

                    <div class="col-sm-10">

                        <input type = "text"
                            class= "form-control"
                            name = "attendance"
                            id   = "attendance"
                            placeholder="Total Days"
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

            $('#emp_cd').change(function(){

                $('#category').val($(this).find(':selected').attr('catg'));

            });

        });

</script>
