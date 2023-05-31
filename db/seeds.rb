# frozen_string_literal: true

ApplicationRecord.reset_column_information

# Load seeds that are shared by each environment
Dir[File.join(Rails.root, "db", "seeds", "shared", "*.rb")].sort.each do |seed|
  load seed
end

# Load seeds applicable to specific environments
if File.exists?(Rails.root, "db", "seeds", "#{Rails.env.downcase}.rb")
  load File.join(Rails.root,  "db", "seeds", "#{Rails.env.downcase}.rb")
end
