#!/bin/bash -u

# 添加新validator的步骤
# 1. 生成validator节点公钥、私钥和地址
# 2. 启动节点，接入网络
# 3. 网络中现有validator节点发起投票，需要不少于二分之一的节点同意加入
# 4. 验证新的validator是否添加成功

. ./.env
. ./.common.sh

NODE_NAME=$1

warnln "Propose adding the new validator"
warnln "--------------------"
ADDRESS=$(cat nodes/$NODE_NAME/address)

function add_validator(){
    curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_proposeValidatorVote","params":["'$1'", true], "id":1}' $2
}

add_validator $ADDRESS http://127.0.0.1:31545
add_validator $ADDRESS http://127.0.0.1:32545
add_validator $ADDRESS http://127.0.0.1:33545
add_validator $ADDRESS http://127.0.0.1:34545


# 判断是否添加成功
# curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_getValidatorsByBlockNumber","params":["latest"], "id":1}' http://127.0.0.1:18545