<?php
session_start();
include "Deo.php";
?>

<!DOCTYPE html>
    <html>
    <head>
        <title>Patients</title>
<!--        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">-->
<!--        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no"/>-->
        <link rel="stylesheet" type="text/css" href="style.css" media="all" />
        <link rel="stylesheet" type="text/css" href="demo.css" media="all" />
    </head>
<body>
<div class="container" style="position:absolute; width:100%">
    <header>
        <h1>Patients</h1>
    </header>
    <?php
    $doctorid=$_POST['doctorid'];

    //selecting records
    $query="select p.PersonId
    ,d.StateMedicalLicenseNo
    ,d.HighestMedicalDegreeEarned
    ,p.PrimCareDrId
    ,FirstName
    ,MiddleName
    ,LastName
    ,SSN
    ,AddressLine1
    ,AddressLine2
    ,City
    ,State
    ,ZIPCode
    ,DateOfBirth
    ,PhoneNo from Doctor d inner join Person p on p.PrimCareDrId = d.PersonId where StateMedicalLicenseNo = '$doctorid'";
    $result=mysqli_query($conn,$query);

    $num=mysqli_num_rows($result); //count how many records are found

    if($num>0){ //check if more than 0 record found
        echo "<div style=\"position:relative; left:5%\">
        <table class=\"outputTable;\"><tr style=\"font-weight: bold\">
                        <td>Person Id:             </td>
                         <td>First Name:            </td>
                         <td>Middle Name:           </td>
                         <td>Last Name:             </td>
                         <td>SSN:                   </td>
                         <td>Address Line 1:        </td>
                         <td>Address Line 2:        </td>
                         <td>City:                  </td>
                         <td>State:                 </td>
                         <td>ZIPCode:               </td>
                         <td>Date Of Birth:         </td>
                         <td>Phone Number:          </td>
                         <td>Primary Care Doctor Id:</td></tr>";
        while ($row = mysqli_fetch_array($result)) {
            echo "<tr><td>" . $row['PersonId'] . "</td>
                <td>" . $row['FirstName'] . "</td>
                <td>" . $row['MiddleName'] . "</td>
                <td>" . $row['LastName'] . "</td>
                <td>" . $row['SSN'] . "</td>;
                <td>" . $row['AddressLine1'] . "</td>
                <td>" . $row['AddressLine2'] . "</td>
                <td>" . $row['City'] . "</td>
                <td>" . $row['State'] . "</td>
                <td>" . $row['ZIPCode'] . "</td>
                <td>" . $row['DateOfBirth'] . "</td>
                <td>" . $row['PhoneNo'] . "</td>
                <td>" . $row['PrimCareDrId'] . "</td></tr>";
        }
        echo "</table></div>";
    ?>
    <div  class="form" style="margin-top:50px">
        <form id="patientsform" method="POST" action="diagprescription.php">
            <p class="contact"><label for="personid">Enter Person's Id to Locate Person's Diagnoses and Prescriptions</label></p>
            <input id="personid" name="personid" placeholder="Person's Id" tabindex="1" type="text">
            <br>
            <input class="button" name="submit" id="submit" tabindex="5" value="Check" type="submit">
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