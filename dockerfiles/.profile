export PS1='\e[1m\e[31m[\h] \e[32m\e[34m\u@$(hostname -i)\e[35m \w\e[0m\n$ '
alias vi='vim'
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
cat /etc/motd
# I can't remember what this does, so commenting for now
#echo $BASHPID > /var/run/cwd
