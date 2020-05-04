# For each of the styles of export/alias below, we actually perform the
# export/alias so that the rest of the script can take advantage of the change

bashExport() {
	echo export "$1=\"$2\""
}

bashAlias() {
	alias "$1=$2"
	echo alias "$1=$2"
}

smartcdExport() {
	echo autostash "$1=\"$2\""
}

smartcdAlias() {
	alias "$1=$2"
	echo autostash alias "$1=$2"
}

githubExport() {
	echo "::set-env name=$1::$(echo "$2" | sed ':a;N;$!ba;s/%/%25/g' |  sed ':a;N;$!ba;s/\r/%0D/g' | sed ':a;N;$!ba;s/\n/%0A/g')"
}

githubAlias() {
	alias "$1=$2"
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
