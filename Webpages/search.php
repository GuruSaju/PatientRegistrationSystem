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
			$nurseid=$_POST['nurseid']; //selecting records 
			$query=mysqli_query($conn, "select * FROM Appointment WHERE NurseId = '$nurseid'"); 
			$num=mysqli_num_rows($query); 
			if($num>0){ //check if more than 0 record found 
        ?>

        <table border="5" cellpadding="5" cellspacing="0" style="border-collapse: collapse;text-align: center;margin: 20px 200px;  width: 70%;" bordercolor="#808080" id="AutoNumber2" bgcolor="#C0C0C0">
            <tr>
			 <td width="45%" align="center">Nurse Id</td>
                <td width="45%" align="center">Appointment Id</td>
               
              
            </tr>

        <?php
			while($row=mysqli_fetch_array($query)){ 
			extract($row); 
        ?>

            <tr>
				 <td>
                    <?php echo $NurseId; ?>
                </td>

                <td>
                    <?php echo $AppointmentId; ?>
                </td>
               

                <!--we will have the edit link here-->

               

            </tr>
			
			
			</div>

            <?php 
			}
            ?>

        </table>
		<div class="form">

            <form id="contactform" method="POST" action="check.php">
			<p class="contact">
                    <label for="AppointmentId">Appointment Id</label>
                </p>
				<input id="AppointmentId" name="AppointmentId" placeholder="Appointment Id" tabindex="1" type="text"> 
					<br>
					<input class="button" name="submit" id="submit" tabindex="5" value="Check" type="submit">
				
			</form>
        <?php 
		}
		else{ 
			
			echo "<h1 style='margin-left: 560px;font-size: 20px;padding: 50px;'>No records found.</h1>"; 
			echo "<a style='margin-left:575px;' class='back_btn' href='index.php'>Back To Search Page</a>";
			
		} 
        ?>