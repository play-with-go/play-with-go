package gen

//go:generate bash -c "export LC_ALL=C; comm -13 <(git grep -Il '' | sort -u) <(git grep -al '' | sort -u) > .binaryfiles"
