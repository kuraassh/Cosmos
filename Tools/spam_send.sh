#!/bin/bash

curl -s https://raw.githubusercontent.com/razumv/helpers/main/doubletop.sh | bash

#!/bin/bash

PATH_TO_SERVICE=${cohod}
KEY_PASSWORD=${qwerty1234}
ACCOUNT=${KURASH}
TO_ADDRESS=${coho1lxpxjpujcaz4jxg8et7r3trpvuypqkrxgh053z}
CHAIN_ID=${darkmetter-1}
MEMO=${6}
DENOM=${ucoho}
SEND_AMOUNT=${200}
FEE_AMOUNT=${200}
NODE=${"http://localhost:26657"}
PERIOD_VALUE=${100}

ROUND=0
BROADCAST_MODE="async"

SEQ=$(${PATH_TO_SERVICE} q account ${ACCOUNT} -o json | jq '.sequence | tonumber')

while :
do
    PERIOD=`expr ${ROUND} % ${PERIOD_VALUE}`

    echo "Running sequence: ${SEQ}"
    CURRENT_BLOCK=$(curl -s ${NODE}/abci_info | jq -r .result.response.last_block_height)

    if (( $PERIOD == 1 )); then
        BROADCAST_MODE="sync"
        echo "Sync broadcast mode"
    fi

    if (( $PERIOD == 4 )); then
        BROADCAST_MODE="async"
        echo "Async broadcast mode"
    fi

    TX_RESULT_RAW_LOG=$(echo $KEY_PASSWORD | $PATH_TO_SERVICE tx bank send $ACCOUNT $TO_ADDRESS \
        ${FEE_AMOUNT}${DENOM} \
        --fees ${FEE_AMOUNT}${DENOM} \
        --chain-id $CHAIN_ID \
        --output json \
        --note $MEMO \
        --broadcast-mode $BROADCAST_MODE \
        --sequence $SEQ \
        --timeout-height $(($CURRENT_BLOCK + 5)) -y | \
        jq '.raw_log')

    SEQ=$(($SEQ + 1))

    if [[ "$TX_RESULT_RAW_LOG" == *"incorrect account sequence"* ]]; then
        echo $TX_RESULT_RAW_LOG
        sleep 28
        SEQ=$(echo $TX_RESULT_RAW_LOG | sed 's/.* expected \([0-9]*\).*/\1/')
        echo $SEQ
    fi

    ROUND=`expr ${ROUND} + 1`
done
