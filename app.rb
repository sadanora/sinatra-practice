# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require 'pg'

APP_TITLE = 'memotra🖋🎩'
CONNECTION = PG.connect(dbname: 'sinatra_memoapp')

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def build_memo(memo_title, memo_detail)
  CONNECTION.exec('INSERT INTO memos (title, detail) VALUES ($1, $2)', [memo_title, memo_detail])
end

def fetch_memo_list
  CONNECTION.exec('SELECT id, title FROM memos').to_a
end

def fetch_memo(memo_id)
  CONNECTION.exec('SELECT id, title, detail FROM memos WHERE id = $1', [memo_id]).to_a
end

def update_memo(memo_id, memo_title, memo_detail)
  CONNECTION.exec('UPDATE memos SET title = $2, detail = $3 WHERE id = $1', [memo_id, memo_title, memo_detail])
end

def delete_memo(memo_id)
  CONNECTION.exec('DELETE FROM memos WHERE id = $1', [memo_id])
end

get '/' do
  @memos = fetch_memo_list

  @page_title = APP_TITLE.to_s

  erb :index
end

post '/new' do
  build_memo(params[:memo_title], params[:memo_detail])

  redirect to '/'
end

get '/memos/:memo_id' do
  @memo = fetch_memo(params[:memo_id].to_s)[0]

  @page_title = "#{@memo['title']} | #{APP_TITLE}"

  erb :memo
end

get '/memos/:memo_id/edit' do
  @memo = fetch_memo(params[:memo_id].to_s)[0]

  @page_title = "edit | #{APP_TITLE}"

  erb :edit
end

patch '/memos/:memo_id' do
  update_memo(params[:memo_id], params[:memo_title], params[:memo_detail])

  redirect to "/memos/#{params[:memo_id]}"
end

delete '/memos/:memo_id' do
  delete_memo(params[:memo_id])

  redirect to '/'
end
