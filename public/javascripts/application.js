function remove_new_menu_item(element) {
  element.remove();
}
function remove_existent_menu_item(element) {
  element.children('input.mark-for-remove').val('true');
  element.hide();
}

function add_new_menu_item(){
  var html = $('#menu-item-for-cloning').html().replace(/randomizer/g, Math.floor(Math.random()*1000));
  $('#menu-item-for-cloning').before(html);
}

$(function(){
  $('.menu a.remove.new-record').live('click', function(){
    remove_new_menu_item($(this).closest('.menu-item'));
    return false;
  });
  $('.menu a.remove.existent-record').live('click', function(){
    remove_existent_menu_item($(this).closest('.menu-item'));
    return false;
  });
  $('.menu a.add-menu-item').live('click', function(){
    add_new_menu_item();
    return false;
  });
});

