<?php
if(isset($_GET["url"]) && preg_match("/^https?:/",$_GET["url"])){
  header('Content-type: application/xml');
  $req_url = $_GET['url'];
  foreach ( $_GET as $key => $value){
    if( strcmp( $key, "url" ) ){
      $req_url .= ("&" . $key . "=" . $value);
    }
  }
  echo file_get_contents($req_url);
}else{
  echo "error";
}
?>