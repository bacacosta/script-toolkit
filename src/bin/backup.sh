# backup script

.backup() {
	if [[ $# == 0 || ! -d $1 ]]; then
		>&2 cat <<- EOF
				No valid target_dir specified.
				Usage: .backup target_dir
		EOF
		return 1
	fi

	local SOURCE_DIR_LIST="
		$BOOKS
		$DOCS
		$GAMES
		$MUSIC
		$PICS
	"

	for SOURCE_DIR in $SOURCE_DIR_LIST; do
		echo "Backing up $SOURCE_DIR to $1..."
		rsync -azvh --delete --progress $SOURCE_DIR $1
	done
}
