<?php
session_start();
require_once "Deo.php";
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
            </header>  
			<?php
    //selecting records
    $query="select * from Appointment";
    $result=mysqli_query($conn,$query);

    echo "<div style=\"position:relative; width:100%;left:50%;right:50%\">
        <table class=\"outputTable;\"><tr style=\"font-weight: bold\">
                        <td>Nurse Id:</td>
                         </tr>";
    while ($row = mysqli_fetch_array($result)) {
        echo "<tr><td>" . $row['NurseId'] . "</td>
                </tr>";
    }
    echo "</table></div>";
    ?>
			
			<div  class="form">
    		<form id="contactform" method="POST" action="search.php"> 
    			<p class="contact"><label for="nurseid">Nurse Id</label></p> 
    			<input id="nurseid" name="nurseid" placeholder="Nurse Id" tabindex="1" type="text"> 
    			 <br>
				 <input class="buttom" name="submit" id="submit" tabindex="5" value="Check" type="submit"> 
			</form>	  
    			
           
</div>      
</div>

</body>
</html>
