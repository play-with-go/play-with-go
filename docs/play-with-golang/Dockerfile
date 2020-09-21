FROM jekyll/jekyll:3.7 as jekyll_build

RUN gem install jekyll-toc

COPY . /srv/jekyll_source

WORKDIR /srv/jekyll_source

RUN mkdir _site && jekyll build 



FROM golang:latest
WORKDIR /app

# Do this first so we can reuse cache
COPY main.go /app/
RUN go get -v -d ./... && go build -o main .

COPY --from=jekyll_build /srv/jekyll_source/_site/ /app/_site


EXPOSE 3000

CMD ["/app/main"]
