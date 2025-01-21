class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many_attached :images
  has_many_attached :videos
  has_many_attached :audios
  has_many_attached :documents
  has_one_attached :main_photo

  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :title, presence: true

  validates :videos, 
    content_type: { in: %w[video/mp4 video/webm video/ogg video/quicktime video/x-msvideo video/x-matroska],
      message: "musi być prawidłowym formatem wideo (mp4, webm, ogg, mov, avi, mkv)." },
    size: { less_than: 100.megabytes,
      message: "powinien być mniejszy niż 100MB." },
    limit: { min: 0, max: 2, 
      message: "Możesz przesłać maksymalnie 2 videos." }

  validates :audios,
    content_type: { in: %w[audio/mpeg audio/wav audio/ogg audio/aac audio/flac audio/x-m4a],
      message: "must be a valid audio format (mp3, wav, ogg, aac, flac, m4a)." }, 
    size: { less_than: 10.megabytes, 
      message: "should be smaller than 10MB." },
    limit: { min: 0, max: 4, 
      message: "You can upload maximum 4 audios." }

  validates :images,
    content_type: { in: %w[image/jpeg image/png image/gif image/bmp image/tiff image/webp image/svg+xml],
      message: "musi być prawidłowym formatem obrazu (jpg, png, gif, bmp, tiff, webp, svg)." }, 
    size: { less_than: 5.megabytes, 
      message: "powinien być mniejszy niż 5MB." },
    limit: { min: 0, max: 10, 
      message: "Możesz przesłać maksymalnie 10 obrazów." }
  
  validates :documents,
    content_type: { in: %w[application/pdf text/plain application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet text/csv],
      message: "must be a valid document format (PDF, TXT, DOC, DOCX, XLS, XLSX, CSV)." },
    size: { less_than: 10.megabytes, 
      message: "should be smaller than 10MB." },
    limit: { min: 0, max: 5, 
      message: "You can upload maximum 5 document." }    

  validates :main_photo,
    content_type: { in: %w[image/jpeg image/png image/gif image/bmp image/tiff image/webp image/svg+xml],
      message: "must be a valid image format (jpg, png, gif, bmp, tiff, webp, svg)." }, 
    size: { less_than: 5.megabytes, 
      message: "should be smaller than 5MB." },
    limit: { min: 0, max: 1, 
      message: "You can upload maximum 1 image." }    
end