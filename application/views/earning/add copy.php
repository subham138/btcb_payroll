      <div class="main-panel">
          <div class="content-wrapper">
              <div class="card">
                  <div class="card-body">
                      <h3>Add Earnings</h3>
                      <div class="row">
                          <div class="col-12 grid-margin stretch-card">
                              <div class="card">
                                  <div class="card-body">
                                      <form method="POST" id="form" action="<?php echo site_url("slryad"); ?>">
                                          <div class="form-group">
                                              <div class="row">
                                                  <div class="col-6">
                                                      <label for="exampleInputName1">Date:</label>
                                                      <input type="date" name="sal_date" class="form-control required" id="sal_date" value="<?php echo $sys_date; ?>" readonly />
                                                  </div>
                                                  <div class="col-6">
                                                      <label for="exampleInputName1">Name:</label>
                                                      <select class="form-control required" name="emp_code" id="emp_code">

                                                          <option value="">Select Employee</option>

                                                          <?php

                                                            if ($emp_list) {

                                                                foreach ($emp_list as $e_list) {

                                                                    foreach ($category  as $catg) {

                                                                        if ($e_list->emp_catg == $catg->category_code) {

                                                            ?>
                                                                          <option value="<?php echo $e_list->emp_code ?>" catg="<?php echo $catg->category_type; ?>"><?php echo $e_list->emp_name; ?></option>

                                                          <?php
                                                                        }
                                                                    }
                                                                }
                                                            }

                                                            ?>

                                                      </select>

                                                  </div>
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <div class="row">
                                                  <div class="col-6">
                                                      <label for="exampleInputName1">Category:</label>
                                                      <input type="text" class="form-control" name="category" id="category" readonly required />
                                                  </div>
                                                  <div class="col-6">
                                                      <label for="exampleInputName1">District:</label>
                                                      <input type="text" class="form-control" name="dist" id="dist" readonly required />
                                                  </div>
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <div class="row">
                                                  <div class="col-6">
                                                      <label for="exampleInputName1">Basic:</label>
                                                      <input type="text" class="form-control" name="basic" id="basic" value=0.00 readonly />
                                                  </div>
                                                  <div class="col-6">
                                                      <label for="exampleInputName1">DA:</label>
                                                      <input type="text" class="form-control" name="da" id="da" value=0.00 />
                                                  </div>
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <div class="row">
                                                  <div class="col-6">
                                                      <label for="exampleInputName1">HRA:</label>
                                                      <input type="text" class="form-control" name="hra" id="hra" value=0.00 />

                                                  </div>
                                                  <div class="col-6">
                                                      <label for="exampleInputName1">Medical Allowance:</label>
                                                      <input type="text" class="form-control" name="ma" id="ma" value=0.00 />
                                                  </div>
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <div class="row">
                                                  <div class="col-6">
                                                      <label for="exampleInputName1">Other Allowance:</label>
                                                      <input type="text" class="form-control" name="oa" id="oa" value=0.00 />
                                                  </div>
                                              </div>
                                          </div>
                                          <button type="submit" class="btn btn-primary mr-2">Submit</button>
                                          <button class="btn btn-light">Cancel</button>
                                      </form>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>

              </div>
          </div>

          <script>
              $("#form").validate({
                  rules: {

                      sal_yr: "required",

                  },
                  messages: {

                      sal_yr: "Please enter valid input"
                  }

              });
          </script>

          <script>
              $(document).ready(function() {

                  $('#emp_code').change(function() {

                      $('#category').val($(this).find(':selected').attr('catg'));

                      $.get(
                              '<?php echo site_url("Salary/f_emp_dtls"); ?>', {
                                  emp_code: $(this).val()
                              }
                          )

                          .done(function(data) {
                              var parseData = JSON.parse(data);
                              // basic=$('#basic').val() 
                              console.log(parseData);
                              $('#dist').val(parseData.district_name)

                          });

                  });

              });
          </script>


          <script>
              $(document).ready(function() {


                  var basic = 0.00;

                  $('#emp_code').change(function() {

                      $.get(

                              '<?php echo site_url("Salary/f_sal_dtls"); ?>', {

                                  emp_code: $(this).val()
                                  // rbt_add =$('#rbt_add').val() 	
                              }

                          )
                          .done(function(data) {
                              var parseData = JSON.parse(data);
                              // basic=$('#basic').val() 
                              console.log(parseData);
                              $('#basic').val(parseData.basic_pay)
                              $('#da').val(parseData.da)
                              $('#hra').val(parseData.hra)
                              $('#ma').val(parseData.ma)

                          });

                  });

              });
          </script>