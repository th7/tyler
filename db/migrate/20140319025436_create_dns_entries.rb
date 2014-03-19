class CreateDnsEntries < ActiveRecord::Migration
  def change
    create_table :dns_entries do |t|
      t.string :url
      t.string :ip

      t.timestamps
    end
  end
end
