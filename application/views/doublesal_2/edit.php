<div class="wraper">      

<div class="col-md-6 container form-wraper">

    <form method="POST" 
        id="form"
        action="<?php echo site_url("payroll/doublesal/edit");?>" >

        <div class="form-header">
        
            <h4>Employee Details</h4>
        
        </div>

        <input type="hidden"
                name="emp_code"
                id="emp_code"
                value="<?php echo $doublesal_dtls->emp_code; ?>"
        />

        <div class="form-group row">

            <label for="emp_name" class="col-sm-2 col-form-label">Employee Name:</label>

            <div class="col-sm-10">

                <input type="text"
                        name="emp_name"
                        class="form-control required"
                        id="emp_name"
                        value="<?php echo $doublesal_dtls->emp_name; ?>"
                />

            </div>

        </div>

        <div class="form-group row">

            <label for="emp_catg" class="control-lebel col-sm-2 col-form-label">Category:</label>

                <div class="col-sm-10">

                    <select
                        class="form-control required"
                        name="emp_catg"
                        id="emp_catg"
                    >

                        <option value="">Select Category</option>

                        <?php foreach($category_dtls as $c_list) {

                        ?>
                            <option value="<?php echo $c_list->category_code ?>" 
                                    <?php echo ($doublesal_dtls->emp_catg == $c_list->category_code)? 'selected':'';?>>
                                    <?php echo $c_list->category_type; ?>
                            </option>

                        <?php

                        }

                        ?>

                    </select>   

                </div>

        </div>

        <div class="form-group row">

            <label for="designation" class="col-sm-2 col-form-label">Designation:</label>

            <div class="col-sm-4">

                <input type="text"
                    class= "form-control required"
                    name = "designation"
                    id   = "designation"
                    value="<?php echo $doublesal_dtls->designation; ?>"
                />

            </div>

            <label for="department" class="col-sm-2 col-form-label">Department:</label>

            <div class="col-sm-4">

                <input type="text"
                    class= "form-control"
                    name = "department"
                    id   = "department"
                    value="<?php echo $doublesal_dtls->department; ?>"
                />

            </div>

        </div> 

        <div class="form-group row">

            <label for="month" class="col-sm-2 col-form-label">Month:</label>

                <div class="col-sm-4">

                    <select
                                class="form-control required"
                                name="month"
                                id="month"
                                required
                    >

                        <option value="">Select Month</option>

                        <?php 
                        
                        foreach($month_list as $m_list) {?>

                            <option value="<?php echo $m_list->month_name; ?>" 
                                    <?php echo ($m_list->month_name == $doublesal_dtls->sal_month) ? "selected":""; ?>
                            
                            ><?php echo $m_list->month_name; ?></option>

                        <?php
                        }
                        ?>

                    </select>   

                </div>


            <label for="year" class="col-sm-2 col-form-label">Year:</label>

            <div class="col-sm-4">

                <input type="text"
                    class="form-control required"
                    name="year"
                    id="year"
                    value="<?php echo $doublesal_dtls->year;?>"
                    readonly required	
                />

            </div>

        </div>

        <div class="form-header">
        
            <h4>Salary Details</h4>
        
        </div>

        <div class="form-group row">

            <label for="band_pay" class="col-sm-2 col-form-label band_pey">Band Pay:</label>

            <div class="col-sm-10">

                <input type="text"
                    class= "form-control required"
                    name = "band_pay"
                    id   = "band_pay"
                    value="<?php echo $doublesal_dtls->band_pay; ?>"
                />

            </div>

        </div> 

        <div class="form-group row grade_pey">

            <label for="grade_pay" class="col-sm-2 col-form-label">Grade Pay:</label>

            <div class="col-sm-10">

                <input type="text"
                    class= "form-control"
                    name = "grade_pay"
                    id   = "grade_pay"
                    value="<?php echo $doublesal_dtls->grade_pay; ?>"
                />

            </div>

        </div> 

        <div class="form-group row grade_pey">

            <label for="ma" class="col-sm-2 col-form-label">Medical Allowance:</label>

            <div class="col-sm-10">

                <input type="text"
                    class= "form-control"
                    name = "ma"
                    id   = "ma"
                    value="<?php echo $doublesal_dtls->ma; ?>"
                />

            </div>

        </div> 

        <div class="form-group row">

            <label for="p_tax_id" class="col-sm-2 col-form-label">P-TAX:</label>

            <div class="col-sm-10">

                <input type="text"
                        class= "form-control"
                        name = "p_tax_id"
                        id   = "p_tax_id"
                        value="<?php echo $doublesal_dtls->p_tax_id; ?>"
                />

            </div>

        </div> 

        <div class="form-group row">

            <label for="ir_pay" class="col-sm-2 col-form-label">IR:</label>

            <div class="col-sm-10">

                <input type="text"
                    class= "form-control"
                    name = "ir_pay"
                    id   = "ir_pay"
                    value="<?php echo $doublesal_dtls->ir_pay; ?>"
                />

            </div>

        </div>

        <div class="form-group row">

            <label for="remarks" class="col-sm-2 col-form-label">Remarks:</label>

            <div class="col-sm-10">

                <textarea class= "form-control required"
                        name = "remarks"
                        id   = "remarks"
                ><?php echo $doublesal_dtls->remarks; ?></textarea>

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

$(document).ready(function(){

    if(<?php echo $doublesal_dtls->emp_catg ?> != 1){

        $('.band_pey').text('Pay:');
        $('.grade_pey').hide();
    }

$('#emp_catg').change(function(){

    if($(this).val() == 1){

        $('.band_pey').text('Band Pay:');
        $('.grade_pey').show();

    }
    else{

        $('.band_pey').text('Pay:');
        
        $('.grade_pey').val('0.00');
        $('.grade_pey').hide();

    }

});

});

</script>
