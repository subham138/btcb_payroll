<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Salary_Process extends CI_Model
{

	public function f_get_particulars($table_name, $select = NULL, $where = NULL, $flag)
	{

		if (isset($select)) {

			$this->db->select($select);
		}

		if (isset($where)) {

			$this->db->where($where);
		}

		$result		=	$this->db->get($table_name);

		if ($flag == 1) {

			return $result->row();
		} else {

			return $result->result();
		}
	}

	//For inserting row
	public function f_insert($table_name, $data_array)
	{

		if ($this->db->insert($table_name, $data_array)) {
			return true;
		} else {
			return false;
		}
	}

	//For Editing row
	public function f_edit($table_name, $data_array, $where)
	{

		$this->db->where($where);
		$this->db->update($table_name, $data_array);

		return;
	}

	//For Deliting row

	public function f_delete($table_name, $where)
	{

		$this->db->delete($table_name, $where);

		return;
	}

	public function f_sal_dtls($emp_code) 										//Calculate Earnings
	{

		$sql = $this->db->query("SELECT a.basic_pay,
										    basic_pay * (select param_value from md_parameters where sl_no=1)/100 as da,
									        basic_pay * (select param_value from md_parameters where sl_no=2)/100 as hra,
											(select param_value from md_parameters where sl_no=4)epf, 
										    (select param_value from md_parameters where sl_no=3) ma
									FROM md_employee a 
								    WHERE a.emp_code ='$emp_code'");
		return $sql->row();
	}

	public function f_get_earning()
	{											//Retrieve Earnings for Dashboard
		$data = $this->db->query("SELECT a.emp_code as emp_code, 
											  b.emp_name as emp_name,
											  b.emp_dist as emp_dist,
											  c.district_name as district_name,
											  MAX(a.effective_date) as effective_date
									    FROM td_income a ,md_employee b,md_district c
										WHERE a.emp_code = b.emp_code
										AND   b.emp_dist = c.district_code
										AND   (b.emp_status = 'A' OR b.emp_status = 'S')
									    GROUP BY a.emp_code, b.emp_name,c.district_name");

		return $data->result();
	}


	//Retive Deduction List
	/*public function f_get_deduction() {

			$sql = "SELECT emp_cd, MAX(cast(created_dt As DATE)) sal_date FROM td_deductions
														  GROUP BY emp_cd";
												  
			$result		=	$this->db->query($sql);	
			
			if($result->num_rows() > 0){

				foreach($result->result() as $row) {

					$where = array(
	
						"emp_cd"			=>	$row->emp_cd,
	
						"created_dt"		=>	$row->sal_date
	
					);
	
					$data[] = $this->f_get_particulars("td_deductions", NULL, $where, 1);

				}

				return $data;

			}
			
			else{

				return false;
				
			}

		}*/


	//Retive Attendance List
	/*public function f_get_attendance() {

			$sql = "SELECT emp_cd, MAX(trans_dt) trans_dt FROM td_attendance
				GROUP BY emp_cd";
												  
			$result		=	$this->db->query($sql);	
			
			if($result->num_rows() > 0){

				foreach($result->result() as $row) {

					$where = array(
	
						"emp_cd"	=>	$row->emp_cd,
	
						"trans_dt"	=>	$row->trans_dt
	
					);
	
					$data[] = $this->f_get_particulars("td_attendance", NULL, $where, 1);

				}

				return $data;

			}
			
			else{
				return false;
			}

		}*/


	//Retive Bonus List
	/*public function f_get_bonus() {

			$sql = "SELECT emp_no, MAX(trans_dt) trans_dt FROM td_bonus
														  GROUP BY emp_no";
												  
			$result		=	$this->db->query($sql);	
			
			if($result->num_rows() > 0){

				foreach($result->result() as $row) {

					$where = array(
	
						"emp_no"	=>	$row->emp_no,
	
						"trans_dt"	=>	$row->trans_dt
	
					);
	
					$data[] = $this->f_get_particulars("td_bonus", NULL, $where, 1);

				}

				return $data;

			}
			
			else{

				return false;

			}

		}*/


	//Retive Incentive List
	/*public function f_get_incentive() {

			$sql = "SELECT emp_no, MAX(trans_dt) trans_dt FROM td_incentive
														  GROUP BY emp_no";
												  
			$result		=	$this->db->query($sql);	
			
			if($result->num_rows() > 0){

				foreach($result->result() as $row) {

					$where = array(
	
						"emp_no"	=>	$row->emp_no,
	
						"trans_dt"	=>	$row->trans_dt
	
					);
	
					$data[] = $this->f_get_particulars("td_incentive", NULL, $where, 1);

				}

				return $data;

			}
			
			else{

				return false;
				
			}

		}*/

	//For Periodic Increment
	/*public function f_get_increment() {

			$sql = "SELECT emp_cd, MAX(effective_dt) trans_dt FROM md_basic_pay
														      GROUP BY emp_cd";
												  
			$result		=	$this->db->query($sql);	
			
			if($result->num_rows() > 0){

				foreach($result->result() as $row) {

					$where = array(
	
						"emp_cd"	    =>	$row->emp_cd,
	
						"effective_dt"	=>	$row->trans_dt
	
					);
	
					$data[] = $this->f_get_particulars("md_basic_pay", NULL, $where, 1);

				}

				return $data;

			}
			
			else{

				return false;
				
			}

		}*/

	//For Salary slip generation
	public function f_get_generation()
	{

		$sql = "SELECT sal_month, sal_year, 
						   MAX(trans_date) trans_date
					FROM   td_salary 
					GROUP BY sal_month, 
							 sal_year LIMIT 1";

		$result	=	$this->db->query($sql);

		return $result->row();
	}

	//For Where in Clause for employees
	public function f_get_particulars_in($table_name, $where_in = NULL, $where = NULL)
	{

		if (isset($where)) {

			$this->db->where($where);
		}

		if (isset($where_in)) {

			$this->db->where_in('emp_no', $where_in);
		}

		$result	=	$this->db->get($table_name);

		return $result->result();
	}


	//For Total Deduction
	public function f_get_totaldeduction($from_date, $to_date)
	{

		$sql	=	"SELECT emp_no,
								emp_name,
								SUM(gen_adv) gen_adv,
								SUM(gen_intt) gen_intt,
								SUM(festival_adv) festival_adv,
								SUM(lic) lic,
								SUM(pf) pf,
								SUM(ptax) ptax,
								SUM(itax) itax FROM td_pay_slip 
											   WHERE trans_date BETWEEN '$from_date' AND '$to_date'
											   GROUP BY emp_no, emp_name
						";

		$result = $this->db->query($sql);

		return $result->result();
	}


	//For last Arear(Stopped) Salary for employee(s)
	public function f_get_stopsalary()
	{

		$sql = "SELECT emp_no, MAX(trans_dt) trans_dt FROM td_stop_salary
														  GROUP BY emp_no";

		$result		=	$this->db->query($sql);

		if ($result->num_rows() > 0) {

			foreach ($result->result() as $row) {

				$where = array(

					"emp_no"	    =>	$row->emp_no,

					"trans_dt"   	=>	$row->trans_dt

				);

				$data[] = $this->f_get_particulars("td_stop_salary", NULL, $where, 1);
			}

			return $data;
		} else {

			return false;
		}
	}

	function get_emp_dtls($catg)
	{
		$this->db->select('emp_code, emp_name, emp_catg, designation, basic_pay, bank_ac_no');
		$this->db->where(array(
			'emp_catg' => $catg
		));
		$query = $this->db->get('md_employee');
		return $query->result();
	}

	function calculate_final_gross()
	{
		$this->db->select('SUM(a.final_gross) final_gross, a.effective_date, a.catg_id, b.category');
		$this->db->where(array(
			'a.catg_id=b.id' => null,
			'a.effective_date = (SELECT MAX(c.effective_date) FROM td_income c)' => null
		));
		$this->db->group_by('a.catg_id');
		$query = $this->db->get('td_income a, md_category b');
		// echo $this->db->last_query();
		// exit;
		return $query->result();
	}

	function earning_save($data)
	{
		// echo '<pre>';
		// var_dump($data);
		// exit;
		$res_dt = false;
		for ($i = 0; $i < count($data['emp_code']); $i++) {
			$this->db->select('emp_code');
			$this->db->where(array(
				'emp_code' => $data['emp_code'][$i],
				'effective_date' => $data['sal_date'],
				'catg_id' => $data['catg_id']
			));
			$query = $this->db->get('td_income');
			// echo $query->num_rows();
			// exit;
			if ($query->num_rows() > 0) {
				$input = array(
					'basic' => $data['basic'][$i],
					'da' => $data['da'][$i],
					'sa' => $data['sa'][$i],
					'hra' => $data['hra'][$i],
					'ta' => $data['ta'][$i],
					'da_on_sa' => $data['da_on_sa'][$i],
					'da_on_ta' => $data['da_on_ta'][$i],
					'ma' => $data['ma'][$i],
					'cash_swa' => $data['cash_swa'][$i],
					'gross' => $data['gross'][$i],
					'lwp' => $data['lwp'][$i],
					'final_gross' => $data['final_gross'][$i],
					"modified_by"    => $this->session->userdata['loggedin']['user_id'],
					"modified_dt"    =>  date('Y-m-d h:i:s')
				);
				$this->db->where(array(
					'emp_code' => $data['emp_code'][$i],
					'effective_date' => $data['sal_date'],
					'catg_id' => $data['catg_id']
				));
				if ($this->db->update('td_income', $input)) {
					$res_dt = true;
				} else {
					$res_dt = false;
					break;
				}
			} else {
				$input = array(
					'emp_code' => $data['emp_code'][$i],
					'effective_date' => $data['sal_date'],
					'catg_id' => $data['catg_id'],
					'basic' => $data['basic'][$i],
					'da' => $data['da'][$i],
					'sa' => $data['sa'][$i],
					'hra' => $data['hra'][$i],
					'ta' => $data['ta'][$i],
					'da_on_sa' => $data['da_on_sa'][$i],
					'da_on_ta' => $data['da_on_ta'][$i],
					'ma' => $data['ma'][$i],
					'cash_swa' => $data['cash_swa'][$i],
					'gross' => $data['gross'][$i],
					'lwp' => $data['lwp'][$i],
					'final_gross' => $data['final_gross'][$i],
					"created_by" => $this->session->userdata['loggedin']['user_id'],
					"created_dt" =>  date('Y-m-d h:i:s')
				);
				if ($this->db->insert('td_income', $input)) {
					$res_dt = true;
				} else {
					$res_dt = false;
					break;
				}
			}
		}
		return $res_dt;
	}

	function earningDtls($catg_id, $date)
	{
		$this->db->select('a.*, b.emp_name');
		$this->db->where(array(
			'a.emp_code=b.emp_code' => null,
			'a.effective_date' => $date,
			'a.catg_id' => $catg_id
		));
		$query = $this->db->get('td_income a, md_employee b');
		return $query->result();
	}

	function calculate_final_deduction()
	{
		$this->db->select('SUM(a.net_sal) net_sal, a.effective_date, a.catg_id, b.category');
		$this->db->where(array(
			'a.catg_id=b.id' => null,
			'a.effective_date = (SELECT MAX(c.effective_date) FROM td_deductions c)' => null
		));
		$this->db->group_by('a.catg_id');
		$query = $this->db->get('td_deductions a, md_category b');
		// echo $this->db->last_query();
		// exit;
		return $query->result();
	}

	function get_last_gross($emp_code)
	{
		$this->db->select('a.emp_code, b.emp_name, a.final_gross, a.da, a.basic');
		$this->db->where(array(
			'a.emp_code=b.emp_code' => null,
			'a.emp_code' => $emp_code,
			'a.effective_date = (SELECT MAX(c.effective_date) FROM td_income c)' => null
		));
		$query = $this->db->get('td_income a, md_employee b');
		// echo $this->db->last_query();
		// exit;
		return $query->row();
	}

	function get_ptx($gross)
	{
		$this->db->select('ptax');
		$this->db->where(array(
			'st <=' => $gross,
			'end >=' => $gross
		));
		$query = $this->db->get('md_ptax');
		return $query->row();
	}

	function deductionDtls($catg_id, $date)
	{
		$this->db->select('a.*, b.emp_name');
		$this->db->where(array(
			'a.emp_code=b.emp_code' => null,
			'a.effective_date' => $date,
			'a.catg_id' => $catg_id
		));
		$query = $this->db->get('td_deductions a, md_employee b');
		return $query->result();
	}

	function deduction_save($data)
	{
		// echo '<pre>';
		// var_dump($data);
		// exit;
		$res_dt = false;
		for ($i = 0; $i < count($data['emp_code']); $i++) {
			$this->db->select('emp_code');
			$this->db->where(array(
				'emp_code' => $data['emp_code'][$i],
				'effective_date' => $data['sal_date'],
				'catg_id' => $data['catg_id']
			));
			$query = $this->db->get('td_deductions');
			// echo $query->num_rows();
			// exit;
			if ($query->num_rows() > 0) {
				$input = array(
					'gross' => $data['gross'][$i],
					'pf' => $data['pf'][$i],
					'adv_agst_hb_prin' => $data['adv_agst_hb_prin'][$i],
					'adv_agst_hb_int' => $data['adv_agst_hb_int'][$i],
					'adv_agst_hb_const_prin' => $data['adv_agst_hb_const_prin'][$i],
					'adv_agst_hb_const_int' => $data['adv_agst_hb_const_int'][$i],
					'adv_agst_hb_staff_prin' => $data['adv_agst_hb_staff_prin'][$i],
					'adv_agst_hb_staff_int' => $data['adv_agst_hb_staff_int'][$i],
					'gross_hb_int' => $data['gross_hb_int'][$i],
					'adv_agst_of_staff_prin' => $data['adv_agst_of_staff_prin'][$i],
					'adv_agst_of_staff_int' => $data['adv_agst_of_staff_int'][$i],
					'staff_adv_ext_prin' => $data['staff_adv_ext_prin'][$i],
					'staff_adv_ext_int' => $data['staff_adv_ext_int'][$i],
					'motor_cycle_prin' => $data['motor_cycle_prin'][$i],
					'motor_cycle_int' => $data['motor_cycle_int'][$i],
					'p_tax' => $data['p_tax'][$i],
					'gici' => $data['gici'][$i],
					'puja_adv' => $data['puja_adv'][$i],
					'income_tax_tds' => $data['income_tax_tds'][$i],
					'union_subs' => $data['union_subs'][$i],
					'tot_diduction' => $data['tot_diduction'][$i],
					'net_sal' => $data['net_sal'][$i],
					'modified_by'    => $this->session->userdata['loggedin']['user_id'],
					'modified_dt'    =>  date('Y-m-d h:i:s')
				);
				$this->db->where(array(
					'emp_code' => $data['emp_code'][$i],
					'effective_date' => $data['sal_date'],
					'catg_id' => $data['catg_id']
				));
				if ($this->db->update('td_deductions', $input)) {
					$res_dt = true;
				} else {
					$res_dt = false;
					break;
				}
			} else {
				$input = array(
					'emp_code' => $data['emp_code'][$i],
					'effective_date' => $data['sal_date'],
					'catg_id' => $data['catg_id'],
					'gross' => $data['gross'][$i],
					'pf' => $data['pf'][$i],
					'adv_agst_hb_prin' => $data['adv_agst_hb_prin'][$i],
					'adv_agst_hb_int' => $data['adv_agst_hb_int'][$i],
					'adv_agst_hb_const_prin' => $data['adv_agst_hb_const_prin'][$i],
					'adv_agst_hb_const_int' => $data['adv_agst_hb_const_int'][$i],
					'adv_agst_hb_staff_prin' => $data['adv_agst_hb_staff_prin'][$i],
					'adv_agst_hb_staff_int' => $data['adv_agst_hb_staff_int'][$i],
					'gross_hb_int' => $data['gross_hb_int'][$i],
					'adv_agst_of_staff_prin' => $data['adv_agst_of_staff_prin'][$i],
					'adv_agst_of_staff_int' => $data['adv_agst_of_staff_int'][$i],
					'staff_adv_ext_prin' => $data['staff_adv_ext_prin'][$i],
					'staff_adv_ext_int' => $data['staff_adv_ext_int'][$i],
					'motor_cycle_prin' => $data['motor_cycle_prin'][$i],
					'motor_cycle_int' => $data['motor_cycle_int'][$i],
					'p_tax' => $data['p_tax'][$i],
					'gici' => $data['gici'][$i],
					'puja_adv' => $data['puja_adv'][$i],
					'income_tax_tds' => $data['income_tax_tds'][$i],
					'union_subs' => $data['union_subs'][$i],
					'tot_diduction' => $data['tot_diduction'][$i],
					'net_sal' => $data['net_sal'][$i],
					'created_by' => $this->session->userdata['loggedin']['user_id'],
					'created_dt' =>  date('Y-m-d h:i:s')
				);
				if ($this->db->insert('td_deductions', $input)) {
					$res_dt = true;
				} else {
					$res_dt = false;
					break;
				}
			}
		}
		return $res_dt;
	}

	function generate_slip($trans_dt, $month, $year, $catg_id, $trans_no, $flag)
	{
		$this->db->select('a.trans_date, a.trans_no, a.sal_month, a.sal_year, a.approval_status, a.catg_cd, c.category, SUM(b.net_sal) tot_sal, SUM(b.final_gross) tot_gross');
		$this->db->where(array(
			'a.trans_date=b.trans_date' => null,
			'a.trans_no=b.trans_no' => null,
			'a.sal_month=b.sal_month' => null,
			'a.sal_year=b.sal_year' => null,
			'a.catg_cd=b.catg_id' => null,
			'a.catg_cd=c.id' => null,
			'a.approval_status' => 'U',
		));
		if ($trans_dt && $month && $year && $catg_id && $trans_no) {
			$this->db->where(array(
				'a.trans_date' => $trans_dt,
				'a.trans_no' => $trans_no,
				'a.sal_month' => $month,
				'a.sal_year' => $year,
				'a.catg_cd' => $catg_id
			));
		}
		$this->db->group_by('a.sal_month, a.catg_cd');
		$query = $this->db->get('td_salary a, td_pay_slip b, md_category c');
		if ($flag > 0) {
			return $query->row();
		} else {
			return $query->result();
		}
	}
}
