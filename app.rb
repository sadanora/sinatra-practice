# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

APP_TITLE = 'memotra🖋🎩'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def build_memo(id, title, detail, file_path)
  Dir.mkdir('./public/memos', 0o755) unless Dir.exist?('./public/memos')
  memo = JSON.pretty_generate({ id: id, title: title, detail: detail })
  File.open(file_path, 'w', 0o755) { |f| f.print memo }
end

def json_to_hash(file_path)
  File.open(file_path, 'r') { |f| JSON.parse(f.read) }
end

get '/' do
  @memos = []
  file_names = Dir.glob('*.json', base: './public/memos/')
  file_names.each do |file_name|
    @memos.push(json_to_hash("./public/memos/#{file_name}"))
  end

  @page_title = APP_TITLE.to_s

  erb :index
end

post '/new' do
  id = SecureRandom.urlsafe_base64
  build_memo(id, params[:memo_title], params[:memo_detail], "./public/memos/#{id}.json")

  redirect to '/'
end

get '/memos/:memo_id' do
  @memo = json_to_hash("./public/memos/#{params[:memo_id]}.json")

  @page_title = "#{@memo['title']} | #{APP_TITLE}"

  erb :memo
end

get '/memos/:memo_id/edit' do
  @memo = json_to_hash("./public/memos/#{params[:memo_id]}.json")

  @page_title = "edit | #{APP_TITLE}"

  erb :edit
end

patch '/memos/:memo_id' do
  build_memo(params[:memo_id], params[:memo_title], params[:memo_detail], "./public/memos/#{params[:memo_id]}.json")

  redirect to "/memos/#{params[:memo_id]}"
end

delete '/memos/:memo_id' do
  File.delete("./public/memos/#{params[:memo_id]}.json")

  redirect to '/'
end
