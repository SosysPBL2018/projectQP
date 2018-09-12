# coding: utf-8
class User < ApplicationRecord

  has_secure_password

  validates :name, {presence: true, uniqueness: true}
  #validates :email, {presence: true, uniqueness: true}
  validates :password,
            confirmation: true,
            presence: { message: 'を入力してください'}
  
  has_many :ideas,  dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :likes,  dependent: :destroy

  mount_uploader :image, ProfileImageUploader
end
