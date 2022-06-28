FROM node:12

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . . 

ENV HOST=okysystembd.mysql.database.azure.com
ENV DB_PORT=3306
ENV DB_USER=okysystem@okysystembd
ENV DB_PASSWORD=%UoV!4~9^z^Dj8%,^h)H
ENV DB_NAME=guanaco_app

ADD BaltimoreCyberTrustRoot.crt.pem /usr/local/sFROM node:12

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . . 

ENV HOST=okysystembd.mysql.database.azure.com
ENV DB_PORT=3306
ENV DB_USER=okysystem@okysystembd
ENV DB_PASSWORD=%UoV!4~9^z^Dj8%,^h)H
ENV DB_NAME=guanaco_app

ADD BaltimoreCyberTrustRoot.crt.pem /usr/local/share/ca-certificates/BaltimoreCyberTrustRoot.crt.pem
RUN chmod 644 /usr/local/share/ca-certificates/BaltimoreCyberTrustRoot.crt.pem && update-ca-certificates

ENV CA_AZURE=/usr/local/share/ca-certificates/BaltimoreCyberTrustRoot.crt.pem

CMD ["npm","start"]
