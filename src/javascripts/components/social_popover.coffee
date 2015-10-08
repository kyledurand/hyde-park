BASE_CLASS = "social-popover"

CLASSES =
  POPOVER: BASE_CLASS
  ACTIVATOR: "#{BASE_CLASS}__activator"
  BUTTON: "#{BASE_CLASS}__button"
STATES =
  ACTIVE: "#{BASE_CLASS}--is-active"

$ ->
  active = false # Need to track active state so that we don't unnecessary apply active state.

  $(".#{CLASSES.ACTIVATOR}").on "click", ->
    active = true

    $activator = $(this)
    $activator.focus() # Need to manually focus because Safari and FF don't focus buttons on click.
    $activator.next(".#{CLASSES.POPOVER}").prepareTransition().addClass(STATES.ACTIVE)

  $(".#{CLASSES.BUTTON}").on "click", ->
    $(this).closest(".#{CLASSES.POPOVER}").prepareTransition().removeClass(STATES.ACTIVE)

  # Check for mousedown even on document because IE8 does not support event.relatedTarget.
  $(document).on "mousedown", (event) ->
    $target = $(event.target)

    if $target.closest(".#{CLASSES.POPOVER}")[0] || $target.closest(".#{CLASSES.ACTIVATOR}")[0]
      return
    else
      if active
        active = false
        $(".#{CLASSES.POPOVER}").prepareTransition().removeClass(STATES.ACTIVE)
