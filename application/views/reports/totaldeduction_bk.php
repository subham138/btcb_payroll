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
            '                                          table { border-collapse: collapse; }' +
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

    if($_SERVER['REQUEST_METHOD'] == 'GET') {

?>        
    <div class="wraper">

        <div class="col-md-6 container form-wraper"> 

            <form method="POST" 
                id="form"
                action="<?php echo site_url("reports/totaldeduction");?>" >

                <div class="form-header">
                
                    <h4>Total Deduction Report</h4>
                
                </div>

                <div class="form-group row">

                    <label for="from_date" class="col-sm-2 col-form-label">From Date:</label>

                    <div class="col-sm-10">

                        <input type="date"
                                name="from_date"
                                class="form-control required"
                                id="from_date"
                                value="<?php echo $sys_date;?>"
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="to_date" class="col-sm-2 col-form-label">To Date:</label>

                    <div class="col-sm-10">

                        <input type="date"
                                name="to_date"
                                class="form-control required"
                                id="to_date"
                                value="<?php echo $sys_date;?>"
                        />

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
    
    else if($_SERVER['REQUEST_METHOD'] == 'POST') { 
        
    //     function getIndianCurrency($number)
    //     {
    //         $decimal = round($number - ($no = floor($number)), 2) * 100;
    //         $hundred = null;
    //         $digits_length = strlen($no);
    //         $i = 0;
    //         $str = array();
    //         $words = array(0 => '', 1 => 'One', 2 => 'Two',
    //             3 => 'Three', 4 => 'Four', 5 => 'Five', 6 => 'Six',
    //             7 => 'Seven', 8 => 'Eight', 9 => 'Nine',
    //             10 => 'Ten', 11 => 'Eleven', 12 => 'Twelve',
    //             13 => 'Thirteen', 14 => 'Fourteen', 15 => 'Fifteen',
    //             16 => 'Sixteen', 17 => 'Seventeen', 18 => 'Eighteen',
    //             19 => 'Nineteen', 20 => 'Twenty', 30 => 'Thirty',
    //             40 => 'Forty', 50 => 'Fifty', 60 => 'Sixty',
    //             70 => 'Seventy', 80 => 'Eighty', 90 => 'Ninety');
    //         $digits = array('', 'Hundred','Thousand','Lakh', 'Crore');
    //         while( $i < $digits_length ) {
    //             $divider = ($i == 2) ? 10 : 100;
    //             $number = floor($no % $divider);
    //             $no = floor($no / $divider);
    //             $i += $divider == 10 ? 1 : 2;
    //             if ($number) {
    //                 $plural = (($counter = count($str)) && $number > 9) ? 's' : null;
    //                 $hundred = ($counter == 1 && $str[0]) ? ' and ' : null;
    //                 $str [] = ($number < 21) ? $words[$number].' '. $digits[$counter]. $plural.' '.$hundred:$words[floor($number / 10) * 10].' '.$words[$number % 10]. ' '.$digits[$counter].$plural.' '.$hundred;
    //             } else $str[] = null;
    //         }
    //         $Rupees = implode('', array_reverse($str));
    //         $paise = ($decimal) ? "and " . ($words[$decimal / 10] . " " . $words[$decimal % 10]) . ' Paise' : '';
    //         return ($Rupees ? $Rupees . 'Rupees ' : '') . $paise .' Only.';
    //     }    
        
        
    // ?>
    
    <div class="wraper"> 

        <div class="col-lg-12 container contant-wraper">

            <div id="divToPrint">

                <div class="item_body">

                    <div style="text-align:center;">

                        <h3>THE WEST BENGAL STATE CO.OP.MARKETING FEDERATION LTD.</h3>

                        <h3>HEAD OFFICE: SOUTHEND CONCLAVE, 3RD FLOOR, 1582 RAJDANGA MAIN ROAD, KOLKATA-700107.</h3>

                        <h3>Total deduction of Regular employees From <?php echo date('d/m/Y',strtotime($this->input->post('from_date'))).' To '.date('d/m/Y',strtotime($this->input->post('to_date')));?> 
                        <!-- <h4>Pay Slip for <?php echo date($this->input->post('sal_month'),"d/m/Y").'-'.$this->input->post('year');?></h4> -->
                      
                        <!-- <?php echo $year->param_value;?> -->
                        </h3>

                    </div>

                </div>

                <br>

                <div class="report_result">

                    <table class="table table-bordered table-hover">

                        <thead>

                            <tr>
                            
                                <th>Sl No.</th>

                                <th>Name of Emplyees</th>

                                <th>Insuarance</th>

                                <th>CCS</th>

                                <th>HBL</th>

                                <th>Telephone</th>

                                <th>Medical Advance</th>

                               <th>Festival Advance</th>

                               <th>TF</th>

                               <th>Medical Insuarance</th>

                               <th>Comp Loan</th>

                                <th>P-Tax</th>

                                <th>I-Tax</th>

                                <th>GPF</th>

                                <th>EPF</th>

                                <th>Other Deduction</th>

                            </tr>

                        </thead>

                        <tbody> 

                            <?php 
                                
                            if($total_deduct) {

                                $i  =   1;

$tot_ins = $tot_css= $tot_hbl = $tot_tel =$tot_med_adv =$tot_fa =$tot_tf = $tot_med_ins = $tot_comp_loan = $tot_ptax = $tot_itax = $tot_gpf = $tot_epf = $tot_other_deduction = 0;
                                    
                                foreach($total_deduct as $td_list) {

                                    $tot_ins += $td_list->insuarance;
                                    $tot_css+= $td_list->ccs;
                                    $tot_hbl += $td_list->hbl;
                                    $tot_tel += $td_list->telephone;
                                    $tot_med_adv += $td_list->med_adv;
                                    $tot_fa += $td_list->festival_adv;
                                    $tot_tf += $td_list->tf;
                                    $tot_med_ins += $td_list->med_ins;
                                    $tot_comp_loan += $td_list->comp_loan;
                                    $tot_ptax += $td_list->ptax;
                                    $tot_itax += $td_list->itax;
                                    $tot_gpf += $td_list->gpf;
                                    $tot_epf += $td_list->epf;
                                    $tot_other_deduction += $td_list->other_deduction;
                                ?>

                                    <tr>

                                        <td><?php echo $i++; ?></td>

                                        <td><?php echo $td_list->emp_name; ?></td>
                                        <td><?php echo $td_list->insuarance; ?></td>
                                        <td><?php echo $td_list->ccs; ?></td>
                                        <td><?php echo $td_list->hbl; ?></td> 
                                        <td><?php echo $td_list->telephone; ?></td>
                                        <td><?php echo $td_list->med_adv; ?></td>
                                        <td><?php echo $td_list->festival_adv; ?></td>
                                        <td><?php echo $td_list->tf; ?></td>
                                        <td><?php echo $td_list->med_ins; ?></td>
                                        <td><?php echo $td_list->comp_loan; ?></td>
                                        <td><?php echo $td_list->ptax; ?></td>
                                        <td><?php echo $td_list->itax; ?></td>
                                        <td><?php echo $td_list->gpf; ?></td>
                                        <td><?php echo $td_list->epf; ?></td>
                                        <td><?php echo $td_list->other_deduction; ?></td>
                                    </tr>

                            <?php
                                        
                                    }

                            ?>


                                    <tr>

                                        <td colspan="2">Total Amount</td>

                                        <td> Rs. <?php echo $tot_ins; ?></td>

                                        <td> Rs. <?php echo $tot_css; ?></td>

                                        <td> Rs. <?php echo $tot_hbl; ?></td>

                                        <td> Rs. <?php echo $tot_tel; ?></td>

                                        <td> Rs. <?php echo $tot_med_adv; ?></td>

                                        <td> Rs. <?php echo $tot_fa; ?></td>

                                        <td> Rs. <?php echo $tot_tf; ?></td>

                                        <td> Rs. <?php echo $tot_med_ins; ?></td>

                                        <td> Rs. <?php echo $tot_comp_loan; ?></td>

                                        <!-- <td> Rs. <?php echo $tot_comp_loan; ?></td> -->

                                        <!-- <td> Rs. <?php echo $tot_pf; ?></td> -->
                                        
                                        <td> Rs. <?php echo $tot_ptax; ?></td>

                                        <td> Rs. <?php echo $tot_itax; ?></td>

                                        <td> Rs. <?php echo $tot_gpf; ?></td>

                                        <td> Rs. <?php echo $tot_epf; ?></td>

                                        <td> Rs. <?php echo $tot_other_deduction; ?></td>

                                        

                                    </tr>

                            <?php        
                                    
                                }

                                else {

                                    echo "<tr><td colspan='9' style='text-align:center;'>No Data Found</td></tr>";
                                }
                            ?>
                        
                        </tbody>

                    </table>

                    <br>

                    <div  class="bottom">
                        
                        <p style="display: inline;">Prepared By</p>

                        <p style="display: inline; margin-left: 8%;">Establishment, Sr. Asstt.</p>

                        <p style="display: inline; margin-left: 8%;">Assistant Manager-II</p>

                        <p style="display: inline; margin-left: 8%;">Chief Executive officer</p>

                    </div>

                </div>

            </div>   

            <div style="text-align: center;">

                <button class="btn btn-info" type="button" onclick="printDiv();">Print</button>

            </div>
                        
        </div>

    </div>    
        
    <?php

    }

    ?>
