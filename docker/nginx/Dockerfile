# nginx:1.18.0
FROM nginx@sha256:f05a6e50202cfae65d7a7da959e02c909e93ec47bc3b2c57755b76f583118e8d

COPY ./docker/nginx/playwithgo-entrypoint.sh /playwithgo-entrypoint.sh

ENTRYPOINT ["/playwithgo-entrypoint.sh"]

CMD [ "nginx", "-g", "daemon off;" ]
