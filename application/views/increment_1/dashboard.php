    <div class="wraper">  

        <div class="row">
            
            <div class="col-lg-9 col-sm-12">

                <h1><strong>Employees Increment</strong></h1>

            </div>

        </div>    
        
        <div class="col-lg-12 container contant-wraper">     

            <h3>
            
                <small><a href="<?php echo site_url("payroll/increment/add");?>" class="btn btn-primary" style="width:100px;">Add</a></small>
                <span class="confirm-div" style="float:right; color:green;"></span>

            </h3>

            

            <table class="table table-bordered table-hover">

                <thead>

                    <tr>
                    
                        <th>Emplyee Code</th>
                        <th>Emplyee Name</th>
                        <th>Increment Date</th>
                        <th>Band Pay</th>
                        <th>Grade Pay</th>
                        <th>I.R.</th>

                    </tr>

                </thead>

                <tbody> 

                    <?php 
                    
                    if($increment_dtls) {

                        
                            foreach($increment_dtls as $i_dtls) {

                    ?>

                            <tr>

                                <td><?php echo $i_dtls->emp_cd; ?></td>
                                <td><?php echo $i_dtls->emp_name; ?></td>
                                <td><?php echo date("d-m-Y", strtotime($i_dtls->effective_dt)); ?></td>
                                <td style="text-align:right;"><?php echo $i_dtls->band_pay; ?></td>
                                <td style="text-align:right;"><?php echo $i_dtls->grade_pay; ?></td>
                                <td style="text-align:right;"><?php echo $i_dtls->ir_amt; ?></td>

                            </tr>

                    <?php
                            
                            }

                        }

                        else {

                            echo "<tr><td colspan='10' style='text-align: center;'>No data Found</td></tr>";

                        }
                    ?>
                
                </tbody>

                <tfoot>

                    <tr>
                    
                        <th>Emplyee Code</th>
                        <th>Emplyee Name</th>
                        <th>Increment Date</th>
                        <th>Band Pay</th>
                        <th>Grade Pay</th>
                        <th>I.R.</th>

                    </tr>
                
                </tfoot>

            </table>
            
        </div>

    </div>

<script>

    $(document).ready( function (){

        $('.delete').click(function () {

            var id = $(this).attr('id'),
                date = $(this).attr('date');

            var result = confirm("Do you really want to delete this record?");

            if(result) {

                window.location = "<?php echo site_url('payroll/increment/delete?empcd="+id+"&saldate="+date+"');?>";

            }
            
        });

    });

</script>

<script>
   
    $(document).ready(function() {

    $('.confirm-div').hide();

    <?php if($this->session->flashdata('msg')){ ?>

    $('.confirm-div').html('<?php echo $this->session->flashdata('msg'); ?>').show();

    });

    <?php } ?>
</script>
