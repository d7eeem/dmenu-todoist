#!/bin/bash
argss=(
	"add"
	"show"
	"sync"
	"finish"
	"edit"
)

show() {
	todoist l | dmenu -p "Show: " -i -c | awk '{print $1}' | xargs -I '{}' todoist show {} | grep -Eo '(https?\:\/\/\w+\S+)' | xargs -I '{}' "$BROWSER" {}
}

finish() {
	todoist l | dmenu -i -c -p " Done: " | awk '{print $1}' | xargs -I '{}' todoist close {}

	notify-send "😊task has been marked done"
}

add() {
	dmenu -i -c -p "Add: " | xargs -I '{}' todoist add {}
}

sync() {
	todoist sync
	notify-send "synced"
}
edit() {
	$EDITOR $0
}

if [ -z "$1" ]; then
	printf '%s\n' "${argss[@]}" | dmenu -c -i -p "todoist: " | xargs -I '{}' dmenu-todoist {}
	if [ "$1" == add ]; then
		add
	fi
fi

case $1 in
add) add ;;
show) show ;;
sync) sync ;;
edit) edit ;;
finish) finish ;;
esac
