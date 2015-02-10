user="none"
shell="unknown"
date="none"
FILE="$HOME/loger.log"

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

function SHOW_ME {
	echo "Your are: $user"
	echo "$date"
	echo "$shell"
	echo "$progress"
}

function UPDATE {
	if [ "$1" ]; then
		progress=$1
	else
		error_echo "bad argument"
	fi

	
}
function SAVE_STAT {
	echo "writing to log file..."
	for f in $FILE; do
		echo "date:$date" > $FILE
		echo "name:$user" >> "$FILE"
		echo "progress:$progress" >> $FILE
		echo "shell:$shell" >> "$FILE"
	done
}