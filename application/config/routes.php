<?php
defined('BASEPATH') or exit('No direct script access allowed');

/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|	example.com/class/method/id/
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|	https://codeigniter.com/userguide3/general/routing.html
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
| There are three reserved routes:
|	$route['default_controller'] = 'welcome';
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|	$route['404_override'] = 'errors/page_missing';
| This route will tell the Router which controller/method to use if those
| provided in the URL cannot be matched to a valid route.
|	$route['translate_uri_dashes'] = FALSE;
| This is not exactly a route, but allows you to automatically route
| controller and method names that contain dashes. '-' isn't a valid
| class or method name character, so it requires translation.
| When you set this option to TRUE, it will replace ALL dashes in the
| controller and method URI segments.
|
| Examples:	my-controller/index	-> my_controller/index
|		my-controller/my-method	-> my_controller/my_method
*/
$route['default_controller'] = 'login';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;
$route['vlsedt'] = 'admin/parameter_edit';
$route['vls'] = 'admin/parameter';
$route['ptax'] = 'admin/ptax';
$route['pedit'] = 'admin/ptax_edit';
$route['dept'] = 'admin/dept';
$route['adept'] = 'admin/dept_add';
$route['edept'] = 'admin/dept_edit';
$route['stfemp'] = 'admin/employee';
$route['emadst'] = 'admin/employee_add';
$route['dstf'] = 'admin/employee_delete';
$route['estem'] = 'admin/employee_edit';
$route['slrydtl'] = 'salary/earning';
$route['slryad'] = 'salary/earning_add';
$route['salsv'] = 'salary/earning_save';
$route['slryed'] = 'salary/earning_edit';
$route['payapprv'] = 'approves/payapprove';
$route['slryded'] = 'salary/deduction';
$route['slrydedad'] = 'salary/deduction_add';
$route['slrydedsv'] = 'salary/deduction_save';
$route['slrydeded'] = 'salary/deduction_edit';
$route['deddl'] = 'salary/deduction_delete';
$route['genspl'] = 'salary/generate_slip';
$route['addgen'] = 'salary/generation_add';
$route['vigen'] = 'salary/generation_view';
$route['unapslipdel'] = 'salary/generation_delete';
// CATEGORY ROUTE
$route['catg'] = 'admin/category'; // DASHBOARD
$route['catged'] = 'admin/category_entry'; // ENTRY & UPDATE
$route['scatg'] = 'admin/category_seve'; // SAVE
/*$route['slrydeded'] = 'salary/deduction_edit';
$route['deddl'] = 'salary/deduction_delete';*/
// $route['paysliprep'] = 'reports/payslipreport';
//For Profile
$route['prof'] = 'profile/index';
$route['chngpass'] = 'profile/change_pass';
$route['userlist'] = 'profile/create_user_view';
$route['useredit'] = 'profile/create_user_edit';
$route['usersave'] = 'profile/create_user_save';
// $route['profile'] = 'profiles';
// $route['profile/(:any)/(:any)'] = 'profiles/f_$1_$2';
// $route['profile/(:any)'] = 'profiles/f_$1';