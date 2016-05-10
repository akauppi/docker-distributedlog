shell:
	docker run -i -t distributedlog:v2 /bin/bash

build:
	docker build -t distributedlog:v2 .

start:
	docker run distributedlog:v2
