
# print success helper
success_echo() {
	local text=$1
	echo -e "\033[0;32m$text\033[0m"
}

# print error message helper
error_echo() {
	local text=$1
	echo -e "\033[0;31m$text\033[0m"
}

# print term message helper
term_echo() {
	local text=$1
	echo -e "\033[1;33m$text\033[0m"
}

type_echo() {
	local text=$1
	echo -e "\033[0;36m$text\033[0m"
}

# end


# default params
user="none"
shell="unknown"
date="none"

# construct new user
CREATE_USER() {

	user="$USER" 

	if [ -e "$1" ]; then
		user="$1"
	fi

	shell="$SHELL"
	date="$(date +'%d/%m/%Y')"
	if [ "$2" ]; then
		progress="$2"
	else
		progress="null"
	fi
}

# show user info
SHOW_ME() {

	echo "$user"
	echo "$date"
	echo "$shell"
	echo "$progress"
}

# update progress
UPDATE() {

	if [ "$1" ]; then
		progress=$1
	else
		error_echo "bad argument"
	fi
}

# save statistic to ol file
SAVE_STAT() {

	local FILE="$HOME/.loger-$user.log"
	for f in $FILE; do
		echo "$date" > $FILE
		echo "$user" >> "$FILE"
		echo "$shell" >> $FILE
		echo "$progress" >> "$FILE"
	done
}

READ_LOG() {
	if [ "$1" ]; then	
		local user=$1
		local filename="$HOME/.loger-$user.log"
		if [ -e "$filename" ]; then		
			while read -r line
			do
			    txt=$line
			    LOG_READ=$(echo "$txt")
			done < "$filename"

		else
			error_echo "incorrect user name"
		fi
	else
		error_echo "None for user name"
	fi
}

CHECK_LOG() {

	local user=$1
	local success=$2
	local error=$3

	if [ -e "$HOME/.loger-$user.log" ]; then
		READ_LOG "$user"
		success "$LOG_READ"
	else
		error
	fi
}

DELETE_LOG() {
	local username=$1
	rm $HOME/.loger-$username.log
}

# end

# exrcise for learning mkdir
mkdirExercise() {

	local input
	local correct="mkdir firstFolder"

	type_echo "Type 'mkdir firstFolder'"
	read -p "  -> " input

	success() {
		mkdir ./firstFolder
		success_echo "\033[0;32mCongratulations! Now you created your first folder!"
		echo "The $(term_echo 'mkdir') command is used for creating folders"
		echo "So, in our case, we created a folder with the name 'firstFolder'"
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

	success_echo "Cool! We have a folder, let's move into it"
	type_echo "Type 'cd firstFolder'"
	read -p "  ->  " input;

	success() {
		cd ./firstFolder
		success_echo "Cool. Now you're in firstFolder, the one you created before"
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

	echo "Let's create one file in this folder"
	type_echo "\033[0;36mType 'touch sample.txt'"
	read -p "  -> " input

	success() {
		success_echo "Cool"
		touch ./sample.txt
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

	echo "So now you know how to create files and folders"
	echo "Let's learn how to delete files"
	echo "Let's delete sample.txt , that we creates earlier"
	type_echo "\033[0;36mType 'rm sample.txt'"
	read -p "  -> " input

	success() {
		success_echo "Cool. You made it!"
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

	echo "If you want to know in which folder you're now,"
	echo "you can type the 'pwd' command that displays your current full path."
	echo "Let's try it."
	type_echo "Type 'pwd'"
	read -p "  -> " input

	success() {
		echo "Your path : $(pwd)"
		success_echo "Nice, you did it!"
		UPDATE "cpExercise"
		SAVE_STAT
		next "cpExercise"
	}
	error() {
		restarting "pwdExercise"
	}

	checkInput "$input" "$correct" success error
}

cpExercise() {

	local input
	local correct="cp sample.txt sample-copy.txt"

	echo "Let's try the 'cp' command."
	type_echo "Type 'cp sample.txt sample-copy.txt'"
	read -p "  -> " input

	success() {
		cp sample.txt sample-copy.txt
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

	echo "Let's try the $(term_echo 'mv') command."
	echo "Let's create a new folder and move our file into it."
	type_echo "Type 'mkdir testFolder; mv sample.txt ./testFolder'"
	read -p "  -> " input

	success() {
		mkdir ./testFolder; mv sample.txt ./testFolder
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

	echo "If you want to run command as a super user, you can use the $(term_echo 'sudo') command."
	echo "Let's enter a super user mode."
	type_echo "Type 'sudo su'"
	read -p "  -> " input

	success() {
		success_echo "Yeah. All right!"
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

	echo "The $(term_echo 'date') command is used for working with different date formats."
	echo "Lets learn it"
	type_echo "Type: date && date +'%d/%m/%Y'"
	read -p "  -> " input

	success() {
		success_echo "Yeah. All right!"
		date && date +'%d/%m/%Y'
		UPDATE "finish"
		SAVE_STAT
		next "lsTraining"
	}

	error() {
		restarting "dateExercise"
	}

	checkInput "$input" "$correct" success error

}

lsTraining() {
	local input
	local correct="ls ."

	echo "The $(term_echo 'ls') command is used for showing which files the current directory cotnains."
	echo "Let's try it'"
	type_echo "Type: ls ."
	read -p "  -> " input

	success() {
		success_echo "Yeah. All right!"
		ls .
		echo "If you want to show hidden files you can use flag -a like ls -a . This command will also show hidden files."
		UPDATE "lsTraining"
		SAVE_STAT
		next "psTraining"
	}

	error() {
		restarting "lsTraining"
	}

	checkInput "$input" "$correct" success error
}

psTraining() {
	local input
	local correct="ps"

	echo "The $(term_echo 'ps') command displays a list of running processes."
	echo "Lets try"
	type_echo "Type: ps"
	read -p "  -> " input

	success() {
		success_echo "Cool!"
		ps
		UPDATE "psTraining"
		SAVE_STAT
		next "nanoTraining"
	}

	error() {
		restarting "psTraining"
	}

	checkInput "$input" "$correct" success error
}

nanoTraining() {
	local input
	local correct="nano"

	echo "UNIX has a lot of terminal text editors like $(term_echo 'nano')"
	echo "Let's discover it."
	type_echo "Type: nano"
	type_echo "When you want to leave edit, just press $(term_echo 'Ctrl+X') . Than you can choose to save your changes."
	read -p "  -> " input

	success() {
		success_echo "Cool!"
		nano
		success_echo "You did it!"
		UPDATE "nanoTraining"
		SAVE_STAT
		next "finish"
	}

	error() {
		restarting "nanoTraining"
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
	error_echo "\033[0;31mIncorrect input. Please, try again\033[0m"
	$state
}

# inital function
initialize() {

	echo -e "\033[1;35mHolla, \033[0;33m$USER!\033[1;35m Welcome to interactive shell! \033[0m"
	echo -e "\033[1;35mDuring this short tutorial, you will learn the basics of working with a UNIX shell."
	echo -e "So, let's start!  \033[0m"
	echo -e "Type :q when you would like to exit script or :h for view script version  \033[0m"

	success() {
		local state=$1
		success_echo "Resuming last game state ... "
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
