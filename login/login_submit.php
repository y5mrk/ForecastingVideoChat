<html>
  <head>
    <title>ログイン</title><meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../style/loginstyle.css">
  </head>
  <body>
    
    <h1><img src="../style/sun.png">ログイン<img src="../style/sun.png"></h1>
    <div id="login">
      <?php
      session_start();
      
      
        if(empty($_SESSION['login'])){
        if(isset($_GET['userid']) && isset($_GET['userpw']) ){
          $userid=$_GET["userid"];
          $userpw=$_GET['userpw'];
          $db=new PDO("sqlite:user.sqlite");
      $result=$db->query("select* from user");
          for($i=0;$row=$result->fetch();$i++){
          if($row['userid']==$userid && $row['userpw']==$userpw){
            $flag=1;
          }
          }
          if($flag===1){
            echo "ログイン成功";
            $_SESSION['login']="ログイン中";
          }else{
            echo "ユーザIDまたはアドレスが間違っています";
          }
      
        }else{
          echo "入力してください";
        }
      }else{
        echo "すでにログイン済です";
        echo '<form action=logout.php method=get>
                <input type="hidden" name="flag" value="logout"/>
                <input type ="submit" value="ログアウト"/>
                </form>';
      }
      
      ?>
      <br>
      <br>
      <a href="../OpenWeather/OpenWeather.html">チャットのページへ</a>
    </div>
  </body>
</html>