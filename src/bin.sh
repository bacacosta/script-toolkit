.cd() {
	[[ -z $1 ]] && cd "$WORKSPACE_DIR" || cd "$WORKSPACE_DIR/$(__find-dir "$1")"
}

__find-dir() {
	DIRS=()

	# find directories in $WORKSPACE_DIR matching parameter
	while read DIR; do
		DIRS+=("$DIR")
	done < <(ls -dQ "$WORKSPACE_DIR"/*/ | xargs -n1 basename | grep -i "$1")

	# error if no or more than one match is found
	if [[ -z $DIRS ]]; then
		>&2 echo "No match found for $1 in $WORKSPACE_DIR."
		return 1
	elif [[ ${#DIRS[@]} > 1 ]]; then
		>&2 echo "More than one match found for $1 in $WORKSPACE_DIR:"
		>&2 printf "%s\n" "${DIRS[@]}"
		return 1
	fi

	echo ${DIRS[0]}
}
