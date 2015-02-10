# default params
user="none"
shell="unknown"
date="none"
FILE="$HOME/loger.log"

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

	echo "writing to log file..."
	for f in $FILE; do
		echo "date:$date" > $FILE
		echo "name:$user" >> "$FILE"
		echo "progress:$progress" >> $FILE
		echo "shell:$shell" >> "$FILE"
	done
}

function READ_LOG {
	for f in $FILE; do
		echo "Text : " << $FILE
	done
}