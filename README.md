これはbitcoin coreに通知用スクリプトを加えたソースコードです
=====================================

付け加えたのは以下6ファイルです
----------------
[rscript_reader.sh](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/rscript_reader.sh)  
[ruby_script.rb](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/ruby_script.rb)  
[cron_script.txt](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/cron_script.txt)  
[last_api.txt](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/last_api.txt)  
[last_curl.txt](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/last_curl.txt)  
[latest_curl.json](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/latest_curl.json)  

cron_script.txt内に、cron設定を書いている為、  
そのコマンドを実行することでrubyスクリプトを通して1時間に1回、  
latest block numberに3以上の差分がある場合のみslack通知を行ってくれます。  


利用したAPI：  
Blockchain Data API(Latest Block)  
https://www.blockchain.com/ja/api/blockchain_api  


rscript_reader.sh
----------------
bashスクリプトを記述。  

ruby_script.rb
----------------
rubyスクリプトを記述し、条件に応じてメッセージをslackに通知。  

cron_script.txt
----------------
cronの指示を記述したコピーファイル。  

last_api.txt
----------------
ruby_script.rbからapiを叩き、最新値を更新した場合のみ本ファイルにlatest block numberを記述。  

latest_curl.json
----------------
rscript_reader.shでbitcoindを通して取得した値json形式のblock情報を格納。  

last_curl.txt
----------------
ruby_script.rbにて、latest_curl.jsonの値と比較し、最新値を更新した場合のみ本ファイルにlatest block numberを記述。  
