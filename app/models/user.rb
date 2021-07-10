# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models

  before_validation :password_confirmation_emptiness, on: :create

  # Include default devise modules. Others available are:
  # :omniauthable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable

  include DeviseTokenAuth::Concerns::User

  validate :name_format
  validate :nickname_format
  #validate :email_domains
  validate :password_complexity, on: :create
  validates :phone_number, presence: true, phone: { possible: true, allow_blank: true, countries: [:fr, :be, :ch, :ca, :us, :gb] }
  
  validates_length_of :name, within: 4..64, allow_blank: true
  validates_length_of :nickname, within: 3..20, allow_blank: true

  validates_presence_of :nickname, :password_confirmation, on: :create

  validates_uniqueness_of :nickname, :phone_number

  def password_confirmation_emptiness
    self.password_confirmation = nil if self.password_confirmation == ""
  end
  
  def name_format
    if name.present?
      errors.add :name, I18n.t('validation.user.full-name.format') unless name.match(/\A[a-zA-ZÀ-ÿ]+([ \-']?[a-zA-ZÀ-ÿ]+[ \-']?[a-zA-ZÀ-ÿ]+[ \-']?)[a-zA-ZÀ-ÿ]+\z/i)
    end
  end

  def nickname_format
    if nickname.present?
      errors.add :nickname, I18n.t('validation.user.nickname.format') unless nickname.match(/\A[a-zA-ZÀ-ÿ\d\-\_]+\z/i)
    end
  end

  def email_domains
    # to do
    # check if the mail used is a droppable mail by checking the domain
  end
  
  def password_complexity
    if password.present?
      errors.add :password, I18n.t('validation.user.password.format-uppercase') unless password.match(/\p{Upper}/)
      errors.add :password, I18n.t('validation.user.password.format-lowercase') unless password.match(/\p{Lower}/)
      errors.add :password, I18n.t('validation.user.password.format-number') unless password.match(/\d+/)
      errors.add :password, I18n.t('validation.user.password.format-symbol') unless password.match(/\W+/)
    end
  end
end
