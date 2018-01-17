class ContactPerson < ApplicationRecord
  belongs_to :target_client

  validates :first_name, :last_name, :target_client_id, presence: true
  validates :contact_number, presence: true, length: {minimum: 7}

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new('||',
      Arel::Nodes::InfixOperation.new('||',
        parent.table[:first_name], Arel::Nodes.build_quoted(' ')
      ),
      parent.table[:last_name]
    )
  end
end
