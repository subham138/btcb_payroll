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
                action="<?php echo site_url("payroll/pfcontribution/report");?>" >

                <div class="form-header">
                
                    <h4>PF Contribution Report</h4>
                
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

                    <label for="emp_cd" class="col-sm-2 col-form-label">Emplyee Name:</label>

                    <div class="col-sm-10">

                        <select
                            class="form-control required"
                            name="emp_cd"
                            id="emp_cd"
                        >

                        <option value="">Select Employee</option>

                        <?php  

                        if($emp_list) {

                            foreach ($emp_list as $e_list) {

                        ?>        
                                <option value='<?php echo $e_list->emp_code ?>'

                                ><?php echo $e_list->emp_name; ?></option>

                        <?php
                                    }

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
    
    else if($_SERVER['REQUEST_METHOD'] == 'POST') { 
        
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
        
        
    ?>

    <div class="wraper">      
        
        <div class="row">
            
            <div class="col-lg-9 col-sm-12">

                <h4><strong>Employees PF Contribution Report</strong></h4>

            </div>

            <div class="col-lg-3 col-sm-12">

                <ol class="breadcrumb">

                    <li class="breadcrumb-item">Payroll</li>
                    <li class="breadcrumb-item">PF Contribution</li>
                    <li class="breadcrumb-item">Report</li>

                </ol>

            </div>   

        </div>

        <div class="col-lg-12 container contant-wraper">

            <div id="divToPrint">

                <div class="item_body">

                    <div style="text-align:center;">

                        <h3>WEST BENGAL STATE CONSUMERS' CO-OPERATIVE FEDERATION LTD.</h3>

                        <h3>P-1, Hide Lane, Akbar Mansion, 3rd Floor, Kolkata-700073</h3>

                        <h3>PF Contribution of employees from <?php echo date("d-m-Y", strtotime($this->input->post('from_date')))." to ".date("d-m-Y", strtotime($this->input->post('to_date'))).", ";?> during the year <?php echo $year->param_value;?></h3>

                    </div>

                </div>

                <br>

                <div class="report_result">

                    <h3>Employee Name: <?php echo $emp_name->emp_name;?> </h3>

                    <h3>Opening Balance: <?php echo ($opening_balance)? $opening_balance->balance : 0; ?></h3>

                    <table class="table table-bordered table-hover">

                        <thead>

                            <tr>
                            
                                <th>Sl No.</th>

                                <th>Employee's Contibution</th>

                                <th>Employer's Contibution</th>

                                <th>Total Ammount</th>

                            </tr>

                        </thead>

                        <tbody> 

                            <?php 
                                
                            if($pf_contribution) {

                                $i  =   1;

                                $tot_emp_cont = $tot_empr_cont = $tot_amount = 0;
                                    
                                foreach($pf_contribution as $pfc_list) {

                                    $tot_emp_cont += $pfc_list->employee_cntr;

                                    $tot_empr_cont += $pfc_list->employer_cntr;

                                    $tot_amount += $pfc_list->balance;

                                ?>

                                    <tr>

                                        <td><?php echo $i++; ?></td>

                                        <td style="text-align: right;"><?php echo $pfc_list->employee_cntr; ?></td>

                                        <td style="text-align: right;"><?php echo $pfc_list->employer_cntr; ?></td>

                                        <td style="text-align: right;"><?php echo $pfc_list->balance; ?></td>

                                    </tr>

                            <?php
                                        
                                    }

                            ?>


                                    <tr>

                                        <td>Total Amount</td>

                                        <td style="text-align: right;"> Rs. <?php echo $tot_emp_cont; ?></td>

                                        <td style="text-align: right;"> Rs. <?php echo $tot_empr_cont; ?></td>

                                        <td style="text-align: right;"> Rs. <?php echo $tot_amount; ?></td>

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


<script>

$("#form").validate();

</script>