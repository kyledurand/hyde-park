CLASSES =
  PAGE: "page"
  MODAL: "social-modal"
  ACTIVATOR: "social-modal__activator"
  DEACTIVATOR: "social-modal__deactivator"

STATES =
  HTML:
    HAS_MODAL: "has-modal"
  PAGE:
    BLURRED: "#{CLASSES.PAGE}--is-blurred"
  MODAL:
    ACTIVE: "#{CLASSES.MODAL}--is-active"

$ ->
  $(".#{CLASSES.ACTIVATOR}, .#{CLASSES.DEACTIVATOR}").on "click", ->

    $html = $("html")
    $page = $(".#{CLASSES.PAGE}")
    $modal = $(".#{CLASSES.MODAL}")

    $html.toggleClass(STATES.HTML.HAS_MODAL)
    $page.toggleClass(STATES.PAGE.BLURRED)
    $modal.prepareTransition().toggleClass(STATES.MODAL.ACTIVE)

    $(window).on 'keydown', (evt) ->
      if $modal.hasClass(STATES.MODAL.ACTIVE)
        if evt.keyCode == $.ui.keyCode.ESCAPE
          $html.toggleClass(STATES.HTML.HAS_MODAL)
          $page.toggleClass(STATES.PAGE.BLURRED)
          $modal.prepareTransition().toggleClass(STATES.MODAL.ACTIVE)
