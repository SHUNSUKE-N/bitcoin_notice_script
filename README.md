これはbitcoin coreに通知用スクリプトを加えたソースコードです
=====================================
cron_script.txt内に、cron設定を書いている為、  
そのコマンドを実行することでrubyスクリプトを通して1時間に1回、  
latest block numberに3以上の差分がある場合のみslack通知を行ってくれます。 


以下6ファイルをスクリプトとして加えています
----------------
[cron_script.txt](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/cron_script.txt)  
[rscript_reader.sh](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/rscript_reader.sh)  
[ruby_script.rb](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/ruby_script.rb)  
[last_api.txt](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/last_api.txt)  
[latest_curl.json](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/latest_curl.json)  
[last_curl.txt](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/last_curl.txt)   

利用したAPI：  
Blockchain Data API(Latest Block)  
https://www.blockchain.com/ja/api/blockchain_api  

利用したRPC：  
getchaintips  
https://developer.bitcoin.org/reference/rpc/getchaintips.html  


cron_script.txt
----------------
cron指示を記述したコピーファイルです。 

rscript_reader.sh
----------------
bashスクリプトを記述しています。JSON-RPCを実行後、jsonデータをlatest_curl.jsonに記述し、ruby_script.rbを呼び出します。  

ruby_script.rb
----------------
rubyスクリプトを記述しています。条件に応じてメッセージをslackに通知します。   

last_api.txt
----------------
ruby_script.rbからapiを叩き、最新値を更新した場合のみ本ファイルにlatest block numberを記述します。  

latest_curl.json
----------------
rscript_reader.shでJSON-RPCを実行して取得した値を格納します。  

last_curl.txt
----------------
ruby_script.rbにて、latest_curl.jsonの値と比較し、最新値を更新した場合のみ本ファイルにlatest block numberを記述しています。  
