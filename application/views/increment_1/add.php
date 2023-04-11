    <div class="wraper">      

        <div class="col-md-6 container form-wraper">

            <form method="POST" 
                id="form"
                action="<?php echo site_url("payroll/increment/add");?>" >

                <div class="form-header">
                
                    <h4>Increment Entry</h4>
                
                </div>

                <div class="form-group row">

                    <label for="effective_date" class="col-sm-2 col-form-label">Transaction Date:</label>

                    <div class="col-sm-10">

                        <input type="date"
                                name="effective_date"
                                class="form-control required"
                                id="effective_date"
                                value="<?php echo $sys_date;?>"
                                readonly
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="emp_no" class="col-sm-2 col-form-label">Emplyee Name:</label>

                    <div class="col-sm-10">

                        <select
                            class="form-control required"
                            name="emp_no"
                            id="emp_no"
                        >

                        <option value="">Select Employee</option>

                        <?php  

                        if($emp_list) {

                            foreach ($emp_list as $e_list) {

                        ?>        
                                    <option value='{"empid":"<?php echo $e_list->emp_code ?>","empname":"<?php echo $e_list->emp_name; ?>"}'
                                    
                                    ><?php echo $e_list->emp_name; ?></option>

                        <?php  

                            }

                        }

                        ?>
                            
                        </select>

                    </div>

                </div>

                <div class="form-group row">

                    <label for="band_pay" class="col-sm-2 col-form-label">Band Pay:</label>

                    <div class="col-sm-10">

                        <input type="text"
                            class= "form-control required"
                            name = "band_pay"
                            id   = "band_pay"
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="grade_pay" class="col-sm-2 col-form-label">Grade Pay:</label>

                    <div class="col-sm-10">

                        <input type="text"
                            class= "form-control required"
                            name = "grade_pay"
                            id   = "grade_pay"
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="ir" class="col-sm-2 col-form-label">I.R.:</label>

                    <div class="col-sm-10">

                        <input type="text"
                            class= "form-control required"
                            name = "ir"
                            id   = "ir"
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

    $("#form").validate();

</script>

<script>

    $(document).ready(function(){

        $('#emp_no').change(function(){

            $('#category').val($(this).find(':selected').attr('catg'));

        });

    });
    
</script>