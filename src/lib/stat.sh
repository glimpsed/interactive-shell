

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
			error_echo "uncorrect user name"
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