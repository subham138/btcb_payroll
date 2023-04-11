<script>
  function printDiv() {

        var divToPrint = document.getElementById('divToPrint');

        var WindowObject = window.open('', 'Print-Window');
        WindowObject.document.open();
        WindowObject.document.writeln('<!DOCTYPE html>');
        WindowObject.document.writeln('<html><head><title></title><style type="text/css">');


        WindowObject.document.writeln('@media print { .center { text-align: center;} .underline { text-decoration: underline; } p { display:inline; } .left { margin-left: 315px; text-align="left" display: inline; } .right { margin-right: 375px; display: inline; } td.left_algn { text-align: left; } td.right_algn { text-align: right; } .t2 td, th { border: 1px solid black; } td.hight { hight: 15px; } table.width { width: 100%; } table.noborder { border: 0px solid black; } th.noborder { border: 0px solid black; } .border { border: 1px solid black; } .bottom { position: absolute;; bottom: 5px; width: 100%; } } </style>');
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

    if($_SERVER['REQUEST_METHOD'] == "POST" && isset($payslip_dtls)) {


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

        <div class="col-lg-12 container contant-wraper">

            <div id="divToPrint">

                <div class="item_body">

                    <div style="text-align:center;">

                        <h3>WEST BENGAL STATE CONSUMERS' CO-OPERATIVE FEDERATION LTD.</h3>

                        <h4>P-1, Hide Lane, Akbar Mansion 3rd Floor Kolkata-700073</h4>

                        <h4> Pay Slip for <?php echo $this->input->post('sal_month').'-'.$this->input->post('year');?></h4>

                        <h4><?php echo $payslip_dtls->emp_name; ?></h4>

                    </div>  

                    <hr>

                    <table class="width noborder" cellpadding="3.5">

                        <tr>
                            <th class="noborder" width="25%"></th>
                            <th class="noborder" width="1%"></th>
                            <th class="noborder" width="25%"></th>
                            <th class="noborder" width="1%"></th>
                            <th class="noborder" width="30%"></th>
                            <th class="noborder" width="1%"></th>
                            <th class="noborder" width="25%"></th>
                        </tr>

                        <tr>

                            <td>Employee Number</td>
                            <td class="left_algn">:</td>
                            <td class="left_algn"><?php echo $payslip_dtls->emp_no; ?></td>
                            <td></td>
                            <td >Date of Joining</td>
                            <td class="left_algn">:</td>
                            <td><?php if(($emp_dtls->join_dt != "0000-00-00") && ($emp_dtls->join_dt != NULL)){ echo date('d-m-Y', strtotime($emp_dtls->join_dt)); } ?></td>

                        </tr>

                        <tr>

                            <td>Designation</td>
                            <td class="left_algn">:</td>
                            <td class="left_algn"><?php echo $payslip_dtls->designation; ?></td>
                            <td></td>
                            <td>Date of Retirement</td>
                            <td class="left_algn">:</td>
                            <td><?php if(($emp_dtls->ret_dt != "0000-00-00") && ($emp_dtls->ret_dt != NULL)){ echo date('d-m-Y', strtotime($emp_dtls->ret_dt)); } ?></td>

                        </tr>

                    </table>   

                    <table class="width" cellpadding="6" style="width:100%; ">

                        <thead>

                            <tr class="t2">
                                <th width="30%">Earnings</th>
                                <th width="20%">Amount</th>
                                <th width="30%">Deductions</th>
                                <th width="20%">Amount</th>
                            </tr>

                        </thead>

                        <tbody> 

                            <tr class="t2">
                                <td class="left_algn">Basic Salary<br>(Band Pay + Grade pay)</td>
                                <td class="right_algn"><?php echo $payslip_dtls->basic_pay; ?></td>
                                <td class="left_algn">Professional Tax</td>
                                <td class="right_algn"><?php echo $payslip_dtls->ptax; ?></td>
                            </tr>

                            <tr class="t2">
                                <td class="left_algn">Dearness Allowance</td>
                                <td class="right_algn"><?php echo $payslip_dtls->da; ?></td>
                                <td class="left_algn">Provident Fund</td>
                                <td class="right_algn"><?php echo $payslip_dtls->pf; ?></td>
                            </tr>

                            <tr class="t2">
                                <td class="left_algn">I.R.</td>
                                <td class="right_algn"><?php echo $payslip_dtls->ir; ?></td>
                                <td class="left_algn">LIC</td>
                                <td class="right_algn"><?php echo $payslip_dtls->lic; ?></td>
                            </tr>

                            <tr class="t2">
                                <td class="left_algn">H.R.A.</td>
                                <td class="right_algn"><?php echo $payslip_dtls->hra; ?></td>
                                <td class="left_algn">I-Tax</td>
                                <td class="right_algn"><?php echo $payslip_dtls->itax; ?></td>

                            </tr>

                            <tr class="t2">
                                <td class="left_algn">Medical Allowance</td>
                                <td class="right_algn"><?php echo $payslip_dtls->ma; ?></td>
                                <td class="left_algn">General Advance</td>
                                <td class="right_algn"><?php echo $payslip_dtls->gen_adv; ?></td>
                            </tr>

                            <tr class="t2">
                                <td class="left_algn">Cash Allowance</td>
                                <td class="right_algn"><?php echo $payslip_dtls->cash_allow; ?></td>
                                <td class="left_algn">General Interest</td>
                                <td class="right_algn"><?php echo $payslip_dtls->gen_intt; ?></td>

                            </tr>

                            <tr class="t2">
                                <td class="left_algn"></td>
                                <td class="right_algn"></td>
                                <td class="left_algn">Festival Advance</td>
                                <td class="right_algn"><?php echo $payslip_dtls->festival_adv; ?></td>

                            </tr>

                            <tr class="t2">

                                <td class="left_algn">Total Earnings</td>
                                <td class="right_algn"><?php  $tot_er = $payslip_dtls->basic_pay + 
                                                                $payslip_dtls->da + 
                                                                $payslip_dtls->ir +
                                                                $payslip_dtls->hra +
                                                                $payslip_dtls->ma +
                                                                $payslip_dtls->cash_allow; echo $tot_er; ?></td>
                                <td class="left_algn">Total Deductions</td>
                                <td class="right_algn"><?php $tot_dd = $payslip_dtls->ptax + 
                                                                $payslip_dtls->pf + 
                                                                $payslip_dtls->itax + 
                                                                $payslip_dtls->lic +
                                                                $payslip_dtls->festival_adv +
                                                                $payslip_dtls->gen_adv +
                                                                $payslip_dtls->gen_intt;  echo $tot_dd;?></td>

                            </tr>

                            <tr class="t2">

                                <td class="left_algn"></td>
                                <td class="right_algn"></td>
                                <td class="left_algn">Net Amount</td>
                                <td class="right_algn"><?php echo $tot_er - $tot_dd; ?></td>

                            </tr>

                        </tbody>

                    </table>
                    
                    <div>
                        <p style="display: inline;">Amount (<small>in words</small>)</p>

                    </div>    

                    <p><?php echo getIndianCurrency($tot_er - $tot_dd);?></p>   

                </div>     

            </div>                

            <div style="text-align: center;">

                <button class="btn btn-info" type="button" onclick="printDiv();">Print</button>

            </div>

        <div>  
            
    </div>        

<?php
    }

    else if($_SERVER['REQUEST_METHOD'] == 'GET') {

?>
    <div class="wraper">

        <div class="col-md-6 container form-wraper">
    
            <form method="POST" 
                id="form"
                action="<?php echo site_url("payroll/payslipold/report");?>" >
                
                <div class="form-header">
                
                    <h4>Payslip Report</h4>
                
                </div>

                <div class="form-group row">

                    <label for="trans_dt" class="col-sm-2 col-form-label">Transaction Date:</label>

                    <div class="col-sm-10">

                        <input type="date"
                                name="trans_dt"
                                class="form-control required"
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
        else {

            echo "<h1 style='text-align: center;'>No Data Found</h1>";

        }

    ?>

<script>

    $("#form").validate();

</script>