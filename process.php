<?php 
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, GET, POST");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");

error_reporting(E_ALL);
ini_set('display_errors', 1);
// read the file if present
$filename = "data.json";
// $chck_str = $_POST['user_data'] ? $_POST['user_data'] : '' ;

$str = file_get_contents($filename);
$json = json_decode($str,true); // decode the JSON into an associative array
$array = array_values(array($json)[0]['defaultWords']);
$tmparray = explode("#", $_POST['user_data']);
$chck_str = $tmparray[1];
if($chck_str!=""){
	if(in_array($chck_str, $array)){
		// i'll run only if keyword exists

		if(is_dir("Userdata/".$tmparray[0])){ // 123 if exists
			chmod("Userdata/".$tmparray[0], 0777);
			if(is_dir("Userdata/".$tmparray[0]."/".$chck_str)){ // if injury direcotry exists
				$response['msg'] = "Data Already exists!!";
			}else{
				if(mkdir("Userdata/".$tmparray[0]."/".$chck_str,0777)){
					$response['msg'] = "Inserted into file!!";
				}else{
					$response['msg'] = "Error creating injury directory!!";
				}
			}
		}else{
			if(mkdir("Userdata/".$tmparray[0],0777)){
				chmod("Userdata/".$tmparray[0],0777);
				if(mkdir("Userdata/".$tmparray[0]."/".$chck_str,0777)){
					$response['msg'] = "Inserted into file!!";
				}else{
					$response['msg'] = "Error creating injury directory!!";
				}
			}else{
				$response['msg'] = "Inserted into file!!But directory not created";
			}	
		}
		chmod("Userdata/".$tmparray[0],0755);
	}else{
		$inp = file_get_contents($filename);
		$tempArray = json_decode($inp,true);
		array_push($tempArray['defaultWords'], $chck_str);
		$jsonData = json_encode($tempArray);
		if(file_put_contents($filename, $jsonData)){
			
			if(is_dir("Userdata/".$tmparray[0])){ // 123 if exists
				chmod("Userdata/".$tmparray[0], 0777);
				if(is_dir("Userdata/".$tmparray[0]."/".$chck_str)){ // if injury direcotry exists
					$response['msg'] = "Data Already exists!!";
				}else{
					if(mkdir("Userdata/".$tmparray[0]."/".$chck_str,0777)){
						$response['msg'] = "Inserted into file!!";
					}else{
						$response['msg'] = "Error creating injury directory!!";
					}
				}
			}else{
				if(mkdir("Userdata/".$tmparray[0],0777)){
					chmod("Userdata/".$tmparray[0],0777);
					if(mkdir("Userdata/".$tmparray[0]."/".$chck_str,0777)){
						$response['msg'] = "Inserted into file!!";
					}else{
						$response['msg'] = "Error creating injury directory!!";
					}
				}else{
					$response['msg'] = "Inserted into file!!But directory not created";
				}	
			}
			chmod("Userdata/".$tmparray[0],0755);
		}else{
			$response['msg'] = "Error !! Inserting file !!";
		}
	}
}else{
	$response['msg'] = "Invalid data!!";
}

echo json_encode($response);
exit();