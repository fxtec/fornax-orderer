#https://github.com/yeasy/docker-hyperledger-fabric-orderer/blob/master/v1.2.0/Dockerfile
FROM hyperledger/fabric-orderer:1.2.0
EXPOSE 7050
ENV ORDERER_GENERAL_LOGLEVEL info
ENV ORDERER_GENERAL_LISTENADDRESS 0.0.0.0
ENV ORDERER_GENERAL_GENESISMETHOD file
ENV ORDERER_GENERAL_GENESISFILE /etc/hyperledger/configtx/genesis.block
ENV ORDERER_GENERAL_LOCALMSPID OrdererMSP
ENV ORDERER_GENERAL_LOCALMSPDIR /etc/hyperledger/msp/orderer/msp
ENV HOME_DIR=/opt/gopath/src/github.com/hyperledger/fabric/orderer

#pre-req etcd's.sh
RUN apt-get update && \
    apt-get install -y jq curl && \
    rm -rf /var/cache/apt

# fornax-orderer
LABEL maintainer="davimesquita@gmail.com"
ENV ETCD_ENDPOINT http://etcd:2379
COPY et.sh /bin/et
COPY etset.sh /bin/etset
COPY etdel.sh /bin/etdel
COPY etfile.sh /bin/etfile
COPY etoutput.sh /bin/etoutput
RUN chmod +x /bin/et
RUN chmod +x /bin/etset
RUN chmod +x /bin/etdel
RUN chmod +x /bin/etfile
RUN chmod +x /bin/etoutput
COPY fornax-orderer.sh /bin/fornax-orderer
RUN chmod +x /bin/fornax-orderer
WORKDIR $HOME_DIR
ENTRYPOINT ["/bin/fornax-orderer"]
