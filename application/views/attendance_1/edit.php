    <div class="wraper">      

        <div class="col-md-6 container form-wraper">

            <form method="POST" 
                action="<?php echo site_url("payroll/attendance/edit");?>" >

                <div class="form-header">

                    <h4>Edit Attendance</h4>

                </div>

                <div class="form-group row">

                    <label for="trans_dt" class="col-sm-2 col-form-label">Date:</label>

                    <div class="col-sm-10">

                        <input type="date"
                                name="trans_dt"
                                class="form-control required"
                                id="trans_dt"
                                value="<?php echo $attendance_dtls->trans_dt;?>"
                                readonly
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="emp_cd" class="col-sm-2 col-form-label">Name:</label>

                    <div class="col-sm-10">

                        <input type="hidden"
                                name="emp_cd"
                                id="emp_cd"
                                value="<?php echo $attendance_dtls->emp_cd;?>"
                                readonly
                        >

                        <input type="text"
                                name="empname"
                                class="form-control required"
                                id="empname"
                                value="<?php echo $attendance_dtls->emp_name;?>"
                                readonly
                        >

                    </div>

                </div>  

                <div class="form-group row">

                <label for="sal_month" class="col-sm-2 col-form-label">Month:</label>

                    <div class="col-sm-4">

                        <select
                                    class="form-control required"
                                    name="sal_month"
				    id="sal_month"
				    required
                        >

                            <option value="">Select Month</option>

                            <?php 
                            
                            foreach($month_list as $m_list) {?>

                                <option value="<?php echo $m_list->month_name; ?>" 
                                        <?php echo ($m_list->month_name == $attendance_dtls->sal_month) ? "selected":""; ?>
                                
                                ><?php echo $m_list->month_name; ?></option>

                            <?php
                            }
                            ?>

                        </select>   

                    </div>
                
                
                    <label for="sal_yr" class="col-sm-2 col-form-label">Year:</label>

                    <div class="col-sm-4">

                        <input type="text"
                            class="form-control required"
                            name="sal_yr"
                            id="sal_yr"
			    value="<?php echo $attendance_dtls->sal_year;?>"
			    required
                        />

                    </div>

                </div>

                <div class="form-group row">

                    <label for="attendance" class="col-sm-2 col-form-label">Attendance:</label>

                    <div class="col-sm-10">

                        <input type = "text"
                            class="form-control required"
                            name = "attendance"
                            id   = "attendance"
                            value="<?php echo $attendance_dtls->no_of_days	;?>"
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
