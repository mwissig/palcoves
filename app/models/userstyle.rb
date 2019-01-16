class Userstyle < ApplicationRecord
  belongs_to :username
  before_save { self.signature_css = signature_css.tr("><","") }
end
