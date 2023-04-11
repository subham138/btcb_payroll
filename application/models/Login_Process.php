<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Login_Process extends CI_Model
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

	public function f_select_password($user_id)
	{		//Check if password exits

		$this->db->select('password,user_status');

		$this->db->where('user_id', $user_id);

		$data = $this->db->get('md_users');

		if ($data->num_rows() > 0) {
			return $data->row();
		} else {
			return false;
		}
	}

	public function f_insert_audit_trail($user_id)
	{				//Insert audit trail when user logs in

		$time = date("Y-m-d h:i:s");

		$pcaddr = $_SERVER['REMOTE_ADDR'];

		$value = array(
			'login_dt' => $time,
			'user_id' => $user_id,
			'terminal_name' => $pcaddr
		);
		$this->db->insert('td_audit_trail', $value);
		return $this->db->insert_id();
	}

	public function f_update_audit_trail($user_id)
	{				//update audit trail when user logs out			
		$time = date("Y-m-d h:i:s");
		$sl_no = $this->session->userdata('sl_no');
		$value = array('logout' => $time);
		$this->db->where('sl_no', $sl_no);
		$this->db->update('td_audit_trail', $value);
	}

	public function f_get_user_inf($user_id)
	{
		$this->db->select('*');
		$this->db->from('md_users');
		$this->db->where('md_users.user_id', $user_id);
		$this->db->join('md_branch', 'md_users.branch_id = md_branch.id', 'LEFT');
		$data = $this->db->get();
		return $data->row();
	}
	public function f_get_branch_inf($branch_id)
	{
		$this->db->select('*');
		$this->db->from('md_branch');
		$this->db->where('md_branch.id', $branch_id);
		$data = $this->db->get();
		return $data->row();
	}
	/*public function f_get_branch_list(){
			$this->db->select('*');
			$this->db->from('md_branch');
			$this->db->order_by("branch_name", "asc");
			$data=$this->db->get();
			return $data->result();
		}*/

	public function f_get_dist_inf($dist_cd)
	{

		$this->db->select('*');

		$this->db->where('district_code', $dist_cd);

		$data = $this->db->get('md_district');

		return $data->row();
	}

	public function f_get_kms_inf($sl_no)
	{

		$this->db->select('*');

		$this->db->where('sl_no', $sl_no);

		$data = $this->db->get('md_kms_year');

		return $data->row();
	}


	public function f_get_kms_yr()
	{

		$this->db->select('*');

		$data = $this->db->get('md_kms_year');

		return $data->result();
	}



	public function f_get_parameters($sl_no)
	{
		$this->db->select('param_value');
		$this->db->where('sl_no', $sl_no);
		$data = $this->db->get('md_parameters');

		if ($data->num_rows() > 0) {
			return $data->row();
		} else {
			return false;
		}
	}

	public function f_audit_trail_value($user_id)
	{
		$this->db->select_max('sl_no');
		$this->db->where('user_id', $user_id);
		$details = $this->db->get('td_audit_trail');
		return $details->row();
	}

	public function f_get_tot_paddy_procurement($kms_id, $branch_id)
	{

		$this->db->select('ifnull(SUM(quantity), 0) tot_quantity,count(cheque_no) cheque_no,ifnull(SUM(amount), 0) amount');
		$this->db->where('kms_id', $kms_id);
		$this->db->where('branch_id', $branch_id);
		$data = $this->db->get('td_collections');
		return $data->row();
	}
	public function f_get_tot_paddy_procurement_ho($kms_id)
	{

		$this->db->select('ifnull(SUM(quantity), 0) tot_quantity,count(cheque_no) cheque_no,ifnull(SUM(amount), 0) amount');
		$this->db->where('kms_id', $kms_id);
		$data = $this->db->get('td_collections');
		return $data->row();
	}
	public function f_get_tot_cheque_cleared($kms_id, $branch_id)
	{

		$this->db->select('ifnull(SUM(amount), 0) tot_clr_cheque');
		$this->db->where('kms_id', $kms_id);
		$this->db->where('chq_status', "C");
		$this->db->where('branch_id', $branch_id);
		$data = $this->db->get('td_collections');
		return $data->row();
	}
	public function f_get_tot_cheque_cleared_ho($kms_id)
	{

		$this->db->select('ifnull(SUM(amount), 0) tot_clr_cheque');
		$this->db->where('kms_id', $kms_id);
		$this->db->where('chq_status', "C");
		$data = $this->db->get('td_collections');
		return $data->row();
	}
	public function f_get_tot_cmr_offered($kms_id, $branch_id)
	{

		$this->db->select('ifnull(SUM(cmr_offered_now), 0) cmr_offered_now');
		$this->db->where('kms_year', $kms_id);
		$this->db->where('branch_id', $branch_id);
		$data = $this->db->get('td_cmr_offered');
		return $data->row();
	}
	public function f_get_tot_cmr_offered_ho($kms_id)
	{

		$this->db->select('ifnull(SUM(cmr_offered_now), 0) cmr_offered_now');
		$this->db->where('kms_year', $kms_id);
		$data = $this->db->get('td_cmr_offered');
		return $data->row();
	}
	public function f_get_tot_cmr_delivery($kms_id, $branch_id)
	{

		$this->db->select('ifnull(SUM(tot_delivery), 0) tot_delivery');
		$this->db->where('kms_year', $kms_id);
		$this->db->where('branch_id', $branch_id);
		$data = $this->db->get('td_cmr_delivery');
		return $data->row();
	}
	public function f_get_tot_cmr_delivery_ho($kms_id)
	{

		$this->db->select('ifnull(SUM(tot_delivery), 0) tot_delivery');
		$this->db->where('kms_year', $kms_id);
		$data = $this->db->get('td_cmr_delivery');
		return $data->row();
	}

	function last_paid_dt()
	{
		$this->db->distinct();
		$this->db->select('sal_month, sal_year');
		$this->db->where(array(
			'sal_month = (SELECT sal_month FROM td_pay_slip ORDER BY sal_year DESC, sal_month DESC LIMIT 1)' => null,
			'sal_year = (SELECT sal_year FROM td_pay_slip ORDER BY sal_year DESC, sal_month DESC LIMIT 1)' => null
		));
		$query = $this->db->get('td_pay_slip');
		return $query->row();
	}
	function tot_emp()
	{
		$this->db->select('COUNT(emp_code) tot_emp');
		$this->db->where(array(
			'emp_status' => 'A'
		));
		$query = $this->db->get('md_employee');
		return $query->row();
	}
	function last_month_sal_state()
	{
		$this->db->select('SUM(tot_diduction) tot_deduct, SUM(final_gross) tot_ear');
		$this->db->where(array(
			'sal_month = (SELECT sal_month FROM td_pay_slip ORDER BY sal_year DESC, sal_month DESC LIMIT 1)' => null,
			'sal_year = (SELECT sal_year FROM td_pay_slip ORDER BY sal_year DESC, sal_month DESC LIMIT 1)' => null
		));
		$query = $this->db->get('td_pay_slip');
		return $query->row();
	}
	function last_month_net_sal_catg_wise($catg_type)
	{
		$this->db->select('SUM(net_sal) tot_sal');
		$this->db->where(array(
			'sal_month = (SELECT sal_month FROM td_pay_slip ORDER BY sal_year DESC, sal_month DESC LIMIT 1)' => null,
			'sal_year = (SELECT sal_year FROM td_pay_slip ORDER BY sal_year DESC, sal_month DESC LIMIT 1)' => null
		));
		if ($catg_type == 'P') {
			$this->db->where('catg_id = 1');
		} else {
			$this->db->where('catg_id != 1');
		}
		$query = $this->db->get('td_pay_slip');
		return $query->row();
	}
}
