# jekyll/jekyll:3.8
FROM jekyll/jekyll@sha256:9521c8aae4739fcbc7137ead19f91841b833d671542f13e91ca40280e88d6e34

RUN gem install jekyll-redirect-from:0.16.0 jekyll-toc:0.16.1

# Overwrite the entrypoint and jekyll with more sensible versions
COPY docker/site/entrypoint /usr/jekyll/bin/entrypoint
COPY docker/site/jekyll /usr/jekyll/bin/jekyll
