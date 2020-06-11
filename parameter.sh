#! /bin/bash

while getopts "ab" opt; do
	case $opt in
		a)
		echo "-a triggered"
		;;
		b)
		echo "-b triggered"
		;;
		\?)
		echo "Usage: -a | -b"
		;;
	esac
done
