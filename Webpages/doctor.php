<?php
session_start();
require_once "Deo.php";
?>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor's Id Lookup</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="style.css" media="all" />
    <link rel="stylesheet" type="text/css" href="demo.css" media="all" />
</head>
<body>
<div class="container" style="position:absolute; width:100%">
    <header>
        <h1>Doctor's Id Lookup</h1>
    </header>
    <?php
    //selecting records
    $query="select * from Doctor";
    $result=mysqli_query($conn,$query);

    echo "<div style=\"position:relative; width:100%;left:25%;right:25%\">
        <table class=\"outputTable;\"><tr style=\"font-weight: bold\">
                        <td>Person Id:</td>
                         <td>State Medical License Number:</td>
                         <td>Highest Medical Degree Earned:</td></tr>";
    while ($row = mysqli_fetch_array($result)) {
        echo "<tr><td>" . $row['PersonId'] . "</td>
                <td>" . $row['StateMedicalLicenseNo'] . "</td>
                <td>" . $row['HighestMedicalDegreeEarned'] . "</td></tr>";
    }
    echo "</table></div>";
    ?>
    <div class="form" style="margin-top:50px; position:relative;">
        <form id="doctorsform" method="POST" action="patients.php">
            <p class="contact"><label for="doctorid">Enter Doctor Id to Locate Doctor's Patients</label></p>
            <input id="doctorid" name="doctorid" placeholder="Doctor's Id" tabindex="1" type="text">
            <br>
            <input class="button" name="submit" id="submit" tabindex="5" value="Check" type="submit">
        </form>
    </div>
</div>

</body>
</html>
