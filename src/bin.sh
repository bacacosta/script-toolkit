.cd() {
	if [[ $# == 0 || ! -d $1 ]]; then
		>&2 cat <<- EOF
				No valid base_dir specified.
				Usage: .cd base_dir [pattern]
		EOF
		return 1
	fi
	[[ -z $2 ]] && cd "$1" || cd "$1/$(__find-dir "$@")"
}

.cdd() {
	.cd $DOCS $1
}

.cddl() {
	.cd $DOWNLOAD $1
}

.cdw() {
	.cd $WORKSPACE $1
}

__find-dir() {
	# find directories in base_dir matching parameter
	local DIRS=($(find "$1"/* -maxdepth 0 -type d -iname "*$2*" -printf "%f\n"))

	# error if no or more than one match is found
	if [[ -z $DIRS ]]; then
		>&2 echo "No match found for $2 in $1."
		return 1
	elif [[ ${#DIRS[@]} > 1 ]]; then
		>&2 echo "More than one match found for $2 in $1:"
		>&2 printf "%s\n" "${DIRS[@]}"
		return 1
	fi

	echo ${DIRS[0]}
}
