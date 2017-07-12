<?php
session_start();
include "Deo.php";

$date_today= date('Y-m-d H:i:s');
$date_week = date('Y-m-d H:i:s',time()-(7*86400));

echo "Todays Date: $date_today" ;
echo "<br/>";
echo "Last Week Date: $date_week";
echo "<br/><br/>";
echo "Records In Between: <br/>";



$query=mysqli_query($conn,"select * FROM Appointment a inner join Person p ON p.PersonId=a.PersonId  WHERE AppointmentDateTime <='$date_today' and AppointmentDateTime >='$date_week' ");

//count how many records found
?>

<table border="5" cellpadding="5" cellspacing="0" style="border-collapse: collapse" bordercolor="#808080" width="100%" id="AutoNumber2" bgcolor="#C0C0C0">
  <tr>
    <td width="7%" align="center">First Name</td>
    <td width="7%" align="center">Last Name</td>
    <td width="7%" align="center">Address</td>
    <td width="7%" align="center">City</td>
    <td width="7%" align="center">Date Of Birth</td>
    <td width="7%" align="center">Phone No</td>
    <td width="7%" align="center">Appointment Date</td>
    <td width="7%" align="center">Body Temperature</td>
    <td width="7%" align="center">Weight</td>
    <td width="7%" align="center">Height</td>
    <td width="7%" align="center">Systolic Blood Pressure</td>
    <td width="7%" align="center">Diastolic Blood Pressure</td>
  </tr>


<?php
//$num=mysqli_num_rows($query);
  while($row = mysqli_fetch_array($query))
      { 
      extract($row);
      ?>
      
    <tr>
    <td width="7%" align="center"><?php echo $row['FirstName']; ?></td>
    <td width="7%" align="center"><?php echo $row['LastName']; ?></td>
    <td width="7%" align="center"><?php echo $row['AddressLine1']; ?></td>
    <td width="7%" align="center"><?php echo $row['City']; ?></td>
    <td width="7%" align="center"><?php echo $row['DateOfBirth']; ?></td>
    <td width="7%" align="center"><?php echo $row['PhoneNo']; ?></td>
    <td width="7%" align="center"><?php echo $row['AppointmentDateTime']; ?></td>
    <td width="7%" align="center"><?php echo $row['BodyTemperature']; ?></td>
    <td width="7%" align="center"><?php echo $row['Weight']; ?></td>
    <td width="7%" align="center"><?php echo $row['Height']; ?></td>
    <td width="7%" align="center"><?php echo $row['SystolicBloodPressure']; ?></td>
    <td width="7%" align="center"><?php echo $row['DiastolicBloodPressure']; ?></td>

  </tr>

 <?php
	 
      }
	
?>

</table>