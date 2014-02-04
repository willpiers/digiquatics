class PrivateLessonDetail < ActiveRecord::Base
  include PaperclipHelper

  has_many :private_lessons
  has_attached_file :logo,
                    path: PAPERCLIP_PATH,
                    url: '/system/:attachment/:id/:style/:filename',
                    styles: {
                      thumb: '100x100>',
                      square: '200x200#',
                      medium: '300x300>'
                    },
                    default_url: '/images/missing.png'
end
