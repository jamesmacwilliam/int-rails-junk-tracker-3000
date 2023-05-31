# frozen_string_literal: true

%w[
  works
  fixable
  junk
].each do |name|
  PartStatus.find_or_create_by(name: name)
end
