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
	local LOG_DIR="$SCRIPT_TOOLKIT_DIR/logs"
	local LOG_FILE="$LOG_DIR/backup.$(date +%Y%m%d%H%M%S).log"

	# create logs directory if it does not exist
	[[ ! -d $LOG_DIR ]] && mkdir "$LOG_DIR"

	for SOURCE_DIR in $SOURCE_DIR_LIST; do
		echo "Backing up $SOURCE_DIR to $1..." |& tee -a $LOG_FILE
		rsync -azvh --delete --progress $SOURCE_DIR $1 |& tee -a $LOG_FILE
		echo "--------------------------------------------------" |& tee -a $LOG_FILE
	done
}
