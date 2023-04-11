<?php

class Reports extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();

        $this->load->model('Login_Process');
        $this->load->model('Report_Process');
        $this->load->model('Admin_Process');
        $this->load->helper('paddyrate_helper');
    }


    //Category wise 

    public function salarycatgreport()
    {

        if ($_SERVER['REQUEST_METHOD'] == "POST") {
            //Employee Ids for Salary List
            $select     =   array("emp_code");
            $where      =   array(
                "emp_catg"  =>  $this->input->post('category')
            );

            $emp_id     =   $this->Report_Process->f_get_particulars("md_employee", $select, $where, 0);
            //Temp variable for emp_list
            $eid_list   =   [];
            for ($i = 0; $i < count($emp_id); $i++) {
                array_push($eid_list, $emp_id[$i]->emp_code);
            }

            //List of Salary Category wise
            unset($where);
            $where = array(
                "m.emp_code = t.emp_no" =>  NULL,
                "t.sal_month"     =>  $this->input->post('sal_month'),
                "t.sal_year"      =>  $this->input->post('year')
            );

            $salary['list']               =   $this->Report_Process->f_get_particulars_in("md_employee m,td_pay_slip t", $eid_list, $where);

            // $salary['attendance_dtls']    =   $this->Report_Process->f_get_attendance();

            //Employee Group Count
            unset($select);
            unset($where);

            $select =   array(
                "m.emp_code",  "COUNT(m.emp_code) count", "m.emp_name"
            );

            $where  =   array(
                "t.sal_month"     =>  $this->input->post('sal_month'),
                "t.sal_year = '" . $this->input->post('year') . "' GROUP BY m.emp_code,m.emp_name"      =>  NULL
            );

            $salary['count']              =   $this->Report_Process->f_get_particulars("md_employee m,td_pay_slip t", $select, $where, 0);
            // f_get_particulars("md_employee m, td_pay_slip t", $select, $where, 0);
            // echo $this->db->last_query();
            // die();

            $this->load->view('post_login/payroll_main');
            $this->load->view("reports/salary", $salary);
            $this->load->view('post_login/footer');
        } else {

            //Month List
            $salary['month_list'] =   $this->Report_Process->f_get_particulars("md_month", NULL, NULL, 0);
            //For Current Date
            $salary['sys_date']   =   $_SESSION['sys_date'];
            //Category List
            $salary['category']   =   $this->Report_Process->f_get_particulars("md_category", NULL, null, 0);

            $this->load->view('post_login/payroll_main');
            $this->load->view("reports/salary", $salary);
            $this->load->view('post_login/footer');
        }
    }

    //For Salary Statement

    public function paystatementreport()
    {

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            //Employees salary statement
            $select = 'a.trans_date, a.trans_no, a.sal_month, a.sal_year, a.emp_code, 
			a.catg_id, a.basic, a.da, a.sa, a.hra, a.ta, a.da_on_sa, a.da_on_ta, a.ma, a.cash_swa, a.lwp, a.final_gross, 
			a.pf, a.adv_agst_hb_prin, a.adv_agst_hb_int, a.adv_agst_hb_const_prin, a.adv_agst_hb_const_int, a.adv_agst_hb_staff_prin, 
			a.adv_agst_hb_staff_int, a.gross_hb_int, a.adv_agst_of_staff_prin, a.adv_agst_of_staff_int, a.staff_adv_ext_prin, 
			a.staff_adv_ext_int, a.motor_cycle_prin, a.motor_cycle_int, a.p_tax, a.gici, a.puja_adv, a.income_tax_tds, 
			a.union_subs, a.tot_diduction, a.net_sal, a.remarks, b.emp_name,b.designation,b.phn_no,b.department,b.pan_no, b.bank_ac_no';

            $where  = array(
                "a.emp_code=b.emp_code" =>  NULL,
                "a.sal_month"           =>  $this->input->post('sal_month'),
                "a.sal_year"            =>  $this->input->post('year'),
                "a.catg_id"            =>  $this->input->post('category'),
                "b.emp_status"          =>  'A'
            );

            $table_name = 'td_pay_slip a,md_employee b';

            $statement['statement'] =   $this->Report_Process->f_get_particulars($table_name, $select, $where, 0);
            //  echo $this->db->last_query();
            //                 die();
            $this->load->view('post_login/payroll_main');
            $this->load->view("reports/statement", $statement);
            $this->load->view('post_login/footer');
        } else {

            //Month List
            $statement['month_list'] =   $this->Report_Process->f_get_particulars("md_month", NULL, NULL, 0);
            //Category List
            $statement['category']   =   $this->Report_Process->f_get_particulars("md_category", NULL, null, 0);
            $this->load->view('post_login/payroll_main');
            $this->load->view("reports/statement", $statement);
            $this->load->view('post_login/footer');
        }
    }
    //Total Deduction Report

    public function totaldeduction()
    {

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $totaldeduction['total_deduct'] =   $this->Report_Process->f_get_totaldeduction($this->input->post('from_date'), $this->input->post('to_date'));
            //Current Year
            $totaldeduction['year']  =   $this->Report_Process->f_get_particulars("md_parameters", array('param_value'), array('sl_no' => 15), 1);

            $this->load->view('post_login/payroll_main');
            $this->load->view("reports/totaldeduction", $totaldeduction);
            $this->load->view('post_login/footer');
        } else {
            //Month List
            $totaldeduction['month_list'] =   $this->Report_Process->f_get_particulars("md_month", NULL, NULL, 0);
            //For Current Date
            $totaldeduction['sys_date']   =   $_SESSION['sys_date'];

            $this->load->view('post_login/payroll_main');
            $this->load->view("reports/totaldeduction", $totaldeduction);
            $this->load->view('post_login/footer');
        }
    }

    public function totalearning()
    {

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $totalearning['total_ear'] =   $this->Report_Process->f_get_totalearning($this->input->post('from_date'), $this->input->post('to_date'));
            //Current Year
            $totalearning['year']  =   $this->Report_Process->f_get_particulars("md_parameters", array('param_value'), array('sl_no' => 15), 1);

            $this->load->view('post_login/payroll_main');
            $this->load->view("reports/totalearning", $totalearning);
            $this->load->view('post_login/footer');
        } else {
            //Month List
            $totalearning['month_list'] =   $this->Report_Process->f_get_particulars("md_month", NULL, NULL, 0);
            //For Current Date
            $totalearning['sys_date']   =   $_SESSION['sys_date'];

            $this->load->view('post_login/payroll_main');
            $this->load->view("reports/totalearning", $totalearning);
            $this->load->view('post_login/footer');
        }
    }

    public function payslipreport()
    {

        if ($_SERVER['REQUEST_METHOD'] == "POST") {

            //Payslip
            $empno     =  $this->input->post('emp_cd');
            $sal_month  = $this->input->post('sal_month');
            $sal_yr     = $this->input->post('year');

            $where  =   array(
                "emp_code"          =>  $this->input->post('emp_cd'),
                "sal_month"         =>  $this->input->post('sal_month'),
                "sal_year"          =>  $this->input->post('year'),
                "approval_status"   =>  'U'
            );

            $emp_whr = array(
                "a.emp_code" =>  $this->input->post('emp_cd'),
                "a.department = b.id" => null
            );
            $emp_select = 'a.*, b.name dept_name';

            $payslip['emp_dtls']    =   $this->Report_Process->f_get_particulars("md_employee a, md_department b", $emp_select, $emp_whr, 1);

            $payslip['payslip_dtls']    =   $this->Report_Process->f_get_emp_dtls($empno, $sal_month, $sal_yr);
            // $payslip['payslip_dtls']=   $this->Report_Process->f_get_particulars("td_pay_slip", NULL, $where, 1);
            // echo $this->db->last_query();
            // die();

            $this->load->view('post_login/payroll_main');

            $this->load->view("reports/payslip", $payslip);

            $this->load->view('post_login/footer');
        } else {

            //Month List
            $payslip['month_list'] =   $this->Report_Process->f_get_particulars("md_month", NULL, NULL, 0);
            //For Current Date
            $payslip['sys_date']   =   $_SESSION['sys_date'];

            //Employee List
            unset($select);
            $select = array("emp_code", "emp_name");
            $payslip['emp_list']   =   $this->Report_Process->f_get_particulars("md_employee", $select, array("emp_catg IN (1,2,3)" => NULL), 0);
            $this->load->view('post_login/payroll_main');
            $this->load->view("reports/payslip", $payslip);
            $this->load->view('post_login/footer');
        }
    }
}
