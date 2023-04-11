<?php
$tot_er =   $payslip_dtls->basic_pay + 
            $payslip_dtls->da + 
            $payslip_dtls->ir +
            $payslip_dtls->hra +
            $payslip_dtls->ma +
            $payslip_dtls->cash_allow;

$tot_dd =   $payslip_dtls->ptax + 
            $payslip_dtls->pf + 
            $payslip_dtls->lic +
            $payslip_dtls->festival_adv +
            $payslip_dtls->gen_adv +
            $payslip_dtls->gen_intt;

$tot_sal = $tot_er - $tot_dd;            

 

tcpdf();
$obj_pdf = new TCPDF("P", PDF_UNIT, PDF_PAGE_FORMAT, true, "UTF-8", false);
$obj_pdf->SetTitle("CONFED");
$obj_pdf->AddPage();

$logo_url = base_url("/confed.jpg");
$html ='<div style="text-align:center; margin: 0;">

            <h3>WEST BENGAL STATE CONSUMERS\' CO-OPERATIVE FEDERATION LTD.</h3>

            <h4>P-1, Hide Lane, Akbar Mansion 3rd Floor Kolkata-700073</h4>

            <h4>Pay Slip for '.$payslip_dtls->sal_month.' '.$payslip_dtls->sal_year.'</h4>

            <h4 style="float: left;">Employee Name: '.$payslip_dtls->emp_name.' </h4>
                
            <img src="'.$logo_url.'" style="height: 35px;" />
            
        </div>  
        
        <hr>

        <table cellpadding="1" >

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
                <td>Employee Number:</td>
                <td>:</td>
                <td>'.$payslip_dtls->emp_no.'</td>
                <td></td>
                <td>Income Tax Number: (PAN)</td>
                <td>:'.$payslip_dtls->pan_no.'</td>
                <td></td>
            </tr>

            <tr>
                <td>Designation:</td>
                <td>:</td>
                <td>'.$payslip_dtls->designation.'</td>
                <td></td>
                <td>PF account Number:</td>
                <td>:</td>
                <td>'.$payslip_dtls->pf_ac_no.'</td>

            </tr>

        </table>   

        <table cellpadding="6" style="width:100%; ">

            <thead>

                <tr style="font-size: 15px;">
                    <th width="30%" style="text-align: left;"><u>Earnings</u></th>
                    <th width="20%" style="text-align: left;"><u>Amount</u></th>
                    <th width="30%" style="text-align: left;"><u>Deductions</u></th>
                    <th width="20%" style="text-align: left;"><u>Amount</u></th>
                </tr>

            </thead>

            <tbody> 

                <tr class="t2">
                    <td >Basic Salary<br>(Band Pay + Grade pay)</td>
                    <td style="text-align: center;">'.$payslip_dtls->basic_pay.'</td>
                    <td >Professional Tax</td>
                    <td style="text-align: center;">'.$payslip_dtls->ptax.'</td>
                </tr>

                <tr class="t2">
                    <td >Dearness Allowance</td>
                    <td style="text-align: center;">'.$payslip_dtls->da.'</td>
                    <td >Provident Fund</td>
                    <td style="text-align: center;">'.$payslip_dtls->pf.'</td>
                </tr>

                <tr class="t2">
                    <td >I.R.</td>
                    <td style="text-align: center;">'.$payslip_dtls->ir.'</td>
                    <td >LIC</td>
                    <td style="text-align: center;">'.$payslip_dtls->lic.'</td>
                </tr>

                <tr class="t2">
                    <td >H.R.A.</td>
                    <td style="text-align: center;">'.$payslip_dtls->hra.'</td>
                    <td >General Advance</td>
                    <td style="text-align: center;">'.$payslip_dtls->gen_adv.'</td>

                </tr>

                <tr class="t2">
                    <td >Medical Allowance</td>
                    <td style="text-align: center;">'.$payslip_dtls->ma.'</td>
                    <td >General Interest</td>
                    <td style="text-align: center;">'.$payslip_dtls->gen_intt.'</td>

                </tr>

                <tr class="t2">
                    <td >Cash Allowence</td>
                    <td style="text-align: center;">'.$payslip_dtls->cash_allow.'</td>
                    <td >Festival Advance</td>
                    <td style="text-align: center;">'.$payslip_dtls->festival_adv.'</td>

                </tr>

                <tr class="t2">

                    <td >Total Earnings</td>
                    <td style="text-align: center;">'. $tot_er.'</td>
                    <td >Total Deductions</td>
                    <td style="text-align: center;">'. $tot_dd.'</td>

                </tr>

                <tr class="t2">

                    <td ></td>
                    <td style="text-align: center;"></td>
                    <td >Net Amount</td>
                    <td style="text-align: center;">'.$tot_sal.'</td>

                </tr>

            </tbody>

        </table>
        
        <div>

            <p style="display: inline;">Amount (<small>in words</small>)</p>

            <p>'. getIndianCurrency($tot_sal).'</p>

        </div>';

        $name = $payslip_dtls->emp_no.$payslip_dtls->sal_year.$payslip_dtls->sal_month;


$obj_pdf->writeHTML($html, true, false, true, false, "");
$obj_pdf->lastPage();
ob_end_clean();

$obj_pdf->Output(FCPATH."payslip/".$name.".pdf", "F");


?>