    <div class="wraper">      

        <div class="col-md-6 container form-wraper">

            <form method="POST" 
                id="form"
                action="<?php echo site_url("payroll/stopsalary/add");?>" >

                <div class="form-header">
                
                    <h4>Stop Salary Entry</h4>
                
                </div>
                
                <div class="form-group row">

                    <label for="trans_dt" class="col-sm-2 col-form-label">Transaction Date:</label>

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

                    <label for="status" class="col-sm-2 col-form-label">Emplyee Name:</label>

                    <div class="col-sm-10">

                        <select
                            class="form-control required"
                            name="status"
                            id="status"
                        >

                            <option value="">Select Status</option>

                            <option value='A'>Active</option>

                            <option value='I'>Inactive</option>

                        </select>

                    </div>

                </div>   

                <div class="form-group row">

                    <label for="remarks" class="col-sm-2 col-form-label">Remarks:</label>

                    <div class="col-sm-10">

                        <textarea class="form-control required" name="remarks"></textarea>

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