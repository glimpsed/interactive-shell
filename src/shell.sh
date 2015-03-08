

# exrcise for learning mkdir
mkdirExercise() {

	local input
	local correct="mkdir firstFolder"

	echo -e "\033[0;36mType 'mkdir firstFolder'"
	read -p "  -> " input

	success() {
		# mkdir ./firstFolder
		success_echo "\033[0;32mCongratulations! Now you create your first folder!"
		echo -e "$(term_echo 'mkdir') command is used for creating folders"
		echo -e "So in our case we created folder with name 'firstFolder'"
		UPDATE "cdExercise"
		SAVE_STAT
		next "cdExercise"
	}
	error() {
		restarting "mkdirExercise"
	}

	checkInput "$input" "$correct" success error
	
}

# exercise for learning cd
cdExercise() {

	local input
	local correct="cd firstFolder"

	echo -e "\033[0mCool! We have folder lets move into in"
	echo -e "\033[0;36mType 'cd firstFolder'"
	read -p "  ->  " input;

	success() {
		# cd ./firstFolder
		echo -e "\033[0;32mCool. Now you in firstFolder, that you created before"
		UPDATE "touchExercise"
		SAVE_STAT
		next "touchExercise"
	}
	error() {
		restarting "cdExercise"
	}

	checkInput "$input" "$correct" success error
}

# exercise for learning touch command
touchExercise() {

	local input
	local correct="touch sample.txt"

	echo -e "\033[0mLets create one file in this folder"
	echo -e "\033[0;36mType 'touch sample.txt'"
	read -p "  -> " input

	success() {
		echo -e "\033[0;32mCool"
		# touch ./sample.txt
		UPDATE "rmExercise"
		SAVE_STAT
		next "rmExercise"
	}
	error() {
		restarting "touchExercise"
	}

	checkInput "$input" "$correct" success error
}

# pwd exercise
rmExercise() {

	local input
	local correct="rm sample.txt"

	echo -e "\033[0mSo now you know how to create files and folders"
	echo -e "\033[0mLets learn how to delete files"
	echo -e "\033[0mLets delete sample.txt , that we create earlier"
	echo -e "\033[0;36mType 'rm sample.txt'"
	read -p "  -> " input

	success() {
		echo -e "\033[0;32mCool. You made it!"
		# rm ./sample.txt
		UPDATE "pwdExercise"
		SAVE_STAT
		next "pwdExercise"
	}
	error() {
		restarting "rmExercise"
	}

	checkInput "$input" "$correct" success error
}

pwdExercise() {

	local input
	local correct="pwd"

	echo -e "\033[0mIf you want to know in which folder you now,"
	echo -e "\033[0myou can type pwd command that display your current full path"
	echo -e "\033[0mLets try it"
	echo -e "\033[0;36mType 'pwd'"
	read -p "  -> " input

	success() {
		echo "Your path : $(pwd)"
		success_echo "Nice you made it!"
		UPDATE "cpExercise"
		SAVE_STAT
		next "cpExercise"
		# rm ./sample.txt
	}
	error() {
		restarting "pwdExercise"
	}

	checkInput "$input" "$correct" success error
}

cpExercise() {

	local input
	local correct="cp sample.txt sample-copy.txt"

	echo -e "\033[0mLets try cp command,"
	echo -e "\033[0;36mType 'cp sample.txt sample-copy.txt'"
	read -p "  -> " input

	success() {
		success_echo "Yeh. All right!"
		UPDATE "mvExercise"
		SAVE_STAT
		next "mvExercise"
	}

	error() {
		restarting "cpExercise"
	}

	checkInput "$input" "$correct" success error
}

mvExercise() {

	local input
	local correct="mkdir testFolder; mv sample.txt ./testFolder"

	echo -e "\033[0mLets try mv command"
	echo -e "\033[0mLets create new folder and move our file into that"
	echo -e "\033[0;36mType 'mkdir testFolder; mv sample.txt ./testFolder'"
	read -p "  -> " input

	success() {
		success_echo "Yeh. All right!"
		UPDATE "sudoTraining"
		SAVE_STAT
		next "sudoTraining"
	}

	error() {
		restarting "mvExercise"
	}

	checkInput "$input" "$correct" success error
}

sudoTraining() {

	local input
	local correct="sudo su"

	echo -e "\033[0mIf you want to run command as a super user you can use $(term_echo 'sudo') command"
	echo -e "\033[0mLet enter a super user mode"
	echo -e "\033[0;36mType 'sudo su'"
	read -p "  -> " input

	success() {
		success_echo "Yeh. All right!"
		UPDATE "dateExercise"
		SAVE_STAT
		next "dateExercise"
		
	}

	error() {
		restarting "sudoTraining"
	}

	checkInput "$input" "$correct" success error

}

dateExercise() {

	local input
	local correct="date && date +'%d/%m/%Y'"

	echo -e "\033[0m $(term_echo 'date') command"
	echo -e "\033[0mLets learn it"
	echo -e "\033[0;36mType ' date && date +'%d/%m/%Y' '"
	read -p "  -> " input

	success() {
		success_echo "Yeh. All right!"
		UPDATE "finish"
		SAVE_STAT
		next "finish"
	}

	error() {
		restarting "dateExercise"
	}

	checkInput "$input" "$correct" success error

}

# loading next state
next() {

	local state=$1
	$state
}

# checking user input
checkInput() {

	local input=$1
	local success=$3
	local error=$4
	local correct=$2
	

	if [ "$input" = "$correct" ]; then
		$success
	elif [ "$input" = ":q" ]; then
		echo -e "\033[0mExit script..."
		exit 0;
	elif [ "$input" = ":h" ]; then
		echo -e "\033[0mauthor: Oleh Kuchuk version: 1.0"
	else
		$error
	fi
}

finish() {

	local input

	success_echo "End of game... type $(term_echo ':restart') $(success_echo 'for restarting game.')"
	error_echo "Note that all scores will be reset!"
	read -p "  -> " input

	if [ "$input" = ":restart" ]; then
		success_echo "restarting game..."
		DELETE_LOG "$USER";
		next "initialize"
	else
		success_echo "exiting..."
	fi
}

# restarting state on error
restarting() {

	local state=$1
	error_echo "\033[0;31mUncorrect input. Please, try again\033[0m"
	$state
}

# inital function
initialize() {

	echo -e "\033[1;35mHolla, \033[0;33m$USER!\033[1;35m Welcome to interactive shell! \033[0m"
	echo -e "\033[1;35mDuring series of 10 tutorials you will learn basics of working with your shell"
	echo -e "So, Lets start!  \033[0m"
	echo -e "Type :q when you would like to exit script or :h for view script version  \033[0m"

	success() {
		local state=$1
		success_echo "Resuming latest game state ... "
		next "$state"
	}

	error() {
		CREATE_USER "$USER"
		next "mkdirExercise"
	}

	CHECK_LOG "$USER" success error
}

initialize

# end