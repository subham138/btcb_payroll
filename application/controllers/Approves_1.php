<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Approves extends MX_Controller {

    public function __construct(){

        parent::__construct();

        $this->load->model('Payroll');

        $this->load->helper('pdf_helper');

        $this->load->library('email');
        
        //For User's Authentication
        if(!isset($this->session->userdata('loggedin')->user_id)){
            
            redirect('User_Login/login');

        }
        
    }


    /**********************For Approve Screen**********************/

    public function f_approve() {

        if($this->input->get('trans_no')){ 

            $data_array     =   array(

                "approval_status"   => 'A',

                "approved_by"       => $this->session->userdata('loggedin')->user_name,

                "approved_dt"       => date('Y-m-d')

            );

            $this->Payroll->f_edit("td_salary", $data_array, array("trans_no" => $this->input->get('trans_no'), "trans_date" => $this->input->get('trans_date')));

            $this->Payroll->f_edit("td_deductions", array("approval_status" => 'A'), array("sal_month" => $this->input->get('month'), 'sal_yr' => $this->input->get('year')));

            $this->Payroll->f_edit("md_doublesal", array("emp_status" => 'I'), array("emp_status" => 'A'));

            $this->Payroll->f_edit("td_pay_slip", array("approval_status" => 'A'), array("sal_month" => $this->input->get('month')));
            
            $select = array(

                "t.trans_date","t.trans_no","t.sal_month",
                "t.sal_year","t.emp_no","t.emp_name","t.emp_catg",
                "m.email", "m.pan_no", "t.designation","t.band_pay","t.grade_pay",
                "t.basic_pay","t.da","t.ir","t.hra","t.ma", "m.pf_ac_no",
                "t.cash_allow","t.gross", "t.gen_adv", "t.gen_intt",
                "t.festival_adv", "t.lic", "t.pf", "t.ptax", "t.itax",
                "t.tot_deduction", "t.net_amount"

            );

            $where  = array(

                "m.emp_code = t.emp_no" => NULL,

                "m.emp_status"          => 'A',

                "t.trans_date"          => $this->input->get('trans_date'),

                "t.trans_no"            => $this->input->get('trans_no'),

                "t.emp_catg"            => $this->input->get('catg_cd')

            );

            $salary_dtls = $this->Payroll->f_get_particulars("md_employee m,td_pay_slip t", $select, $where, 0);

            function getIndianCurrency($number){

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
            

            foreach($salary_dtls as $s_list){
            
               if($s_list->email){
                
                    $this->f_pdf($s_list);

                    $this->f_email($s_list->emp_no.$s_list->sal_year.$s_list->sal_month, $s_list->email);

               }

            }
    
            $this->session->set_flashdata('msg', 'Successfully Approved!');

            redirect('payroll/approve');

        }

        //Unapprove List of Salary
        $select =   array(

            "trans_date", "trans_no", "sal_month", 

            "sal_year", "catg_cd", "bank"

        );
        
        $where  =   array(

            "approval_status"       =>  'U'

        );

        $approve['unapprove_dtls']     =  (array) $this->Payroll->f_get_particulars("td_salary", $select, $where, 0);

        unset($select);
        unset($where);

        //Temp Variable
        $approve['unapprove_tot_dtls'] = [];


        $select     =   array( "SUM(gross) gross",
                               "SUM(net_amount) net_amount");
        
        
        for($i = 0; $i < count($approve['unapprove_dtls']); $i++){

            unset($where);

            $where  =   array(

                "trans_date"    =>  $approve['unapprove_dtls'][$i]->trans_date,

                "trans_no"      =>  $approve['unapprove_dtls'][$i]->trans_no,
                
            );

            $data_array     =   (array) $this->Payroll->f_get_particulars("td_pay_slip", $select, $where, 1);

            array_push($approve['unapprove_tot_dtls'], (object) array_merge((array) $approve['unapprove_dtls'][$i], (array) $data_array));

        }                               

        //Bank List
        $approve['bank']	         =   $this->Payroll->f_get_particulars("md_bank", NULL, NULL, 0);			
        
        //Category List
        $approve['category']         =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

        $this->load->view('post_login/main');

        $this->load->view("approve/dashboard", $approve);
        
        $this->load->view('post_login/footer');

    }

    //Creating individual payslip PDF
    public function f_pdf($emp_dtls=NULL) {
        
        $data['payslip_dtls'] = $emp_dtls;

        $this->load->view('reports/pdfreport', $data);

        $file_name  = $emp_dtls->emp_no.$emp_dtls->sal_year.$emp_dtls->sal_month;
        
        $email_addr = $emp_dtls->email;

        chmod(FCPATH."payslip/".$file_name.".pdf", 0766);

    }

    //Send Mail to the invidual email account
    public function f_email($file_name, $email_addr){

        $this->email->clear(TRUE);
        $this->email->from('confedwb.org@gmail.com', 'Payslip');
        
        $this->email->to($email_addr);

        $this->email->subject('Payslip for the month of '.date("F", strtotime(date('Y-m-d'))));
        $this->email->message('');
        $this->email->attach(FCPATH.'payslip/'.$file_name.'.pdf');
        $this->email->send();

        unlink(FCPATH.'payslip/'.$file_name.'.pdf');

    }

}