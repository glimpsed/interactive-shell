# exrcise for learning mkdir
function mkdirExercise {

	local input
	local correct="mkdir firstFolder"

	echo "Type 'mkdir firstFolder'"
	read -p "  -> " input

	function success {
		mkdir ./firstFolder
		echo "Congratulations! Now you create your first folder!"
		echo "mkdir command is used for creating folders"
		echo "So in our case we created folder with name 'firstFolder'"
		next "cdExercise"
	}
	function error {
		restarting "mkdirExercise"
	}

	checkInput "$input" "$correct" success error
	
}

# exercise for learning cd
function cdExercise {

	local input
	local correct="cd firstFolder"

	echo "Cool! We have folder lets move into in"
	echo "Type 'cd firstFolder'"
	read -p "  ->  " input;

	function success {
		cd ./firstFolder
		echo "Cool. Now you in firstFolder, that you created before"
		next touchExercise
	}
	function error {
		restarting "cdExercise"
	}

	checkInput "$input" "$correct" success error
}

# exercise for learning touch command
function touchExercise {
	local input
	local correct="touch sample.txt"

	echo "Lets make some file in the folder"
	echo "Type 'touch sample.txt'"
	read -p "  -> " input

	function success {
		echo "Cool"
		touch ./sample.txt
		next "rmExercise"
	}
	function error {
		restarting "touchExercise"
	}

	checkInput "$input" "$correct" success error
}

# pwd exercise
function rmExercise {

	local input
	local correct="rm sample.txt"

	echo "So now you know how to create files and folders"
	echo "Lets learn how to delete files"
	echo "Lets delete sample.txt , that we create earlier"
	echo "Type 'rm sample.txt'"
	read -p "  -> " input

	function success {
		echo "Cool. You made it!"
		rm ./sample.txt
	}
	function error {
		restarting "rmExercise"
	}

	checkInput "$input" "$correct" success error
}

# loading next state
function next {
	local state=$1
	$state
}

# checking user input
function checkInput {

	local input=$1
	local success=$3
	local error=$4
	local correct=$2
	

	if [ "$input" = "$correct" ]; then
		$success
	else 
		$error
	fi
}

# restarting state on error
function restarting {
	local state=$1
	echo "Uncorrect input. Please, try again"
	$state
}

# inital function
function initialize {
	echo "Holla, $USER! Welcome to interactive shell!"
	echo "During series of 10 tutorials you will learn basics of working with your shell"
	echo "So, Lets start!"
	mkdirExercise
}

initialize