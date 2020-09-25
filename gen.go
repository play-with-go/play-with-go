package gen

//go:generate bash -c "comm -13 <(git grep -Il '' | sort -u) <(git grep -al '' | sort -u) > .binaryfiles"
