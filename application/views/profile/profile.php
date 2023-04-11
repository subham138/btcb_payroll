    <div class="main-panel">
        <div class="content-wrapper">
            <div class="card">
                <div class="card-body">
                    <h3>Profile</h3>
                    <?php if ($this->session->flashdata('msg')) { ?>
                        <div class="alert <?= $this->session->flashdata('style') ?>" role="alert">
                            <?php echo $this->session->flashdata('msg'); ?>
                        </div>
                    <?php } ?>
                    <div class="row">
                        <div class="col-12 grid-margin stretch-card">
                            <div class="card">
                                <div class="card-body">
                                    <form method="POST" id="form" action="<?= site_url(); ?>/profile/prof_save">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-6">
                                                    <label for="exampleInputName1">Name:</label>
                                                    <input type="text" name="user_name" class="form-control" id="user_name" value="<?= $user->user_name ?>" required />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-6">
                                                    <label for="exampleInputName1">User ID:</label>
                                                    <input type="text" name="user_id" class="form-control" id="user_id" value="<?= $user->user_id ?>" readonly />
                                                </div>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-warning text-white mr-2">Submit</button>
                                        <button class="btn btn-light">Cancel</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>