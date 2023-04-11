<div class="wraper">          

    <div class="col-md-6 container form-wraper">

        <form method="POST" 
            action="<?php echo site_url("addgen");?>"
            >      

            <div class="form-header">
            
                <h4><?php if($generation_dtls) {

                        echo "Last Generated Date: ".$generation_dtls->sal_month.", ".$generation_dtls->sal_year."";

                    }

                    else {

                        echo "Generate payslip";

                    }
                
                    ?>
                    
                </h4>
            
            </div>

            <div>

                <h4><span class="confirm-div" style="float:right; color:green;"></span></h4>

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

                <label for="month" class="col-sm-2 col-form-label">Month:</label>

                <div class="col-sm-4">

                    <select class="form-control required" name="month" id="month" required>

                        <option value="">Select Month</option>

                        <?php foreach($month_list as $m_list) {?>

                            <option value="<?php echo $m_list->id; ?>" ><?php echo $m_list->month_name; ?></option>

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

                <label for="category" class="col-sm-2 col-form-label">Category:</label>

                <div class="col-sm-10">

                    <select type="text"
                                class="form-control required"
                                name="category"
                                id="category"
                                required		
                        >

                        <option value="">Select Category</option>

                        <?php foreach($category as $c_list) {?>

                            <option value="<?php echo $c_list->category_code; ?>" ><?php echo $c_list->category_type; ?></option>

                        <?php
                        }
                        ?>

                    </select>   

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
