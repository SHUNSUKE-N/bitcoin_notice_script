require 'net/http'
require 'json'
require 'slack/incoming/webhooks'

def get_current_hash
  url = URI.parse("https://blockchain.info/latestblock")
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  req = Net::HTTP::Get.new(url.path)
  res = https.request(req)
  hash = JSON.parse(res.body)
end

def slack_notice(diff:)
  slack = Slack::Incoming::Webhooks.new "WEBHOOK_URL", channel: '#notice-channel', username: 'latest-block-notice'
  slack.post "latest block numberに差分#{diff}のdiff生まれました（form Blockchain Data API）"
end

last_block_num = File.read('/Users/shunsuke/bitcoin_notice_script/last_height.txt').to_i
latest_block_num = get_current_hash["height"].to_i
diff = latest_block_num - last_block_num

if diff > 2 || diff < 2
  slack_notice(diff: diff)
  File.write("/Users/shunsuke/bitcoin_notice_script/last_height.txt",latest_block_num)
end
