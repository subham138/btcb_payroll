      <div class="main-panel">
        <div class="content-wrapper">
          <div class="card">
            <div class="card-body">
            <div class="row" style="margin-bottom:10px">
                <div class="col-10"> <h3>Deductions</h3></div>
                <div class="col-2"> <a href="<?php echo site_url("slrydedad");?>" class="btn btn-primary" style="width: 100px;">Add</a></div>
                <span class="confirm-div" style="float:right; color:green;"></span>
            </div>    
              <div class="row">
                <div class="col-12">
                  <div class="table-responsive">
                    <table id="order-listing" class="table">
                      <thead>
                      <tr>
                    <th>Sl No.</th>
                    <!-- <th>Date </th> -->
                    <!-- <th>Year</th>
                    <th>Month</th> -->
                    <th>Employee code</th>
                    <th>Name</th>
                    <th>District</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                      </thead>
                      <tbody> 

                <?php 
                
                if($deduction_dtls) {

                        $i = 1;
                        foreach($deduction_dtls as $d_dtls) {
                ?>
                        <tr>
                            <td><?php echo $i++; ?></td>
                            <!-- <td><?php //echo date("d-m-Y", strtotime($d_dtls->created_dt)); ?></td> -->
                            <!-- <td><?php //echo $d_dtls->ded_yr; ?></td>
                            <td><?php //echo date("F", mktime(0, 0, 0, $d_dtls->ded_month, 10)); ?></td> -->
                            <td><?php echo $d_dtls->emp_code; ?></td>
                            <td><?php echo $d_dtls->emp_name; ?></td>
                            <td><?php echo $d_dtls->district_name; ?></td>
                            <td>
                            
                                <a href="slrydeded?emp_cd=<?php echo $d_dtls->emp_cd; ?>" 
                                    data-toggle="tooltip"
                                    data-placement="bottom" 
                                    title="Edit"
                                >

                                    <i class="fa fa-edit fa-2x" style="color: #007bff"></i>
                                    
                                </a>
                            </td>

                            <td>    
                                <span 
                                    type="button"
                                    class="delete"
                                    id="<?php echo $d_dtls->emp_cd; ?>"
                                    data-toggle="tooltip"
                                    data-placement="bottom" 
                                    title="Delete">
                                    <i class="fa fa-trash-o fa-2x" style="color: #bd2130"></i>
                                </span>
                                
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
        </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <script>

$(document).ready( function (){

    $('.delete').click(function () {

        var id = $(this).attr('id'),
            date = $(this).attr('date');

        var result = confirm("Do you really want to delete this record?");

        if(result) {

            window.location = "<?php echo site_url('deddl?empcd="+id+"');?>";

        }
        
    });

});

</script>

<script>

$(document).ready(function() {

$('.confirm-div').hide();

<?php if($this->session->flashdata('msg')){ ?>

$('.confirm-div').html('<?php echo $this->session->flashdata('msg'); ?>').show();
<?php } ?>

});



</script>