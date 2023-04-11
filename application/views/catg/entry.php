<div class="main-panel">
    <div class="content-wrapper">
        <div class="card">
            <div class="card-body">
                <h3>Employee Category Edit</h3>
                <div class="row">
                    <div class="col-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <form method="POST" id="myform" action="<?php echo site_url("scatg"); ?>">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">Category:</label>
                                                <input type="text" class="form-control" name="category" id="category" value="<?php echo $selected['category']; ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">D.A.(%):</label>
                                                <input type="text" class="form-control" name="da" id="da" value="<?php echo $selected['da']; ?>" />
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">S.A.(%):</label>
                                                <input type="text" class="form-control" name="sa" id="sa" value="<?php echo $selected['sa']; ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">H.R.A.(%):</label>
                                                <input type="text" class="form-control" name="hra" id="hra" value="<?php echo $selected['hra']; ?>" />
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">H.R.A. MAX:</label>
                                                <input type="text" class="form-control" name="hra_max" id="hra_max" value="<?php echo $selected['hra_max']; ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">P.F.(%):</label>
                                                <input type="text" class="form-control required" name="pf" id="pf" value="<?php echo $selected['pf']; ?>" />
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">P.F. MAX:</label>
                                                <input type="text" class="form-control" name="pf_max" id="pf_max" value="<?php echo $selected['pf_max']; ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">P.F. MIN:</label>
                                                <input type="text" class="form-control required" name="pf_min" id="pf_min" value="<?php echo $selected['pf_min']; ?>" />
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-6">
                                                <label for="exampleInputName1">T.A.(%):</label>
                                                <input type="text" class="form-control" name="ta" id="ta" value="<?php echo $selected['ta']; ?>" />
                                            </div>
                                            <div class="col-6">
                                                <label for="exampleInputName1">M.A.(%):</label>
                                                <input type="text" class="form-control required" name="ma" id="ma" value="<?php echo $selected['ma']; ?>" />
                                            </div>

                                        </div>
                                    </div>
                                    <input type="hidden" name="id" value="<?= $selected['id'] ?>">
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