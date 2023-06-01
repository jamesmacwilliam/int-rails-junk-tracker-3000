# frozen_string_literal: true

default_status = PartStatus.find_or_create_by(name: "works")
[
  { name: "Sedan", door_count: 4, parts: %w[Engine] },
  { name: "Coupe", door_count: 2, parts: %w[Engine] },
  { name: "Mini-Van", door_count: 4, sliding_door_count: 2, parts: %w[Engine] },
  { name: "Motorcycle", parts: %w[Engine Seat] },
].each do |attrs|
  record = VehicleType.find_or_initialize_by(name: attrs[:name])
  record.assign_attributes(attrs.except(:parts))
  record.save
  attrs[:parts].each do |part_name|
    part = Part.find_or_create_by(name: part_name)
    record.vehicle_type_parts
      .find_or_initialize_by(part_id: part.id)
      .update(part_status: default_status)
  end
end
