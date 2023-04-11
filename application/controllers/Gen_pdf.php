<?php

class Gen_pdf extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Login_Process');
        $this->load->model('Salary_Process');
        $this->load->model('Admin_Process');
    }

    function pdf()
    {
        require(APPPATH . 'third_party\fpdf_protection.php');
        $pdf = new FPDF_Protection();
        $pdf->SetProtection(array('print'), 'SUBH291996');
        $pdf->AddPage();
        $pdf->SetFont('Arial');
        $pdf->Write(10, 'You can print me but not copy my text.');
        $pdf->Output();
        // var_dump(APPPATH . 'third_party\fpdf_protection.php');
    }
}
