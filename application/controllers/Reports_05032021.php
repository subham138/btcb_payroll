<?php

	class Reports extends CI_Controller{

		public function __construct(){
			parent::__construct();

			$this->load->model('Login_Process');
            $this->load->model('Report_Process');
            $this->load->model('Admin_Process');
            $this->load->helper('paddyrate_helper');
		}

        
    //For Salary Statement

    public function paystatementreport(){

        if($_SERVER['REQUEST_METHOD'] == 'POST') {

            //Employees salary statement
            $select = array(

                "m.emp_name", "m.bank_ac_no",
                
                "t.net_amount"

            );

            $where  = array(

                "m.emp_code = t.emp_no" =>  NULL,

                "t.sal_month"           =>  $this->input->post('sal_month'),

                "t.sal_year"            =>  $this->input->post('year'),

                "m.emp_catg"            =>  $this->input->post('category'),

                "m.emp_status"          =>  'A'

            );

            $statement['statement'] =   $this->Report_Process->f_get_particulars("md_employee m, td_pay_slip t", $select, $where, 0);
//  echo $this->db->last_query();
//                 die();
          $this->load->view('post_login/payroll_main');

            $this->load->view("reports/statement", $statement);

            $this->load->view('post_login/footer');

        }

        else {

            //Month List
            $statement['month_list'] =   $this->Report_Process->f_get_particulars("md_month",NULL, NULL, 0);

            //Category List
            $statement['category']   =   $this->Report_Process->f_get_particulars("md_category", NULL, array('category_code IN (1,2,3)' => NULL), 0);

            $this->load->view('post_login/payroll_main');

            $this->load->view("reports/statement", $statement);

            $this->load->view('post_login/footer');

        }

    }
 //Total Deduction Report

 public function totaldeduction () {

    if($_SERVER['REQUEST_METHOD'] == 'POST'){

        $totaldeduction['total_deduct'] =   $this->Report_Process->f_get_totaldeduction($this->input->post('from_date'), $this->input->post('to_date'));

        //Current Year
        $totaldeduction['year']  =   $this->Report_Process->f_get_particulars("md_parameters", array('param_value'), array('sl_no' => 15), 1);

        $this->load->view('post_login/payroll_main');

        $this->load->view("reports/totaldeduction", $totaldeduction);

        $this->load->view('post_login/footer');

    }

    else{

        //Month List
        $totaldeduction['month_list'] =   $this->Report_Process->f_get_particulars("md_month",NULL, NULL, 0);

        //For Current Date
        $totaldeduction['sys_date']   =   $_SESSION['sys_date'];

        $this->load->view('post_login/payroll_main');

        $this->load->view("reports/totaldeduction", $totaldeduction);

        $this->load->view('post_login/footer');

    }

}


        public function payslipreport() {
// echo 'raja';
// die();
            if($_SERVER['REQUEST_METHOD'] == "POST") {
    
                //Payslip
                $empno     =  $this->input->post('emp_cd');
    
                $sal_month  = $this->input->post('sal_month');
    
                $sal_yr     = $this->input->post('year');

                $where  =   array(
    
                    "emp_no"            =>  $this->input->post('emp_cd'),
    
                    "sal_month"         =>  $this->input->post('sal_month'),
    
                    "sal_year"          =>  $this->input->post('year'),
    
                    "approval_status"   =>  'A' );
    
                $payslip['emp_dtls']    =   $this->Report_Process->f_get_particulars("md_employee", NULL, array("emp_code" =>  $this->input->post('emp_cd')), 1);
    
                $payslip['payslip_dtls']    =   $this->Report_Process->f_get_emp_dtls($empno, $sal_month,$sal_yr);
                // $payslip['payslip_dtls']=   $this->Report_Process->f_get_particulars("td_pay_slip", NULL, $where, 1);
                // echo $this->db->last_query();
                // die();

                $this->load->view('post_login/payroll_main');
    
                $this->load->view("reports/payslip", $payslip);
    
                $this->load->view('post_login/footer');
    
            }
            
            else {
    
                //Month List
                $payslip['month_list'] =   $this->Report_Process->f_get_particulars("md_month",NULL, NULL, 0);
    
                //For Current Date
                $payslip['sys_date']   =   $_SESSION['sys_date'];
    
                //Employee List
                unset($select);
                $select = array ("emp_code", "emp_name");
    
                $payslip['emp_list']   =   $this->Report_Process->f_get_particulars("md_employee", $select, array("emp_catg IN (1,2,3)" => NULL), 0);
    
                $this->load->view('post_login/payroll_main');
    
                $this->load->view("reports/payslip", $payslip);
    
                $this->load->view('post_login/footer');
                
            }
    
        }
    

	}
?>
		
		 