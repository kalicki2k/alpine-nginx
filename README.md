# Nginx on Alpine Linux 3.6
This is a micro docker images based on Alpine Linux 3.6 and Nginx 1.12.

To access site contents from outside the container you should map /var/www/localhost/htdocs.

## Usage

To use this start the container on port 8080 with:
```
docker run -d --name nginx -p 8080:80 -v /path/to/localhost:/var/www/localbost kalicki2k/alpine-nginx
```