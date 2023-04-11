    <div class="wraper">      

        <div class="row">
            
            <div class="col-lg-9 col-sm-12">

                <h1><strong>Attendance List</strong></h1>

            </div>

        </div>

        <div class="col-lg-12 container contant-wraper">

            <h3>

                <small><a href="<?php echo site_url("payroll/attendance/add");?>" class="btn btn-primary" style="width: 100px;">Add</a></small>
                <span class="confirm-div" style="float:right; color:green;"></span>

            </h3>

            <table class="table table-bordered table-hover">

                <thead>

                    <tr>
                    
                        <th>Sl.No.</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Month</th>
                        <th>Year</th>
                        <th>No.of Days</th>
                        <th>Options</th>

                    </tr>

                </thead>

                <tbody> 

                    <?php 
                    
                    if($attendance_dtls) {

                        
                            foreach($attendance_dtls as $d_dtls) {

                    ?>

                            <tr>

                                <td><?php echo $d_dtls->emp_cd; ?></td>
                                <td><?php echo $d_dtls->emp_name; ?></td>
                                <td><?php echo $d_dtls->emp_catg; ?></td>
                                <td><?php echo $d_dtls->sal_month; ?></td>
                                <td><?php echo $d_dtls->sal_year; ?></td>
                                <td><?php echo $d_dtls->no_of_days; ?></td>
                                <td>
                                
                                    <a href="attendance/edit?emp_cd=<?php echo $d_dtls->emp_cd; ?>&month=<?php echo $d_dtls->trans_dt; ?>" 
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
                                        id="<?php echo $d_dtls->emp_cd; ?>"
                                        date="<?php echo $d_dtls->trans_dt; ?>"
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

                            echo "<tr><td colspan='7' style='text-align: center;'>No data Found</td></tr>";

                        }
                    ?>

                </tbody>

                <tfoot>

                    <tr>
                    
                        <th>Sl.No.</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Month</th>
                        <th>Year</th>
                        <th>No.of Days</th>
                        <th>Options</th>

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

                window.location = "<?php echo site_url('payroll/attendance/delete?empcd="+id+"&saldate="+date+"');?>";

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
