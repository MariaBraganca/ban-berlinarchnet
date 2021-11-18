module ApplicationHelper
  def image_path_generator(photo, width = nil)
    width ||= 300
    cl_image_path(photo, crop: 'fill', gravity: :auto, width: width, format: :webp)
  end

  def image_path_selector(photo, tag, **args)
    args[:placeholder] ||= 'logo/logo1-gray'
    args[:width] ||= 300

    return image_path_generator(photo.key, args[:width]) if photo.attached?
    return image_path_generator(tag, args[:width]) if tag

    image_path_generator(args[:placeholder], args[:width])
  end
end
