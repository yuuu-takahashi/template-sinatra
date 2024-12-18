# frozen_string_literal: true

require 'rake'

require_relative 'app/services/database_client'
require_relative 'db/schema'
require_relative 'db/seeds'

namespace :db do
  task :create do
    client = DatabaseClient.connect_without_database
    create_database(client, 'template-sinatra_development')
    client.close
  end

  task :create_users_table do
    client = DatabaseClient.connect
    create_users_table(client)
    client.close
  end

  task :seed do
    client = DatabaseClient.connect
    seed_data(client)
    client.close
  end

  task setup: %i[create create_users_table seed] do
    puts 'データベースとユーザーテーブルをセットアップしました。'
  end

  desc 'データベースを削除します'
  task :drop do
    client = DatabaseClient.connect
    drop_database(client, 'template-sinatra_development')
    client.close
  end

  desc 'データベースをリセット（削除、セットアップとシードを再実行）します'
  task reset: %i[drop setup]
end
