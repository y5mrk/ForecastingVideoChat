<?php
session_start();

if($_GET['flag']=="logout"){
  $_SESSION=array();
  session_destroy();
}
?>
<META HTTP-EQUIV="Refresh" CONTENT="1; URL=login.php" />