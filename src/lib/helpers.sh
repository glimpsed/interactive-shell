
# print success helper
success_echo() {
	local text=$1
	echo -e "\033[0;32m$text\033[0m"
	return 0
}

# print error message helper
error_echo() {
	local text=$1
	echo -e "\033[0;31m$text\033[0m"
	return 0
}

# print term message helper
term_echo() {
	local text=$1
	echo -e "\033[1;33m$text\033[0m"
	return 0
}

# end
