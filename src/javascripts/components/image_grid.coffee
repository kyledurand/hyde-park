BASE_CLASS = "image-grid"

CLASSES =
  BASE: BASE_CLASS
  ITEM: "#{BASE_CLASS}__item"
  HIDDEN_COUNT: "#{BASE_CLASS}__hidden-count"

VARIANTS =
  ITEM: PLACEHOLDER: "#{CLASSES.ITEM}--placeholder"

ATTRS =
  IMAGE_COUNT: "data-other-images-count"



visible_count = (images) ->
  (image for image in images when image.offsetHeight > 0).length

ImageGrid = (node) ->
  image_count = +node.getAttribute(ATTRS.IMAGE_COUNT)

  # Using jQuery because IE8 querySelectorAll cannot handle :not
  $image_nodes = $(".#{CLASSES.ITEM}:not(.#{VARIANTS.ITEM.PLACEHOLDER})")
  images = $.makeArray($image_nodes)
  placeholder = node.querySelector(".#{VARIANTS.ITEM.PLACEHOLDER}")
  hidden_count = node.querySelector(".#{CLASSES.HIDDEN_COUNT}")

  update_placeholder = ->
    difference = image_count - visible_count(images)
    hidden_count.textContent = difference
    placeholder.style.display = if difference > 0 then "" else "none"

  update_placeholder()

  $(window).on("resize", update_placeholder)

$ ->
  for image_grid in document.querySelectorAll(".#{CLASSES.BASE}")
    ImageGrid(image_grid)
