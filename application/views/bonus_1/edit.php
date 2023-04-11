    <div class="wraper">      

        <div class="col-md-6 container form-wraper">

            <form method="POST" 
                action="<?php echo site_url("payroll/bonus/edit");?>" >

                <div class="form-header">
                
                    <h4>Edit Bonus</h4>
                
                </div>

                <div class="form-group row">

                    <label for="trans_dt" class="col-sm-2 col-form-label">Transaction Date:</label>

                    <div class="col-sm-10">

                        <input type="date"
                                name="trans_dt"
                                class="form-control required"
                                id="trans_dt"
                                value="<?php echo $bonus_dtls->trans_dt;?>"
                                readonly
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="emp_no" class="col-sm-2 col-form-label">Emplyee Name:</label>

                    <div class="col-sm-10">

                        <input type="hidden"
                                name="emp_no"
                                id="emp_no"
                                value="<?php echo $bonus_dtls->emp_no;?>"
                                readonly
                        >

                        <input type="text"
                                name="empname"
                                class="form-control required"
                                id="empname"
                                value="<?php echo $bonus_dtls->emp_name;?>"
                                readonly
                        >

                    </div>

                </div>  

                <div class="form-group row">

                    <label for="month" class="col-sm-2 col-form-label">Select Month:</label>

                        <div class="col-sm-10">

                            <select
                                class="form-control required"
                                name="month"
                                id="month"
                            >

                                <option value="">Select Month</option>

                                <?php 
                                
                                foreach($month_list as $m_list) {?>

                                    <option value="<?php echo $m_list->month_name; ?>" 
                                            <?php echo ($m_list->month_name == $bonus_dtls->month) ? "selected":""; ?>
                                    
                                    ><?php echo $m_list->month_name; ?></option>

                                <?php
                                }
                                ?>

                            </select>   

                        </div>
                </div>

                <div class="form-group row">

                    <label for="year" class="col-sm-2 col-form-label">Input Year:</label>

                    <div class="col-sm-10">

                        <input type="text"
                            class="form-control required"
                            name="year"
                            id="year"
                            value="<?php echo $bonus_dtls->year;?>"
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="bonus_type" class="col-sm-2 col-form-label">Adv/Bonus Type:</label>

                    <div class="col-sm-10">

                        <select
                            class="form-control required"
                            name="bonus_type"
                            id="bonus_type"
                        >

                            <option value="">Select</option>

                            <option value="A" <?php echo ($bonus_dtls->bonus_flag == "A")?"selected":"";?> >Advance</option>

                            <option value="B" <?php echo ($bonus_dtls->bonus_flag == "B")?"selected":"";?>>Bonus</option>
                            
                        </select>

                    </div>

                    </div>

                    <div class="form-group row">

                    <label for="amount" class="col-sm-2 col-form-label">Amount:</label>

                    <div class="col-sm-10">

                        <input type="text"
                            class= "form-control required"
                            name = "amount"
                            id   = "amount"
                            value="<?php echo $bonus_dtls->amount;?>"
                        />

                    </div>

                </div> 

                <div class="form-group row">

                    <div class="col-sm-10">

                        <button type="submit" class="btn btn-info">Save</button>

                    </div>

                </div>

            </form>
        
        </div>

    </div>