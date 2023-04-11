<div class="main-panel">
    <div class="content-wrapper">
        <div class="card">
            <div class="card-body">
                <h3><?php if ($generation_dtls) {

                        echo "Last Generated Date: " . $generation_dtls->sal_month . ", " . $generation_dtls->sal_year . "";
                    } else {

                        echo "Generate payslip";
                    }

                    ?></h3>
                <div class="row">
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <form method="POST" action="<?php echo site_url("addgen"); ?>">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Date:</label>
                                                <input type="date" name="sal_date" class="form-control required" id="sal_date" value="<?php echo $sys_date; ?>" readonly />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">Category:</label>
                                                <select type="text" class="form-control required" name="category" id="category" required />

                                                <option value="">Select Category</option>

                                                <?php foreach ($category as $c_list) { ?>

                                                    <option value="<?php echo $c_list->id; ?>"><?php echo $c_list->category; ?></option>

                                                <?php
                                                }
                                                ?>

                                                </select>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Month:</label>
                                                <input type="hidden" class="form-control" name="month" id="month" value="" readonly />
                                                <input type="text" class="form-control" name="monthn" id="monthn" value="" readonly />
                                                <!-- <select class="form-control required" name="month" id="month" required>

                                    <option value="">Select Month</option>
                                    <?php //foreach($month_list as $m_list) {
                                    ?>
                                        <option value="<?php //echo $m_list->id; 
                                                        ?>" ><?php //echo $m_list->month_name; 
                                                                                        ?></option>

                                    <?php
                                    //   }
                                    ?>
                                    </select> -->

                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">Year:</label>
                                                <input type="text" class="form-control" name="year" id="year" value="<?php //echo date('Y');
                                                                                                                        ?>" readonly />
                                            </div>

                                        </div>
                                    </div>


                                    <input type="submit" class="btn btn-info" value="Generate New Payslip" />
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
        $(document).ready(function() {

            $('.confirm-div').hide();

            <?php if ($this->session->flashdata('msg')) { ?>

                $('.confirm-div').html('<?php echo $this->session->flashdata('msg'); ?>').show();
            <?php } ?>

            $('#category').change(function() {

                $.ajax({
                    type: "POST",
                    url: "<?= base_url() ?>index.php/salary/get_required_yearmonth",
                    data: {
                        category: $(this).val()
                    },
                    cache: false,
                    success: function(data) {
                        var data = JSON.parse(data)
                        $("#year").val(data.year);
                        $("#month").val(data.month);
                        $("#monthn").val(data.monthn);
                    }
                });

            })

        });
    </script>