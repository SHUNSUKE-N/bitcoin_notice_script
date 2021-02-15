これはbitcoin coreに通知用スクリプトを加えたソースコードです
=====================================

付け加えたのは以下4ファイルです
----------------
cron_script.txt  
last_height.txt  
rscript_reader.sh  
ruby_script.rb  


cron_script.txt内に、cron設定を書いている為、
そのコマンドを実行することで、rubyスクリプトを通して1時間に一回slack通知を行ってくれます。