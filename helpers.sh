# print success helper
function success_echo {
	local text=$1
	echo -e "\033[0;32m$text\033[0m"
	return 0
}

# print error message helper
function error_echo {
	local text=$1
	echo -e "\033[0;31m$text\033[0m"
	return 0
}
