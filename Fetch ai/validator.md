#Command for create and interactions with validator

$ fetchd tx staking create-validator \
--amount=1000000000000000000afet \
--pubkey=$(fetchd tendermint show-validator) \
--moniker="VAlIDATOR_NAME" \
--chain-id=fetchhub-3 \
--commission-rate="0.05" \
--commission-max-rate="0.20" \
--commission-max-change-rate="0.02" \
--min-self-delegation=1000000000000000000 \
--from="WALLET_NAME" \
--identity="KEYBASE_ID" \
--details="YOUR_DETAILS" \
--website="WEBSITE" \
--gas=890955000afet \
--fees=1000000000000000000afet

$ fetchd tx staking delegate ADDR_VALOPER 1000000000000000000000afet \
--fees=1000000000000000000afet \
--from="WALLET_NAME" \
--gas=auto \
--fees=1000000000000000000afet \
--chain-id=fetchhub-3

#Wallet command. Replace $WALLET to your wallet name or use $ WALLET=YOUR_WALLET_NAME to add a variable

$ fetchd q distribution rewards $(fetchd keys show $WALLET -a)

$ fetchd q distribution commission $(fetchd keys show $WALLET --bech val -a)

$ fetchd tx distribution withdraw-rewards $(fetchd keys show $WALLET --bech val -a) --commission --from $WALLET

$ fetchd q bank balances $(fetchd keys show $WALLET)

#Help commands

$ fetchd tx staking create-validator --help

$ fetchd tx staking edit-validator --help

$ fetchd tx staking delegate --help
