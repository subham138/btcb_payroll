<div class="main-panel">
    <div class="content-wrapper">
        <div class="card">
            <div class="card-body">
                <h3><?php if ($sal_dtls) {

                        echo "Last Generated Date: " . $sal_dtls->sal_month . ", " . $sal_dtls->sal_year . "";
                    } else {

                        echo "Generate payslip";
                    }

                    ?></h3>
                <div class="row">
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <!-- <form method="POST" action="<?php echo site_url("addgen"); ?>"> -->
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-6">
                                            <label for="exampleInputName1">Date:</label>
                                            <input type="date" name="sal_date" class="form-control required" id="sal_date" value="<?= $sal_dtls->trans_date; ?>" readonly />
                                        </div>
                                        <div class="col-6">
                                            <label for="exampleInputName1">Category:</label>
                                            <select type="text" class="form-control required" name="category" id="category" disabled />

                                            <option value="">Select Category</option>

                                            <?php
                                            foreach ($category as $c_list) {
                                                $selected = '';
                                                if ($c_list->id == $sal_dtls->catg_cd) {
                                                    $selected = 'selected';
                                                }
                                            ?>

                                                <option value="<?= $c_list->id; ?>" <?= $selected ?>><?= $c_list->category; ?></option>

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
                                            <input type="text" class="form-control" name="month" id="month" value="<?= date("F", mktime(0, 0, 0, $sal_dtls->sal_month, 10)) ?>" readonly />
                                        </div>
                                        <div class="col-6">
                                            <label for="exampleInputName1">Year:</label>
                                            <input type="text" class="form-control" name="year" id="year" value="<?= $sal_dtls->sal_year; ?>" readonly />
                                        </div>
                                    </div>
                                </div>
                                <div class="row text-white ml-1">
                                    <div class="col-4 p-3" style="background-color: #074fd9;">
                                        <label>TOTAL PAYMENT: </label>
                                        <span><?= $sal_dtls->tot_sal ?></span>
                                    </div>
                                </div>


                                <!-- <input type="submit" class="btn btn-info" value="Generate New Payslip" />
                                    <button class="btn btn-light">Cancel</button>
                                </form> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>