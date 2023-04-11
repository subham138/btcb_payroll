<?php

	class Admin extends CI_Controller{

		public function __construct(){
			parent::__construct();

			$this->load->model('Login_Process');

			$this->load->model('Admin_Process');
		}

		public function parameter(){

    		$this->load->view('post_login/payroll_main');

    		$param_dtls['parameter'] = $this->Admin_Process->f_get_particulars("md_parameters",NULL,NULL,0);
    		
			$this->load->view('parameter/dashboard', $param_dtls);

    		$this->load->view('post_login/footer'); 
		}

		public function parameter_edit(){

			if($_SERVER['REQUEST_METHOD'] == "POST") {
				
				$sl_no  			=   $this->input->post('sl_no');
		
				$param_desc       	=   $this->input->post('param_desc');
		
				$param_value   		=   $this->input->post('param_value');
		
				$data_array = array (
		
					"param_value"     	=>  $param_value,

					"modified_by"		=>  $this->session->userdata['loggedin']['user_id'],

					"modified_dt"    =>  date('Y-m-d h:i:s')

				);
		
				$where = array(
		
					"sl_no"       =>  $sl_no
		
				);
				
				$this->session->set_flashdata('msg', 'Successfully updated!');
		
				$this->Admin_Process->f_edit('md_parameters', $data_array, $where);
		
				redirect('vls');
		
			}
		
			else {
		
				$where = array(
		
					"sl_no"     =>  $this->input->get('sl_no')
		
				);
				
				//Bonus list of latest month
				 $parameter['param_dtls']    =   $this->Admin_Process->f_get_particulars("md_parameters", NULL, $where, 1);
		
				$this->load->view('post_login/payroll_main');
		
				$this->load->view("parameter/edit", $parameter);
		
				$this->load->view('post_login/footer');
		
			}
		
		}

		public function employee() {		//Employee Dashboard

			//Employee List
			$select = array("emp_code", "emp_name", "emp_catg",
							"department");
	
			$employee['employee_dtls']    =   $this->Admin_Process->f_get_particulars("md_employee", $select, array("emp_status" => 'A'), 0);
			
	
			//Category List 
			$employee['category_dtls']    =   $this->Admin_Process->f_get_particulars("md_category", NULL, NULL, 0);
	
			$this->load->view('post_login/payroll_main');
	
			$this->load->view("employee/dashboard", $employee);
	
			$this->load->view('post_login/footer');
			
		}

		public function employee_add() {	//Add Employee		

			if($_SERVER['REQUEST_METHOD'] == "POST") {
	
				//$maxCode     =   $this->Payroll->f_get_particulars("md_employee", array("MAX(emp_code) + 1 emp_code"), null, 1);
				
				$data_array = array (
	
					"emp_code"         =>  $this->input->post('emp_code'),
	
					"emp_name"         =>  $this->input->post('emp_name'),
	
					"emp_catg"         =>  $this->input->post('emp_catg'),

					"emp_dist"         =>  $this->input->post('emp_dist'),

					"dob"          	   =>  $this->input->post('dob'),
					
					"join_dt"          =>  $this->input->post('join_dt'),
	
					"ret_dt"           =>  $this->input->post('ret_dt'),
					
					"phn_no"           =>  $this->input->post('phn_no'),
					
					"email"            =>  $this->input->post('email'),
					
					"designation"      =>  $this->input->post('designation'),
					
					"department"       =>  $this->input->post('department'),

					"emp_addr"         =>  $this->input->post('emp_addr'),
	
					"pan_no"           =>  $this->input->post('pan_no'),

					"aadhar_no"        =>  $this->input->post('aadhar'),
	
					"bank_name"        =>  $this->input->post('bank_name'),
	
					"bank_ac_no"       =>  $this->input->post('bank_ac_no'),
	
					"pf_ac_no"         =>  $this->input->post('pf_ac_no'),
	
					"basic_pay"        =>  $this->input->post('basic_pay'),
	
					"created_by"       =>  $this->session->userdata['loggedin']['user_id'],
	
					"created_dt"       =>  date('Y-m-d h:i:s')
	
				);  
	
				$this->Admin_Process->f_insert('md_employee', $data_array);
	
				$this->session->set_flashdata('msg', 'Successfully added!');
	 
				redirect('stfemp');
	
			}
	
			else {
	
				//Category List 
				$employee['category_dtls']    =   $this->Admin_Process->f_get_particulars("md_category", NULL, NULL, 0);
				$employee['dist_dtls']    =   $this->Admin_Process->f_get_particulars("md_district", NULL, NULL, 0);
				$this->load->view('post_login/payroll_main');
	
				$this->load->view("employee/add", $employee);
	
				$this->load->view('post_login/footer');
	
			}
	
		}

		public function employee_delete(){		//Delete Employee

			$where = array(
				
				"emp_code"    =>  $this->input->get('empcd'),

				
			);

			$this->Admin_Process->f_delete('md_employee', $where);
	
			$this->session->set_flashdata('msg', 'Successfully Deleted!');
	
			redirect("stfemp");
	
		}

		public function employee_edit(){		//Edit Employee

			if($_SERVER['REQUEST_METHOD'] == "POST") {
	
				$data_array = array (
	
					"emp_name"         =>  $this->input->post('emp_name'),
	
					"emp_catg"         =>  $this->input->post('emp_catg'),

					"emp_dist"         =>  $this->input->post('emp_dist'),

					"dob"          	   =>  $this->input->post('dob'),
	
					"join_dt"          =>  $this->input->post('join_dt'),
					
					"ret_dt"           =>  $this->input->post('ret_dt'),
					
					"phn_no"           =>  $this->input->post('phn_no'),
					
					"email"            =>  $this->input->post('email'),
					
					"designation"      =>  $this->input->post('designation'),
					
					"department"       =>  $this->input->post('department'),
	
					"emp_addr"         =>  $this->input->post('emp_addr'),
	
					"pan_no"           =>  $this->input->post('pan_no'),

					"aadhar_no"        =>  $this->input->post('aadhar'),
	
					"bank_name"        =>  $this->input->post('bank_name'),
	
					"bank_ac_no"       =>  $this->input->post('bank_ac_no'),
	
					"pf_ac_no"         =>  $this->input->post('pf_ac_no'),
	
					"basic_pay"        =>  $this->input->post('basic_pay'),
	
					"modified_by"       => $this->session->userdata['loggedin']['user_id'],
	
					"modified_dt"       =>  date('Y-m-d h:i:s')
	
				);  
	
				$where  =   array(
					
					"emp_code"         =>  $this->input->post('emp_code')
				);
				
				$this->session->set_flashdata('msg', 'Successfully updated!');
	
				$this->Admin_Process->f_edit('md_employee', $data_array, $where);
	
				redirect('stfemp');
	
			}
	
			else {

				//For Employee Details
				unset($select);
				$select = array ("emp_code", "emp_name", "emp_catg","emp_dist", "dob","email", "phn_no",
								 "designation", "department","emp_addr",
								 "pan_no", "bank_name", "bank_ac_no", "join_dt","ret_dt",
								 "pf_ac_no","basic_pay","aadhar_no"
								 );
	
	
				$where = array(
	
					"emp_code"       =>  $this->input->get('emp_code')
	
				);
	
				//Category List 
				$employee['category_dtls']    =   $this->Admin_Process->f_get_particulars("md_category", NULL, NULL, 0);
				$employee['dist_dtls']    =   $this->Admin_Process->f_get_particulars("md_district", NULL, NULL, 0);
	
				//Employee list
				$employee['employee_dtls']    =   $this->Admin_Process->f_get_particulars("md_employee", $select, $where, 1);
	
				$this->load->view('post_login/payroll_main');
	
				$this->load->view("employee/edit", $employee);
	
				$this->load->view('post_login/footer');
	
			}
	
		}

		public function emp_dtls(){

			$emp_code 	= 	 $this->input->get('emp_code');

			$count   =   $this->Admin_Process->f_count_emp($emp_code);

			echo $count->count_emp;

		}

	}
?>
		
		 