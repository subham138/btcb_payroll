    <div class="wraper"> 
    
        <div class="row">
            
            <div class="col-lg-9 col-sm-12">

                <h1><strong>Stop Salary</strong></h1>

            </div>

        </div>     

        <div class="col-lg-12 container contant-wraper">   

            <h3>
            
                <small><a href="<?php echo site_url("payroll/stopsalary/add");?>" class="btn btn-primary" style="width: 100px;">Add</a></small>
                <span class="confirm-div" style="float:right; color:green;"></span>

            </h3>

            <table class="table table-bordered table-hover">

                <thead>

                    <tr>
                    
                        <th>Emplyee Code</th>
                        <th>Emplyee Name</th>
                        <th>Date</th>
                        <th>Emplyee Status</th>
                        <th>Cause</th>

                    </tr>

                </thead>

                <tbody> 

                    <?php 
                    
                    if($stopsalary_dtls) {

                        
                            foreach($stopsalary_dtls as $i_dtls) {

                    ?>

                            <tr>

                                <td><?php echo $i_dtls->emp_no; ?></td>
                                <td><?php echo $i_dtls->emp_name; ?></td>
                                <td><?php echo date("d-m-Y", strtotime($i_dtls->trans_dt)); ?></td>
                                <td><?php echo ($i_dtls->status == "I")?"<p style='color: red'>Inactive</p>" : "'<p style='color: green'>Active</p>'"; ?></td>
                                <td><?php echo $i_dtls->remarks ?></td>

                            </tr>

                    <?php
                            
                            }

                        }

                        else {

                            echo "<tr><td colspan='5' style='text-align:center;'>No data Found</td></tr>";

                        }

                    ?>
                
                </tbody>

                <tfoot>

                    <tr>
                    
                        <th>Emplyee Code</th>
                        <th>Emplyee Name</th>
                        <th>Date</th>
                        <th>Emplyee Status</th>
                        <th>Cause</th>
                        
                    </tr>
                
                </tfoot>

            </table>
        
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
