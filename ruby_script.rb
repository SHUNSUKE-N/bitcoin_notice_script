require 'net/http'
require 'uri'
require 'json'

def get_current_hash
  uri = URI.parse("https://blockchain.info/latestblock")
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  req = Net::HTTP::Get.new(uri.path)
  res = https.request(req)
  JSON.parse(res.body)
end

def slack_notice(diff:, message:)
  uri  = URI.parse('WEBHOOK_URL')
  params = { username: "notice_bot", channel: "latest_block_notice", text: "latest block numberに差分#{diff}のdiffが生まれました（from #{message}）" }
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  https.start do
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(payload: params.to_json)
    https.request(request)
  end
end

last_curl_num = File.read('/Users/shunsuke/bitcoin_notice_script/last_curl.txt').to_i
latest_curl_num = File.read('/Users/shunsuke/bitcoin_notice_script/latest_curl.json').split(":")[1].strip.split(",")[0].to_i
curl_diff = latest_curl_num - last_curl_num

last_api_num = File.read('/Users/shunsuke/bitcoin_notice_script/last_api.txt').to_i
latest_api_num = get_current_hash["height"].to_i
api_diff = latest_api_num - last_api_num

if api_diff > 2 || api_diff < -2
  api_message = "Blockchain Data API"
  slack_notice(diff: api_diff, message: api_message)
  File.write("/Users/shunsuke/bitcoin_notice_script/last_api.txt", latest_api_num)
end

if curl_diff > 2 || curl_diff < -2
  bitcoind_message = "bitcoind"
  slack_notice(diff: curl_diff, message: bitcoind_message)
  File.write("/Users/shunsuke/bitcoin_notice_script/last_curl.txt", latest_curl_num)
end