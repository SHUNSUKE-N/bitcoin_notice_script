これはbitcoin coreに通知用スクリプトを加えたソースコードです
=====================================

付け加えたのは以下4ファイルです
----------------
[cron_script.txt](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/cron_script.txt)  
[last_api.txt](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/last_api.txt)  
[rscript_reader.sh](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/rscript_reader.sh)  
[ruby_script.rb](https://github.com/SHUNSUKE-N/bitcoin_notice_script/blob/master/ruby_script.rb)  


cron_script.txt内に、cron設定を書いている為、  
そのコマンドを実行することでrubyスクリプトを通して1時間に1回、  
latest block numberに3以上の差分がある場合のみslack通知を行ってくれます。