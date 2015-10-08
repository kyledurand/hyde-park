detectIE = require("../utilities/detect_ie_version.coffee")
breakpoints = require("../utilities/breakpoints.coffee")

BASE_CLASS = "card"

CLASSES =
  BASE: BASE_CLASS
  IMAGE: "image"
  CARD_HEADER: "card__content__header"
  CARD_DETAILS: "card__content__details"
  TEXT_PARAGRAPH: "type--paragraph"
  TEXT_CONTAINER: "text-container--description"
  TEXT_REVEALER: "text-container__revealer"

STATES =
  BASE: IS_VISIBLE: "#{CLASSES.BASE}--is-visible"
  REVEALER: IS_VISIBLE: "#{CLASSES.TEXT_REVEALER}--is-visible"

VARIANTS =
  BASE: WITH_IMAGE: "#{CLASSES.BASE}--with-image"

Card = (node) ->
  image = $(node).find(".#{CLASSES.IMAGE}")[0]
  $image = $(image)
  $details = $(node).find(".#{CLASSES.CARD_DETAILS}")
  $text_revealer = $(node).find(".#{CLASSES.TEXT_REVEALER}")
  $text_paragraph = $(node).find(".#{CLASSES.TEXT_CONTAINER} .#{CLASSES.TEXT_PARAGRAPH}")

  size_card_to_image = ->
    image = $(node).find(".#{CLASSES.IMAGE}")[0] unless document.documentElement.contains(image)
    card_header_height = $(node).find(".#{CLASSES.CARD_HEADER}").innerHeight()
    node.style.height = "#{image.offsetHeight}px"
    $details.innerHeight(image.offsetHeight - card_header_height)

  pre_flip_reset = ->
    # Set height to null before card-flip (so that it takes its natural height)
    node.style.height = null
    $details.height("auto")
    $text_container = $(node).find(".#{CLASSES.TEXT_CONTAINER}")
    text_container_height = $text_container.height()
    text_paragraph_height = $text_paragraph.height()
    if !$text_container.hasClass("text-container--is-open")
      $text_revealer.toggleClass(STATES.REVEALER.IS_VISIBLE, text_paragraph_height > text_container_height)

  $(window).on "load", ->
    if $image[0].complete
      $image.load()
      $(node).addClass(STATES.BASE.IS_VISIBLE)

  $(window).on "load resize", ->
    if detectIE.is_internet_explorer() && detectIE.get_internet_explorer_version() < 10
      if $(window).width() >= 720
        size_card_to_image()
      else
        pre_flip_reset()
    else if breakpoints.card_flip.matches
      size_card_to_image()
    else
      pre_flip_reset()

  return

$ ->
  $(".#{VARIANTS.BASE.WITH_IMAGE}").each (index, card) -> Card(card)
