<?php
$textfile = fopen("owResult.txt", "w");//「text.txt」をオープン
$data = array();
for ($i = 0; $i < count(@$_POST["weather"]); $i++){
  $data = @$_POST["weather"][$i];
}
foreach ($data as $a){
  fputs($textfile,$a."\n");
}
fclose($textfile);
?>