#https://github.com/yeasy/docker-hyperledger-fabric-orderer/blob/master/v1.2.0/Dockerfile
FROM hyperledger/fabric-orderer:1.2.0

#pre-req etcd's.sh
RUN apt-get update && \
    apt-get install -y jq curl && \
    rm -rf /var/cache/apt

EXPOSE 7050

# fornax-orderer
LABEL maintainer="davimesquita@gmail.com"
ENV ETCD_ENDPOINT http://etcd:2379

# orderer
ENV ORDERER_GENERAL_LOGLEVEL info
ENV ORDERER_GENERAL_LISTENADDRESS 0.0.0.0
ENV ORDERER_GENERAL_GENESISMETHOD file
ENV ORDERER_GENERAL_GENESISFILE /etc/hyperledger/fabric/config/genesis.block
ENV ORDERER_GENERAL_LOCALMSPID Org1MSP
ENV ORDERER_GENERAL_LOCALMSPDIR /etc/hyperledger/fabric/crypto-config/ordererOrganizations/blockchain.com/orderers/orderer.blockchain.com/msp

COPY et.sh /bin/et
COPY etset.sh /bin/etset
COPY etdel.sh /bin/etdel
COPY etfile.sh /bin/etfile
COPY etoutput.sh /bin/etoutput
COPY fornax-orderer.sh /bin/fornax-orderer
ENTRYPOINT ["/bin/fornax-orderer"]
