#!/bin/bash

function main() {

precert

cpdir ./config/ /etc/hyperledger/configtx
cpdir ./crypto-config/ordererOrganizations/blockchain.com/orderers/orderer.blockchain.com/ /etc/hyperledger/msp/orderer
cpdir ./crypto-config/peerOrganizations/org1.blockchain.com/peers/peer0.org1.blockchain.com/ /etc/hyperledger/msp/peerOrg1

cd $HOME_DIR
orderer

};
function cpdir() {
    cd /etc/fornax/fabric
    mkdir -p $2
    cp -r $1/* $2
};
function precert() {
mkdir -p /etc/fornax
cd /etc/fornax
et fornax-genesis | base64 -d | xargs -L 1 etoutput
};

main
