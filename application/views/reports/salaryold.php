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

        function getIndianCurrency($number)
        {
            $decimal = round($number - ($no = floor($number)), 2) * 100;
            $hundred = null;
            $digits_length = strlen($no);
            $i = 0;
            $str = array();
            $words = array(0 => '', 1 => 'One', 2 => 'Two',
                3 => 'Three', 4 => 'Four', 5 => 'Five', 6 => 'Six',
                7 => 'Seven', 8 => 'Eight', 9 => 'Nine',
                10 => 'Ten', 11 => 'Eleven', 12 => 'Twelve',
                13 => 'Thirteen', 14 => 'Fourteen', 15 => 'Fifteen',
                16 => 'Sixteen', 17 => 'Seventeen', 18 => 'Eighteen',
                19 => 'Nineteen', 20 => 'Twenty', 30 => 'Thirty',
                40 => 'Forty', 50 => 'Fifty', 60 => 'Sixty',
                70 => 'Seventy', 80 => 'Eighty', 90 => 'Ninety');
            $digits = array('', 'Hundred','Thousand','Lakh', 'Crore');
            while( $i < $digits_length ) {
                $divider = ($i == 2) ? 10 : 100;
                $number = floor($no % $divider);
                $no = floor($no / $divider);
                $i += $divider == 10 ? 1 : 2;
                if ($number) {
                    $plural = (($counter = count($str)) && $number > 9) ? 's' : null;
                    $hundred = ($counter == 1 && $str[0]) ? ' and ' : null;
                    $str [] = ($number < 21) ? $words[$number].' '. $digits[$counter]. $plural.' '.$hundred:$words[floor($number / 10) * 10].' '.$words[$number % 10]. ' '.$digits[$counter].$plural.' '.$hundred;
                } else $str[] = null;
            }
            $Rupees = implode('', array_reverse($str));
            $paise = ($decimal) ? "and " . ($words[$decimal / 10] . " " . $words[$decimal % 10]) . ' Paise' : '';
            return ($Rupees ? $Rupees . 'Rupees ' : '') . $paise .' Only.';
        }   
        
        $bp = $gp  =  $gross = $pf = $ptax = $tot_deduct = $net =
        
        $basic = $da  =  $ir = $hra = $ma = $ca = $ga = $gi =

        $fa = $lic  =  $itx = $pa = 0;        
        
  ?>

    <div class="wraper">      

        <div class="col-lg-12 container contant-wraper">

            <div id="divToPrint">

                <div class="item_body">

                    <div style="text-align:center;">

                        <h3>WEST BENGAL STATE CONSUMERS' CO-OPERATIVE FEDERATION LTD.</h3>

                        <h3>P-1, Hide Lane, Akbar Mansion, 3rd Floor, Kolkata-700073</h3>

                        <h3> SALARY FOR THE <?php if ($this->input->post('category') == 1) {
                            
                            echo "REGULAR ";
                        
                        }
                        
                        else if ($this->input->post('category') == 2){

                            echo "CONTRACTUAL Basis ";

                        } 
                        
                        else if ($this->input->post('category') == 3) {
                            
                            echo "DAILY WAGES ";
                        
                        }?> EMPLOYEES FOR THE MONTH OF <?php echo $this->input->post('sal_month').' '.$this->input->post('year') ; ?></h3>
                        <!--<h3>Allowing Periodical Increment 3%</h3>-->

                    </div>

                </div>
        
                <br>

                <table class="table table-bordered table-hover" style="width: 100%;">

                    <thead>

                        <?php 

                            if($this->input->post('category') == 2 || $this->input->post('category') == 3) {
                            
                        ?>
                            <tr>
                            
                                <th>Emplyee<br>Code</th>
                                <th>Emplyee Name</th>
                                <th>Day</th>
                                <th>Designation</th>
                                <?php echo ($this->input->post('category') == 3)?"<th></th>":"";?>
                                <th>Pay</th>
                                <th>Gross</th>
                                <th>Employee<br>12% P.F</th>
                                <th>P-tax</th>
                                <th>Total Deduction</th>
                                <th>Net Amount</th>
                                <th>Signature</th>

                            </tr>

                        </thead>

                        <tbody> 

                            <?php 
                            
                            if($list && $this->input->post('category') == 3) {
                                
                                    foreach($list as $s_list) {

                                        foreach($attendance_dtls as $a_dtls) {

                                            if($s_list->emp_no  ==  $a_dtls->emp_cd) {

                                                $pa += $s_list->band_pay * $a_dtls->no_of_days;

                                                $pf += $s_list->pf;

                                                $ptax += $s_list->ptax;

                                                $tot_deduct += $s_list->tot_deduction;

                                                $net += $s_list->net_amount;

                            ?>

                                    <tr>

                                        <td><?php echo $s_list->emp_no; ?></td>
                                        <td><?php echo $s_list->emp_name; ?></td>
                                        <td><?php echo $a_dtls->no_of_days; ?></td>
                                        <td><?php echo $s_list->designation; ?></td>
                                        <td><?php echo $s_list->band_pay." X ".$a_dtls->no_of_days; ?></td>

                                        <td><?php echo $s_list->band_pay * $a_dtls->no_of_days; ?></td>
                                        <td><?php echo $s_list->band_pay * $a_dtls->no_of_days; ?></td>
                                        <td><?php echo $s_list->pf; ?></td>
                                        <td><?php echo $s_list->ptax; ?></td>
                                        <td><?php echo $s_list->tot_deduction; ?></td>
                                        <td><?php echo $s_list->net_amount; ?></td>
                                        <td></td>

                                    </tr>

                            <?php
                                    
                                        }

                                    }
                                } ?>

                                    <tr>
                                    
                                        <td colspan="5">Total</td>

                                        <td><?php echo $pa; ?></td>

                                        <td><?php echo $pa; ?></td>

                                        <td><?php echo $pf; ?></td>

                                        <td><?php echo $ptax; ?></td>

                                        <td><?php echo $tot_deduct; ?></td>

                                        <td><?php echo $net; ?></td>

                                        <td></td>
                                        
                                    </tr>

                            <?php
                                
                            }

                            else if($list && $this->input->post('category') == 2) {

                                foreach($list as $s_list) {

                                    $pa += $s_list->band_pay;

                                    $pf += $s_list->pf;

                                    $ptax += $s_list->ptax;

                                    $tot_deduct += $s_list->tot_deduction;

                                    $net += $s_list->net_amount;

                            ?>

                                <tr>

                                    <td><?php echo $s_list->emp_no; ?></td>
                                    <td><?php echo $s_list->emp_name; ?></td>
                                    <td></td>
                                    <td><?php echo $s_list->designation; ?></td>
                                    <td><?php echo $s_list->band_pay; ?></td>
                                    <td><?php echo $s_list->band_pay; ?></td>
                                    <td><?php echo $s_list->pf; ?></td>
                                    <td><?php echo $s_list->ptax; ?></td>
                                    <td><?php echo $s_list->tot_deduction; ?></td>
                                    <td><?php echo $s_list->net_amount; ?></td>
                                    <td></td>

                                </tr>


                            <?php
                                }

                            ?>

                                <tr>
                                    
                                    <td colspan="4">Total</td>

                                    <td><?php echo $pa; ?></td>

                                    <td><?php echo $pa; ?></td>

                                    <td><?php echo $pf; ?></td>

                                    <td><?php echo $ptax; ?></td>

                                    <td><?php echo $tot_deduct; ?></td>

                                    <td><?php echo $net; ?></td>

                                    <td></td>
                                    
                                </tr>

                            <?php    

                            }

                            else {

                                echo "<tr><td colspan='12' style='text-align:center;'>No data Found</td></tr>";

                            }
                        }

                        else {

                    ?>
                        
                        <tr>
                            
                            <th width="15px">Sl<br>No.</th>
                            <th width="200px">Emplyee Name</th>
                            <th width="15px">Desig</th>
                            <th width="15px">Band Pay</th>
                            <th width="15px">Grade Pay</th>
                            <th width="15px">Basic Pay</th>
                            <th width="15px">125 %<br>D.A.</th>
                            <th width="15px">I.R.</th>
                            <th width="15px">15 %<br>H.R.A.</th>
                            <th width="15px">M.A.</th>
                            <th width="15px">Cash Allow</th>
                            <th width="15px">Gross</th>

                            <th width="15px">General Adv.</th>
                            <th width="15px">Intt.</th>
                            <th width="15px">Festival Adv.</th>
                            <th width="15px">SSS of<br>L.I.C</th>

                            <th width="15px">Employee<br>12% P.F</th>
                            <th width="15px">P-tax</th>
                            <th width="15px">I-Tax</th>
                            <th width="15px">Total Deduction</th>
                            <th width="15px">Net Amount</th>
                            <th>Remarks</th>

                        </tr>

                    </thead>

                    <tbody> 

                        <?php 

                            if($list) {

                                $temp_var = 0;
                                $tempCount = 0;
                                $i = 1;
                            foreach($list as $s_list) {

                                $bp += $s_list->band_pay;
                                
                                $gp += $s_list->grade_pay;

                                $basic += $s_list->basic_pay;

                                $da +=  $s_list->da;

                                $ir +=  $s_list->ir;

                                $hra += $s_list->hra;

                                $ma += $s_list->ma;

                                $ca += $s_list->cash_allow;

                                $gross += $s_list->gross;

                                $ga +=  $s_list->gen_adv;

                                $gi +=  $s_list->gen_intt;

                                $fa +=  $s_list->festival_adv;

                                $lic +=  $s_list->lic;

                                $pf += $s_list->pf;

                                $ptax += $s_list->ptax;

                                $itx += $s_list->itax;

                                $tot_deduct += $s_list->tot_deduction;

                                $net += $s_list->net_amount;

                        ?>        

                        <tr <?php echo ($tempCount == 10)? 'class="breakAfter"':'';  ?>>

                            <?php foreach($count as $row){

                                    if(($row->emp_no == $s_list->emp_no) && ($row->emp_no != $temp_var)){

                                        echo '<td rowspan="'.$row->count.'">'.$i++.'</td>';

                                        echo '<td rowspan="'.$row->count.'">'.$s_list->emp_name.'</td>';

                                        $temp_var = $row->emp_no;
                                        
                                    }

                                }
                                
                            ?>  
                            <td><?php echo $s_list->designation; ?></td>
                            <td><?php echo $s_list->band_pay; ?></td>
                            <td><?php echo $s_list->grade_pay; ?></td>

                            <td><?php echo $s_list->basic_pay; ?></td>
                            <td><?php echo $s_list->da; ?></td>
                            <td><?php echo $s_list->ir; ?></td>
                            <td><?php echo $s_list->hra; ?></td>
                            <td><?php echo $s_list->ma; ?></td>
                            <td><?php echo $s_list->cash_allow; ?></td>
                            <td><?php echo $s_list->gross; ?></td>

                            <td><?php echo $s_list->gen_adv; ?></td>
                            <td><?php echo $s_list->gen_intt; ?></td>
                            <td><?php echo $s_list->festival_adv; ?></td>
                            <td><?php echo $s_list->lic; ?></td>
                            <td><?php echo $s_list->pf; ?></td>
                            <td><?php echo $s_list->ptax; ?></td>
                            <td><?php echo $s_list->itax; ?></td>

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

                                    <td><?php echo $bp; ?></td>

                                    <td><?php echo $gp; ?></td>

                                    <td><?php echo $basic; ?></td>

                                    <td><?php echo $da; ?></td>

                                    <td><?php echo $ir; ?></td>

                                    <td><?php echo $hra; ?></td>

                                    <td><?php echo $ma; ?></td>

                                    <td><?php echo $ca; ?></td>

                                    <td><?php echo $gross; ?></td>

                                    <td><?php echo $ga; ?></td>

                                    <td><?php echo $gi; ?></td>

                                    <td><?php echo $fa; ?></td>

                                    <td><?php echo $lic; ?></td>

                                    <td><?php echo $pf; ?></td>
                                    
                                    <td><?php echo $ptax; ?></td>

                                    <td><?php echo $itx; ?></td>

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
                <p> May be passed for payment Rs. 
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
                </p>

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
            action="<?php echo site_url("payroll/salaryold/report");?>" >

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

                                    <option value="<?php echo $m_list->month_name ?>" ><?php echo $m_list->month_name; ?></option>

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