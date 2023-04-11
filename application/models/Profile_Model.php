<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Profile_Model extends CI_Model
{
    function change_pass($data)
    {
        $user_name = $_SESSION['loggedin']['user_id'];
        $input = array(
            'password' => password_hash($data['pass'], PASSWORD_DEFAULT),
            'modified_by' => $user_name,
            'modified_dt' => date("Y-m-d h:i:s")
        );
        // var_dump($input);
        // exit;
        $this->db->where(array(
            'user_id' => $_SESSION['loggedin']['user_id']
        ));
        if ($this->db->update('md_users', $input)) {
            return true;
        } else {
            return false;
        }
    }

    function check_pass($data)
    {
        $this->db->select('password');
        $this->db->where(array(
            'user_id' => $_SESSION['loggedin']['user_id']
        ));
        $query = $this->db->get('md_users');
        $result = $query->row();
        if (password_verify($data['old_pass'], $result->password)) {
            return true;
        } else {
            return false;
        }
    }
    function user_dtls($user_id)
    {
        $this->db->select('*');
        $this->db->where(array(
            'user_id' => $user_id
        ));
        $query = $this->db->get('md_users');
        return $query->row();
    }

    function prof_save($data)
    {
        $user_name = $_SESSION['loggedin']['user_id'];
        $input = array(
            'user_name' => $data['user_name'],
            'modified_by' => $user_name,
            'modified_dt' => date("Y-m-d h:i:s")
        );
        // var_dump($input);
        // exit;
        $this->db->where(array(
            'user_id' => $_SESSION['loggedin']['user_id']
        ));
        if ($this->db->update('md_users', $input)) {
            return true;
        } else {
            return false;
        }
    }

    function user_list($user_id)
    {
        $this->db->where(array(
            'user_id not in("sss", "' . $user_id . '")' => null
        ));
        $query = $this->db->get('md_users');
        return $query->result();
    }
    function create_user_save($data)
    {
        $user_name = $_SESSION['loggedin']['user_id'];
        if ($data['id_update'] > 0) {
            $input = array(
                'user_type' => $data['user_type'],
                'user_name' => $data['user_name'],
                'user_status' => $data['user_status'],
                'modified_by' => $user_name,
                'modified_dt' => date("Y-m-d h:i:s")
            );
            $this->db->where(array(
                'user_id' => $data['user_id']
            ));
            if ($this->db->update('md_users', $input)) {
                return true;
            } else {
                return false;
            }
        } else {
            $pass = password_hash($data['pass'], PASSWORD_DEFAULT);
            $input = array(
                'user_id' => $data['user_id'],
                'password' => $pass,
                'user_type' => $data['user_type'],
                'user_name' => $data['user_name'],
                'user_status' => $data['user_status'],
                'created_by' => $user_name,
                'created_dt' => date("Y-m-d h:i:s")
            );
            // var_dump($input);
            // exit;
            if ($this->db->insert('md_users', $input)) {
                return true;
            } else {
                return false;
            }
        }
    }
}
