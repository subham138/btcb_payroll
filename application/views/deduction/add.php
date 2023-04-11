<style>
    .table td .form-group {
        width: 165px;
    }
</style>

<div class="main-panel">
    <div class="content-wrapper">
        <div class="card">
            <div class="card-body">
                <h3>Add Deductions</h3>
                <div class="row">
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <form method="POST" id="form" action="<?php echo site_url("slrydedad"); ?>?catg_id=<?= $selected['catg_id'] ?>&sys_dt=<?= $selected['sal_date'] ?>&flag=<?= $selected['sal_flag'] ?>">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-5">
                                                <label for="exampleInputName1">Date:</label>
                                                <input type="date" name="sal_date" class="form-control required" id="sal_date" value="<?= $selected['sal_date']; ?>" />
                                            </div>
                                            <div class="col-5">
                                                <label for="exampleInputName1">Category:</label>
                                                <select class="form-control required" name="catg_id" id="catg_id">
                                                    <option value="">Select Category</option>
                                                    <?php
                                                    if ($catg_list) {
                                                        $select = '';
                                                        foreach ($catg_list as $catg) {
                                                            if ($selected['catg_id'] == $catg->id) {
                                                                $select = 'selected';
                                                            } else {
                                                                $select = '';
                                                            } ?>
                                                            <option value="<?= $catg->id ?>" <?= $select ?>><?= $catg->category; ?></option>
                                                    <?php }
                                                    } ?>
                                                </select>
                                            </div>
                                            <div class="col-2 float-right">
                                                <label for="exampleInputName1">&nbsp;</label>
                                                <button type="submit" id="submit" name="submit" class="btn btn-primary mr-2 form-control">Populate</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <?php if (isset($_REQUEST['submit'])) {
            $display = '';
            $disabled = '';
            if ($selected['catg_id'] == 2) {
                $display = 'style="display:none;"';
            } ?>
            <div class="card mt-4">
                <div class="card-body">
                    <h3>Add Deductions</h3>
                    <div class="row">
                        <div class="col-12 grid-margin stretch-card">
                            <div class="card">
                                <div class="card-body">
                                    <form method="POST" id="form" action="<?php echo site_url("slrydedsv"); ?>">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="table-responsive" id='permanent'>

                                                    <table class="table table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th>Employee</th>
                                                                <th>GROSS SALARY (after deduction)</th>
                                                                <th>Service P.F.</th>
                                                                <th <?= $display ?>>Adv. agst. H.B. Prin.</th>
                                                                <th <?= $display ?>>Adv. agst. H.B. Int</th>
                                                                <th <?= $display ?>>Adv. agst. H.B. Construction Prin.</th>
                                                                <th <?= $display ?>>Adv. agst. H.B. Construction Int.</th>
                                                                <th <?= $display ?>>Adv. agst. Staff H.B. Extention Prin.</th>
                                                                <th <?= $display ?>>Adv. agst. Staff H.B. Extention Int.</th>
                                                                <th <?= $display ?>>Gross H.B. Int.</th>
                                                                <th <?= $display ?>>Adv. agst of staff with int. Prin.</th>
                                                                <th <?= $display ?>>Adv. agst of staff with int. Int.</th>
                                                                <th>Staff Advance Extension Prin.</th>
                                                                <th>Staff Advance Extension Int.</th>
                                                                <th <?= $display ?>>Motor Cycle / TV Loan Prin.</th>
                                                                <th <?= $display ?>>Motor Cycle / TV Loan Int.</th>
                                                                <th>P.Tax</th>
                                                                <th <?= $display ?>>G.I.C.I</th>
                                                                <th>Puja Adv.</th>
                                                                <th <?= $display ?>>Income Tax TDS.</th>
                                                                <th <?= $display ?>>Union Subs.</th>
                                                                <th>Total Deduction</th>
                                                                <th style="display: none;">NET SALARY</th>
                                                            </tr>

                                                        </thead>
                                                        <tbody>
                                                            <?php
                                                            $tot_pf = 0;
                                                            $tot_adv_agst_hb_prin = 0;
                                                            $tot_adv_agst_hb_int = 0;
                                                            $tot_adv_agst_hb_const_prin = 0;
                                                            $tot_adv_agst_hb_const_int = 0;
                                                            $tot_adv_agst_hb_staff_prin = 0;
                                                            $tot_adv_agst_hb_staff_int = 0;
                                                            $tot_gross_hb_int = 0;
                                                            $tot_adv_agst_of_staff_prin = 0;
                                                            $tot_adv_agst_of_staff_int = 0;
                                                            $tot_staff_adv_ext_prin = 0;
                                                            $tot_staff_adv_ext_int = 0;
                                                            $tot_motor_cycle_prin = 0;
                                                            $tot_motor_cycle_int = 0;
                                                            $tot_p_tax = 0;
                                                            $tot_gici = 0;
                                                            $tot_puja_adv = 0;
                                                            $tot_income_tax_tds = 0;
                                                            $tot_union_subs = 0;
                                                            $tot_tot_diduction = 0;
                                                            $tot_net_sal = 0;
                                                            if ($sal_list) {
                                                                $i = 0;
                                                                foreach ($sal_list as $sal) {
                                                                    if ($sal['gross'] > 0) {
                                                                        $tot_pf += $sal['pf'];
                                                                        $tot_adv_agst_hb_prin += $sal['adv_agst_hb_prin'];
                                                                        $tot_adv_agst_hb_int += $sal['adv_agst_hb_int'];
                                                                        $tot_adv_agst_hb_const_prin += $sal['adv_agst_hb_const_prin'];
                                                                        $tot_adv_agst_hb_const_int += $sal['adv_agst_hb_const_int'];
                                                                        $tot_adv_agst_hb_staff_prin += $sal['adv_agst_hb_staff_prin'];
                                                                        $tot_adv_agst_hb_staff_int += $sal['adv_agst_hb_staff_int'];
                                                                        $tot_gross_hb_int += $sal['gross_hb_int'];
                                                                        $tot_adv_agst_of_staff_prin += $sal['adv_agst_of_staff_prin'];
                                                                        $tot_adv_agst_of_staff_int += $sal['adv_agst_of_staff_int'];
                                                                        $tot_staff_adv_ext_prin += $sal['staff_adv_ext_prin'];
                                                                        $tot_staff_adv_ext_int += $sal['staff_adv_ext_int'];
                                                                        $tot_motor_cycle_prin += $sal['motor_cycle_prin'];
                                                                        $tot_motor_cycle_int += $sal['motor_cycle_int'];
                                                                        $tot_p_tax += $sal['p_tax'];
                                                                        $tot_gici += $sal['gici'];
                                                                        $tot_puja_adv += $sal['puja_adv'];
                                                                        $tot_income_tax_tds += $sal['income_tax_tds'];
                                                                        $tot_union_subs += $sal['union_subs'];
                                                                        $tot_tot_diduction += $sal['tot_diduction'];
                                                                        $tot_net_sal += $sal['net_sal'];
                                                                    }
                                                                    if ($sal['gross'] == 'Fill Income First') {
                                                                        $disabled = 'disabled';
                                                                    } ?>
                                                                    <tr>
                                                                        <td>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="emp_name[]" id="emp_name_<?= $i ?>" value="<?= $sal['emp_name']; ?>" />
                                                                                <input type="hidden" name="emp_code[]" id="emp_code_<?= $i ?>" value="<?= $sal['emp_code'] ?>">
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="gross[]" id="gross_<?= $i ?>" value="<?= $sal['gross']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="pf[]" id="pf_<?= $i ?>" value="<?= $sal['pf']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="adv_agst_hb_prin[]" id="adv_agst_hb_prin_<?= $i ?>" value="<?= $sal['adv_agst_hb_prin']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="adv_agst_hb_int[]" id="adv_agst_hb_int_<?= $i ?>" value="<?= $sal['adv_agst_hb_int']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="adv_agst_hb_const_prin[]" id="adv_agst_hb_const_prin_<?= $i ?>" value="<?= $sal['adv_agst_hb_const_prin']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="adv_agst_hb_const_int[]" id="adv_agst_hb_const_int_<?= $i ?>" value="<?= $sal['adv_agst_hb_const_int']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="adv_agst_hb_staff_prin[]" id="adv_agst_hb_staff_prin_<?= $i ?>" value="<?= $sal['adv_agst_hb_staff_prin']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="adv_agst_hb_staff_int[]" id="adv_agst_hb_staff_int_<?= $i ?>" value="<?= $sal['adv_agst_hb_staff_int']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="gross_hb_int[]" id="gross_hb_int_<?= $i ?>" value="<?= $sal['gross_hb_int']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="adv_agst_of_staff_prin[]" id="adv_agst_of_staff_prin_<?= $i ?>" value="<?= $sal['adv_agst_of_staff_prin']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="adv_agst_of_staff_int[]" id="adv_agst_of_staff_int_<?= $i ?>" value="<?= $sal['adv_agst_of_staff_int']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="staff_adv_ext_prin[]" id="staff_adv_ext_prin_<?= $i ?>" value="<?= $sal['staff_adv_ext_prin']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="staff_adv_ext_int[]" id="staff_adv_ext_int_<?= $i ?>" value="<?= $sal['staff_adv_ext_int']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="motor_cycle_prin[]" id="motor_cycle_prin_<?= $i ?>" value="<?= $sal['motor_cycle_prin']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="motor_cycle_int[]" id="motor_cycle_int_<?= $i ?>" value="<?= $sal['motor_cycle_int']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="p_tax[]" id="p_tax_<?= $i ?>" value="<?= $sal['p_tax']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="gici[]" id="gici_<?= $i ?>" value="<?= $sal['gici']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="puja_adv[]" id="puja_adv_<?= $i ?>" value="<?= $sal['puja_adv']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="income_tax_tds[]" id="income_tax_tds_<?= $i ?>" value="<?= $sal['income_tax_tds']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td <?= $display ?>>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="union_subs[]" id="union_subs_<?= $i ?>" value="<?= $sal['union_subs']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="tot_diduction[]" id="tot_diduction_<?= $i ?>" value="<?= $sal['tot_diduction']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>
                                                                        <td style="display: none;">
                                                                            <div class="form-group">
                                                                                <input type="text" class="form-control" name="net_sal[]" id="net_sal_<?= $i ?>" value="<?= $sal['net_sal']; ?>" onchange="cal_deduction(<?= $i ?>)" />
                                                                            </div>
                                                                        </td>

                                                                    </tr>
                                                            <?php $i++;
                                                                }
                                                            }
                                                            ?>
                                                            <tr>
                                                                <td colspan="2">TOTAL: </td>
                                                                <td><span id="tot_pf"><?= $tot_pf ?></span></td>
                                                                <td <?= $display ?>><span id="tot_adv_agst_hb_prin"><?= $tot_adv_agst_hb_prin ?></span></td>
                                                                <td <?= $display ?>><span id="tot_adv_agst_hb_int"><?= $tot_adv_agst_hb_int ?></span></td>
                                                                <td <?= $display ?>><span id="tot_adv_agst_hb_const_prin"><?= $tot_adv_agst_hb_const_prin ?></span></td>
                                                                <td <?= $display ?>><span id="tot_adv_agst_hb_const_int"><?= $tot_adv_agst_hb_const_int ?></span></td>
                                                                <td <?= $display ?>><span id="tot_adv_agst_hb_staff_prin"><?= $tot_adv_agst_hb_staff_prin ?></span></td>
                                                                <td <?= $display ?>><span id="tot_adv_agst_hb_staff_int"><?= $tot_adv_agst_hb_staff_int ?></span></td>
                                                                <td <?= $display ?>><span id="tot_gross_hb_int"><?= $tot_gross_hb_int ?></span></td>
                                                                <td <?= $display ?>><span id="tot_adv_agst_of_staff_prin"><?= $tot_adv_agst_of_staff_prin ?></span></td>
                                                                <td <?= $display ?>><span id="tot_adv_agst_of_staff_int"><?= $tot_adv_agst_of_staff_int ?></span></td>
                                                                <td><span id="tot_staff_adv_ext_prin"><?= $tot_staff_adv_ext_prin ?></span></td>
                                                                <td><span id="tot_staff_adv_ext_int"><?= $tot_staff_adv_ext_int ?></span></td>
                                                                <td <?= $display ?>><span id="tot_motor_cycle_prin"><?= $tot_motor_cycle_prin ?></span></td>
                                                                <td <?= $display ?>><span id="tot_motor_cycle_int"><?= $tot_motor_cycle_int ?></span></td>
                                                                <td><span id="tot_p_tax"><?= $tot_p_tax ?></span></td>
                                                                <td <?= $display ?>><span id="tot_gici"><?= $tot_gici ?></span></td>
                                                                <td><span id="tot_puja_adv"><?= $tot_puja_adv ?></span></td>
                                                                <td <?= $display ?>><span id="tot_income_tax_tds"><?= $tot_income_tax_tds ?></span></td>
                                                                <td <?= $display ?>><span id="tot_union_subs"><?= $tot_union_subs ?></span></td>
                                                                <td><span id="tot_tot_diduction"><?= $tot_tot_diduction ?></span></td>
                                                                <td style="display: none;"><span id="tot_net_sal"><?= $tot_net_sal ?></span></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="sal_date" value="<?= $selected['sal_date']; ?>">
                                        <input type="hidden" name="catg_id" value="<?= $selected['catg_id']; ?>">
                                        <input type="hidden" name="flag" value="<?= $selected['sal_flag']; ?>">
                                        <div class="mt-3">
                                            <button type="submit" class="btn btn-primary mr-2" <?= $disabled ?>>Submit</button>
                                            <a href="<?= site_url() ?>/slryded" class="btn btn-light">Back</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        <?php } ?>
    </div>

    <script>
        $('#sal_date').on('change', function() {
            var sal_date = $(this).val()
            var catg_id = $('#catg_id').val()
            if (catg_id > 0) {
                $.ajax({
                    type: "GET",
                    url: "<?= site_url() ?>/salary/chk_deduction",
                    data: {
                        "sal_date": sal_date,
                        "catg_id": catg_id
                    },
                    dataType: 'html',
                    success: function(result) {
                        if (result) {
                            alert("You have already entered this month's deduction");
                            $('#submit').attr('disabled', 'disabled')
                        } else {
                            $('#submit').removeAttr('disabled')
                        }
                    }
                });
            }
        })
        $('#catg_id').on('change', function() {
            var catg_id = $(this).val()
            var sal_date = $('#sal_date').val()
            $.ajax({
                type: "GET",
                url: "<?= site_url() ?>/salary/chk_deduction",
                data: {
                    "sal_date": sal_date,
                    "catg_id": catg_id
                },
                dataType: 'html',
                success: function(result) {
                    if (result) {
                        alert("You have already entered this month's deduction");
                        $('#submit').attr('disabled', 'disabled')
                    } else {
                        $('#submit').removeAttr('disabled')
                    }
                }
            });
        })
    </script>

    <script>
        function cal_deduction(id) {
            var gross = $('#gross_' + id).val();
            var pf = $('#pf_' + id).val();
            var adv_agst_hb_prin = $('#adv_agst_hb_prin_' + id).val();
            var adv_agst_hb_int = $('#adv_agst_hb_int_' + id).val();
            var adv_agst_hb_const_prin = $('#adv_agst_hb_const_prin_' + id).val();
            var adv_agst_hb_const_int = $('#adv_agst_hb_const_int_' + id).val();
            var adv_agst_hb_staff_prin = $('#adv_agst_hb_staff_prin_' + id).val();
            var adv_agst_hb_staff_int = $('#adv_agst_hb_staff_int_' + id).val();
            var gross_hb_int = $('#gross_hb_int_' + id).val();
            var adv_agst_of_staff_prin = $('#adv_agst_of_staff_prin_' + id).val();
            var adv_agst_of_staff_int = $('#adv_agst_of_staff_int_' + id).val();
            var staff_adv_ext_prin = $('#staff_adv_ext_prin_' + id).val();
            var staff_adv_ext_int = $('#staff_adv_ext_int_' + id).val();
            var motor_cycle_prin = $('#motor_cycle_prin_' + id).val();
            var motor_cycle_int = $('#motor_cycle_int_' + id).val();
            var p_tax = $('#p_tax_' + id).val();
            var gici = $('#gici_' + id).val();
            var puja_adv = $('#puja_adv_' + id).val();
            var income_tax_tds = $('#income_tax_tds_' + id).val();
            var union_subs = $('#union_subs_' + id).val();
            var tot_diduction = $('#tot_diduction_' + id).val();
            var net_sal = $('#net_sal_' + id).val();
            var total_did = parseInt(pf) + parseInt(adv_agst_hb_prin) + parseInt(adv_agst_hb_int) + parseInt(adv_agst_hb_const_prin) + parseInt(adv_agst_hb_const_int) + parseInt(adv_agst_hb_staff_prin) + parseInt(adv_agst_hb_staff_int) + parseInt(adv_agst_of_staff_prin) + parseInt(adv_agst_of_staff_int) + parseInt(staff_adv_ext_prin) + parseInt(staff_adv_ext_int) + parseInt(motor_cycle_prin) + parseInt(motor_cycle_int) + parseInt(p_tax) + parseInt(gici) + parseInt(puja_adv) + parseInt(income_tax_tds) + parseInt(union_subs)

            var tot_gross_int = parseInt(adv_agst_hb_int) + parseInt(adv_agst_hb_const_int) + parseInt(adv_agst_hb_staff_int)
            $('#gross_hb_int_' + id).val(tot_gross_int)

            $('#tot_diduction_' + id).val(total_did)

            var diduction = parseInt(gross) - parseInt(total_did)
            $('#net_sal_' + id).val(diduction);
            cal_tot_amt();
        }

        function cal_tot_amt() {
            var tot_pf = 0;
            var tot_adv_agst_hb_prin = 0;
            var tot_adv_agst_hb_int = 0;
            var tot_adv_agst_hb_const_prin = 0;
            var tot_adv_agst_hb_const_int = 0;
            var tot_adv_agst_hb_staff_prin = 0;
            var tot_adv_agst_hb_staff_int = 0;
            var tot_gross_hb_int = 0;
            var tot_adv_agst_of_staff_prin = 0;
            var tot_adv_agst_of_staff_int = 0;
            var tot_staff_adv_ext_prin = 0;
            var tot_staff_adv_ext_int = 0;
            var tot_motor_cycle_prin = 0;
            var tot_motor_cycle_int = 0;
            var tot_p_tax = 0;
            var tot_gici = 0;
            var tot_puja_adv = 0;
            var tot_income_tax_tds = 0;
            var tot_union_subs = 0;
            var tot_tot_diduction = 0;
            var tot_net_sal = 0;

            $('input[name="pf[]"]').each(function() {
                tot_pf = parseInt(tot_pf) + parseInt(this.value)
            });
            $('input[name="adv_agst_hb_prin[]"]').each(function() {
                tot_adv_agst_hb_prin = parseInt(tot_adv_agst_hb_prin) + parseInt(this.value)
            });
            $('input[name="adv_agst_hb_int[]"]').each(function() {
                tot_adv_agst_hb_int = parseInt(tot_adv_agst_hb_int) + parseInt(this.value)
            });
            $('input[name="adv_agst_hb_const_prin[]"]').each(function() {
                tot_adv_agst_hb_const_prin = parseInt(tot_adv_agst_hb_const_prin) + parseInt(this.value)
            });
            $('input[name="adv_agst_hb_const_int[]"]').each(function() {
                tot_adv_agst_hb_const_int = parseInt(tot_adv_agst_hb_const_int) + parseInt(this.value)
            });
            $('input[name="adv_agst_hb_staff_prin[]"]').each(function() {
                tot_adv_agst_hb_staff_prin = parseInt(tot_adv_agst_hb_staff_prin) + parseInt(this.value)
            });
            $('input[name="adv_agst_hb_staff_int[]"]').each(function() {
                tot_adv_agst_hb_staff_int = parseInt(tot_adv_agst_hb_staff_int) + parseInt(this.value)
            });
            $('input[name="gross_hb_int[]"]').each(function() {
                tot_gross_hb_int = parseInt(tot_gross_hb_int) + parseInt(this.value)
            });
            $('input[name="adv_agst_of_staff_prin[]"]').each(function() {
                tot_adv_agst_of_staff_prin = parseInt(tot_adv_agst_of_staff_prin) + parseInt(this.value)
            });
            $('input[name="adv_agst_of_staff_int[]"]').each(function() {
                tot_adv_agst_of_staff_int = parseInt(tot_adv_agst_of_staff_int) + parseInt(this.value)
            });
            $('input[name="staff_adv_ext_prin[]"]').each(function() {
                tot_staff_adv_ext_prin = parseInt(tot_staff_adv_ext_prin) + parseInt(this.value)
            });
            $('input[name="staff_adv_ext_int[]"]').each(function() {
                tot_staff_adv_ext_int = parseInt(tot_staff_adv_ext_int) + parseInt(this.value)
            });
            $('input[name="motor_cycle_prin[]"]').each(function() {
                tot_motor_cycle_prin = parseInt(tot_motor_cycle_prin) + parseInt(this.value)
            });
            $('input[name="motor_cycle_int[]"]').each(function() {
                tot_motor_cycle_int = parseInt(tot_motor_cycle_int) + parseInt(this.value)
            });
            $('input[name="p_tax[]"]').each(function() {
                tot_p_tax = parseInt(tot_p_tax) + parseInt(this.value)
            });
            $('input[name="gici[]"]').each(function() {
                tot_gici = parseInt(tot_gici) + parseInt(this.value)
            });
            $('input[name="puja_adv[]"]').each(function() {
                tot_puja_adv = parseInt(tot_puja_adv) + parseInt(this.value)
            });
            $('input[name="income_tax_tds[]"]').each(function() {
                tot_income_tax_tds = parseInt(tot_income_tax_tds) + parseInt(this.value)
            });
            $('input[name="union_subs[]"]').each(function() {
                tot_union_subs = parseInt(tot_union_subs) + parseInt(this.value)
            });
            $('input[name="tot_diduction[]"]').each(function() {
                tot_tot_diduction = parseInt(tot_tot_diduction) + parseInt(this.value)
            });
            $('input[name="net_sal[]"]').each(function() {
                tot_net_sal = parseInt(tot_net_sal) + parseInt(this.value)
            });
            $('#tot_pf').text(tot_pf);
            $('#tot_adv_agst_hb_prin').text(tot_adv_agst_hb_prin);
            $('#tot_adv_agst_hb_int').text(tot_adv_agst_hb_int);
            $('#tot_adv_agst_hb_const_prin').text(tot_adv_agst_hb_const_prin);
            $('#tot_adv_agst_hb_const_int').text(tot_adv_agst_hb_const_int);
            $('#tot_adv_agst_hb_staff_prin').text(tot_adv_agst_hb_staff_prin);
            $('#tot_adv_agst_hb_staff_int').text(tot_adv_agst_hb_staff_int);
            $('#tot_gross_hb_int').text(tot_gross_hb_int);
            $('#tot_adv_agst_of_staff_prin').text(tot_adv_agst_of_staff_prin);
            $('#tot_adv_agst_of_staff_int').text(tot_adv_agst_of_staff_int);
            $('#tot_staff_adv_ext_prin').text(tot_staff_adv_ext_prin);
            $('#tot_staff_adv_ext_int').text(tot_staff_adv_ext_int);
            $('#tot_motor_cycle_prin').text(tot_motor_cycle_prin);
            $('#tot_motor_cycle_int').text(tot_motor_cycle_int);
            $('#tot_p_tax').text(tot_p_tax);
            $('#tot_gici').text(tot_gici);
            $('#tot_puja_adv').text(tot_puja_adv);
            $('#tot_income_tax_tds').text(tot_income_tax_tds);
            $('#tot_union_subs').text(tot_union_subs);
            $('#tot_tot_diduction').text(tot_tot_diduction);
            $('#tot_net_sal').text(tot_net_sal);
        }
    </script>

    <script>
        $(document).ready(function() {
            var catg_id = <?= $selected['catg_id'] ?> > 0 ? <?= $selected['catg_id'] ?> : 0;
            if (catg_id > 0) {
                $('#sal_date').attr('readonly', 'readonly')
                <?php if (!isset($_REQUEST['submit'])) { ?>
                    $('#submit').click();
                <?php } ?>
            }
        })
    </script>