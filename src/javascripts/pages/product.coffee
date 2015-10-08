CLASSES =
  CONTENT: "card__content"
  DETAILS: "card__content__details"

STATES =
  FADED: "card__content--fade"

$ ->
  $(".#{CLASSES.DETAILS}").on "scroll", ->
    if $(".#{CLASSES.DETAILS}")[0].scrollHeight - $(".#{CLASSES.DETAILS}").scrollTop() <= $(".#{CLASSES.DETAILS}").outerHeight()
      $(".#{CLASSES.CONTENT}").removeClass(STATES.FADED)
    else
      $(".#{CLASSES.CONTENT}").addClass(STATES.FADED)
