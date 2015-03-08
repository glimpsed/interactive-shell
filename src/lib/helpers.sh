
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
