<?php

class Profile extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();

        $this->load->model('profile_model');
    }

    function index()
    {
        $user_id = $_SESSION['loggedin']['user_id'];
        $data['user'] = $this->profile_model->user_dtls($user_id);
        $this->load->view('post_login/payroll_main');
        $this->load->view("profile/profile", $data);
        $this->load->view('post_login/footer');
    }

    function prof_save()
    {
        $user_id = $_SESSION['loggedin']['user_id'];
        $data = $this->input->post();
        if ($this->profile_model->prof_save($data)) {
            $user_data = $this->profile_model->user_dtls($user_id);

            $this->session->unset_userdata('loggedin');

            $loggedin['user_id']            = $user_data->user_id;
            $loggedin['password']           = $user_data->password;
            $loggedin['user_type']          = $user_data->user_type;
            $loggedin['user_name']          = $user_data->user_name;
            $loggedin['user_status']           = $user_data->user_status;
            $loggedin['branch_id']           = $user_data->branch_id;
            $loggedin['branch_name']           = 'HO';
            $loggedin['ho_flag']            = 'Y';
            $loggedin['fin_id']              = 1;

            $this->session->set_userdata('loggedin', $loggedin);

            $this->session->set_flashdata('msg', 'Successfully updated!');
            $this->session->set_flashdata('style', 'alert-success');
            redirect('prof');
        } else {
            $this->session->set_flashdata('msg', 'Profile Not Updated');
            $this->session->set_flashdata('style', 'alert-danger');
            redirect('prof');
        }
    }

    function change_pass()
    {
        $this->load->view('post_login/payroll_main');
        $this->load->view("profile/change_pass");
        $this->load->view('post_login/footer');
    }

    function pass_save()
    {
        $data = $this->input->post();
        $chk_pass = $this->profile_model->check_pass($data);
        if ($chk_pass) {
            if ($this->profile_model->change_pass($data)) {
                $this->session->set_flashdata('msg', 'Successfully updated!');
                $this->session->set_flashdata('style', 'alert-success');
                redirect('chngpass');
            } else {
                $this->session->set_flashdata('msg', 'Password Not Updated');
                $this->session->set_flashdata('style', 'alert-danger');
                redirect('chngpass');
            }
        } else {
            $this->session->set_flashdata('msg', 'Please check your old password');
            $this->session->set_flashdata('style', 'alert-warning');
            redirect('chngpass');
        }
    }

    function create_user_view()
    {
        $user_id = $_SESSION['loggedin']['user_id'];
        $data['user_list'] = $this->profile_model->user_list($user_id);
        $this->load->view('post_login/payroll_main');
        $this->load->view("profile/create_user_view", $data);
        $this->load->view('post_login/footer');
    }

    function create_user_edit()
    {
        $id = $this->input->get('id');
        $selected = array(
            'user_id' => '',
            'password' => '',
            'user_type' => 'U',
            'user_name' => '',
            'user_status' => 'A',
            'id_update' => 0
        );
        if ($id != '') {
            $user_dt = $this->profile_model->user_dtls($id);
            $selected = array(
                'user_id' => $user_dt->user_id,
                'password' => $user_dt->password,
                'user_type' => $user_dt->user_type,
                'user_name' => $user_dt->user_name,
                'user_status' => $user_dt->user_status,
                'id_update' => 1
            );
        }
        $user_id = $_SESSION['loggedin']['user_id'];
        $data['user_list'] = $this->profile_model->user_list($user_id);
        $data['selected'] = $selected;
        $this->load->view('post_login/payroll_main');
        $this->load->view("profile/create_user_edit", $data);
        $this->load->view('post_login/footer');
    }

    function create_user_save()
    {
        $data = $this->input->post();
        if ($this->profile_model->create_user_save($data)) {
            $this->session->set_flashdata('msg', 'Successfully saved!');
            $this->session->set_flashdata('style', 'alert-success');
            redirect('userlist');
        } else {
            $this->session->set_flashdata('msg', 'User Not Saved');
            $this->session->set_flashdata('style', 'alert-danger');
            redirect('userlist');
        }
    }
}
