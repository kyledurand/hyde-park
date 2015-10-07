CLASSES =
  PAGE: "page"
  MODAL: "modal"
  MODAL_CONTENT: "modal__content"
  ACTIVATOR: "modal__activator"
  DEACTIVATOR: "modal__deactivator"

VARIANTS =
  MODAL:
    MODAL_DARK: "#{CLASSES.MODAL}--dark"

STATES =
  HTML:
    HAS_MODAL: "has-modal"
  PAGE:
    BLURRED: "#{CLASSES.PAGE}--is-blurred"
  MODAL:
    ACTIVE: "#{CLASSES.MODAL}--is-active"

$ ->
  $html = $("html")
  $document = $(document)
  $page = $(".#{CLASSES.PAGE}")

  modal_off = ->
    $document
      .off("keydown")
      .off("click", ".#{VARIANTS.MODAL.MODAL_DARK}")
      .off("click", ".#{CLASSES.ACTIVATOR}, .#{CLASSES.DEACTIVATOR}")

  $(".#{CLASSES.ACTIVATOR}, .#{CLASSES.DEACTIVATOR}").on "click", ->

    modal_target = "##{$(this).attr("data-modal-target")}"
    $modal = $html.find(modal_target)

    modal_off() if $modal.hasClass(STATES.MODAL.ACTIVE)

    $html.toggleClass(STATES.HTML.HAS_MODAL)
    $page.toggleClass(STATES.PAGE.BLURRED)
    $modal.prepareTransition().toggleClass(STATES.MODAL.ACTIVE)

    $document
      .on 'keydown', (evt) ->
        if $modal.hasClass(STATES.MODAL.ACTIVE)
          if evt.keyCode == $.ui.keyCode.ESCAPE
            $html.toggleClass(STATES.HTML.HAS_MODAL)
            $page.toggleClass(STATES.PAGE.BLURRED)
            $modal.prepareTransition().toggleClass(STATES.MODAL.ACTIVE)
            modal_off()

      # destroy modal when clicking on background
      .on "click", ".#{VARIANTS.MODAL.MODAL_DARK}", ->
        $html.removeClass(STATES.HTML.HAS_MODAL)
        $page.removeClass(STATES.PAGE.BLURRED)
        $modal.prepareTransition().removeClass(STATES.MODAL.ACTIVE)
        modal_off()

      # prevent click through on content
      .on "click", ".#{CLASSES.MODAL_CONTENT}", (evt) ->
        evt.stopPropagation()
