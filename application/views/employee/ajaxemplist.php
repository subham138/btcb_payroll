    <table id="order-listing" class="table">
        <thead>
            <tr>
                <th>Emp code</th>
                <th>Name</th>
                <th>Category</th>
                <th>Department</th>
                <th>District</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
            <?php
            if ($employee_dtls) {
                foreach ($employee_dtls as $e_dtls) {
            ?>
                    <tr>
                        <td><?= $e_dtls->emp_code; ?></td>
                        <td><?= $e_dtls->emp_name; ?></td>
                        <td><?= $e_dtls->category; ?></td>
                        <td><?= $e_dtls->department; ?></td>
                        <td><?= $e_dtls->district_name; ?></td>
                        <td>
                            <a href="estem?emp_code=<?= $e_dtls->emp_code; ?>" data-toggle="tooltip" data-placement="bottom" title="Edit">
                                <i class="fa fa-edit fa-2x" style="color: #007bff"></i>
                            </a>
                        </td>
                        <td>
                            <a type="button" class="delete" id="<?= $e_dtls->emp_code; ?>" data-toggle="tooltip" data-placement="bottom" title="Delete">
                                <i class="fa fa-trash fa-2x"></i>
                            </a>
                        </td>
                    </tr>
            <?php
                }
            } else {
                echo "<tr><td colspan='10' style='text-align: center;'>No data Found</td></tr>";
            }
            ?>
        </tbody>
    </table>