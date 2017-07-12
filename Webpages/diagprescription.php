<?php
session_start();
include "Deo.php";
?>

<!DOCTYPE html>
    <html>
    <head>
        <title>Patients</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no"/>
        <link rel="stylesheet" type="text/css" href="style.css" media="all" />
        <link rel="stylesheet" type="text/css" href="demo.css" media="all" />
    </head>
<body>
<div class="container" style="position:absolute; width:100%">
    <header>
        <h1>Patient Diagnoses and Prescriptions</h1>
    </header>
    <?php
    $personid=$_POST['personid'];

    //selecting records
    $query="select d.DiagnosisId, d.Notes, d.DiagnosisDate, d.MedicalConditionId, pr.* from Person p inner join Diagnosis d on p.PersonId = d.PersonId inner join Prescription pr on pr.PersonID = p.PersonId where p.PersonId = '$personid';";
    $result=mysqli_query($conn,$query);

    $num=mysqli_num_rows($result); //count how many records are found

    if($num>0){ //check if more than 0 record found
        echo "<div style=\"position:relative; left:5%\">
        <table class=\"outputTable;\"><tr style=\"font-weight: bold\">
                <td>Diagnosis Id:</td>
                <td>Notes:</td>
                <td>Diagnosis Date:</td>
                <td>Person Id:</td>
                <td>Medical Condition Id:</td>
                <td>Prescription Id:</td>
                <td>Prescription No:</td>
                <td>Date Prescribed:</td>
                <td>Quantity:</td>
                <td>Frequency:</td>
                <td>Per Time Frame:</td>
                <td>Medication Id:</td>
                <td>Person Id:</td>
                <td>Organization Id:</td></tr>";
        while ($row = mysqli_fetch_array($result)) {
            echo "<tr><td>" . $row['DiagnosisId'] . "</td>
                <td>" . $row['Notes'] . "</td>
                <td>" . $row['DiagnosisDate'] . "</td>
                <td>" . $row['PersonId'] . "</td>
                <td>" . $row['MedicalConditionId'] . "</td>
                <td>" . $row['PrescriptionId'] . "</td>
                <td>" . $row['PrescriptionNo'] . "</td>
                <td>" . $row['DatePrescribed'] . "</td>
                <td>" . $row['Quantity'] . "</td>
                <td>" . $row['Frequency'] . "</td>
                <td>" . $row['PerTimeFrame'] . "</td>
                <td>" . $row['MedicationId'] . "</td>
                <td>" . $row['PersonId'] . "</td>
                <td>" . $row['OrganizationId'] . "</td></tr>";
        }
        echo "</table></div>";
    ?>
    <div  class="form" style="margin-top:50px">
        <form id="diagnosisidform" method="POST" action="editDiagnosis.php">
            <p class="contact"><label for="diagnosisid">Enter a Person's Diagnosis Id to Edit it</label></p>
            <input id="diagnosisid" name="diagnosisid" placeholder="Diagnosis Id" tabindex="1" type="text">
            <br>
            <input class="button" name="submit" id="submit" tabindex="5" value="Edit" type="submit">
        </form>
    </div>

    <div  class="form" style="margin-top:50px">
        <form id="prescriptionidform" method="POST" action="editPrescription.php">
            <p class="contact"><label for="prescriptionid">Enter a Person's Prescription Id to Edit it</label></p>
            <input id="prescriptionid" name="prescriptionid" placeholder="Prescription Id" tabindex="1" type="text">
            <br>
            <input class="button" name="submit" id="submit" tabindex="5" value="Edit" type="submit">
        </form>
    </div>    
</div>

<?php
}else{ //if no records found
    ?><div style="text-align:center">
        No records found.
        <br>
        <br>
        <a class='back_btn' href='doctor.php'>Back To Doctor Page</a>
    </div>
<?php
}

?>
</body>
</html>