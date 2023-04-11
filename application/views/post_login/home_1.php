<!--<div class="daseboard_home">
    <div class="col-sm-3 float-left">
    <div class="left_bar">
    <h2>Quick Links  <i class="fa fa-link" aria-hidden="true"></i></h2>
<?php if( $this->session->userdata['loggedin']['ho_flag'] == "N" ) { ?>
    <ul>
    <li><a href="<?php echo site_url('stock/stock_entry'); ?>">Purchase</a></li>
    <li><a href="<?php echo site_url('trade/sale'); ?>">Sale</a></li>
    <li><a href="<?php echo site_url('socpay/society_payment'); ?>">Customer Payment</a></li>
    <li> <a href="#">Stock Ledger</a></li>
    <li><a href="#">Day Book</a></li>
   
    </ul>
   <?php }else{ ?>
     
    <ul>
    <li><a href="<?php echo site_url('category'); ?>">Add Category</a></li>
    <li><a href="<?php echo site_url('fertilizer/sale_rate'); ?>">Sale Rate Entry</a></li>
    <li><a href="<?php echo site_url('material'); ?>">Add Product</a></li>
    <li><a href="<?php echo site_url('compay/company_payment'); ?>">Company Payment</a></li>
    <li><a href="#">Stock ledger</a></li>
    
    </ul>

   <?php } ?>
    </div>
    </div>

    <div class="col-sm-9 float-left" style="z-index:-1;">
    <div class="daseboardNav"><a href="#">Dashboard</a>  /  Overview </div>

    <div class="row daseSmBoxMain">
		
    <div class="col-sm-4">
        <div class="daseSmBox">
            <div class="subBox">
                <div class="icon"><img src="<?php echo base_url('assets/images/box_f_a.png'); ?>"></div>
                <div class="value"><strong>&#2352;</strong>
               </div>
            </div>
        <h3>Purchase For The Day</h3>
        </div>
    </div>

    <div class="col-sm-4">
        <div class="daseSmBox">
            <div class="subBox">
                <div class="icon2"><img src="<?php echo base_url('assets/images/box_b.png'); ?>"></div>
                <div class="value"><strong>&#2352;</strong>
                </div>
            </div>
        <h3>Purchase For The Month</h3>
        </div>
    </div>

    <div class="col-sm-4">
        <div class="daseSmBox">
            <div class="subBox">
                <div class="icon3"><img src="<?php echo base_url('assets/images/box_c.png'); ?>"></div>
               <div class="value"><strong>&#2352;</strong>
               </div>
            </div>
        <h3>Purchase For The Year</h3>
        </div>
    </div>
			

    <div class="col-sm-4">
        <div class="daseSmBox">
            <div class="subBox">
                <div class="icon4"><img src="<?php echo base_url('assets/images/box_d.png'); ?>"></div>
               <div class="value"><strong>&#2352;</strong>
             </div>
            </div>
        <h3>Sale For The Day</h3>
        </div>
    </div>
			
    <div class="col-sm-4">
        <div class="daseSmBox">
            <div class="subBox">
                <div class="icon5"><img src="<?php echo base_url('assets/images/box_f_e.png'); ?>"></div>
                <div class="value"><strong>&#2352;</strong>
              </div>
            </div>
        <h3>Sale For The Month</h3>
        </div>
    </div>

    <div class="col-sm-4">
        <div class="daseSmBox">
            <div class="subBox">
                <div class="icon6"><img src="<?php echo base_url('assets/images/box_f.png'); ?>"></div>
                <div class="value"><strong>&#2352;</strong>
               </div>
            </div>
        <h3>Sale For The Year</h3>
        </div>
    </div>


    </div>

    </div>

</div>--->

<script>
    var myIndex = 0;
    carousel();

    function carousel() {
        var i;
        var x = document.getElementsByClassName("mySlides");
        for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";  
        }
        myIndex++;
        if (myIndex > x.length) {myIndex = 1}    
        x[myIndex-1].style.display = "block";  
        setTimeout(carousel, 3000); // Change image every 2 seconds
    }
</script>