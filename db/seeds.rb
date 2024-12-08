# frozen_string_literal: true

def seed_data(client)
  result = client.query('SELECT COUNT(*) AS count FROM users')
  user_count = result.first['count']

  if user_count.zero?
    insert_sample_data(client)
  else
    puts 'Sample data already exists. No data inserted.'
  end
end

def insert_sample_data(client)
  client.query(<<-SQL)
    INSERT INTO users (username, email)
    VALUES
      ('JohnDoe', 'johndoe@example.com'),
      ('JaneSmith', 'janesmith@example.com'),
      ('TestUser', 'testuser@example.com');
  SQL
  puts 'Sample data inserted successfully!'
end
