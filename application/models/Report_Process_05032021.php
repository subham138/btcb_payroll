<?php
	defined('BASEPATH') OR exit('No direct script access allowed');

	class Report_Process extends CI_Model{

		public function f_get_particulars($table_name, $select=NULL, $where=NULL, $flag) {

			if(isset($select)) {

				$this->db->select($select);

			}

			if(isset($where)) {

				$this->db->where($where);

			}

			$result		=	$this->db->get($table_name);

			if($flag == 1) {

				return $result->row();
				
			}else {

				return $result->result();

			}

		}

        public function f_edit($table_name, $data_array, $where) {

			$this->db->where($where);
			$this->db->update($table_name, $data_array);

			return;

		}

		//For inserting row
		public function f_insert($table_name, $data_array) {

			$this->db->insert($table_name, $data_array);

			return;

		}

		//For Deliting row
		public function f_delete($table_name, $where) {

			$this->db->delete($table_name, $where);

			return;

		}

		public function f_get_totaldeduction($from_date, $to_date) {

			$sql	=	"SELECT a.emp_no,
								b.emp_name,
								SUM(a.insuarance) insuarance,
								SUM(a.ccs) ccs,
								SUM(a.hbl) hbl,
								SUM(a.telephone) telephone,
								SUM(a.med_adv) med_adv,
								SUM(a.festival_adv) festival_adv,
								sum(a.tf)tf,
								sum(a.med_ins)med_ins,
								sum(a.comp_loan)comp_loan,
								sum(a.ptax)ptax,
								sum(a.gpf)gpf,
								sum(a.epf)epf,
								sum(a.other_deduction)other_deduction,
								SUM(itax) itax FROM td_pay_slip a,md_employee b
											   WHERE a.emp_no=b.emp_code
											   and  trans_date BETWEEN '$from_date' AND '$to_date'
											   GROUP BY a.emp_no, b.emp_name
						";
			
			$result = $this->db->query($sql);

			return $result->result();

		}

		public function f_get_emp_dtls($empno, $sal_month,$sal_yr){

			$result = $this->db->query("select a.trans_date,a.trans_no,a.sal_month,a.sal_year,a.emp_no,a.basic_pay,
			a.da_amt,a.hra_amt,a.med_allow,a.othr_allow,a.insuarance,a.ccs,a.hbl,a.telephone,a.med_adv,a.festival_adv,
			a.tf,a.med_ins,a.comp_loan,a.ptax,a.itax,a.gpf,a.epf,a.other_deduction,a.tot_deduction,a.net_amount,a.remarks
			,b.emp_name,b.designation
			  from 
			  td_pay_slip a,md_employee b where a.emp_no =b.emp_code and a.emp_no = $empno
			  and a.sal_month=$sal_month and a.sal_year=$sal_yr ");

			//$result	=	$this->db->query($sql);

			return $result->row();
		}


		public function f_count_emp($emp_code){

			$result = $this->db->query("select count(*)count_emp from md_employee where emp_code = $emp_code");

			//$result	=	$this->db->query($sql);

			return $result->row();
		}

    }
?>