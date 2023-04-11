    <div class="wraper">      
        
        <div class="row">
            
            <div class="col-lg-9 col-sm-12">

                <h1><strong>Employees Incentive</strong></h1>

            </div>

        </div>

        <div class="col-lg-12 container contant-wraper">    

            <h3>

                <small><a href="<?php echo site_url("payroll/incentive/add");?>" class="btn btn-primary" style="width: 100px;">Add</a></small>
                <span class="confirm-div" style="float:right; color:green;"></span>

            </h3>

            <table class="table table-bordered table-hover">

                <thead>

                    <tr>
                    
                        <th>Emplyee Code</th>
                        <th>Emplyee Name</th>
                        <th>Incentive Date</th>
                        <th>Amount</th>
                        <th>Option</th>

                    </tr>

                </thead>

                <tbody> 

                    <?php 
                    
                    if($incentive_dtls) {

                        
                            foreach($incentive_dtls as $i_dtls) {

                    ?>

                            <tr>

                                <td><?php echo $i_dtls->emp_no; ?></td>
                                <td><?php echo $i_dtls->emp_name; ?></td>
                                <td><?php echo date("d-m-Y", strtotime($i_dtls->trans_dt)); ?></td>
                                <td style="text-align:right;"><?php echo $i_dtls->amount; ?></td>
                                
                                <td>
                                
                                    <a href="incentive/edit?emp_no=<?php echo $i_dtls->emp_no; ?>&month=<?php echo $i_dtls->trans_dt; ?>" 
                                        data-toggle="tooltip"
                                        data-placement="bottom" 
                                        title="Edit"
                                    >

                                        <i class="fa fa-edit fa-2x" style="color: #007bff"></i>
                                        
                                    </a>

                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                    <button 
                                        type="button"
                                        class="delete"
                                        id="<?php echo $i_dtls->emp_no; ?>"
                                        date="<?php echo $i_dtls->trans_dt; ?>"
                                        data-toggle="tooltip"
                                        data-placement="bottom" 
                                        title="Delete"
                                        
                                    >

                                        <i class="fa fa-trash-o fa-2x" style="color: #bd2130"></i>

                                    </button>
                                    
                                </td>

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
                        <th>Incentive Date</th>
                        <th>Amount</th>
                        <th>Option</th>

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

                window.location = "<?php echo site_url('payroll/incentive/delete?empcd="+id+"&saldate="+date+"');?>";

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
