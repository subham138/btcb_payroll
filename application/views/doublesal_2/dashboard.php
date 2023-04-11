    <div class="wraper">      
        
        <div class="row">
            
            <div class="col-lg-9 col-sm-12">

                <h1><strong>Employee</strong></h1>

            </div>

        </div>

        <div class="col-lg-12 container contant-wraper">    

            <h3>

                <small><a href="<?php echo site_url("payroll/doublesal/add");?>" class="btn btn-primary" style="width: 100px;">Add</a></small>
                <span class="confirm-div" style="float:right; color:green;"></span>

            </h3>

            <table class="table table-bordered table-hover">

                <thead>

                    <tr>
                    
                        <th>Sl No.</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Designation</th>
                        <th>Option</th>

                    </tr>

                </thead>

                <tbody> 

                    <?php 
                    
                    if($doublesal_dtls) {

                        
                            foreach($doublesal_dtls as $e_dtls) {

                    ?>

                            <tr>

                                <td><?php echo $e_dtls->emp_code; ?></td>
                                <td><?php echo $e_dtls->emp_name; ?></td>
                                <td><?php 
                                
                                    foreach($category_dtls as $c_list) {

                                        if($e_dtls->emp_catg == $c_list->category_code) {
                                            
                                            echo $c_list->category_type;

                                        }

                                    }
                                ?>
                                </td>
                                <td><?php echo $e_dtls->designation; ?></td>
                                
                                <td>
                                
                                    <a href="doublesal/edit?emp_code=<?php echo $e_dtls->emp_code; ?>" 
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
                                        id="<?php echo $e_dtls->emp_code; ?>"
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
                    
                        <th>Sl No.</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Designation</th>
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

                window.location = "<?php echo site_url('payroll/doublesal/delete?empcd="+id+"');?>";

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
