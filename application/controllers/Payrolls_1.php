<?php
defined('BASEPATH') OR exit('No direct script access allowed');

// Global Variables.................................

class Payrolls extends MX_Controller {

    public function __construct(){

        parent::__construct();

        $this->load->model('Payroll');
        
        //For User's Authentication
        if(!isset($this->session->userdata('loggedin')->user_id)){
            
            redirect('User_Login/login');

        }
        
    }
    
    //For Adding Bulk Employee Dtails
    #this is no longar needed
    // public function f_addemp(){
        
	//     if($_SERVER['REQUEST_METHOD']=="POST"){
            
	// 	    if($_POST['importSubmit']){
			
	// 	    //validate whether uploaded file is a csv file
	// 		$csvMimes = array('text/x-comma-separated-values',
	// 				  'text/comma-separated-values',
	// 				  'application/octet-stream',
	// 				  'application/vnd.ms-excel',
	// 				  'application/x-csv',
	// 				  'text/x-csv',
	// 				  'text/csv',
	// 				  'application/csv',
	// 				  'application/excel',
	// 				  'application/vnd.msexcel',
	// 				  'text/plain');

	// 		if(!empty($_FILES['upemp']['name']) && in_array($_FILES['upemp']['type'], $csvMimes)){
				
	// 			if($_FILES['upemp']['tmp_name']){

	// 				$csvFile = fopen($_FILES['upemp']['tmp_name'], 'r');

	// 				while(($line = fgetcsv($csvFile)) !== FALSE){

	// 					if($line[0]!='' && $line[0]!='Employee No.'){
	// 						echo"<pre>";
	// 						var_dump($line);
							
	// 				   		   $data = array(
	// 					   			 "emp_code"   		=> $line[0],
	// 					   			 "emp_name"		=> $line[1],
	// 			   		   			 "emp_catg"   		=> $line[2],
	// 					   			 "join_dt"		=> $line[3],
	// 		   			   			 "ret_dt"		=> $line[4],
	// 					   			 "designation"		=> $line[5],		   
	// 				   	   			 "department" 		=> $line[6],
	// 		   			   			 "location"		=> 'NA',
	// 					   			 "pan_no"		=> $line[7],
	// 					   			 "bank_name"  		=> 'NA',
	// 					   			 "bank_ac_no" 		=> $line[8],
	// 					   			 "pf_ac_no"		=> $line[9],
	// 					   			 "deduction_flag"	=> 'Y',
	// 					   			 "cash_allow"		=> $line[10],
	// 					   			 "band_pay"		=> $line[11],
	// 					   			 "grade_pay"		=> $line[12],
	// 					   			 "p_tax_id"		=> 0,
	// 					   			 "ir_pay"		=> $line[13],
	// 					   			 "created_by"   	=> $this->session->userdata('loggedin')->user_name,
	// 								 "created_dt"   	=> date('Y-m-d h:i:s'),
	// 								 "emp_status"		=> 'A',
	// 								 "modified_by"		=> NULL,
	// 								 "modified_dt" 		=> NULL
	// 				   			);
	// 				//	echo "<pre>";
	// 		   		//	var_dump($data);		   

	// 				    $this->Payroll->f_insert('md_employee', $data);
	// 				}
	// 			}	
	// 				    $this->session->set_flashdata('msg', 'Successfully Added!');
	// 				    redirect('payroll/addemp');			
					  
	// 			   fclose($csvFile);
	// 			   $qstring = '?status=succ';
	// 		   }else{
	// 		   	$qstring = '?status=err';
	// 		   }
	// 	   }else{
	// 	  	$qstring = '?status=invalid_file';
	// 	   }			   				   
	//     }
	//  }else{    
    // 		$this->load->view('post_login/main');
	// 	    $this->load->view('upemp');
    // 	  }	
    // }
    
    // public function f_download(){
        
    // 	$this->load->helper('download');
	// $data = file_get_contents(base_url('/application/modules/payrolls/views/sample_Employee_details.csv'));
	// force_download('sample_Employee_details.csv', $data);
    // }

/************************************** */
//salary parameters fro da ,hra etc
public function f_parameter()
{

    $this->load->view('post_login/main');

    $param_dtls['parameter'] = $this->Payroll->f_get_parameter();
    $this->load->view('parameter/table', $param_dtls);

    $this->load->view('post_login/footer'); 

}


public function f_parameter_edit(){

    if($_SERVER['REQUEST_METHOD'] == "POST") {
        
        $sl_no  =   $this->input->post('sl_no');

        $param_desc       =   $this->input->post('param_desc');

        $param_value   =   $this->input->post('param_value');

        $data_array = array (

            "sl_no"         =>  $sl_no,

            "param_desc"        =>  $param_desc,

            "param_value"     =>  $param_value

           

            // "modified_by"   =>  $this->session->userdata('loggedin')->user_name,

            // "modified_dt"   =>  date('Y-m-d h:i:s')

        );

        $where = array(

            "sl_no"       =>  $sl_no

        );
        
        $this->session->set_flashdata('msg', 'Successfully updated!');

        $this->Payroll->f_edit('md_parameters', $data_array, $where);

        redirect('payroll/parameter');

    }

    else {

        $where = array(

            "sl_no"     =>  $this->input->get('sl_no')

        );


        //Month List
        // $bonus['month_list'] =   $this->Payroll->f_get_particulars("md_month", NULL, NULL, 0);
        
        //Bonus list of latest month
         $parameter['param_dtls']    =   $this->Payroll->f_get_particulars("md_parameters", NULL, $where, 0);

        $this->load->view('post_login/main');

        $this->load->view("parameter/edit", $parameter);

        $this->load->view('post_login/footer');

    }

}


    /******************For Employee Screen*****************/

    //Retriving employee list
    public function f_employee() {

        //Employee List
        $select = array("emp_code", "emp_name", "emp_catg",
                        "designation", "email");

        $employee['employee_dtls']    =   $this->Payroll->f_get_particulars("md_employee", $select, array("emp_status" => 'A'), 0);
        

        //Category List 
        $employee['category_dtls']    =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

        $this->load->view('post_login/main');

        $this->load->view("employee/dashboard", $employee);

        $this->load->view('post_login/footer');
        
    }


    //New Employee Add
    public function f_employee_add() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {

            $maxCode     =   $this->Payroll->f_get_particulars("md_employee", array("MAX(emp_code) + 1 emp_code"), null, 1);
            
            $data_array = array (

                "emp_code"         =>  $maxCode->emp_code,

                "emp_name"         =>  $this->input->post('emp_name'),

                "emp_catg"         =>  $this->input->post('emp_catg'),
                
                "join_dt"          =>  $this->input->post('join_dt'),

                "ret_dt"           =>  $this->input->post('ret_dt'),
                
                "phn_no"           =>  $this->input->post('phn_no'),
                
                "email"            =>  $this->input->post('email'),
                
                "designation"      =>  $this->input->post('designation'),
                
                "department"       =>  $this->input->post('department'),

                "location"         =>  $this->input->post('location'),

                "pan_no"           =>  $this->input->post('pan_no'),

                "bank_name"        =>  $this->input->post('bank_name'),

                "bank_ac_no"       =>  $this->input->post('bank_ac_no'),

                "pf_ac_no"         =>  $this->input->post('pf_ac_no'),

                "deduction_flag"   =>  $this->input->post('d_flag'),

                "cash_allow"       =>  0,

                "band_pay"         =>  $this->input->post('band_pay'),

                "grade_pay"        =>  $this->input->post('grade_pay'),
                
                "ma"               =>  $this->input->post('ma'),

                "p_tax_id"         =>  $this->input->post('p_tax_id'),

                "ir_pay"           =>  $this->input->post('ir_pay'),

                "created_by"       =>  $this->session->userdata('loggedin')->user_name,

                "created_dt"       =>  date('Y-m-d h:i:s')

            );  

            $this->Payroll->f_insert('md_employee', $data_array);

            $this->session->set_flashdata('msg', 'Successfully added!');
 
            redirect('payroll/employee');

        }

        else {

            //Category List 
            $employee['category_dtls']    =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

            //P-Tax List 
            $employee['ptax_dtls']        =   $this->Payroll->f_get_particulars("md_ptax_slab", NULL, NULL, 0);

            $this->load->view('post_login/main');

            $this->load->view("employee/add", $employee);

            $this->load->view('post_login/footer');

        }

    }


    //Employee Edit

    public function f_employee_edit(){

        if($_SERVER['REQUEST_METHOD'] == "POST") {

            $data_array = array (

                "emp_name"         =>  $this->input->post('emp_name'),

                "emp_catg"         =>  $this->input->post('emp_catg'),

                "join_dt"          =>  $this->input->post('join_dt'),
                
                "ret_dt"           =>  $this->input->post('ret_dt'),
                
                "phn_no"           =>  $this->input->post('phn_no'),
                
                "email"            =>  $this->input->post('email'),
                
                "designation"      =>  $this->input->post('designation'),
                
                "department"       =>  $this->input->post('department'),

                "location"         =>  $this->input->post('location'),

                "pan_no"           =>  $this->input->post('pan_no'),

                "bank_name"        =>  $this->input->post('bank_name'),

                "bank_ac_no"       =>  $this->input->post('bank_ac_no'),

                "pf_ac_no"         =>  $this->input->post('pf_ac_no'),

                "deduction_flag"   =>  $this->input->post('d_flag'),

                "cash_allow"       =>  0,

                "band_pay"         =>  $this->input->post('band_pay'),

                "grade_pay"        =>  $this->input->post('grade_pay'),

                "ma"               =>  $this->input->post('ma'),

                "p_tax_id"         =>  $this->input->post('p_tax_id'),

                "ir_pay"           =>  $this->input->post('ir_pay'),

                "modified_by"       =>  $this->session->userdata('loggedin')->user_name,

                "modified_dt"       =>  date('Y-m-d h:i:s')

            );  

            $where  =   array(
                
                "emp_code"         =>  $this->input->post('emp_code')
            );
            
            $this->session->set_flashdata('msg', 'Successfully updated!');

            $this->Payroll->f_edit('md_employee', $data_array, $where);

            redirect('payroll/employee');

        }

        else {

            //For Employee Details
            unset($select);
            $select = array ("emp_code", "emp_name", "emp_catg", "email", "phn_no",
                             "designation", "department", "location",
                             "pan_no", "bank_name", "bank_ac_no", "join_dt",
                             "pf_ac_no", "cash_allow", "band_pay", "deduction_flag",
                             "grade_pay", "ma", "p_tax_id", "ir_pay");


            $where = array(

                "emp_code"       =>  $this->input->get('emp_code')

            );

            //Category List 
            $employee['category_dtls']    =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

            //P-Tax List 
            $employee['ptax_dtls']        =   $this->Payroll->f_get_particulars("md_ptax_slab", NULL, NULL, 0);


            //Employee list
            $employee['employee_dtls']    =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 1);

            $this->load->view('post_login/main');

            $this->load->view("employee/edit", $employee);

            $this->load->view('post_login/footer');

        }

    }


    /******************For Double Salary Screen*****************/

    #In case if a employee's designation change in the middle of the month, the employee holds his/her both
    #previous designation's salary and current designation's salary.
    
    //Retriving employee's(active) who are holding double salary
    public function f_doublesal() {

        //Employee List
        $select = array("emp_code", "emp_name", "emp_catg",
                        "designation", "email");

        $doublesal['doublesal_dtls']    =   $this->Payroll->f_get_particulars("md_doublesal", $select, array('emp_status' => 'A'), 0);
        

        //Category List 
        $doublesal['category_dtls']    =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

        $this->load->view('post_login/main');

        $this->load->view("doublesal/dashboard", $doublesal);

        $this->load->view('post_login/footer');
        
    }


    //Adding selected employee's previous designation and other salary related details in the table md_doublesal
    public function f_doublesal_add() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {

            $emp_dtls   =   json_decode($this->input->post('emp_cd'));
             
            //Employee List
            $select = array("email", "phn_no", "pan_no",
                            "bank_name", "bank_ac_no", 
                            "pf_ac_no", "cash_allow");

            $doublesal  =   $this->Payroll->f_get_particulars("md_doublesal", $select, array('emp_code' => $emp_dtls->empid), 1);

            $data_array = array (

                "sal_month"        =>   $this->input->post('month'),

                "year"             =>   $this->input->post('year'),

                "emp_code"         =>  $emp_dtls->empid,

                "emp_name"         =>  $emp_dtls->empname,

                "emp_catg"         =>  $this->input->post('emp_catg'),
                
                "phn_no"           =>  (isset($doublesal))? $doublesal->phn_no : '',
                
                "email"            =>  (isset($doublesal))? $doublesal->email : '',
                
                "designation"      =>  $this->input->post('designation'),
                
                "department"       =>  $this->input->post('department'),

                "pan_no"           =>  (isset($doublesal))? $doublesal->pan_no : '',

                "bank_name"        =>  (isset($doublesal))? $doublesal->bank_name : '',

                "bank_ac_no"       =>  (isset($doublesal))? $doublesal->bank_ac_no : '',

                "pf_ac_no"         =>  (isset($doublesal))? $doublesal->pf_ac_no : '',

                "cash_allow"       =>  0,

                "band_pay"         =>  $this->input->post('band_pay'),

                "grade_pay"        =>  $this->input->post('grade_pay'),
                
                "ma"               =>  $this->input->post('ma'),

                "p_tax_id"         =>  $this->input->post('p_tax_id'),

                "ir_pay"           =>  $this->input->post('ir_pay'),

                "remarks"          =>  $this->input->post('remarks'),

                "emp_status"       =>  'A',
                
                "created_by"       =>  $this->session->userdata('loggedin')->user_name,

                "created_dt"       =>  date('Y-m-d h:i:s')

            );  

            $this->Payroll->f_insert('md_doublesal', $data_array);

            $this->session->set_flashdata('msg', 'Successfully added!');

            redirect('payroll/doublesal');

        }

        else {

            //Employee List
            $select = array("emp_code", "emp_name");

            $doublesal['doublesal_dtls']   =   $this->Payroll->f_get_particulars("md_employee", $select, NULL, 0);

            //Category List 
            $doublesal['category_dtls']    =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

            //P-Tax List 
            $doublesal['ptax_dtls']        =   $this->Payroll->f_get_particulars("md_ptax_slab", NULL, NULL, 0);

            //Month List
            $doublesal['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            
            //For Current Date
            $doublesal['sys_date']   =   $_SESSION['sys_date'];

            $this->load->view('post_login/main');

            $this->load->view("doublesal/add", $doublesal);

            $this->load->view('post_login/footer');

        }

    }


    //Edit selected employee's previous designation and other salary related details in the table md_doublesal    
    public function f_doublesal_edit(){

        if($_SERVER['REQUEST_METHOD'] == "POST") {

            $data_array = array (

                "sal_month"        =>   $this->input->post('month'),

                "year"             =>   $this->input->post('year'),

                "emp_name"         =>  $this->input->post('emp_name'),

                "emp_catg"         =>  $this->input->post('emp_catg'),
                
                "designation"      =>  $this->input->post('designation'),
                
                "department"       =>  $this->input->post('department'),

                "band_pay"         =>  $this->input->post('band_pay'),

                "grade_pay"        =>  $this->input->post('grade_pay'),

                "ma"               =>  $this->input->post('ma'),

                "p_tax_id"         =>  $this->input->post('p_tax_id'),

                "ir_pay"           =>  $this->input->post('ir_pay'),

                "remarks"          =>  $this->input->post('remarks'),

                "modified_by"      =>  $this->session->userdata('loggedin')->user_name,

                "modified_dt"      =>  date('Y-m-d h:i:s')

            );  

            $where  =   array(
                
                "emp_code"         =>  $this->input->post('emp_code')
            );
            
            $this->session->set_flashdata('msg', 'Successfully updated!');

            $this->Payroll->f_edit('md_doublesal', $data_array, $where);

            redirect('payroll/doublesal');

        }

        else {

            //For Employee Details
            $select = array ("sal_month", "year", "emp_code", "emp_name", 
                             "emp_catg","designation", "department", "pan_no",
                             "bank_name", "bank_ac_no",
                             "pf_ac_no", "cash_allow", "band_pay", 
                             "grade_pay", "ma", "p_tax_id", "ir_pay", "remarks");


            $where = array(

                "emp_code"       =>  $this->input->get('emp_code')

            );

            //Employee list
            $doublesal['doublesal_dtls']    =   $this->Payroll->f_get_particulars("md_doublesal", $select, $where, 1);

            //Category List 
            $doublesal['category_dtls']    =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

            //P-Tax List 
            $doublesal['ptax_dtls']        =   $this->Payroll->f_get_particulars("md_ptax_slab", NULL, NULL, 0);
            
            //Month List
            $doublesal['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            $this->load->view('post_login/main');

            $this->load->view("doublesal/edit", $doublesal);

            $this->load->view('post_login/footer');

        }

    }

    //Delete Employee from md_doublesal
    public function f_doublesal_delete(){

        $where = array(
            
            "emp_code"    =>  $this->input->get('empcd'),

            "emp_status"  =>  'A'
            
        );

        $this->session->set_flashdata('msg', 'Successfully Deleted!');

        $this->Payroll->f_delete('md_doublesal', $where);

        redirect("payroll/doublesal");

    }

    /*********************For Deduction Screen******************/
    //Salary Deduction List for all employees		
    public function f_deduction() {

            $deduction['deduction_dtls']    =   $this->Payroll->f_get_deduction();

            $this->load->view('post_login/main');

            $this->load->view("deduction/dashboard", $deduction);

            $this->load->view('post_login/footer');
        
    }

    //New Deduction Add for a particular employee 
    public function f_deduction_add() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {
            
            $sal_month  =   $this->input->post('month');

            $year       =   $this->input->post('year');

            $emp_dtls   =   json_decode($this->input->post('emp_cd'));

            $emp_cd     =   $emp_dtls->empid;

            $emp_name   =   $emp_dtls->empname;

            $category   =   $this->input->post('category');

            $gen_adv    =   $this->input->post('gen_adv');

            $gen_intt   =   $this->input->post('gen_intt');

            $fest_adv   =   $this->input->post('fest_adv');

            $lic        =   $this->input->post('lic');

            $itax       =   $this->input->post('itax');

            //For Current Date
            $sal_date   =   $_SESSION['sys_date'];
       
            if(!isset($gen_adv) || !isset($gen_intt) || !isset($fest_adv) || !isset($lic) || !isset($itax)) {

                $data_array = array (

                    "sal_yr"       =>  $year,
    
                    "sal_month"    =>  $sal_month,

                    "sal_date"     =>  $sal_date,
    
                    "emp_cd"       =>  $emp_cd,
    
                    "emp_name"     =>  $emp_name,

                    "emp_catg"     =>  $category,
    
                    "gen_adv"      =>  0,
    
                    "gen_intt"     =>  0,
    
                    "festival_adv" =>  0,
    
                    "lic"          =>  0,
    
                    "itax"         =>  0,
    
                    "created_by"   =>  $this->session->userdata('loggedin')->user_name,
    
                    "created_dt"   =>  date('Y-m-d h:i:s')
    
                );  

            }

            else {

		    $data_array = array (

		    "sal_yr"       =>  $year,		
    
                    "sal_month"    =>  $sal_month,

                    "sal_date"     =>  $sal_date,
    
                    "emp_cd"       =>  $emp_cd,
    
                    "emp_name"     =>  $emp_name,

                    "emp_catg"     =>  $category,
    
                    "gen_adv"      =>  $gen_adv,
    
                    "gen_intt"     =>  $gen_intt,
    
                    "festival_adv" =>  $fest_adv,
    
                    "lic"          =>  $lic,
    
                    "itax"         =>  $itax,
    
                    "created_by"   =>  $this->session->userdata('loggedin')->user_name,
    
                    "created_dt"   =>  date('Y-m-d h:i:s')
    
                );
            }

            $this->Payroll->f_insert('td_deductions', $data_array);

            $this->session->set_flashdata('msg', 'Successfully Added!');

            redirect('payroll/deduction');

        }

        else {
            
            //Month List
            $deduction['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            
            //For Current Date
            $deduction['sys_date']   =   $_SESSION['sys_date'];

            //For Employee List
            unset($select);
            $select = array ("emp_code", "emp_name", "emp_catg");

            $where  = array (

		    "emp_catg in (1,2,3)"  => null,
		     "emp_status"	   => 'A'

            );
	
	    //Employee List
            $deduction['emp_list']   =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            //Category List
	    $deduction['category']   =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

	    //Month List
	    $deduction['month']	     =   $this->Payroll->f_get_particulars("md_month", NULL, NULL, 0);

            $this->load->view('post_login/main');

            $this->load->view("deduction/add", $deduction);

            $this->load->view('post_login/footer');

        }

    }


    //Edit Deduction Add for a particular employee 
    public function f_deduction_edit(){

        if($_SERVER['REQUEST_METHOD'] == "POST") {
            
            $sal_month  =   $this->input->post('sal_month');

            $year       =   $this->input->post('sal_yr');

            $sal_date   =   $this->input->post('sal_date');

            $emp_cd     =   $this->input->post('emp_cd');

            $emp_name   =   $this->input->post('empname');

            $gen_adv    =   $this->input->post('gen_adv');

            $gen_intt   =   $this->input->post('gen_intt');

            $fest_adv   =   $this->input->post('fest_adv');

            $lic        =   $this->input->post('lic');

            $itax       =   $this->input->post('itax');


            $data_array = array (

                "sal_yr"       =>  $year,

                "sal_month"    =>  $sal_month,

                "sal_date"     =>  $sal_date,

                "emp_cd"       =>  $emp_cd,

                "emp_name"     =>  $emp_name,

                "gen_adv"      =>  $gen_adv,

                "gen_intt"     =>  $gen_intt,

                "festival_adv" =>  $fest_adv,

                "lic"          =>  $lic,

                "itax"         =>  $itax,

                "modified_by"  =>  $this->session->userdata('loggedin')->user_name,

                "modified_dt"  =>  date('Y-m-d h:i:s')

            );

            $where = array(

                "emp_cd"       =>  $emp_cd,

                "sal_date"     =>  $sal_date

            );
            
            $this->session->set_flashdata('msg', 'Successfully Updated!');

            $this->Payroll->f_edit('td_deductions', $data_array, $where);

            redirect('payroll/deduction');

        }

        else {

            $where = array(

                "sal_date"    =>  $this->input->get('month'),

                "emp_cd"       =>  $this->input->get('emp_cd')

            );


            //Month List
            $deduction['month_list'] =   $this->Payroll->f_get_particulars("md_month", NULL, NULL, 0);
            
            //Deduction list of latest month
            $deduction['deduction_dtls']    =   $this->Payroll->f_get_particulars("td_deductions", NULL, $where, 1);

            $this->load->view('post_login/main');

            $this->load->view("deduction/edit", $deduction);

            $this->load->view('post_login/footer');

        }
    }

    //Deduction Delete for a particular employee
    public function f_deduction_delete(){

        $where = array(
            
            "emp_cd"    =>  $this->input->get('empcd'),

            "sal_date"  =>  $this->input->get('saldate')
            
        );

        $this->session->set_flashdata('msg', 'Successfully Deleted!');

        $this->Payroll->f_delete('td_deductions', $where);

        redirect("payroll/deduction");
        
    }


    /**********************For Attendance**********************/
    #Attendances for Daily Wages(Category) Employees
    #Based on there attendances salary generate
    
    //Retriving attendance list for Daily Wages Employees from the table td_attendance
    public function f_attendance() {

        $attendance['attendance_dtls']    =   $this->Payroll->f_get_attendance();

        $this->load->view('post_login/main');

        $this->load->view("attendance/dashboard", $attendance);
        
        $this->load->view('post_login/footer');
        
    }

    //Add New Attendance for a particular Daily wages employees in the table td_attendance
    public function f_attendance_add() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {

            $trans_dt   =   $this->input->post('trans_dt');
            
            $sal_month  =   $this->input->post('sal_month');

            $year       =   $this->input->post('sal_yr');

            $emp_dtls   =   json_decode($this->input->post('emp_cd'));

            $emp_cd     =   $emp_dtls->empid;

            $emp_name   =   $emp_dtls->empname;

            $category   =   $this->input->post('category');

            $attendance =   $this->input->post('attendance');       
            

            $data_array = array (

                "trans_dt"     =>  $trans_dt,

                "sal_year"     =>  $year,

                "sal_month"    =>  $sal_month,

                "emp_cd"       =>  $emp_cd,

                "emp_name"     =>  $emp_name,

                "emp_catg"     =>  $category,

                "no_of_days"   =>  $attendance,

                "created_by"   =>  $this->session->userdata('loggedin')->user_name,

                "created_dt"   =>  date('Y-m-d h:i:s')

            );

            $this->Payroll->f_insert('td_attendance', $data_array);

            $this->session->set_flashdata('msg', 'Successfully added!');

            redirect('payroll/attendance');

        }

        else {
            
            //Month List
            $attendance['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            //For Current Date
            $attendance['sys_date']   =   $_SESSION['sys_date'];

            //Employee List
            unset($select);
            $select = array ("emp_code", "emp_name", "emp_catg");

            $where  = array (

                "emp_catg in (3)"  => null

            );

            $attendance['emp_list']   =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            //Category List
            $attendance['category']   =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

            $this->load->view('post_login/main');

            $this->load->view("attendance/add", $attendance);

            $this->load->view('post_login/footer');

        }

        

    }

    //Edit Attendance for a particular Daily wages employees in the table td_attendance
    public function f_attendance_edit(){

        if($_SERVER['REQUEST_METHOD'] == "POST") {
 
            $trans_dt   =   $this->input->post('trans_dt');
            
            $year       =   $this->input->post('sal_yr');

            $sal_month  =   $this->input->post('sal_month');
            
            $emp_cd     =   $this->input->post('emp_cd');

            $emp_name   =   $this->input->post('empname');

            $attendance =   $this->input->post('attendance'); 
            

            $data_array = array (

                "trans_dt"     =>  $trans_dt,

                "sal_year"     =>  $year,

                "sal_month"    =>  $sal_month,

                "emp_cd"       =>  $emp_cd,

                "emp_name"     =>  $emp_name,

                "no_of_days"   =>  $attendance,

                "modified_by"   =>  $this->session->userdata('loggedin')->user_name,

                "modified_dt"   =>  date('Y-m-d h:i:s')

            );

            $where = array(

                "emp_cd"       =>  $emp_cd,

                "trans_dt"     =>  $trans_dt

            );

            
            $this->session->set_flashdata('msg', 'Successfully updated!');

            $this->Payroll->f_edit('td_attendance', $data_array, $where);

            redirect('payroll/attendance');

        }

        else {

            $where = array(

                "trans_dt"    =>  $this->input->get('month'),

                "emp_cd"       =>  $this->input->get('emp_cd')

            );

            //Month List
            $attendance['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            $attendance['attendance_dtls']    =   $this->Payroll->f_get_particulars("td_attendance", NULL, $where, 1);

            $this->load->view('post_login/main');

            $this->load->view("attendance/edit", $attendance);

            $this->load->view('post_login/footer');

        }
    }

    //Attendance Delete
    public function f_attendance_delete(){

        $where = array(
            
            "emp_cd"    =>  $this->input->get('empcd'),

            "trans_dt"  =>  $this->input->get('saldate')
            
        );

        $this->session->set_flashdata('msg', 'Successfully deleted!');

        $this->Payroll->f_delete('td_attendance', $where);

        redirect("payroll/attendance");
        
    }

    /*********************For Payslip Generation Screen****************/
    #In Payslip Generation we generate pay slips for all the Regular, Contructual & Daily Wages Employees

    //List of Payslip generation unapproved details from table td_salary
    public function f_generation() {

        //Bank List
        $generation['bank']	            =   $this->Payroll->f_get_particulars("md_bank", NULL, NULL, 0);			
        
        //Generation Details
        $generation['generation_dtls']  =   $this->Payroll->f_get_particulars("td_salary", NULL, array( "approval_status" => 'U'), 0);

        //Category List
        $generation['category']         =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

        $this->load->view('post_login/main');

        $this->load->view("generation/dashboard", $generation);

        $this->load->view('post_login/footer');

    }
    
    //New Payslip Generation Add for a particular category
    public function f_generation_add() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {

            $trans_dt     =   $this->input->post('trans_dt');

            $sal_month    =   $this->input->post('month');

            $year         =   $this->input->post('year');

            $category     =   $this->input->post('category');

            //Check given category exsit or not
            //for given month and date
            $select     =   array("catg_cd");

            $where      =   array(

                "catg_cd"       =>  $category,
                
                "sal_month"     =>  $sal_month,

                "sal_year"      =>  $year
            
            );

            $flag     =   $this->Payroll->f_get_particulars("td_salary", $select, $where, 1);

            if($flag) {

                $this->session->set_flashdata('msg', 'For this month and category Payslip already generated!');

            }

            else {

                //Retrive max trans no
                $select     =   array("MAX(trans_no) trans_no");

                $where      =   array(

                    "trans_date"    =>  $trans_dt,
                    
                    "sal_month"     =>  $sal_month,

                    "sal_year"      =>  $year
                
                );
                
                $trans_no     =   $this->Payroll->f_get_particulars("td_salary", $select, $where, 1);

                $data_array = array (

                    "trans_date"   =>  $trans_dt,

                    "trans_no"     =>  ($trans_no != NULL)? ($trans_no->trans_no + 1):'1',
    
                    "sal_month"    =>  $sal_month,

                    "sal_year"     =>  $year,

                    "catg_cd"      =>  $category,

                    "bank"         =>  $this->input->post('bank'), 

                    "chq_no"       =>  $this->input->post('chq_no'), 

                    "chq_dt"       =>  $this->input->post('chq_dt'), 

                    "trans_type"   =>  $this->input->post('trans_type'),
    
                    "created_by"   =>  $this->session->userdata('loggedin')->user_name,
    
                    "created_dt"   =>  date('Y-m-d')
    
                );
    
                $this->Payroll->f_insert("td_salary", $data_array);


                /*


                    For double Salary Generation


                */

                //For those Employees who have double salary in the current payslip generation month and year
                $select = array ("sal_month", "year", "emp_code", "emp_name", 
                                 "emp_catg", "designation", "department", "pan_no",
                                 "bank_name", "bank_ac_no",
                                 "pf_ac_no", "cash_allow", "band_pay", 
                                 "grade_pay", "ma", "p_tax_id", "ir_pay", "remarks");


                $where = array(

                            "sal_month"       =>  $sal_month,

                            "year"            =>  $year,

                            "emp_catg"         =>  $category,

                            "emp_status"      =>  "A"

                        );
                
                        
                //Retriving Employee list
                $emp_dtls    =   $this->Payroll->f_get_particulars("md_doublesal", $select, $where, 0);
                
                //If Present then employee(s) details will inserted in the td_pay_slip table
                if($emp_dtls) {

                    unset($data_array);

                    foreach($emp_dtls as $e_list) {

                        $data_array  =   array(

                            "trans_date"        =>  $trans_dt,
        
                            "trans_no"          =>  ($trans_no != NULL)? ($trans_no->trans_no + 1):'1',
        
                            "sal_month"         =>  $sal_month,
        
                            "sal_year"          =>  $year,
        
                            "emp_no"            =>  $e_list->emp_code,
        
                            "emp_name"          =>  $e_list->emp_name,
        
                            "emp_catg"          =>  $e_list->emp_catg,
        
                            "designation"       =>  $e_list->designation,
        
                            "band_pay"          =>  $e_list->band_pay,
        
                            "grade_pay"         =>  $e_list->grade_pay,
        
                            // "basic_pay"       =>  $basic = round($e_list->band_pay + $e_list->grade_pay),
                            "basic_pay"         =>  $basic = round($e_list->band_pay ),
                            
        
                            "da"                =>  $basic,
        
                            "ir"                =>  $e_list->ir_pay,
        
                            "hra"               =>  $hra = round(($basic * 15) / 100),
        
                            "ma"                =>  $e_list->ma,
        
                            "cash_allow"        =>  $e_list->cash_allow,
        
                            "gross"             =>  $gross = (2 * $basic) + $hra + $e_list->ma + $e_list->ir_pay + $e_list->cash_allow,
        
                            "pf"                =>  $pf = round((2 * $basic  * 12) / 100),
        
                            "ptax"              =>  $ptax = $e_list->p_tax_id,
        
                            "tot_deduction"     =>  $pf + $ptax,
        
                            "net_amount"        =>  $gross - ($pf + $ptax),
        
                            "remarks"           =>  $e_list->remarks
        
                        );

                        $this->Payroll->f_insert("td_pay_slip", $data_array);

                    }

                }

                $this->session->set_flashdata('msg', 'Successfully generated!');

            }

            redirect('payroll/generation');


        }

        else {

            //Month List
            $generation['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            //For Current Date
            $generation['sys_date']   =   $_SESSION['sys_date'];

            //Last payslip generation date
            $generation['generation_dtls']    =   $this->Payroll->f_get_generation();

            //Category List
	        $generation['category']   =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);

            //Bank List
            $generation['bank']	      =   $this->Payroll->f_get_particulars("md_bank", NULL, NULL, 0);			
                

            $this->load->view('post_login/main');

            $this->load->view("generation/add", $generation);

            $this->load->view('post_login/footer');

        }
        
    }


    //Payslip Genaration Edit
    public function f_generation_edit() {

        if($_SERVER['REQUEST_METHOD'] == 'POST') {
            
            $where      = array(

                "trans_date"   => $this->input->post('trans_dt'),

                "sal_month"    => $this->input->post('month'),

                "sal_year"     => $this->input->post('year'),

                "trans_no"     => $this->input->post('trans_no')

            );
            

            $data_array = array (

                "bank"          =>  $this->input->post('bank'),

                "trans_type"    =>  $this->input->post('trans_type'),

                "chq_no"        =>  $this->input->post('chq_no'),

                "chq_dt"        =>  $this->input->post('chq_dt')

            );

            $this->Payroll->f_edit('td_salary', $data_array, $where);

            $this->session->set_flashdata('msg', 'Successfully updated!');

            redirect('payroll/generation');
            

        }
        else{

            //Particular Generated Details
            $where  =   array(

                "trans_no"      =>  $this->input->get('trans_no'),

                "sal_month"     =>  $this->input->get('month'),

                "sal_year"      =>  $this->input->get('year')

            );

            $generation['generation_dtls']  =   $this->Payroll->f_get_particulars("td_salary", NULL, $where, 1);

            //Month List
            $generation['month_list']       =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);
            
            //Bank List
            $generation['bank']	            =   $this->Payroll->f_get_particulars("md_bank", NULL, NULL, 0);			
             
            $this->load->view('post_login/main');

            $this->load->view("generation/edit", $generation);

            $this->load->view('post_login/footer');

        }

    }

    //Payslip Genaration Delete
    public function f_generation_delete() {

        $where  =   array(

            "trans_date"    =>   $this->input->get('date'),
            
            "trans_no"      =>   $this->input->get('trans_no'),
            
            "sal_month"     =>   $this->input->get('month'),

            "sal_year"      =>   $this->input->get('year')

        );

        $this->Payroll->f_delete("td_pay_slip", $where);

        $this->Payroll->f_delete("tm_pf_dtls", array("trans_dt" => $this->input->get('date'), "trans_no" => $this->input->get('trans_no')));

        $this->Payroll->f_delete("td_salary", $where);

        $this->session->set_flashdata('msg', 'Successfully Deleted!');

        redirect('payroll/generation');

    }


    /*********************For Bonus Screen*********************/

    public function f_bonus() {

        $bonus['bonus_dtls']    =   $this->Payroll->f_get_bonus();

        $this->load->view('post_login/main');

        $this->load->view("bonus/dashboard", $bonus);

        $this->load->view('post_login/footer');
        
    }


    //Bonus Add

    public function f_bonus_add() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {
            
            $sal_month  =   date('F', strtotime($sal_date));

            $year       =   date('Y', strtotime($sal_date));

            $emp_dtls   =   json_decode($this->input->post('emp_no'));

            $emp_no     =   $emp_dtls->empid;

            $emp_name   =   $emp_dtls->empname;

            //Gross Salary for the given employee
            $max_trans_dt=   $this->Payroll->f_get_particulars("td_pay_slip", array("MAX(trans_date) trans_date"), array("emp_no" => $emp_no), 1);

            $gross      =   $this->Payroll->f_get_particulars("td_pay_slip", array("gross"), array("emp_no" => $emp_no, "trans_date" => $max_trans_dt->trans_date), 1);

            //Bonus Salary Range
            $sal_range  =   $this->Payroll->f_get_particulars("md_parameters", array('param_value'), array('sl_no' => 14), 1);

            //Checking if Gross Salary greater than 25000, then he/she cant'afford Bonus
            if(($gross->gross > $sal_range->param_value) && ($this->input->post('bonus_type')) == 'B') {

                $this->session->set_flashdata('msg', "Sorry! this person can not take bonus for puja.");

                redirect('payroll/bonus');

            }//Checking if Gross Salary less than 25000, then he/she cant'afford Advance

            else if(($gross->gross <= $sal_range->param_value) && ($this->input->post('bonus_type')) == 'A') {

                $this->session->set_flashdata('msg', "Sorry! this person can not take advance for puja.");

                redirect('payroll/bonus');

            }
            
            else {

                //For Current Date
                $sal_date   =   $_SESSION['sys_date'];
            
                $data_array = array (

                    "year"         =>  $year,

                    "month"        =>  $sal_month,

                    "trans_dt"     =>  $sal_date,

                    "emp_no"       =>  $emp_no,

                    "emp_name"     =>  $emp_name,

                    "bonus_flag"   =>  $this->input->post('bonus_type'),

                    "amount"       =>  $this->input->post('amount'),

                    "created_by"   =>  $this->session->userdata('loggedin')->user_name,

                    "created_dt"   =>  date('Y-m-d h:i:s')

                );  

                $this->Payroll->f_insert('td_bonus', $data_array);

                $this->session->set_flashdata('msg', 'Successfully added!');

                redirect('payroll/bonus');

            }

        }

        else {
            
            //Month List
            $bonus['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            
            //For Current Date
            $bonus['sys_date']   =   $_SESSION['sys_date'];

            //For Employee List
            unset($select);
            $select = array ("emp_code", "emp_name");

            $where  = array (

                "emp_catg in (1,2,3)"  => null

            );

            $bonus['emp_list']   =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            $this->load->view('post_login/main');

            $this->load->view("bonus/add", $bonus);

            $this->load->view('post_login/footer');

        }

    }


    //Bonus Edit
    public function f_bonus_edit(){

        if($_SERVER['REQUEST_METHOD'] == "POST") {
            
            $sal_month  =   $this->input->post('month');

            $year       =   $this->input->post('year');

            $sal_date   =   $this->input->post('trans_dt');

            $emp_no     =   $this->input->post('emp_no');

            $emp_name   =   $this->input->post('empname');

            $bonus_type =   $this->input->post('bonus_type');

            $amount     =   $this->input->post('amount');


            $data_array = array (

                "year"         =>  $year,

                "month"        =>  $sal_month,

                "trans_dt"     =>  $sal_date,

                "emp_no"       =>  $emp_no,

                "emp_name"     =>  $emp_name,

                "bonus_flag"   =>  $bonus_type,

                "amount"       =>  $amount,

                "modified_by"   =>  $this->session->userdata('loggedin')->user_name,

                "modified_dt"   =>  date('Y-m-d h:i:s')

            );

            $where = array(

                "emp_no"       =>  $emp_no,

                "trans_dt"     =>  $sal_date

            );
            
            $this->session->set_flashdata('msg', 'Successfully updated!');

            $this->Payroll->f_edit('td_bonus', $data_array, $where);

            redirect('payroll/bonus');

        }

        else {

            $where = array(

                "trans_dt"     =>  $this->input->get('month'),

                "emp_no"       =>  $this->input->get('emp_no')

            );


            //Month List
            $bonus['month_list'] =   $this->Payroll->f_get_particulars("md_month", NULL, NULL, 0);
            
            //Bonus list of latest month
            $bonus['bonus_dtls']    =   $this->Payroll->f_get_particulars("td_bonus", NULL, $where, 1);

            $this->load->view('post_login/main');

            $this->load->view("bonus/edit", $bonus);

            $this->load->view('post_login/footer');

        }

    }

    //Bonus Delete for a particular employee
    public function f_bonus_delete(){

        $where = array(
            
            "emp_no"    =>  $this->input->get('empcd'),

            "trans_dt"  =>  $this->input->get('saldate')
            
        );

        $this->session->set_flashdata('msg', 'Successfully deleted!');

        $this->Payroll->f_delete('td_bonus', $where);

        redirect("payroll/bonus");
        
    }


    /******************For Incentive Screen*****************/
    #inactive employees are not eligible for any payroll functionalities

    //Retriving inactive employee list
    public function f_incentive() {

        $incentive['incentive_dtls']    =   $this->Payroll->f_get_incentive();

        $this->load->view('post_login/main');

        $this->load->view("incentive/dashboard", $incentive);

        $this->load->view('post_login/footer');
        
    }


    //Add New Incentive Employee
    public function f_incentive_add() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {
            
            $sal_month  =   $this->input->post('sal_month');

            $year       =   $this->input->post('sal_yr');

            $emp_dtls   =   json_decode($this->input->post('emp_no'));

            $emp_no     =   $emp_dtls->empid;

            $emp_name   =   $emp_dtls->empname;

            //For Current Date
            $sal_date   =   $_SESSION['sys_date'];
            
            $data_array = array (

                "year"         =>  $year,

                "month"        =>  $sal_month,

                "trans_dt"     =>  $sal_date,

                "emp_no"       =>  $emp_no,

                "emp_name"     =>  $emp_name,

                "amount"       =>  $this->input->post('amount'),

                "created_by"   =>  $this->session->userdata('loggedin')->user_name,

                "created_dt"   =>  date('Y-m-d h:i:s')

            );  

            $this->Payroll->f_insert('td_incentive', $data_array);

            $this->session->set_flashdata('msg', 'Successfully added!');

            redirect('payroll/incentive');

        }

        else {
            
            //Month List
            $incentive['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            
            //For Current Date
            $incentive['sys_date']   =   $_SESSION['sys_date'];

            //For Employee List
            unset($select);
            $select = array ("emp_code", "emp_name");

            $where  = array (

                "emp_catg"  =>  4
            );

            $incentive['emp_list']   =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            $this->load->view('post_login/main');

            $this->load->view("incentive/add", $incentive);

            $this->load->view('post_login/footer');

        }

    }


    //Incentive Employee Edit
    public function f_incentive_edit(){

        if($_SERVER['REQUEST_METHOD'] == "POST") {
            
            $sal_month  =   $this->input->post('month');

            $year       =   $this->input->post('year');

            $sal_date   =   $this->input->post('trans_dt');

            $emp_no     =   $this->input->post('emp_no');

            $emp_name   =   $this->input->post('empname');

            $incentive_type =   $this->input->post('incentive_type');

            $amount     =   $this->input->post('amount');

            $data_array = array (

                "year"         =>  $year,

                "month"        =>  $sal_month,

                "trans_dt"     =>  $sal_date,

                "emp_no"       =>  $emp_no,

                "emp_name"     =>  $emp_name,

                "amount"       =>  $amount,

                "modified_by"   =>  $this->session->userdata('loggedin')->user_name,

                "modified_dt"   =>  date('Y-m-d h:i:s')

            );

            $where = array(

                "emp_no"       =>  $emp_no,

                "trans_dt"     =>  $sal_date

            );
            
            $this->session->set_flashdata('msg', 'Successfully updated!');

            $this->Payroll->f_edit('td_incentive', $data_array, $where);

            redirect('payroll/incentive');

        }

        else {

            $where = array(

                "trans_dt"     =>  $this->input->get('month'),

                "emp_no"       =>  $this->input->get('emp_no')

            );

            //Month List
            $incentive['month_list'] =   $this->Payroll->f_get_particulars("md_month", NULL, NULL, 0);
            
            //incentive list of latest month
            $incentive['incentive_dtls']    =   $this->Payroll->f_get_particulars("td_incentive", NULL, $where, 1);

            $this->load->view('post_login/main');

            $this->load->view("incentive/edit", $incentive);

            $this->load->view('post_login/footer');

        }

    }

    //Incentive Delete
    public function f_incentive_delete(){

        $where = array(
            
            "emp_no"    =>  $this->input->get('empcd'),

            "trans_dt"  =>  $this->input->get('saldate')
            
        );

        $this->session->set_flashdata('msg', 'Successfully deleted!');

        $this->Payroll->f_delete('td_incentive', $where);

        redirect("payroll/incentive");
        
    }


    /******************For Priodic Increment Screen**************/

    public function f_increment() {

        //MAX Transaction Date
        $increment['increment_dtls']   =   $this->Payroll->f_get_increment();

        $this->load->view('post_login/main');

        $this->load->view("increment/dashboard", $increment);

        $this->load->view('post_login/footer');
        
    }


    //Priodic Increment Add

    public function f_increment_add() {


        if($_SERVER['REQUEST_METHOD'] == "POST") {
            
            $eff_date   =   $this->input->post('effective_date');

            $emp_dtls   =   json_decode($this->input->post('emp_no'));

            $emp_no     =   $emp_dtls->empid;

            $emp_name   =   $emp_dtls->empname;

            
            $data_array = array (

                "effective_dt" =>  $eff_date,

                "emp_cd"       =>  $emp_no,

                "emp_name"     =>  $emp_name,

                "band_pay"     =>  $this->input->post('band_pay'),

                "grade_pay"    =>  $this->input->post('grade_pay'),

                "ir_amt"       =>  $this->input->post('ir')

            );  

            $this->Payroll->f_insert('md_basic_pay', $data_array);

            $this->session->set_flashdata('msg', 'Successfully added!');

            redirect('payroll/increment');

        }

        else {
            
            //For Current Date
            $increment['sys_date']   =   $_SESSION['sys_date'];

            //For Employee List
            unset($select);
            $select = array ("emp_code", "emp_name");

            $where  = array (

                "emp_catg"  =>  1
            );

            $increment['emp_list']   =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            $this->load->view('post_login/main');

            $this->load->view("increment/add", $increment);

            $this->load->view('post_login/footer');

        }

    }


    /******************For Stop Salary Screen**************/

    public function f_stopsalary() {

        //MAX Transaction Date
        $stopsalary['stopsalary_dtls']   =   $this->Payroll->f_get_stopsalary();

        $this->load->view('post_login/main');

        $this->load->view("stopsalary/dashboard", $stopsalary);

        $this->load->view('post_login/footer');
        
    }


    //Stop Salary Add
    public function f_stopsalary_add() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {
            
            $trans_dt   =   $this->input->post('trans_dt');

            $emp_dtls   =   json_decode($this->input->post('emp_no'));

            $emp_no     =   $emp_dtls->empid;

            $emp_name   =   $emp_dtls->empname;
            
            $data_array = array (

                "trans_dt"     =>  $trans_dt,

                "emp_no"       =>  $emp_no,

                "emp_name"     =>  $emp_name,

                "status"       =>  $this->input->post('status'),
                
                "remarks"      =>  $this->input->post('remarks'),
                
                "created_by"   =>  $this->session->userdata('loggedin')->user_name,

                "created_dt"   =>  date('Y-m-d h:i:s')

            );  

            $this->Payroll->f_insert('td_stop_salary', $data_array);

            $this->session->set_flashdata('msg', 'Successfully added!');

            redirect('payroll/stopsalary');

        }

        else {
            
            //For Current Date
            $stopsalary['sys_date']   =   $_SESSION['sys_date'];

            //For Employee List
            unset($select);
            $select = array ("emp_code", "emp_name");

            $where  = array (

                "emp_catg in (1,2,3)"  =>  NULL
            );

            $stopsalary['emp_list']   =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            $this->load->view('post_login/main');

            $this->load->view("stopsalary/add", $stopsalary);

            $this->load->view('post_login/footer');

        }

    }


  /*************************REPORTS**************************/

    //For Categorywise Salary Report
    public function f_salary_report() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {


            //Employee Ids for Salary List
            $select     =   array("emp_code");

            $where      =   array(

                "emp_catg"  =>  $this->input->post('category')

            );

            $emp_id     =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            //Temp variable for emp_list
            $eid_list   =   [];

            for($i = 0; $i < count($emp_id); $i++) {

                array_push($eid_list, $emp_id[$i]->emp_code);

            }


            //List of Salary Category wise
            unset($where);
            $where = array (

                "sal_month"     =>  $this->input->post('sal_month'),

                "sal_year"      =>  $this->input->post('year')

            );

            $salary['list']               =   $this->Payroll->f_get_particulars_in("td_pay_slip", $eid_list, $where);

            $salary['attendance_dtls']    =   $this->Payroll->f_get_attendance();

            //Employee Group Count
            unset($select);
            unset($where);

            $select =   array(

                "emp_no", "emp_name", "COUNT(emp_name) count"

            );

            $where  =   array(

                "sal_month"     =>  $this->input->post('sal_month'),

                "sal_year = '".$this->input->post('year')."' GROUP BY emp_no, emp_name"      =>  NULL

            );

            $salary['count']              =   $this->Payroll->f_get_particulars("td_pay_slip", $select, $where, 0);

            $this->load->view('post_login/main');

            $this->load->view("reports/salary", $salary);

            $this->load->view('post_login/footer');

        }

        else {

            //Month List
            $salary['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            //For Current Date
            $salary['sys_date']   =   $_SESSION['sys_date'];

            //Category List
            $salary['category']   =   $this->Payroll->f_get_particulars("md_category", NULL, array('category_code IN (1,2,3)' => NULL), 0);

            $this->load->view('post_login/main');

            $this->load->view("reports/salary", $salary);

            $this->load->view('post_login/footer');

        }

    }
//////////////////////////////////////////////////////////////////////////
public function f_salaryold_report() {

    if($_SERVER['REQUEST_METHOD'] == "POST") {


        //Employee Ids for Salary List
        $select     =   array("emp_code");

        $where      =   array(

            "emp_catg"  =>  $this->input->post('category')

        );

        $emp_id     =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

        //Temp variable for emp_list
        $eid_list   =   [];

        for($i = 0; $i < count($emp_id); $i++) {

            array_push($eid_list, $emp_id[$i]->emp_code);

        }


        //List of Salary Category wise
        unset($where);
        $where = array (

            "sal_month"     =>  $this->input->post('sal_month'),

            "sal_year"      =>  $this->input->post('year')

        );

        $salary['list']               =   $this->Payroll->f_get_particulars_in("td_pay_slip_old ", $eid_list, $where);

        $salary['attendance_dtls']    =   $this->Payroll->f_get_attendance();

        //Employee Group Count
        unset($select);
        unset($where);

        $select =   array(

            "emp_no", "emp_name", "COUNT(emp_name) count"

        );

        $where  =   array(

            "sal_month"     =>  $this->input->post('sal_month'),

            "sal_year = '".$this->input->post('year')."' GROUP BY emp_no, emp_name"      =>  NULL

        );

        $salary['count']              =   $this->Payroll->f_get_particulars("td_pay_slip_old ", $select, $where, 0);

        $this->load->view('post_login/main');

        $this->load->view("reports/salaryold", $salary);

        $this->load->view('post_login/footer');

    }

    else {

        //Month List
        $salary['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

        //For Current Date
        $salary['sys_date']   =   $_SESSION['sys_date'];

        //Category List
        $salary['category']   =   $this->Payroll->f_get_particulars("md_category", NULL, array('category_code IN (1,2,3)' => NULL), 0);

        $this->load->view('post_login/main');

        $this->load->view("reports/salaryold", $salary);

        $this->load->view('post_login/footer');

    }

}
//////////////////////////////////////////////////////////////////////////
    //For Payslip Report
    public function f_payslip_report() {

        if($_SERVER['REQUEST_METHOD'] == "POST") {

            //Payslip
            $where  =   array(

                "emp_no"            =>  $this->input->post('emp_cd'),

                "sal_month"         =>  $this->input->post('sal_month'),

                "sal_year"          =>  $this->input->post('year'),

                "approval_status"   =>  'A'

            );

            $payslip['emp_dtls']    =   $this->Payroll->f_get_particulars("md_employee", NULL, array("emp_code" =>  $this->input->post('emp_cd')), 1);

            $payslip['payslip_dtls']=   $this->Payroll->f_get_particulars("td_pay_slip", NULL, $where, 1);

            $this->load->view('post_login/main');

            $this->load->view("reports/payslip", $payslip);

            $this->load->view('post_login/footer');

        }
        
        else {

            //Month List
            $payslip['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            //For Current Date
            $payslip['sys_date']   =   $_SESSION['sys_date'];

            //Employee List
            unset($select);
            $select = array ("emp_code", "emp_name");

            $payslip['emp_list']   =   $this->Payroll->f_get_particulars("md_employee", $select, array("emp_catg IN (1,2,3)" => NULL), 0);

            $this->load->view('post_login/main');

            $this->load->view("reports/payslip", $payslip);

            $this->load->view('post_login/footer');
            
        }

    }

//////////////////////////////////////////////////////////////////

public function f_payslipold_report() {

    if($_SERVER['REQUEST_METHOD'] == "POST") {

        //Payslip
        $where  =   array(

            "emp_no"            =>  $this->input->post('emp_cd'),

            "sal_month"         =>  $this->input->post('sal_month'),

            "sal_year"          =>  $this->input->post('year'),

            "approval_status"   =>  'A'

        );

        $payslip['emp_dtls']    =   $this->Payroll->f_get_particulars("md_employee", NULL, array("emp_code" =>  $this->input->post('emp_cd')), 1);

        $payslip['payslip_dtls']=   $this->Payroll->f_get_particulars("td_pay_slip_old ", NULL, $where, 1);

        $this->load->view('post_login/main');

        $this->load->view("reports/payslipold", $payslip);

        $this->load->view('post_login/footer');

    }
    
    else {

        //Month List
        $payslip['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

        //For Current Date
        $payslip['sys_date']   =   $_SESSION['sys_date'];

        //Employee List
        unset($select);
        $select = array ("emp_code", "emp_name");

        $payslip['emp_list']   =   $this->Payroll->f_get_particulars("md_employee", $select, array("emp_catg IN (1,2,3)" => NULL), 0);

        $this->load->view('post_login/main');

        $this->load->view("reports/payslipold", $payslip);

        $this->load->view('post_login/footer');
        
    }

}

    //For Salary Statement
    public function f_statement_report(){

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

                "m.emp_status"          =>  'A',

                "m.deduction_flag"      =>  'Y'

            );

            $statement['statement'] =   $this->Payroll->f_get_particulars("md_employee m, td_pay_slip t", $select, $where, 0);

            $this->load->view('post_login/main');

            $this->load->view("reports/statement", $statement);

            $this->load->view('post_login/footer');

        }

        else {

            //Month List
            $statement['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            //Category List
            $statement['category']   =   $this->Payroll->f_get_particulars("md_category", NULL, array('category_code IN (1,2,3)' => NULL), 0);

            $this->load->view('post_login/main');

            $this->load->view("reports/statement", $statement);

            $this->load->view('post_login/footer');

        }

    }
//////////////////////////////////////
public function f_statementold_report(){

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

            "m.emp_status"          =>  'A',

            "m.deduction_flag"      =>  'Y'

        );

        $statement['statement'] =   $this->Payroll->f_get_particulars("md_employee m, td_pay_slip t", $select, $where, 0);

        $this->load->view('post_login/main');

        $this->load->view("reports/statementold", $statement);

        $this->load->view('post_login/footer');

    }

    else {

        //Month List
        $statement['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

        //Category List
        $statement['category']   =   $this->Payroll->f_get_particulars("md_category", NULL, array('category_code IN (1,2,3)' => NULL), 0);

        $this->load->view('post_login/main');

        $this->load->view("reports/statementold", $statement);

        $this->load->view('post_login/footer');

    }

}



////////////////////////////////////////

    //For Bonus Report
    public function f_bonus_report() {

        if($_SERVER['REQUEST_METHOD'] == 'POST') {

            //Employee Ids for Bonus
            $select     =   array("emp_code");

            $where      =   array(

                "emp_catg"  =>  $this->input->post('category')

            );

            $emp_id     =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            //Temp variable for emp_list
            $eid_list   =   [];

            for($i = 0; $i < count($emp_id); $i++) {

                array_push($eid_list, $emp_id[$i]->emp_code);

            }


            //List of Bonus Category wise
            unset($where);
            $where = array (

                "month"     =>  $this->input->post('month'),

                "year"      =>  $this->input->post('year')

            );

            $bonus['list']          =   $this->Payroll->f_get_particulars_in("td_bonus", $eid_list, $where);

            $bonus['bonus_dtls']    =   $this->Payroll->f_get_attendance();

            //Bonus Salary Range
            $bonus['bonus_range']  =   $this->Payroll->f_get_particulars("md_parameters", array('param_value'), array('sl_no' => 14), 1);

            //Bonus Salary Year
            $bonus['bonus_year']  =   $this->Payroll->f_get_particulars("md_parameters", array('param_value'), array('sl_no' => 15), 1);

            $this->load->view('post_login/main');

            $this->load->view("reports/bonus", $bonus);

            $this->load->view('post_login/footer');

        }

        else {

            //Month List
            $bonus['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            //For Current Date
            $bonus['sys_date']   =   $_SESSION['sys_date'];

            //Category List
            $bonus['category']   =   $this->Payroll->f_get_particulars("md_category", NULL, NULL, 0);


            $this->load->view('post_login/main');

            $this->load->view("reports/bonus", $bonus);

            $this->load->view('post_login/footer');

        }

    }


    //For Incentive Report
    public function f_incentive_report() {

        if($_SERVER['REQUEST_METHOD'] == 'POST') {

            //Employee Ids for Incentive
            $select     =   array("emp_code");

            $where      =   array(

                "emp_catg"  =>  4

            );

            $emp_id     =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            //Temp variable for emp_list
            $eid_list   =   [];

            for($i = 0; $i < count($emp_id); $i++) {

                array_push($eid_list, $emp_id[$i]->emp_code);

            }


            //List of Incentive Category wise
            unset($where);
            $where = array (

                "month"     =>  $this->input->post('month'),

                "year"      =>  $this->input->post('year')

            );

            //Incentive list
            $incentive['list']          =   $this->Payroll->f_get_particulars_in("td_incentive", $eid_list, $where);

            //Incentive Year
            $incentive['incentive_year']  =   $this->Payroll->f_get_particulars("md_parameters", array('param_value'), array('sl_no' => 15), 1);

            $this->load->view('post_login/main');

            $this->load->view("reports/incentive", $incentive);

            $this->load->view('post_login/footer');

        }

        else {

            //Month List
            $incentive['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            //For Current Date
            $incentive['sys_date']   =   $_SESSION['sys_date'];

            $this->load->view('post_login/main');

            $this->load->view("reports/incentive", $incentive);

            $this->load->view('post_login/footer');

        }

    }


    //Total Deduction Report

    public function f_totaldeduction_report () {

        if($_SERVER['REQUEST_METHOD'] == 'POST'){

            $totaldeduction['total_deduct'] =   $this->Payroll->f_get_totaldeduction($this->input->post('from_date'), $this->input->post('to_date'));

            //Current Year
            $totaldeduction['year']  =   $this->Payroll->f_get_particulars("md_parameters", array('param_value'), array('sl_no' => 15), 1);

            $this->load->view('post_login/main');

            $this->load->view("reports/totaldeduction", $totaldeduction);

            $this->load->view('post_login/footer');

        }

        else{

            //Month List
            $totaldeduction['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            //For Current Date
            $totaldeduction['sys_date']   =   $_SESSION['sys_date'];

            $this->load->view('post_login/main');

            $this->load->view("reports/totaldeduction", $totaldeduction);

            $this->load->view('post_login/footer');

        }

    }


    //PF Contribution Report
    public function f_pfcontribution_report () {

        if($_SERVER['REQUEST_METHOD'] == 'POST'){

            //Opening Balance Date
            $where  =   array(

                "emp_no"      => $this->input->post('emp_cd'),

                "trans_dt < " => $this->input->post("from_date")

            );

            //Max Transaction Date
            $max_trans_dt   =   $this->Payroll->f_get_particulars("tm_pf_dtls", array("MAX(trans_dt) trans_dt"), $where, 1);
            

            //temp variable
            $pfcontribution['pf_contribution']   =   NULL;

            if(!is_null($max_trans_dt->trans_dt)) {

                //Opening Balance
                $pfcontribution['opening_balance']   =   $this->Payroll->f_get_particulars("tm_pf_dtls", array("balance"), array("emp_no" => $this->input->post('emp_cd'),"trans_dt" => $max_trans_dt->trans_dt), 1);

            }

            else {

                //Opening Balance
                $pfcontribution['opening_balance']   =   0;

            }

            //PF Contribution List
            unset($where);
            $where  =   array(

                "emp_no"    => $this->input->post('emp_cd'),

                "trans_dt BETWEEN '".$this->input->post("from_date")."' AND '".$this->input->post('to_date')."'" => NULL

            );

            $pfcontribution['pf_contribution']   =   $this->Payroll->f_get_particulars("tm_pf_dtls", NULL, $where, 0);


            //Current Year
            $pfcontribution['year']  =   $this->Payroll->f_get_particulars("md_parameters", array('param_value'), array('sl_no' => 15), 1);

            //Employee Name
            $pfcontribution['emp_name']  =   $this->Payroll->f_get_particulars("md_employee", array('emp_name'), array('emp_code' => $this->input->post('emp_cd')), 1);

            $this->load->view('post_login/main');

            $this->load->view("reports/pfcontribution", $pfcontribution);

            $this->load->view('post_login/footer');

        }

        else{

            //Month List
            $pfcontribution['month_list'] =   $this->Payroll->f_get_particulars("md_month",NULL, NULL, 0);

            //For Current Date
            $pfcontribution['sys_date']   =   $_SESSION['sys_date'];

            //Employee List
            $select =   array ("emp_code", "emp_name");

            $where  =   array(

                "emp_catg IN (1,2,3)"      => NULL,

                "deduction_flag"           => "Y"
            );

            $pfcontribution['emp_list']   =   $this->Payroll->f_get_particulars("md_employee", $select, $where, 0);

            $this->load->view('post_login/main');

            $this->load->view("reports/pfcontribution", $pfcontribution);

            $this->load->view('post_login/footer');

        }

    }

}
    
?>
