class Datum < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
end
