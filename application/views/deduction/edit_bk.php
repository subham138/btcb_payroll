<div class="wraper">      

<div class="col-md-6 container form-wraper">

    <div class="form-header">
        
        <h4>Edit Deductions</h4>
     
    </div>

    <form method="POST" 
        id="form"
        action="<?php echo site_url("slrydeded");?>" >

        <div class="form-group row">

            <label for="emp_cd" class="col-sm-2 col-form-label">Employee code:</label>

            <div class="col-sm-10">

                <input type="text"
                        name="emp_code"
                        class="form-control required"
                        id="emp_code"
                        value="<?php echo $deduction_dtls->emp_code;?>"
                        readonly
                />

            </div>

        </div>

        <div class="form-group row">

            <label for="emp_cd" class="col-sm-2 col-form-label">Name:</label>

            <div class="col-sm-10">

                <input type="text"
                        name="empname"
                        class="form-control required"
                        id="empname"
                        value="<?php echo $deduction_dtls->emp_name;?>"
                        readonly
                >

            </div>

        </div> 

        <div class="form-group row">

            <label for="category" class="col-sm-2 col-form-label">Category:</label>

            <div class="col-sm-10">

                <input type = "text"
                    class= "form-control"
                    name = "category"
                    id   = "category"
                    value="<?php echo $deduction_dtls->category_type;?>"
                    readonly
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
                    value="<?php echo $deduction_dtls->district_name;?>"
                    readonly
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
                           value="<?php echo $deduction_dtls->ded_yr;?>" readonly/>
    
                </div>

        </div>


        <div class="form-group row">

            <label for="gen_adv" class="col-sm-2 col-form-label">Salary Linked Insurance:</label>

            <div class="col-sm-4">

                <input type="text"
                    class= "form-control"
                    name = "sal_ins"
                    id   = "sal_ins"
                    value = "<?php echo $deduction_dtls->insuarance;?>"	
                />

            </div>

           <label for="gen_intt" class="col-sm-2 col-form-label">Co-operative Credit Society:</label>

            <div class="col-sm-4">

                <input type = "text"
                    class= "form-control"
                    name = "ccs"
                    id   = "ccs"
                    value = "<?php echo $deduction_dtls->ccs;?>" 
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
                        value = "<?php echo $deduction_dtls->hbl;?>"
                    />

                </div>

        
            <label for="lic" class="col-sm-2 col-form-label">Telephone:</label>

            <div class="col-sm-4">

                <input type = "text"
                    class= "form-control"
                    name = "phone"
                    id   = "phone"
                    value = "<?php echo $deduction_dtls->telephone;?>"
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
                    value = "<?php echo $deduction_dtls->med_adv;?>"
                />

            </div>

            <label for="itax" class="col-sm-2 col-form-label">Festival Advance:</label>

            <div class="col-sm-4">

                <input type = "text"
                    class= "form-control"
                    name = "fest_adv"
                    id   = "fest_adv"
                    value = "<?php echo $deduction_dtls->festival_adv;?>"
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
                    value = "<?php echo $deduction_dtls->tf;?>"
                />

            </div>

            <label for="itax" class="col-sm-2 col-form-label">Medical Insurance:</label>

            <div class="col-sm-4">

                <input type = "text"
                    class= "form-control"
                    name = "med_ins"
                    id   = "med_ins"
                    value = "<?php echo $deduction_dtls->med_ins;?>"
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
                    value = "<?php echo $deduction_dtls->comp_loan;?>"
                />

            </div>

            <label for="itax" class="col-sm-2 col-form-label">Itax:</label>

            <div class="col-sm-4">

                <input type = "text"
                    class= "form-control"
                    name = "itax"
                    id   = "itax"
                    value = "<?php echo $deduction_dtls->itax;?>"
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
                    value = "<?php echo $deduction_dtls->gpf;?>"
                />

            </div>

            <label for="itax" class="col-sm-2 col-form-label">EPF:</label>

            <div class="col-sm-4">

                <input type = "text"
                    class= "form-control"
                    name = "epf"
                    id   = "epf"
                    value = "<?php echo $deduction_dtls->epf;?>"
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
                    value = "<?php echo $deduction_dtls->other_deduction;?>"
                />

            </div>

            <label for="itax" class="col-sm-2 col-form-label">PTax:</label>

            <div class="col-sm-4">

                <input type = "text"
                    class= "form-control"
                    name = "ptax"
                    id   = "ptax"
                    value = "<?php echo $deduction_dtls->ptax;?>"
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

    $('#month').change(function(){

        /*$('#category').val($(this).find(':selected').attr('catg'));

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

        });*/

        $.get( 

            '<?php echo site_url("Salary/f_sal_dtls");?>',
            { 

                emp_code: $("#emp_code").val()	
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