<div class="wraper">      
        
    <div class="row">
        
        <div class="col-lg-9 col-sm-12">

            <h1><strong>Unapproved Generation List</strong></h1>

        </div>

    </div>

    <div class="col-lg-12 container contant-wraper">    

        <h3>
                <a href="<?php echo site_url("addgen");?>" class="btn btn-primary" style="width: 100px;">Add</a>
                <span class="confirm-div" style="float:right; color:green;"></span>
        </h3>

        <table class="table table-bordered table-hover">

            <thead>

                <tr>
                    <th>Date</th>
                    <th>Category</th>
                    <th>Year</th>
                    <th>Month</th>
                    <th>Created By</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>

            </thead>

            <tbody> 

                <?php 
                
                if($generation_dtls) {

                    foreach($generation_dtls as $d_dtls) {

                        foreach($category as $c_list) {

                            if($d_dtls->catg_cd == $c_list->category_code) {


                ?>

                        <tr>
                            <td><?php echo date('d-m-Y', strtotime($d_dtls->trans_date)); ?></td>
                            <td><?php echo $c_list->category_type; ?></td>
                            <td><?php echo $d_dtls->sal_year; ?></td>
                            <td><?php echo date("F", mktime(0, 0, 0, $d_dtls->sal_month, 10)); ?></td>
                            <td><?php echo $d_dtls->created_by; ?></td>
                            <td>
                            
                                <a href="generation/edit?trans_no=<?php echo $d_dtls->trans_no; ?>&month=<?php echo $d_dtls->sal_month; ?>&year=<?php echo $d_dtls->sal_year; ?>" 
                                    data-toggle="tooltip"
                                    data-placement="bottom" 
                                    title="Edit"
                                >

                                    <i class="fa fa-edit fa-2x" style="color: #007bff"></i>
                                    
                                </a>

                            </td>

                            <td>
                                <button 
                                    type="button"
                                    class="delete"
                                    date="<?php echo $d_dtls->trans_date; ?>"
                                    id="<?php echo $d_dtls->trans_no; ?>"
                                    month="<?php echo $d_dtls->sal_month; ?>"
                                    year="<?php echo $d_dtls->sal_year; ?>"
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

                    } 

                    }

                    else {

                        echo "<tr><td colspan='10' style='text-align: center;'>No data Found</td></tr>";

                    }
                ?>
            
            </tbody>

            <tfoot>

                <tr>
                
                    <th>Date</th>
                    <th>Category</th>
                    <th>Year</th>
                    <th>Month</th>
                    <th>Created By</th>
                    <th>Edit</th>
                    <th>Delete</th>

                </tr>
            
            </tfoot>

        </table>
        
    </div>

</div>

<script>

    $(document).ready( function (){

        $('.delete').click(function () {

            var date  = $(this).attr('date'),
                id    = $(this).attr('id'),
                month = $(this).attr('month'),
                year  = $(this).attr('year');

            var result = confirm("Do you really want to delete this record?");

            if(result) {

                window.location = "<?php echo site_url('unapslipdel?date="+date+"&trans_no="+id+"&month="+month+"&year="+year+"');?>";
                // window.location = "<?php echo site_url('dstf?empcd="+id+"');?>";

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