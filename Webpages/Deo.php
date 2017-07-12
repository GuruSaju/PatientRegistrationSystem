<?php

$conn = mysqli_connect("onyx.boisestate.edu", "root", "grad2015", "AllTeam", 4655);

if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}
//if ($mysqli_connect_errno) {
//    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
//}
else{
//echo "Successfull";

}



?>