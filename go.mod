module github.com/play-with-go/play-with-go

go 1.15

require (
	cuelang.org/go v0.3.0-alpha3
	github.com/gorilla/securecookie v1.1.1
	github.com/kr/pretty v0.2.0
	github.com/myitcv/docker-compose v0.0.0-20200623052903-c60483a3250f
	github.com/play-with-docker/play-with-docker v0.0.3-0.20200904130329-2d1515d12fb0
	github.com/play-with-go/gitea v0.0.0-20200929134129-867a89fbd9eb
	github.com/play-with-go/preguide v0.0.2-0.20201003154103-6be0cdb0cf79
	golang.org/x/sync v0.0.0-20200317015054-43a5402ce75a
)

replace github.com/play-with-docker/play-with-docker => github.com/myitcvforks/play-with-docker v0.0.2-0.20201006081434-ee215e95a325
