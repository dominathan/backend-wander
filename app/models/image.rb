class Image < ApplicationRecord
  belongs_to :place

  has_attached_file :avatar,
    styles: {
      original: '400x400#',
    },
    default_style: :original,
    path: "places/avatar/:hash/:style/:extension",
    hash_data: ":id",
    hash_secret: ENV['AWS_SECRET_ACCESS_KEY'],
    hash_digest: 'SHA1'

  do_not_validate_attachment_file_type :avatar


end
