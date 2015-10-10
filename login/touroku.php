<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../style/tourokustyle.css">
    <title>会員登録</title><meta charset="UTF-8">
  </head>
  <body>
    
    <?php
      if(isset($_GET['userid'])){
        $userid=$_GET['userid'];
      }
      if(isset($_GET['userpw'])){
        $userpw=$_GET['userpw'];
      }
      
      $db=new PDO ("sqlite:user.sqlite");
      if(isset($userid)){
        $db->query("insert into user values(null,'$userid','$userpw')");
      }
      /*$result=$db->query("select*from user");
      for($i=0;$row=$result->fetch();++$i){
        echo $row['id']."<br>";
        echo $row['userid']."<br>";
        echo $row['userpw']."<br>";
      }*/
?>
    <h1><img src="../style/sun.png">会員登録画面<img src="../style/sun.png"></h1>
    <div id="touroku">
    <form action =touroku.php method=get>
      <p>ユーザID:<input type=text  name=userid></p>
      <br><p>パスワード:<input type=text name=userpw></p>
      <input type=submit value="登録">
      <br><br><a href="login.php">ログイン画面に戻る</a>
    </form>
    </div>
  </body>
</html>

      