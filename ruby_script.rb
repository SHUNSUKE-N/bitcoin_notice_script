require 'net/http'
require 'uri'
require 'json'

def get_current_hash
  uri = URI.parse("https://blockchain.info/latestblock")
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  req = Net::HTTP::Get.new(uri.path)
  res = https.request(req)
  hash = JSON.parse(res.body)
end

def slack_notice(diff:)
  uri  = URI.parse('WEBHOOK_URL')
  params = { text: "latest block numberに差分#{diff}のdiffが生まれました（form Blockchain Data API）" }
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  https.start do
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(payload: params.to_json)
    https.request(request)
  end
end

last_block_num = File.read('/Users/shunsuke/bitcoin_notice_script/last_height.txt').to_i
latest_block_num = get_current_hash["height"].to_i
diff = latest_block_num - last_block_num

if diff > 2 || diff < -2
  slack_notice(diff: diff)
  File.write("/Users/shunsuke/bitcoin_notice_script/last_height.txt",latest_block_num)
end
