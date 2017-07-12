<?php
session_start();
include "Deo.php";
?>

<!DOCTYPE html>
    <html>
    <head>
        <title>Edit Prescription</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" type="text/css" href="style.css" media="all" />
        <link rel="stylesheet" type="text/css" href="demo.css" media="all" />
    </head>
<body>
<div class="container">
    <header>
        <h1>Edit Prescription</h1>
    </header>
    <?php

    if(isset($_REQUEST['prescriptionid'])){


    if(isset($_REQUEST['edit'])){

    extract($_REQUEST);

    //update the record if the form was submitted
    $query = "update Prescription
            set
            PrescriptionNo = '$PrescriptionNo'
            ,DatePrescribed = '$DatePrescribed'
            ,Quantity = '$Quantity'
            ,Frequency = '$Frequency'
            ,PerTimeFrame = '$PerTimeFrame'
            where prescriptionid = '$prescriptionid'";
    $results=mysqli_query($conn,$query) or die(mysql_error()); ?>

    <h2>
        <?php if($results){

//this will be displayed when the query was successful

            echo "<div style=\"text-align:center\">Record Was Updated Successfully.</div>";
        }
        }
        ?>
    </h2>
    </header>

    <?php
    $prescriptionid=$_REQUEST['prescriptionid'];

    //this query will select the user data which is to be used to fill up the form
    $query="select * from Prescription where PrescriptionId = '$prescriptionid'";
    $results=mysqli_query($conn,$query) or die(mysqli_error($conn));

    $num=mysqli_num_rows($results);

    //just a little validation, if a record was found, the form will be shown

    //it means that there's an information to be edited

    if($num>0){

        $row=mysqli_fetch_assoc($results);

        extract($row);

    ?>

    <div class="form">

        <form id="prescriptionform" method="POST" action="">

            <p class="contact"><label for="prescriptionid">Prescription Id</label></p>
            <input type='text' name='PrescriptionId' readonly value='<?php echo $PrescriptionId;  ?>' />

            <p class="contact"><label for="prescriptionno">Prescription Number</label></p>
            <input type='text' name='PrescriptionNo' value='<?php echo $PrescriptionNo;  ?>' />

            <p class="contact"><label for="dateprescribed">Date Prescribed</label></p>
            <input type='text' name='DatePrescribed' value='<?php echo $DatePrescribed;  ?>' />

            <p class="contact"><label for="quantity">Quantity</label></p>
            <input type='text' name='Quantity' value='<?php echo $Quantity;  ?>' />

            <p class="contact"><label for="frequency">Frequency</label></p>
            <input type='text' name='Frequency' value='<?php echo $Frequency;  ?>' />

            <p class="contact"><label for="pertimeframe">Per Time Frame</label></p>
            <input type='text' name='PerTimeFrame' value='<?php echo $PerTimeFrame;  ?>' />

            <p class="contact"><label for="medicationid">Medication Id</label></p>
            <input type='text' name='medicationid' readonly value='<?php echo $MedicationId;  ?>' />

            <p class="contact"><label for="personid">Person Id</label></p>
            <input type='text' name='PersonId' readonly value='<?php echo $PersonId;  ?>' />

            <p class="contact"><label for="organizationid">Organization Id</label></p>
            <input type='text' name='OrganizationId' readonly value='<?php echo $OrganizationId;  ?>' />

            <br><br>

            <!-- so that we could identify what record is to be updated -->

            <input type='hidden' name='prescriptionid' value='<?php echo $prescriptionid ?>' />

            <!-- we will set the action to edit -->

            <input class="button" type='submit' value='Submit Edits' name="edit" />

        </form>
        <?php echo "<a class='back_btn' href='doctor.php'>Back To Doctor Page</a>"; ?>
    </div>
</div>

<?php

}else{

    echo "<div style=\"text-align:center;\">Prescription with the Prescription Id '$prescriptionid' is not found.</div>";
    echo "<br /><br />";
    echo "<div style=\"text-align:center;\"><a class='back_btn' href='doctor.php'>Back To Doctor Page</a></div>";
}

}
else{
    echo "<div> You are not authorized to view this page";
}
?>
</body>
</html>