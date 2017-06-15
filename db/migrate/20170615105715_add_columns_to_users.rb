class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string, null: false, default:""
    add_column :users, :provider, :string, null: false, default:""
    add_column :users, :username, :string

    add_index :users, [:uid, :provider], unique: true
    #上記でTwitterとFacebook複数のOAuth認証を併用できるようにする
    #user = User.where(:provider => auth.provider, :uid => auth.uid).first
  end
end
