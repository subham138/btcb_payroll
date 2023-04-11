<style>
    table {
        border-collapse: collapse;
    }

    .table{
        width: 236%;
        max-width: 250%;
        margin-bottom: 20px;
    }

    table, td, th {
        border: 1px solid #dddddd;

        padding: 6px;

        font-size: 14px;
    }

    th {

        text-align: center;

    }

    tr:hover {background-color: #f5f5f5;}

</style>

<script>
  function printDiv() {

        var divToPrint = document.getElementById('divToPrint');

        var WindowObject = window.open('', 'Print-Window');
        WindowObject.document.open();
        WindowObject.document.writeln('<!DOCTYPE html>');
        WindowObject.document.writeln('<html><head><title></title><style type="text/css">');


        WindowObject.document.writeln('@media print { .center { text-align: center;}' +
            '                                         .inline { display: inline; }' +
            '                                         .underline { text-decoration: underline; }' +
            '                                         .left { margin-left: 315px;} ' +
            '                                         .right { margin-right: 375px; display: inline; }' +
            '                                          .table{ width: 236%; max-width: 250%; margin-bottom: 20px; } table { border-collapse: collapse; font-size: 14px;}' +
            '                                          th, td { border: 1px solid black; border-collapse: collapse; padding: 10px;}' +
            '                                           th, td { }' +
            '                                         .border { border: 1px solid black; } ' +
            '                                         .bottom { bottom: 5px; width: 100%; position: fixed ' +
            '                                       ' +
            '                                   } } </style>');
        WindowObject.document.writeln('</head><body onload="window.print()">');
        WindowObject.document.writeln(divToPrint.innerHTML);
        WindowObject.document.writeln('</body></html>');
        WindowObject.document.close();
        setTimeout(function () {
            WindowObject.close();
        }, 10);

  }
</script>
  
    

  <?php

    if($_SERVER['REQUEST_METHOD'] == "POST") {

       
         $bp = $gp =  $gross = $pf =$ptax = $tot_deduct = $net =$tf=$gpf=$epf=$comploan=
        
         $basic = $da  =  $ir = $hra = $ma = $oa = $ccs = $ins = $tf=$hbl=$tel=$med_adv=$med_ins=

        $oth_ded= $comp_loan= $fa = $lic  =  $itx = $pa = 0;        
        
  ?>

    <div class="wraper">      

        <div class="col-lg-12 container contant-wraper">

            <div id="divToPrint">

                <div class="item_body">

                    <div style="text-align:center;">

                        <h3>THE WEST BENGAL STATE CO.OP.MARKETING FEDERATION LTD.</h3>

                        <h3>HEAD OFFICE: SOUTHEND CONCLAVE, 3RD FLOOR, 1582 RAJDANGA MAIN ROAD, KOLKATA-700107.</h3>

                        <h3>SALARY FOR THE <?php if ($this->input->post('category') == 1) {
                            
                            echo "Govt.Regular Employee";
                        
                        }
                        
                        else if ($this->input->post('category') == 2){

                            echo "BENFED RAGULAR ";

                        } 
                        
                        else if ($this->input->post('category') == 3) {
                            
                            echo "Contractual Employee ";
                        }
                            else if ($this->input->post('category') == 4) {
                            
                                echo "Daily Wages Employee ";
                        
                        }?> EMPLOYEES FOR THE MONTH OF <?php echo $this->input->post('sal_month').' '.$this->input->post('year') ; ?></h3>
                        <!--<h3>Allowing Periodical Increment 3%</h3>-->

                    </div>

                </div>
        
                <br>

                <table class="table table-bordered table-hover" style="width: 100%;">

                    <thead>

                        <?php 

                            if($this->input->post('category') == 0 ) {
                            
                        ?>
                          

                        </thead>

                        <tbody> 

                            <?php 
                            
                            if($list ) {
                                

                             ?>
                         

                            <?php
                                
                            }

                         
                        }

                 else {

                    ?>
                        
                        <tr>
                            
                            <th width="15px">Sl No.</th>
                            <th width="200px">Emplyee Name</th>
                            <th width="15px">Desig</th>
                            <th width="15px">Basic Pay</th>
                            <th width="15px">D.A.</th>
                            <th width="15px">H.R.A.</th>
                            <th width="15px">Medical allow.</th>
                            <th width="15px">Other Allow</th>
                            <th width="15px">insuarance</th>
                            <th width="15px">CCS</th>
                            <th width="15px">HBL</th>
                            <th width="15px">Telephone</th>
                            <th width="15px">Med Advance</th>
                            <th width="15px">Festival Adv.</th>
                            <th width="15px">TF.</th>
                            <th width="15px">Med Ins.</th>
                            <th width="15px">P-tax</th>
                            <th width="15px">Comp Loan</th>
                            <th width="15px">I-Tax</th>
                            <th width="15px">EPF.</th>
                            <th width="15px">GPF.</th>
                            <th width="15px">Other Deduction</th>
                            <th width="15px">Total Deduction</th>
                            <th width="15px">Net Amount</th>
                            <th width="15px">Remarks</th>
                       
                        </tr>

                    </thead>

                    <tbody> 

                        <?php 

                            if($list) {

                                $temp_var = 0;
                                $tempCount = 0;
                                $i = 1;
                            foreach($list as $s_list) {

                                $basic       +=  $s_list->basic_pay;
                                $da          +=  $s_list->da_amt;
                                $hra         +=  $s_list->hra_amt;
                                $ma          +=  $s_list->med_allow;
                                $oa          +=  $s_list->othr_allow;
                                $ins         +=  $s_list->insuarance;
                                $ccs         +=  $s_list->ccs;
                                $hbl         +=  $s_list->hbl;
                                $tel         +=  $s_list->telephone;
                                $med_adv     +=  $s_list->med_adv;
                                $fa          +=  $s_list->festival_adv;
                                $tf          +=  $s_list->tf;
                                $med_ins     +=  $s_list->med_ins;
                                $ptax        +=  $s_list->ptax;
                                $comploan    +=  $s_list->comp_loan;
                                $itx         +=  $s_list->itax;
                                $epf         +=  $s_list->epf;
                                $gpf         +=  $s_list->gpf;
                                $oth_ded     +=  $s_list->other_deduction;
                                $tot_deduct  +=  $s_list->tot_deduction;
                                $net         +=  $s_list->net_amount;

                        ?>        

                        <tr <?php echo ($tempCount == 20)? 'class="breakAfter"':'';  ?>>

                            <?php foreach($count as $row){

                                    if(($row->emp_code == $s_list->emp_code) && ($row->emp_code != $temp_var)){

                                        echo '<td >'.$i++.'</td>';

                                        echo '<td >'.$s_list->emp_name.'</td>';

                                         $temp_var = $row->emp_code;
                                        
                                    }

                                }
                                
                            ?>  
                            
                            <td><?php echo $s_list->designation; ?></td>
                            <td><?php echo $s_list->basic_pay; ?></td>
                            <td><?php echo $s_list->da_amt; ?></td>
                            <td><?php echo $s_list->hra_amt; ?></td>
                            <td><?php echo $s_list->med_allow; ?></td>
                            <td><?php echo $s_list->othr_allow; ?></td>
                            <td><?php echo $s_list->insuarance; ?></td>
                            <td><?php echo $s_list->ccs; ?></td>
                            <td><?php echo $s_list->hbl; ?></td>
                            <td><?php echo $s_list->telephone; ?></td>
                            <td><?php echo $s_list->med_adv; ?></td>
                            <td><?php echo $s_list->festival_adv; ?></td>
                            <td><?php echo $s_list->tf; ?></td>
                            <td><?php echo $s_list->med_ins; ?></td>
                            <td><?php echo $s_list->ptax; ?></td>
                            <td><?php echo $s_list->comp_loan; ?></td> 
                            <td><?php echo $s_list->itax; ?></td>
                            <td><?php echo $s_list->epf; ?></td>
                            <td><?php echo $s_list->gpf; ?></td>
                            <td><?php echo $s_list->other_deduction; ?></td>
                            <td><?php echo $s_list->tot_deduction; ?></td>
                            <td><?php echo $s_list->net_amount; ?></td>
                            <td><?php echo $s_list->remarks; ?></td>
                           
                        </tr>
                    <?php
                                $tempCount++;
                            }

                            ?>
                                <tr>
                                    
                                    <td colspan="3">Total</td>
                                    <td><?php echo $basic; ?></td>
                                    <td><?php echo $da; ?></td>
                                    <td><?php echo $hra; ?></td>
                                    <td><?php echo $ma; ?></td>
                                    <td><?php echo $oa; ?></td>
                                    <td><?php echo $ins; ?></td>
                                    <td><?php echo $ccs; ?></td>
                                    <td><?php echo $hbl; ?></td>
                                    <td><?php echo $tel; ?></td>
                                    <td><?php echo $med_adv; ?></td>
                                    <td><?php echo $fa; ?></td>
                                    <td><?php echo $tf; ?></td>
                                    <td><?php echo $med_ins; ?></td>
                                    <td><?php echo $ptax; ?></td>
                                    <td><?php echo $comploan; ?></td>
                                    <td><?php echo $itx; ?></td>
                                    <td><?php echo $epf; ?></td>
                                    <td><?php echo $gpf; ?></td>
                                    <td><?php echo $oth_ded; ?></td>
                                    <td><?php echo $tot_deduct; ?></td>
                                    <td><?php echo $net; ?></td>
                                    <td></td>
                                 
                                    
                                </tr>

                            <?php    

                            
                            }
                            else {

                                echo "<tr><td colspan='22' style='text-align:center;'>No data Found</td></tr>";

                            }
                        }

                        
                    ?>
                    
                    </tbody>

                </table>
                
                <br>
                <!-- <p> May be passed for payment Rs. 
                <?php if ($this->input->post('category') == 1){

                    echo getIndianCurrency($gross);

                }
                else if ($this->input->post('category') == 2){

                    echo getIndianCurrency($pa);

                }

                else {

                    echo getIndianCurrency($pa);

                }
                ?>
                </p> -->

                <div  class="bottom">
                
                    <p style="display: inline;">Prepared By</p>

                    <p style="display: inline; margin-left: 8%;">Establishment, Sr. Asstt.</p>

                    <p style="display: inline; margin-left: 8%;">Assistant Manager-II</p>

                    <p style="display: inline; margin-left: 8%;">ARCS Attached to CONFED-WB</p>

                    <p style="display: inline; margin-left: 8%;">Chief Executive Officer</p>

                </div>

            </div>

            <div style="text-align: center;">

                <button class="btn btn-info" type="button" onclick="printDiv();">Print</button>

            </div>

        </div>           

    </div>

  <?php

    }

    else {

  ?>

    <div class="wraper">      

        <div class="col-md-6 container form-wraper">

            <form method="POST" 
            id="form"
            action="<?php echo site_url("reports/salarycatgreport");?>" >

                <div class="form-header">
                
                    <h4>Category wise Salary Report</h4>
                
                </div>

                <div class="form-group row">

                    <label for="trans_dt" class="col-sm-2 col-form-label">Transaction Date:</label>

                    <div class="col-sm-10">

                        <input type="date"
                                name="trans_dt"
                                class="form-control"
                                id="trans_dt"
                                value="<?php echo $sys_date;?>"
                                readonly
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="sal_month" class="control-lebel col-sm-2 col-form-label">Select Month:</label>

                        <div class="col-sm-10">

                            <select
                                class="form-control required"
                                name="sal_month"
                                id="sal_month"
                                >

                                <option value="">Select Month</option>

                                <?php foreach($month_list as $m_list) {?>

                                    <option value="<?php echo $m_list->id ?>" ><?php echo $m_list->month_name; ?></option>

                                <?php
                                }
                                ?>

                            </select>   

                        </div>

                </div>

                <div class="form-group row">

                    <label for="year" class="col-sm-2 col-form-label">Input Year:</label>

                    <div class="col-sm-10">

                        <input type="text"
                            class="form-control"
                            name="year"
                            id="year"
                            value="<?php echo date('Y');?>"
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="category" class="col-sm-2 col-form-label">Category:</label>

                    <div class="col-sm-10">

                        <select
                            class="form-control required"
                            name="category"
                            id="category"
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

                        <input type="submit" class="btn btn-info" value="Proceed" />

                    </div>

                </div>

            </form>    

        </div>

    </div>    

  <?php

    }

  ?>

<script>

    $("#form").validate();

</script>