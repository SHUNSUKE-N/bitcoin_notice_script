これはbitcoin coreに通知用スクリプトを加えたソースコードです
=====================================
cron_script.txt内に、cronの設定コマンドを記述しています。  
そのコマンドを叩くことでをbashスクリプトを1時間に1回実行し、  
APIを叩いて取ったブロックとJSON-RPCを実行して取ったブロックを比較し、  
latest block numberに3以上の差分がある場合のみslack通知を行ってくれます。 
（スクリプト内の階層パスについては、環境毎に要調整）  


[cron_script.txt](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/cron_script.txt)  
----------------
cron指示を記述したコピーファイルです。 

[rscript_reader.sh](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/rscript_reader.sh) 
----------------
bashスクリプトを記述しています。  
JSON-RPCを実行後、jsonデータをlatest_curl.jsonに格納し、ruby_script.rbを呼び出します。  

[ruby_script.rb](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/ruby_script.rb) 
----------------
rubyスクリプトを記述しています。  
Blockchain Data APIを叩き、その後、条件に応じてメッセージをslackに通知します。   

[latest_curl.json](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/latest_curl.json)  
----------------
rscript_reader.shでJSON-RPCを実行して取得した値を格納します。  


参照元 
----------------
利用したAPI：  
Blockchain Data API(Latest Block)  
https://www.blockchain.com/ja/api/blockchain_api  

利用したRPC：  
getchaintips  
https://developer.bitcoin.org/reference/rpc/getchaintips.html  