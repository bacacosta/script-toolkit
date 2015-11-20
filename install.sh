#!/bin/bash -ex
# script-toolkit install script

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_TOOLKIT_DIR="$HOME/.script-toolkit"

__init() {
	[[ -d $SCRIPT_TOOLKIT_DIR ]] && rm -r "$SCRIPT_TOOLKIT_DIR"
	mkdir "$SCRIPT_TOOLKIT_DIR"
	cp "$BASE_DIR/src"/* "$SCRIPT_TOOLKIT_DIR"
}

__generate-bootstrap() {
	for SCRIPT in "$BASE_DIR/src"/*; do
		echo ". \"$SCRIPT\"" >> "$SCRIPT_TOOLKIT_DIR/bootstrap.sh"
	done
}

__update-bashrc() {
	grep -q "script-toolkit" "$HOME/.bashrc" || cat <<- EOF >> "$HOME/.bashrc"

			# script-toolkit
			[[ -f $SCRIPT_TOOLKIT_DIR/bootstrap.sh ]] && . $SCRIPT_TOOLKIT_DIR/bootstrap.sh
	EOF
}

__init && __generate-bootstrap && __update-bashrc
