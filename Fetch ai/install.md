
#Packages update and GO and Git installation:
$ sudo apt-get update && sudo apt-get install -y make gcc $ sudo wget -q -O - https://git.io/vQhTU | bash
$ source /$HOME/.bashrc
$ sudo apt install git

#Downloading binaries : 
$ git clone --branch v0.9.0 https://github.com/fetchai/fetchd.git fetchd_0.9.0
$ cd fetchd_0.9.0

#Binaries installation: 
$ git fetch && git checkout v0.9.0
$ make install

#Node address creation and Keys:
$ fetchd init <NodeName> --chain-id fetchub-3
$ fetchd keys add <KeysName>

#             <NodeName> - your Node name
#             <KeysName> - your Wallet name

#Downloading genesis file:
$ wget https://raw.githubusercontent.com/fetchai/genesis-fetchhub/main/ fetchhub-3/data/genesis.json
$ mv ./genesis.json $HOME/.fetchd/config/

#Adding seeds:
$ sed -E -i 's/seeds = ".*"/seeds = "5f3fa6404a67b664be07d0e133a00c1600967396@connect-fetchhub3.m-v2-london-
c.fetch-ai.com:36756,8272b70e1986e2080ca328309a5aad3bb932fcab@connect- fetchhub3.m-v2-london-c.fetch- ai.com:36757,81f479ad9b4b1d25bceedb2a13139187792442bf@connect-fetchhub3.m- v2-london-c.fetch-ai.com:36758"/' ~/.fetchd/config/config.toml

#App.toml config:
$ nano ~/.fetchd/config/app.toml

Changing parameters:
minimum-gas-prices = “5000afet"
pruning = "custom"
pruning-keep-recent = “100"
pruning-keep-every = "0"
pruning-interval = "10"

#Service file config:

$ sudo tee <<EOF >/dev/null /etc/systemd/system/fetcd.service
[Unit]
 Description=fetch
 After=network-online.target
[Service]
 User=root
 ExecStart=$(which fetchd) start
 Restart=always
 RestartSec=3
 LimitNOFILE=4096
[Install]
 WantedBy=multi-user.target
 EOF

$ sudo systemctl enable fetchd
$ sudo systemctl daemon-reload
$ sudo systemctl restart fetchd

#See logs:
$  journalctl -u fetchd -f
