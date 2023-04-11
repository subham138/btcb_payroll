    <style>
        .has-float-label {
            display: block;
            position: relative
        }

        .has-float-label label,
        .has-float-label>span {
            position: absolute;
            cursor: text;
            font-size: 75%;
            opacity: 1;
            -webkit-transition: all .2s;
            transition: all .2s;
            top: -.5em;
            left: .75rem;
            z-index: 3;
            line-height: 1;
            padding: 0 1px
        }

        .has-float-label label::after,
        .has-float-label>span::after {
            content: " ";
            display: block;
            position: absolute;
            background: #fff;
            height: 2px;
            top: 50%;
            left: -.2em;
            right: -.2em;
            z-index: -1
        }

        .has-float-label .form-control::-webkit-input-placeholder {
            opacity: 1;
            -webkit-transition: all .2s;
            transition: all .2s
        }

        .has-float-label .form-control:placeholder-shown:not(:focus)::-webkit-input-placeholder {
            opacity: 0
        }

        .has-float-label .form-control:placeholder-shown:not(:focus)+* {
            font-size: 150%;
            opacity: .5;
            top: .3em
        }

        .input-group .has-float-label {
            display: table-cell
        }

        .input-group .has-float-label .form-control {
            border-radius: .25rem
        }

        .input-group .has-float-label:not(:last-child),
        .input-group .has-float-label:not(:last-child) .form-control {
            border-bottom-right-radius: 0;
            border-top-right-radius: 0;
            border-right: 0
        }

        .input-group .has-float-label:not(:first-child),
        .input-group .has-float-label:not(:first-child) .form-control {
            border-bottom-left-radius: 0;
            border-top-left-radius: 0
        }

        .has-float-label .form-control:placeholder-shown:not(:focus)+* {
            font-size: 100%;
            opacity: .7;
            top: 0.7em;
        }

        /* password validation */
        /* The message box is shown when the user clicks on the password field */
        #message {
            display: none;
            /* background: #f1f1f1; */
            color: #000;
            position: relative;
            padding-left: 20px;
            /* margin-top: 10px; */
        }

        #message p {
            padding: 6px 35px;
            font-size: 14px;
        }

        /* Add a green text color and a checkmark when the requirements are right */
        .valid {
            color: green;
        }

        .valid:before {
            position: relative;
            left: -35px;
            content: "✔";
        }

        /* Add a red text color and an "x" when the requirements are wrong */
        .invalid {
            color: red;
        }

        .invalid:before {
            position: relative;
            left: -35px;
            content: "✖";
        }
    </style>
    <div class="main-panel">
        <div class="content-wrapper">
            <div class="card">
                <div class="card-body">
                    <h3>Change Password</h3>
                    <?php if ($this->session->flashdata('msg')) { ?>
                        <div class="alert <?= $this->session->flashdata('style') ?>" role="alert">
                            <?php echo $this->session->flashdata('msg'); ?>
                        </div>
                    <?php } ?>
                    <div class="row">
                        <div class="col-12 grid-margin stretch-card">
                            <div class="card">
                                <div class="card-body">
                                    <form method="POST" id="form" action="<?= site_url(); ?>/profile/pass_save">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-5">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <label for="exampleInputName1">Current Password:</label>
                                                            <input type="password" name="old_pass" class="form-control" id="old_pass" value="" required />
                                                        </div>
                                                    </div>
                                                    <div class="row mt-3">
                                                        <div class="col-12">
                                                            <label for="exampleInputName1">Enter Password:</label>
                                                            <input type="password" name="pass" class="form-control" id="pass" value="" required />
                                                        </div>
                                                    </div>
                                                    <div class="row mt-3">
                                                        <div class="col-12">
                                                            <label for="exampleInputName1">Re-Enter Password:</label>
                                                            <input type="password" name="re_pass" class="form-control" id="re_pass" value="" required />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-7">
                                                    <div id="message">
                                                        <h5>Password must contain the following:</h5>
                                                        <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
                                                        <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
                                                        <p id="number" class="invalid">A <b>number</b></p>
                                                        <p id="char" class="invalid">A <b>special character</b></p>
                                                        <p id="length" class="invalid">Minimum <b>8 characters</b></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-warning text-white mr-2" onclick="return check_submit();">Submit</button>
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
            var myInput = document.getElementById("pass");
            var letter = document.getElementById("letter");
            var capital = document.getElementById("capital");
            var number = document.getElementById("number");
            var length = document.getElementById("length");
            var character = document.getElementById("char");
            var pass_val = false;
            var pass_chk = false;

            $('#pass').keyup(function() {
                // Validate lowercase letters
                var lowerCaseLetters = /[a-z]/g;
                if (myInput.value.match(lowerCaseLetters)) {
                    letter.classList.remove("invalid");
                    letter.classList.add("valid");
                } else {
                    letter.classList.remove("valid");
                    letter.classList.add("invalid");
                }

                // Validate capital letters
                var upperCaseLetters = /[A-Z]/g;
                if (myInput.value.match(upperCaseLetters)) {
                    capital.classList.remove("invalid");
                    capital.classList.add("valid");
                } else {
                    capital.classList.remove("valid");
                    capital.classList.add("invalid");
                }

                // Validate numbers
                var numbers = /[0-9]/g;
                if (myInput.value.match(numbers)) {
                    number.classList.remove("invalid");
                    number.classList.add("valid");
                } else {
                    number.classList.remove("valid");
                    number.classList.add("invalid");
                }

                // Special character
                var char = /[#?!@$%^&*-]/g;
                if (myInput.value.match(char)) {
                    character.classList.remove("invalid");
                    character.classList.add("valid");
                } else {
                    character.classList.remove("valid");
                    character.classList.add("invalid");
                }

                // Validate length
                if (myInput.value.length >= 8) {
                    length.classList.remove("invalid");
                    length.classList.add("valid");
                } else {
                    length.classList.remove("valid");
                    length.classList.add("invalid");
                }

                if (myInput.value.match(lowerCaseLetters) && myInput.value.match(upperCaseLetters) && myInput.value.match(numbers) && myInput.value.match(char) && myInput.value.length >= 8) {
                    pass_val = true;
                } else {
                    pass_val = false;
                }
            }).focus(function() {
                // focus code here
                $("#message").show();
            }).blur(function() {
                // blur code here
                $("#message").hide();
            });

            $('#pass').on('change', function() {
                var re_pass = $('#re_pass').val(),
                    pass = $(this).val();
                if (re_pass != '') {
                    if (pass == re_pass) {
                        $('#re_pass').removeClass('is-invalid');
                        pass_chk = true;
                    } else {
                        $('#re_pass').addClass('is-invalid');
                        alert('Please Enter Correct Password');
                        pass_chk = false;
                    }
                } else {
                    pass_chk = false;
                }
            });
            $('#re_pass').on('change', function() {
                var pass = $('#pass').val(),
                    re_pass = $(this).val();
                if (re_pass != '') {
                    if (pass == re_pass) {
                        $('#re_pass').removeClass('is-invalid');
                        pass_chk = true;
                    } else {
                        $('#re_pass').addClass('is-invalid');
                        alert('Please Enter Correct Password')
                        pass_chk = false;
                    }
                } else {
                    pass_chk = false;
                }
            });

            function check_submit() {
                if (pass_chk) {
                    return true;
                } else {
                    if (!pass_chk) {
                        alert('Please Enter Correct Password')
                    }
                    if (!pass_val) {
                        $('#pass').addClass('is-invalid');
                        alert('Please match the password credentials');
                    } else {
                        $('#pass').removeClass('is-invalid');
                    }
                    return false;
                }
            }
        </script>