<?php
session_start();
include "Deo.php";
?>

<!DOCTYPE html>
    <html>
    <head>
        <title>Edit Diagnosis</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" type="text/css" href="style.css" media="all" />
        <link rel="stylesheet" type="text/css" href="demo.css" media="all" />
    </head>
<body>
<div class="container">
    <header>
        <h1>Edit Diagnosis</h1>
    </header>
    <?php

    if(isset($_REQUEST['diagnosisid'])){


    if(isset($_REQUEST['edit'])){

    extract($_REQUEST);

    //update the record if the form was submitted
    $query = "update Diagnosis set Notes = '$Notes', DiagnosisDate = '$DiagnosisDate' where DiagnosisId = '$diagnosisid'";
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
    $diagnosisid=$_REQUEST['diagnosisid'];

    //this query will select the user data which is to be used to fill up the form
    $query = "select d.DiagnosisId, d.Notes, d.DiagnosisDate, d.MedicalConditionId, d.PersonId from Diagnosis d where d.DiagnosisId = '$diagnosisid'";
    $results=mysqli_query($conn,$query) or die(mysqli_error($conn));

    $num=mysqli_num_rows($results);

    //just a little validation, if a record was found, the form will be shown

    //it means that there's an information to be edited

    if($num>0){

    $row=mysqli_fetch_assoc($results);

    extract($row);

    ?>

    <div  class="form">

        <form id="diagnosisform" method="POST" action="">


            <p class="contact"><label for="diagnosisid">Diagnosis Id</label></p>
            <input type='text' name='DiagnosisId' readonly value='<?php echo $DiagnosisId;  ?>' />

            <p class="contact"><label for="notes">Notes</label></p>
            <input type='text' name='Notes' value='<?php echo $Notes;  ?>' />

            <p class="contact"><label for="diagnosisdate">Diagnosis Date</label></p>
            <input type='text' name='DiagnosisDate' value='<?php echo $DiagnosisDate;  ?>' />

            <p class="contact"><label for="personid">Person Id</label></p>
            <input type='text' name='PersonId' readonly value='<?php echo $PersonId;  ?>' />

            <p class="contact"><label for="medicalconditionid">Medical Condition Id</label></p>
            <input type='text' name='MedicalConditionId' readonly value='<?php echo $MedicalConditionId;  ?>' />

            <br><br>

            <!-- so that we could identify what record is to be updated -->

            <input type='hidden' name='diagnosisid' value='<?php echo $diagnosisid ?>' />

            <!-- we will set the action to edit -->

            <input class="button" type='submit' value='Submit Edits' name="edit" />
        </form>
        <?php echo "<a class='back_btn' href='doctor.php'>Back To Doctor Page</a>"; ?>
    </div>
</div>

<?php

}else{

    echo "<div style=\"text-align:center;\">Diagnosis with Diagnosis Id '$diagnosisid' is not found.</div>";
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