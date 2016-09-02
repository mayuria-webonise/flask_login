FROM ubuntu:14.04

RUN apt-get update && sudo apt-get install -y \
								python-pip \
								 python \
								 mongodb 
								 

COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
