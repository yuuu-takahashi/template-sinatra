# frozen_string_literal: true

require 'rake'

require_relative 'app/services/database_client'
require_relative 'db/schema'
require_relative 'db/seeds'

namespace :db do
  desc 'データベースを作成します'
  task :create do
    client = DatabaseClient.connect
    create_database(client, 'template-sinatra_development')
    client.close
  end

  desc 'ユーザーテーブルを作成します'
  task :create_users_table do
    client = DatabaseClient.connect
    create_users_table(client)
    client.close
  end

  desc 'データベースをセットアップします（データベースとユーザーテーブル作成）'
  task setup: %i[create create_users_table] do
    puts 'データベースとユーザーテーブルをセットアップしました。'
  end

  desc 'シードデータを投入します'
  task :seed do
    client = DatabaseClient.connect
    seed_data(client)
    client.close
  end

  desc 'データベースをリセット（セットアップとシードを再実行）します'
  task reset: %i[setup seed]
end