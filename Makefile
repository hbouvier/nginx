all: build push


build:
	docker build -t hbouvier/nginx:1.12-alpine-003 .

push:
	docker push hbouvier/nginx:1.12-alpine-003