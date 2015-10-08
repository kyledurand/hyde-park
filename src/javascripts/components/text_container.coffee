LINK_TEXT = "Read more"
BASE_CLASS = "text-container"

CLASSES =
  TEXT_REVEALER: "#{BASE_CLASS}__revealer"
  TEXT_CONTAINER: "#{BASE_CLASS}--description"

STATES =
  TEXT_CONTAINER: OPEN: "#{BASE_CLASS}--is-open"

$ ->
  $(".#{CLASSES.TEXT_REVEALER}").on "click", ->

    $(".#{CLASSES.TEXT_CONTAINER}").toggleClass(STATES.TEXT_CONTAINER.OPEN)

    if $(".#{CLASSES.TEXT_CONTAINER}").hasClass(STATES.TEXT_CONTAINER.OPEN)
      LINK_TEXT = "Show less"
    else
      LINK_TEXT = "Read more"

    $(".#{CLASSES.TEXT_REVEALER}").text(LINK_TEXT)

    return
