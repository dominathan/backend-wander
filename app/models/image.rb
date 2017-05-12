class Image < ApplicationRecord
  belongs_to :place

  has_attached_file :avatar,
    styles: {
      original: '400x400#',
    },
    default_style: :original

  do_not_validate_attachment_file_type :avatar

  def s3_file_path
    url = self.avatar.url.split('s3.')[1]
    url.prepend('https://s3.us-east-2.')
  end

end
