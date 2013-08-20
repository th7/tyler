class CreateSmsMessages < ActiveRecord::Migration
  def change
    create_table :sms_messages do |t|
      t.text :text
      t.string :from
      t.datetime :sent_at

      t.timestamps
    end
  end
end
