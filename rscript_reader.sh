bitcoind -daemon << EOF
curl --user rpcuser --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getchaintips", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/ > curl_result.txt
rpcpassword
EOF
irb << EOF
load "/Users/shunsuke/bitcoin_notice_script/ruby_script.rb"
exit
EOF
