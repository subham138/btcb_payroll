<!DOCTYPE html>
<html>
    <head><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="<?php echo base_url("/benfed.png"); ?>"> 
        <title>BENFED</title>
         <link href="<?php echo base_url("/assets/css/bootstrap.min.css");?>" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="<?php echo base_url("/assets/css/sb-admin.css");?>">
        <link rel="stylesheet" href="<?php echo base_url("/assets/css/select2.css");?>">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script type="text/javascript" src="<?php echo base_url("/assets/js/validation.js")?>"></script>
        <script type="text/javascript" src="<?php echo base_url("/assets/js/select2.js")?>"></script>
        <script type="text/javascript" src="<?php echo base_url("/assets/js/select2.min.js")?>"></script>
       <link href="<?php echo base_url("/assets/css/bootstrap-toggle.css");?>" rel="stylesheet">
   <!--  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script> -->
     <script type="text/javascript" src="<?php echo base_url("/assets/js/table2excel.js")?>"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="<?php echo base_url("/assets/js/bootstrap-toggle.js")?>" ></script> 
    <link href="<?php echo base_url("/assets/css/jquery.dataTables.css");?>" rel="stylesheet">
    <script type="text/javascript" src="<?php echo base_url("/assets/js/jquery.dataTables.js")?>"></script>
    <style>
        .hr {
            display: block;
            margin-top: 0.5em;
            margin-bottom: 0.5em;
            margin-left: auto;
            margin-right: auto;
            border-style: inset;
            border-width: 1px;
        }
        .transparent_tag {

            background: transparent; 
            border: none;

        }
        .no-border {
            border: 0;
            box-shadow: none;
            width: 75px;
        }

        .tooltip {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black;
}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;

  /* Position the tooltip */
  position: absolute;
  z-index: 1;
}

.tooltip:hover .tooltiptext {
  visibility: visible;
}
    </style>
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i&display=swap" rel="stylesheet"> 
    <link href="<?php echo base_url("/assets/css/apps.css");?>" rel="stylesheet">
    </head>  
    <body id="page-top" style="background-color: #eff3f6;">
        <header class="header_class">
<ul class="header_top">
    <li><strong>Branch Name: </strong><?php if(isset($this->session->userdata['loggedin']['branch_name'])){ echo $this->session->userdata['loggedin']['branch_name'];}?></li>
    <li><strong>Financial Year: </strong><?php if(isset($this->session->userdata['loggedin']['fin_yr'])){ echo $this->session->userdata['loggedin']['fin_yr'];}?></li>
    <li><strong>User: </strong><?php if(isset($this->session->userdata['loggedin']['user_name'])){ echo $this->session->userdata['loggedin']['user_name'];}?></li>
   
    <li class="date"><strong>Date: </strong> <?php echo date("d-m-Y");?></li>
</ul>
</header>
    
        <nav class="navbar navbar-inverse bg-primary">
            
                <div class="col-sm-2 logo_sec_main">
                    <div class="logo_sec">
                    <img src="<?php echo base_url("/benfed.png");?>" />
                    </div>
                </div>
<div class="col-sm-10 navbarSectio">

                    <div class="dropdown">
                    <div class="dropbtn">
                    <a href="<?php echo site_url("Payroll_Login/main");?>" style="color: white; text-decoration: none;"><i class="fa fa-home"></i> Home</a>
                    </div> 
                    </div>
                    <?php if($this->session->userdata['loggedin']['user_type']!="U" ){?>   
                    <div class="dropdown">
                        <div class="dropbtn">
                            <i class="fa fa-university" aria-hidden="true"></i>
                                Master
                            <i class="fa fa-angle-down"></i>
                        </div>
                        
                        <div class="dropdown-content">
                          
                            <div class="sub-dropdown">
                                
                                <a href="<?php echo site_url("vls");?>">Set Parameters</a>
                                <a href="<?php echo site_url("stfemp");?>">Employee</a>
                                <!--<a href="<?php echo site_url("crCatg");?>">Credit Note Category</a>
                                <a href="<?php echo site_url("material");?>">Product</a>
                                <a href="<?php echo site_url("category");?>">Sale Rate Category</a>
                                <a href="<?php echo site_url("rateslab");?>">Sale Rate</a>
                                <a href="<?php echo site_url("BNK");?>">Bank Master</a>
                                <a href="<?php echo site_url("customer");?>">Society</a>
                                <a href="<?php echo site_url("BNK");?>">Bank Master</a>-->
                            </div>

                        </div>
                    
                    </div>

                    <?php } ?>
                    
                    <div class="dropdown">
                        <div class="dropbtn">
                            <i class="fa fa-university" aria-hidden="true"></i>
                                Salary
                              
                            <i class="fa fa-angle-down"></i>
                        </div>

                        <?php if( $this->session->userdata['loggedin']['ho_flag']=="N"){?> 
                        <div class="dropdown-content">
                            <div class="sub-dropdown">
                            
                              <a href="<?php echo site_url("adv/advance");?>">Advance</a>
                              <a href="<?php echo site_url("stock/stock_entry");?>">Purchase</a>
                              <a href="<?php echo site_url("trade/sale");?>">Sale</a>
                              <a href="<?php echo site_url("socpay/society_payment");?>">Customer Payment</a>
                              <a href="<?php echo site_url("drcrnote/dr_note");?>">Credit Note</a>
                              <a href="<?php echo site_url("virtualpnt/virtual_stk_point");?>">Secondary Stock Point</a>
                              
                            </div>
                          
                        </div>
                        <?php } ?>

                        <?php if( $this->session->userdata['loggedin']['ho_flag']=="Y"){?> 
                            <div class="dropdown-content">
                                <div class="sub-dropdown">
                                    <a href="<?php echo site_url("slrydtl");?>">Earnings</a>
                                    <a href="<?php echo site_url("slryded");?>">Deductions</a>
                                    <a href="<?php echo site_url("genspl");?>">Generate Payslip</a>
                                    <a href="<?php echo site_url("payapprv");?>">Approve</a> 
                                </div>
                            </div>
                        <?php } ?>
                    
                    </div> 

                    <div class="dropdown">
                        <div class="dropbtn">
                            <i class="fa fa-university" aria-hidden="true"></i>
                                Leave
                              
                            <i class="fa fa-angle-down"></i>
                        </div>

                        <?php if( $this->session->userdata['loggedin']['ho_flag']=="N"){?> 
                        <div class="dropdown-content">
                            <div class="sub-dropdown">
                            
                              <a href="<?php echo site_url("adv/advance");?>">Advance</a>
                              <a href="<?php echo site_url("stock/stock_entry");?>">Purchase</a>
                              <a href="<?php echo site_url("trade/sale");?>">Sale</a>
                              <a href="<?php echo site_url("socpay/society_payment");?>">Customer Payment</a>
                              <a href="<?php echo site_url("drcrnote/dr_note");?>">Credit Note</a>
                              <a href="<?php echo site_url("virtualpnt/virtual_stk_point");?>">Secondary Stock Point</a>
                              
                            </div>
                          
                        </div>
                        <?php } ?>

                        <?php if( $this->session->userdata['loggedin']['ho_flag']=="Y"){?> 
                            <div class="dropdown-content">
                            <!-- <div class="sub-dropdown">
                            <a href="<?php echo site_url("adv/company_advance");?>">Advance To Company</a>
                            <a href="<?php echo site_url("drcrnote/cr_note");?>">Credit Note</a>
                            <a href="<?php echo site_url("compay/company_payment");?>">Company Payment</a>
                             
                            </div> -->
                          
                        </div>
                    <?php } ?>
                    
                    </div> 


                    
                    <div class="dropdown">
                        <div class="dropbtn">
                            <i class="fa fa-university" aria-hidden="true"></i>
                                Report
                            <i class="fa fa-angle-down"></i>
                        </div>  

                        
                        <div class="dropdown-content">
                            <div class="sub-dropdown">
                                  
                                <?php if( $this->session->userdata['loggedin']['ho_flag']!="Y"){?>

                                    <a href="<?php echo site_url("fert/rep/rateslab");?>">Sale Rate Slab</a>

                                    <a href="<?php echo site_url("fert/rep/stkStmt");?>">Consolidated Stock</a>

                                    <a href="<?php echo site_url("fert/rep/stkScomp");?>">Stock (Companywise)</a>

                                    <a href="<?php echo site_url("fert/rep/stkstkpnt");?>">Stock (Stokpoint Wise)</a>

                                    <a href="<?php echo site_url("fert/rep/stkSprodro");?>">Product (RO wise)</a>

                                    <a href="<?php echo site_url("fert/rep/purrep");?>">Purchase Ledger</a>

                                    <a href="<?php echo site_url("fert/rep/salerep");?>">Sale Ledger</a>

                                    <a href="<?php echo site_url("fert/rep/salerepsoc");?>">Sale Ledger(Society Wise)</a>

                                        <!--<a href="<?php echo site_url("fertilizer/f_cash_bk");?>">Purchase Report</a>
                                        <a href="<?php echo site_url("fertilizer/society_report");?>">Society Report</a> -->
                                   <!--  <a href="<?php echo site_url("fertilizer/stock_ledg_report");?>">Purchase Ledger</a> -->
                                        <!-- <a href="<?php echo site_url("fertilizer/stock_reportcompanywise");?>">Purchase Stock Report(Company Wise)</a> -->
                                        <!-- <a href="<?php echo site_url("fertilizer/f_trial")?>">Return Report</a> -->
                                <?php } ?>
                                <?php if( $this->session->userdata['loggedin']['ho_flag']=="Y"){?>
                                  
                                    <!-- <a href="<?php echo site_url("paysliprep");?>">Payslip</a> -->
                                    <a href="<?php echo site_url('reports/payslipreport'); ?>">Payslip</a>
                                    <a href="<?php echo site_url('reports/paystatementreport'); ?>">Salary Statement Month Wise</a>
                                    <a href="<?php echo site_url('reports/salarycatgreport'); ?>">Category wise Salary List</a>
                                    <a href="<?php echo site_url('reports/totaldeduction'); ?>">Total Deduction</a>
                                    <!-- <a href="<?php echo site_url("fert/rep/salerepbr");?>">Branch Wise Sale</a>
                                    <a href="<?php echo site_url("fert/rep/rateslabho");?>">Sale Rate Slab</a> -->
                                    
                                <?php } ?>

                            </div>
                        </div>

                    </div>

                    <!-- <div class="dropdown">
                    <div class="dropbtn">
                    <a href="<?php //echo site_url("fertilizer/aprvVouDashboard");?>" style="color: white; text-decoration: none;"> Approve</a>
                    </div> 
                    </div> -->

                    <div class="dropdown">
                        <div class="dropbtn">
                                <i class="fa fa-cog fa-spin fa-fw" aria-hidden="true"></i>
                                Setting
                                <i class="fa fa-angle-down"></i>
                            </div>
                            <div class="dropdown-content">
                            <a href="<?php echo site_url("profile") ?>">Change Password</a>
                            <?php  if($this->session->userdata['loggedin']['user_type']!="U"){
                                ?>
                            <a href="<?php echo site_url('admin/user'); ?>">Create User</a>
                            <?php }?>
                            </div>
                        </div>
                    <div class="dropdown">
                    <div class="dropdown">
                        <div class="dropbtn">
                            <a href="<?php echo site_url("Payroll_Login/logout") ?>" style="color: white; text-decoration: none;"><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
                        </div>    
                    </div>    
                </div>
            
        </nav>
    <section>