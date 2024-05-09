<?php
  $link = mysqli_connect('localhost', 'root', '', 'plmcrsdb');

  $sql = "SELECT * FROM `news_general` ORDER BY `newsID` DESC LIMIT 12";
        
  $result = mysqli_query($link, $sql);

  if ($result) {
      while ($row = mysqli_fetch_assoc($result)) {
          $news = array(
              "newsID" => $row['newsID'],
              "newstitle" => $row['newstitle'],
              "description" => $row['description'],
              "type" => $row['type'], //announcement 0, press release 1
              "imageurl" => $row['imageurl'],
              "enteredon" => $row['enteredon'],
              "validuntil" => $row['validuntil']
          );

          $return[] = $news;
      }

      mysqli_free_result($result);
  }

    header('Content-Type: application/json');
    echo json_encode($return, JSON_PRETTY_PRINT);

  mysqli_close($link);
?>