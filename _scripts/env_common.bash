bashExport() {
	echo export "$1=\"$2\""
}

bashAlias() {
	echo alias "$1=$2"
}

smartcdExport() {
	echo autostash "$1=\"$2\""
}

smartcdAlias() {
	echo autostash alias "$1=$2"
}

githubExport() {
	echo "$1=$(echo "$2" | sed ':a;N;$!ba;s/%/%25/g' |  sed ':a;N;$!ba;s/\r/%0D/g' | sed ':a;N;$!ba;s/\n/%0A/g')" >> $GITHUB_ENV
}

githubAlias() {
	# no-op
	echo ""
}

export=bashExport
alias=bashAlias

if [ "$1" = "smartcd" ]
then
	export="smartcdExport"
	alias="smartcdAlias"
elif [ "$1" = "github" ]
then
	export="githubExport"
	alias="githubAlias"
fi
