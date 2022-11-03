<?php
    require_once('DB_connect.php');

    $image= $_FILES["uploadFile"]["name"];
    $image_name = $_POST["Image_name"];
    $image_path = 'images=/'.$image_name;
   
    move_uploaded_file($image, $image_path);
    $con->query("INSERT INTO images(Image_name, Image_path) VALUES ('".$image_name."', '".$image_path."')");
    $Image_id = $con->insert_id;

    $longitude = $_POST["Longitude"];
    $latitude = $_POST["Latitude"];
    $con->query("INSERT INTO locations(Longitude, Latitude) VALUES ('".$longitude."', '".$latitude."')");
    $Location_id = $con->insert_id;

    $city_Id = $_POST["city_Id"];
    $dep_Id = $_POST["Dep_Id"];
    $phone = $POST["Phone"];
    $note = $POST["Note"];
    $mac_address = $POST["MAVC_address"];
    $ip_address = $POST["IP_address"];
    $date = $POST["Date"];
    $con->query("INSERT INTO orders(Phone, Note, MAC_addrees, IP_address, Date, Dep_id, City_id, Image_id, Location_id) VALUES ('".$phone."', '".$note."', '".$mac_address."', '".$ip_address."', '".$date."', '".$dep_Id."', '".$city_Id."', '".$insert_id."', '".$insert_id."')");

?>