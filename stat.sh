# default params
user="none"
shell="unknown"
date="none"

# construct new user
function CREATE_USER {

	user="$USER" 

	if [ "$1" ]; then
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
function SHOW_ME {

	echo "Your are: $user"
	echo "$date"
	echo "$shell"
	echo "$progress"
}

# update progress
function UPDATE {

	if [ "$1" ]; then
		progress=$1
	else
		error_echo "bad argument"
	fi
}

# save statistic to ol file
function SAVE_STAT {

	local FILE="$HOME/loger-$user.log"

	echo "writing to log file..."
	for f in $FILE; do
		echo "$date" > $FILE
		echo "$user" >> "$FILE"
		echo "$shell" >> $FILE
		echo "$progress" >> "$FILE"
	done
}

function READ_LOG {
	if [ "$1" ]; then	
		local user=$1
		local filename="$HOME/loger-$user.log"
		if [ -e "$filename" ]; then		
			while read -r line
			do
			    txt=$line
			    LOG_READ=$(echo "$txt")
			done < "$filename"

			echo "Current progress : $LOG_READ"
		else
			error_echo "uncorrect user name"
		fi
	else
		error_echo "None for user name"
	fi
}