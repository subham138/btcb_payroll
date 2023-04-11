<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Approves extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();

        $this->load->model('Login_Process');

        $this->load->model('Salary_Process');
        $this->load->model('Admin_Process');
        $this->load->helper('pdf_helper');

        $this->load->library('email');


        //For User's Authentication
        // if(!isset($this->session->userdata('loggedin')->user_id)){

        //     redirect('User_Login/login');

        // }

    }


    /**********************For Approve Screen**********************/

    public function payapprove()
    {

        if ($this->input->get('trans_no')) {

            $data_array     =   array(
                "approval_status"   => 'A',
                "approved_by"       => $this->session->userdata['loggedin']['user_id'],
                "approved_dt"       => date('Y-m-d')
            );
            $where = array(
                "trans_no" => $this->input->get('trans_no'),
                "trans_date" => $this->input->get('trans_date'),
                "sal_month" => $this->input->get('month'),
                "sal_year" => $this->input->get('year'),
                "catg_cd" => $this->input->get('catg_cd')
            );

            $this->Salary_Process->f_edit("td_salary", $data_array, $where);

            // $this->Salary_Process->f_edit("td_deductions",  array("ded_month" => $this->input->get('month'), 'ded_yr' => $this->input->get('year')));
            // $this->Payroll->f_edit("md_doublesal", array("emp_status" => 'I'), array("emp_status" => 'A'));

            $data_array1 = array(
                "approval_status" => 'A'
            );
            $where1 = array(
                "sal_month" => $this->input->get('month'),
                "sal_year" => $this->input->get('year'),
                "trans_date" => $this->input->get('trans_date'),
                "catg_id" => $this->input->get('catg_cd')
            );
            $this->Salary_Process->f_edit("td_pay_slip", $data_array1, $where1);
            // echo $this->db->last_query();
            // exit;

            $erning_dt = $this->Admin_Process->f_get_particulars("td_pay_slip", null, $where1, 0);
            $res_dt = $this->save_sal_slip($erning_dt);
            $res_dt = json_decode($res_dt);
            if ($res_dt->suc > 0) {
                $this->session->set_flashdata('msg', 'Successfully Approved!');
            } else {
                $this->session->set_flashdata('msg', 'Data not updated in server');
            }
            redirect('payapprv');
        }

        //Unapprove List of Salary
        $approve['unapprove_tot_dtls'] = $this->Salary_Process->generate_slip($trans_dt = null, $month = null, $year = null, $catg_id = null, $trans_no = null, 0);
        $this->load->view('post_login/payroll_main');
        $this->load->view("approve/dashboard", $approve);
        $this->load->view('post_l ogin/footer');
    }

    function save_sal_slip($data)
    {
        $url = 'https://restaurantapi.opentech4u.co.in';
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => $url . '/sal/save',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => array(
                'Content-Type: application/json'
            ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        return $response;
        // exit;
    }

    //Creating individual payslip PDF
    public function f_pdf($emp_dtls = NULL)
    {

        $data['payslip_dtls'] = $emp_dtls;

        $this->load->view('reports/pdfreport', $data);

        $file_name  = $emp_dtls->emp_no . $emp_dtls->sal_year . $emp_dtls->sal_month;

        $email_addr = $emp_dtls->email;

        chmod(FCPATH . "payslip/" . $file_name . ".pdf", 0766);
    }

    //Send Mail to the invidual email account
    public function f_email($file_name, $email_addr)
    {

        $this->email->clear(TRUE);
        $this->email->from('confedwb.org@gmail.com', 'Payslip');

        $this->email->to($email_addr);

        $this->email->subject('Payslip for the month of ' . date("F", strtotime(date('Y-m-d'))));
        $this->email->message('');
        $this->email->attach(FCPATH . 'payslip/' . $file_name . '.pdf');
        $this->email->send();

        unlink(FCPATH . 'payslip/' . $file_name . '.pdf');
    }
}
