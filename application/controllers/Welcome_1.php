<?php

	class Welcome extends MX_Controller{

		public function __construct(){
			parent::__construct();
			$this->load->model('Login_Process');
		}
		
		public function index(){

			$this->load->view("department");	
		}		
	}