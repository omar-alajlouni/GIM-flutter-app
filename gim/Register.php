<?php
  require_once('DB_connect.php');   
  $username = $_POST["Name"];
  $national_number = $_POST["NationalNumber"];
  $phone = $_POST["Phone"];
  $city_id = $_POST["City_id"];
  $password = $_POST["Password"];
  $username = mysqli_real_escape_string($con, $username);
  //escape inverted comma query conflict from string
  $sql = "INSERT INTO citizens (Name, NationalNumber, Phone, City_id, Password) VALUES ($username, $national_number, $city_id, $password)";
  //building SQL query
  if(mysqli_query($con, $sql)){
    echo json_encode(array('result' => true,'msg'=> 'citez added successfully')); 
  }
  else{
    echo json_encode(array('result' => false,'msg'=> 'phone is exist')); 
  }
  //converting array to JSON string
/*
$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
//require_once('DB_connecct.php'); 
$json = file_get_contents('php://input');
$obj = json_decode($json,true);   
$name = $obj['Name'];   
$phone = $obj['Phone'];   
$password = $obj['Password'];
$national_number = $obj['NationalNumber'];
$mac = $obj['MAC'];
// Checking whether Email is Already Exist or Not in MySQL Table.
$CheckSQL = "SELECT * FROM citizens WHERE Phone='$phone'";
// Executing Email Check MySQL Query.
$check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));   
if(isset($check)){   
  $phoneExist = 'This Phone Number Already Exist, Please Try Again With New Number..!';   
  // Converting the message into JSON format.
  $existPhoneJSON = json_encode($phoneExist);   
  // Echo the message on Screen.
  echo $existPhoneJSON ;  
}
else{
  // Creating SQL query and insert the record into MySQL database table.
  $Sql_Query = "INSERT INTO citizens (Name,Phone,Password,NationalNumber,MAC) values ('$name','$phone','$password','$National_Number','$MAC')";
  if(mysqli_query($con,$Sql_Query)){   
    // If the record inserted successfully then show the message.
    $MSG = 'User Registered Successfully' ;     
    // Converting the message into JSON format.
    $json = json_encode($MSG);     
    // Echo the message.
    echo $json ; 
  }
  else{   
    echo 'Try Again'; 
  }
}
mysqli_close($con);
*/
?>
/*
upload images to the server using PHP from Flutter App
https://www.fluttercampus.com/guide/8/how-to-use-image-picker-and-upload-file-to-php-server/
*/