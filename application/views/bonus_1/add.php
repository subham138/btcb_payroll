    <div class="wraper">      

        <div class="col-md-6 container form-wraper">

            <div class="form-header">
                
                <h4>Advance/Bonus Entry</h4>
             
            </div>

            <form method="POST" 
                id="form"
                action="<?php echo site_url("payroll/bonus/add");?>" >

                <div class="form-group row">

                    <label for="sal_yr" class="col-sm-2 col-form-label">Transaction Date:</label>

                    <div class="col-sm-10">

                        <input type="date"
                                name="sal_date"
                                class="form-control required"
                                id="sal_date"
                                value="<?php echo $sys_date;?>"
                                readonly
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="sal_month" class="control-lebel col-sm-2 col-form-label">Select Month:</label>

                        <div class="col-sm-10">

                            <select
                                class="form-control required"
                                name="sal_month"
                                id="sal_month"
                            >

                                <option value="">Select Month</option>

                                <?php foreach($month_list as $m_list) {?>

                                    <option value="<?php echo $m_list->month_name ?>" ><?php echo $m_list->month_name; ?></option>

                                <?php

                                }

                                ?>

                            </select>   

                        </div>
                </div>

                <div class="form-group row">

                    <label for="sal_yr" class="col-sm-2 col-form-label">Input Year:</label>

                    <div class="col-sm-10">

                        <input type="text"
                            class="form-control"
                            name="sal_yr"
                            id="sal_yr"
                            value="<?php echo date('Y');?>"
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

                    <label for="bonus_type" class="col-sm-2 col-form-label">Adv/Bonus Type:</label>

                    <div class="col-sm-10">

                        <select
                            class="form-control required"
                            name="bonus_type"
                            id="bonus_type"
                        >

                            <option value="">Select</option>

                            <option value="A">Advance</option>

                            <option value="B">Bonus</option>
                            
                        </select>

                    </div>

                </div>

                <div class="form-group row">

                    <label for="amount" class="col-sm-2 col-form-label">Amount:</label>

                    <div class="col-sm-10">

                        <input type="text"
                            class= "form-control required"
                            name = "amount"
                            id   = "amount"
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