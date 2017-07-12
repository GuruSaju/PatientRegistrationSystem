<?php 
session_start(); 
include "Deo.php";
//echo "Done"; 
?>

<!DOCTYPE html>
<html>

<head>
    <title>Updating form</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no" />
    <link rel="stylesheet" type="text/css" href="style.css" media="all" />
    <link rel="stylesheet" type="text/css" href="demo.css" media="all" />
</head>

<body>
    <div class="container">

        <header>
            <h1>Updating form</h1>
        </header>
        <?php 
			//echo "Tamanna";
			$AppointmentId=$_POST['AppointmentId']; 
			//echo $AppointmentId;
		?>
		<?php
			 
			//echo "Shamrin";
			$query=mysqli_query($conn,"SELECT * FROM Appointment WHERE AppointmentId = '$AppointmentId'");
			//echo "Tamanna";
			$num=mysqli_num_rows($query); 
			if($num>0){ 
        
				while($row=mysqli_fetch_array($query)){ 
				extract($row); 
				} 
		?>


			<div class="form">

            <form id="contactform" method="POST" action="">

                <p class="contact">
                    <label for="appointmentdatetime">Appointment Datetime</label>
                </p>
					<input type='text' name='AppointmentDateTime' value='<?php echo $AppointmentDateTime;  ?>' readonly />

                <p class="contact">
                    <label for="bodytemp">Body Temparature</label>
                </p>
                <input type='text' name='BodyTemperature' value='<?php echo $BodyTemperature;  ?>' readonly />

                <p class="contact">
                    <label for="weight">Weight</label>
                </p>
                <input type='text' name='Weight' value='<?php echo $Weight;  ?>' readonly />

                <p class="contact">
                    <label for="height">Height</label>
                </p>
                <input type='text' name='Height' value='<?php echo $Height;  ?>' readonly />

                <p class="contact">
                    <label for="SystolicBloodPressure">Systolic Blood Pressure</label>
                </p>
                <input type='text' name='SystolicBloodPressure' value='<?php echo $SystolicBloodPressure;  ?>' readonly />

                <p class="contact">
                    <label for="DiastolicBloodPressure">Diastolic Blood Pressure</label>
                </p>
                <input type='text' name='DiastolicBloodPressure' value='<?php echo $DiastolicBloodPressure;  ?>' readonly />

                <br>
                <br>


                <!-- so that we could identify what record is to be updated -->
                <a class="back_btn" href="edit.php?id=<?php echo $AppointmentId; ?>">Update Your Data</a>

            </form>

        </div>


        <?php 
		}
		else{ }
        ?>
        

       