<?php
session_start();
include "Deo.php";
	?>
	
	<!DOCTYPE html>
<html>
<head>
<title>Updating form</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="style.css" media="all" />
    <link rel="stylesheet" type="text/css" href="demo.css" media="all" />
</head>
<body>
<div class="container">
			
			<header>
				<h1>Updating form</h1>
				
<?php
	
if(isset($_REQUEST['id'])){


if(isset($_REQUEST['edit'])){

extract($_REQUEST);

//update the record if the form was submitted

$query=mysqli_query($conn,"UPDATE Appointment SET  AppointmentDateTime='$AppointmentDateTime', BodyTemperature='$BodyTemperature',
Weight='$Weight', Height='$Height',SystolicBloodPressure='$SystolicBloodPressure',DiastolicBloodPressure='$DiastolicBloodPressure'
WHERE AppointmentId='$id'") or die(mysql_error()); ?>

<h2>
				<?php if($query){

//this will be displayed when the query was successful

echo "<div>Record Was Updated Successfully.</div>";

} 			
}
?> 
</h2>
</header> 	

<?php
$id=$_REQUEST['id'];

//this query will select the user data which is to be used to fill up the form

$query=mysqli_query($conn,"select * FROM Appointment WHERE AppointmentId = '$id'") or die(mysqli_error($conn));

$num=mysqli_num_rows($query);

//just a little validation, if a record was found, the form will be shown

//it means that there's an information to be edited

if($num>0){

$row=mysqli_fetch_assoc($query);

extract($row);

?>
				
                  
<div  class="form">

<form id="contactform" method="POST" action=""> 
    			
                
               
    			 
				<p class="contact"><label for="appointmentdatetime">Appointment Datetime</label></p> 
    			<input type='text' name='AppointmentDateTime' value='<?php echo $AppointmentDateTime;  ?>' />
				 
				<p class="contact"><label for="bodytemp">Body Temparature</label></p> 
    			<input type='text' name='BodyTemperature'  value='<?php echo $BodyTemperature;  ?>' />
				 
				<p class="contact"><label for="weight">Weight</label></p> 
    			<input type='text' name='Weight'  value='<?php echo $Weight;  ?>' />
				
				<p class="contact"><label for="height">Height</label></p> 
    			<input type='text' name='Height'  value='<?php echo $Height;  ?>' />
				
				<p class="contact"><label for="SystolicBloodPressure">Systolic Blood Pressure</label></p> 
    			<input type='text' name='SystolicBloodPressure' value='<?php echo $SystolicBloodPressure;  ?>' />
				
				<p class="contact"><label for="DiastolicBloodPressure">Diastolic Blood Pressure</label></p> 
    			<input type='text' name='DiastolicBloodPressure'  value='<?php echo $DiastolicBloodPressure;  ?>' />
				
               <br><br>
            
           
           
			<!-- so that we could identify what record is to be updated -->

<input type='hidden' name='id' value='<?php echo $id ?>' />

<!-- we will set the action to edit -->

<input class="buttom" type='submit' value='Edit' name="edit" />
   
			</form>	  
			
			
			<?php echo "<a class='back_btn' href='index.php'>Back To Search Page</a>"; ?>
		</div>      
</div>

</body>
</html>

<?php

}else{

echo "<div>User with this id is not found.</div>";

}

}

else{

echo "<div> You are not authorized to view this page";

}


?>
