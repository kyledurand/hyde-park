Photoswipe = require("./../vendor/photoswipe.js")
PhotoswipeUI = require("./../vendor/photoswipe_ui.js")

CLASSES =
  CARD: "card"
  DOT: "pswp__navigation__dot"
  NAV_LINK: "pswp__navigation__link"
  CLOSE_BUTTON: "pswp__close-button"

STATES =
  DOT: IS_ACTIVE: "#{CLASSES.DOT}--is-active"
  CARD: ACTIVE_GALLERY: "#{CLASSES.CARD}--has-active-image-gallery"
  CLOSE_BUTTON: IS_ACTIVE: "#{CLASSES.CLOSE_BUTTON}--is-active"

add_natural_size = (detail) ->
  natural_image = new Image

  natural_image.onload = ->
    detail.h = natural_image.height
    detail.w = natural_image.width

  natural_image.src = detail.el.src
  return

image_details = ->
  details = []

  $("#extra-images img").each (i, img) ->
    detail =
      src: img.src
      msrc: img.src
      el: img

    add_natural_size(detail)
    details.push(detail)

  details

apply_active_state = (current_index) ->
  $(".#{CLASSES.NAV_LINK}").each (i) ->
    link = $(this)
    index = parseInt((link).attr("data-nav-index"), 10)
    add_active_class = false

    if index == current_index
      add_active_class = true

    link.find(".#{CLASSES.DOT}").toggleClass(STATES.DOT.IS_ACTIVE, add_active_class)
  return

$ ->
  $document = $(document)
  $photoswipe = $(".pswp")
  $close_button = $(".#{CLASSES.CLOSE_BUTTON}")
  thumbnail_details = image_details()
  new_index = 0

  $document.on "click", ".image--featured", ->
    $card = $(".#{CLASSES.CARD}")
    $card_image_container = $card.find(".card__image")
    $close_button.prepareTransition().addClass(STATES.CLOSE_BUTTON.IS_ACTIVE)
    $card.addClass(STATES.CARD.ACTIVE_GALLERY)

    options =
      index: new_index
      closeOnScroll: true
      captionEl: false
      arrowEl: false
      fullscreenEl: false
      zoomEl: false
      shareEl: false
      counterEl: false
      history: false

      getThumbBoundsFn: (index) ->
        rect = $card_image_container[0].getBoundingClientRect()

        x: rect.left
        y: rect.top + window.pageYOffset
        w: rect.width

    photoswipe = new Photoswipe($photoswipe[0], PhotoswipeUI, thumbnail_details, options)
    setTimeout (-> photoswipe.init()), 100 # settimeout to allow time for transitions

    $document.on "click", ".#{CLASSES.NAV_LINK}", ->
      nav_target = parseInt($(this).attr("data-nav-index"), 10)
      photoswipe.goTo(nav_target)

    $document.on "click", ".#{CLASSES.CLOSE_BUTTON}", ->
      photoswipe.close();

    photoswipe.listen "afterChange", ->
      $current_image = $(photoswipe.currItem.el)
      current_index = parseInt($current_image.attr("data-img-index"), 10)
      apply_active_state(current_index)
      new_index = current_index

    photoswipe.listen "unbindEvents", ->
      $document.off "click", ".#{CLASSES.NAV_LINK}"

    photoswipe.listen "destroy", ->
      # empty the image container and replace the image with the current pswp image
      $card_image_container.empty()
      $current_image = $(photoswipe.currItem.el)
      $card_image = $current_image.clone().attr("class", "image image--featured")
      $card_image_container.append($card_image)
      # same with pswp dot nav to show the user that more images are available
      $nav = $(".pswp__navigation").clone()
      $card_image_container.append($nav)
      # remove pswp classes and hide close button
      $card.removeClass(STATES.CARD.ACTIVE_GALLERY)
      $close_button.prepareTransition().removeClass(STATES.CLOSE_BUTTON.IS_ACTIVE)
