<?php 
  require_once('DB_connect.php');
  $phone = $_POST["Phone"];
  $password = $_POST["Password"];
  $sql = "SELECT * FROM citizens where Phone = '$phone' and  Password = '$password'";
  $res = mysqli_query($con, $sql);
  if(mysqli_num_rows($res)>0){
    $row = mysqli_fetch_array($res);   //?????????   must be phone and password
    echo json_encode(array('result' => true,'Id'=> $row['Id'],'Name'=> $row['Name'],'NationalNumber'=> $row['NationalNumber'])); 
  }
  else{
    echo json_encode(array('result' => false,'msg'=> 'phone or password incorrect')); 
  }
?>