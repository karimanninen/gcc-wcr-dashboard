/* ============================================================================
   SCROLL.JS - Navigation and Scroll Behavior
   GCC Competitiveness Dashboard
   ============================================================================ */

$(document).ready(function() {
  
  // Update active nav dot on scroll
  $('.story-container').on('scroll', function() {
    var sections = $('.story-section');
    var scrollPos = $(this).scrollTop();
    var windowHeight = $(window).height();
    
    sections.each(function(i) {
      var top = $(this).position().top;
      if (top <= windowHeight/2 && top > -windowHeight/2) {
        $('.nav-dot').removeClass('active');
        $('.nav-dot').eq(i).addClass('active');
      }
    });
  });
  
  // Click nav dot to scroll to section
  $('.nav-dot').on('click', function() {
    var index = $(this).index();
    var target = $('.story-section').eq(index);
    $('.story-container').animate({
      scrollTop: target.position().top + $('.story-container').scrollTop()
    }, 800);
  });
  
  // Keyboard navigation
  $(document).on('keydown', function(e) {
    var currentIndex = $('.nav-dot.active').index();
    var totalSections = $('.story-section').length;
    
    if (e.keyCode === 40 || e.keyCode === 34) { // Down or PageDown
      e.preventDefault();
      if (currentIndex < totalSections - 1) {
        $('.nav-dot').eq(currentIndex + 1).click();
      }
    }
    
    if (e.keyCode === 38 || e.keyCode === 33) { // Up or PageUp
      e.preventDefault();
      if (currentIndex > 0) {
        $('.nav-dot').eq(currentIndex - 1).click();
      }
    }
  });
  
  // Scroll indicator click
  $('.scroll-indicator').on('click', function() {
    $('.nav-dot').eq(1).click();
  });
  
});
