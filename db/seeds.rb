# frozen_string_literal: true

ApplicationRecord.reset_column_information

# Load seeds that are shared by each environment
Dir[File.join(Rails.root, "db", "seeds", "shared", "*.rb")].sort.each do |seed|
  load seed
end
