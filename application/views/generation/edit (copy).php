<div class="wraper">          

    <div class="col-md-6 container form-wraper">

        <form method="POST" 
        action="<?php echo site_url("payroll/generation/edit");?>"
        >      

            <div class="form-header">
            
                <h4>Generation Edit</h4>
            
            </div>

            <input type="hidden"
                   name="trans_no"
                   value="<?php echo $generation_dtls->trans_no;?>"
                />   

            <div class="form-group row">

                <label for="trans_dt" class="col-sm-2 col-form-label">Date:</label>

                <div class="col-sm-10">

                    <input type="date"
                            name="trans_dt"
                            class="form-control required"
                            id="trans_dt"
                            value="<?php echo $generation_dtls->trans_date;?>"
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

                            <option value="<?php echo $m_list->month_name ?>" <?php echo ($generation_dtls->sal_month == $m_list->month_name)?'selected':''; ?> ><?php echo $m_list->month_name; ?></option>

                        <?php
                        }
                        ?>

                    </select>

                </div>    
                

                <label for="year" class="col-sm-2 col-form-label">Year:</label>

                <div class="col-sm-4">

                    <input type="text" class="form-control"
                        name="year" id="year" 
                        value="<?php echo date('Y');?>" readonly
                    />
        
                </div>

            </div>


            <div class="form-group row">

                <label for="bank" class="col-sm-2 col-form-label">Bank:</label>

                <div class="col-sm-10">

                    <select class="form-control required" name="bank" id="bank" required>

                        <option value="">Select Bank</option>

                        <?php 
                        
                        foreach($bank as $b_list) {?>

                        <option value="<?php echo $b_list->acc_code;?>" <?php echo ($b_list->acc_code == $generation_dtls->bank)?'selected':'';?>>
                            <?php echo $b_list->bank_name."(".$b_list->ac_no.")"; ?>
                        </option>
                            
                        <?php

                        }

                        ?>

                    </select>

                </div>
                
            </div>

            <div class="for-group row">
                
                <label for="trans_type" class="col-sm-2 col-form-label">Transaction Type:</label>
                
                <div class="col-sm-10">
                        
                    <select class="form-control required" name="trans_type" id="trans_type" required>

                        <option value="">Select Transaction</option>
                        <option value="C" <?php echo ('C' == $generation_dtls->trans_type)?'selected':'';?>>Cheque</option>
                        <option value="N" <?php echo ('N' == $generation_dtls->trans_type)?'selected':'';?>>NEFT</option>

                    </select>

                </div>	

            </div>

            <div class="for-group row">

                <label for="chq_no" class="col-sm-2 col-form-label">Cheque No.:</label>

                <div class="col-sm-4">

                    <input type="text" 
                           class="form-control" 
                           name="chq_no" 
                           id="chq_no" 
                           value="<?php echo $generation_dtls->chq_no;?>"   
                        />

                </div>


                <label for="chq_dt" class="col-sm-2 col-form-label">Cheque Date:</label> 

                <div class="col-sm-4">

                    <input type="date" 
                           class="form-control" 
                           name="chq_dt" 
                           id="chq_dt"
                           value="<?php echo $generation_dtls->chq_dt;?>"   
                        />

                </div>

            </div>  

            <div class="form-group row">

                <div class="col-sm-10">

                    <input type="submit" class="btn btn-info" value="Generate New Payslip" />

                </div>

            </div>   

        </form>
    
    </div>  

</div>

<script>

    $(document).ready(function() {

    $('.confirm-div').hide();

    <?php if($this->session->flashdata('msg')){ ?>

    $('.confirm-div').html('<?php echo $this->session->flashdata('msg'); ?>').show();

    });

    <?php } ?>

</script>
