cd /Users/shunsuke/bitcoin_notice_script/
bitcoind -daemon
sleep 30s
bitcoin-cli getchaintips > latest_curl.json
sleep 10s
bitcoin-cli stop
irb << EOF
load "/Users/shunsuke/bitcoin_notice_script/ruby_script.rb"
exit
EOF