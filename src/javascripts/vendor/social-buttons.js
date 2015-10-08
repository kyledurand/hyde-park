/*============================================================================
  Social Icon Buttons v1.0
  Author:
    Carson Shold | @cshold
    http://www.carsonshold.com
  MIT License
==============================================================================*/
window.timberSocial = window.timberSocial || {};

timberSocial.cacheSelectors = function () {
  timberSocial.cache = {
    $shareButtons: $('.social-sharing'),
  }
};

timberSocial.init = function () {
  timberSocial.cacheSelectors();
  timberSocial.sliders();
};

timberSocial.socialSharing = function () {

  timberSocial.cacheSelectors();

  // General selectors
  var $buttons = timberSocial.cache.$shareButtons,
      $shareLinks = $buttons.find('a'),
      permalink = $buttons.attr('data-permalink');

  // Share button selectors
  var $fbLink = $('.share-facebook'),
      $twitLink = $('.share-twitter'),
      $pinLink = $('.share-pinterest'),
      $googleLink = $('.share-google');

  // Share popups
  $shareLinks.on('click', function(e) {
    e.preventDefault();
    var el = $(this),
        popup = el.attr('class').replace('-','_'),
        link = el.attr('href'),
        w = 700,
        h = 400;

    // Set popup sizes
    switch (popup) {
      case 'share-twitter':
        h = 300;
        break;
      case 'share-fancy':
        w = 480;
        h = 720;
        break;
      case 'share-google':
        w = 500;
        break;
    }

    window.open(link, '', 'width=' + w + ', height=' + h);
  });
}

$(timberSocial.socialSharing)
