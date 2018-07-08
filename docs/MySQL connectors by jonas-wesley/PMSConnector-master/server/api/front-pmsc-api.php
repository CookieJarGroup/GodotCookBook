<?php

/*
 * Php mysql connector API to server connections with godot
 * revised version on 30/11/2017 | date of next version 01/01/2018
 * written by jonas wesley, Version 1.7
 * 
 * "Everything can connect, everything can be connected."
 * 
 * Copyright (C) 2017  Lights On
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License or other latest 
 * version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

# no error messages
  error_reporting(0);
  
 const POST = 'post';
 const GET = 'get';
 
# verify if file exists 
if (!file_exists("PMSConnector.php")) {
     die("Main file no exist.");
} else {
    
     include "PMSConnector.php";
     
     if(isset($_POST['opt'])) {
        
        $client_opt = $_POST['opt'];
        $client_method = "post";
        
     } else if (isset($_GET['opt'])) {
        
        $client_opt = $_GET['opt'];
        $client_method = "get";
     }
}
    
  
if(isset($client_opt)) {
    
    if($client_method==POST) {
        
        $host = "localhost";
        $user_con = $_POST['dbusername'];
        $pass_con = $_POST['dbuserpass'];
        $DB = $_POST['dbname'];
        
        # get client query
        $query = $_POST['query'];
     
    } else if($client_method==GET) {
        
        $host = "localhost";
        $user_con = $_GET['dbusername'];
        $pass_con = $_GET['dbuserpass'];
        $DB = $_GET['dbname'];
        
        # get client query
        $query = $_GET['query'];
        
    }


} else { die("client option not found."); }
    



if ($client_opt == "direct_query") {

      $pmsc = new PMSConnection();
      $_connection = $pmsc->pmsc_connect("$host","$user_con","$pass_con","$DB");
      
      if(!$_connection) {
          
          die("not connected.");
          
      } else {
          
      $pmsc_query = new PMSCQuery();
      $pmsc_query->pmsc_query($_connection,$query);
      
      }
      
} elseif ($client_opt == "server_info") {

     # get server info
     $server = getenv($query);
     
     $_j = new PMSCJson();
     $server = $_j->add_as($server);
     $_j->pmsc_consult("open","0");
     $_j->pmsc_new_json_line("server_response","$server","true");
     $_j->pmsc_close_consult();
     
    }
    

