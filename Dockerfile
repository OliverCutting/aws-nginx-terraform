FROM alpine

WORKDIR "/opt/app/"

COPY requirements.txt .

RUN apk add --no-cache py3-pip terraform make && \
    pip install -Ur --no-cache-dir requirements.txt