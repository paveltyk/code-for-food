function remove_menu_item(element) {
  if (element.hasClass('new-record')) {
    element.remove();
  } else {
    element.children('input.mark-for-remove').val('true');
    element.hide();
  }
}

function render_menu_items_from_string(text) {
  $('#current-menu-items .menu-item').each(function(index, item){
    remove_menu_item($(this));
  });
  $.each(text.split(/\n/), function(i, row){
    row = row.trim();
    if (row.length > 0) {
      attrs = row.split(/\t+/);
      var menu_item = build_menu_item_from_array(attrs);
      add_new_menu_item(menu_item);
    }
  });
  $('input[placeholder]').placeholder();
}

function build_menu_item_from_array(arr) {
  var name = arr[0].replace(/\([^\)]+\)/g,'').trim();
  var price = arr[2].replace(/\D/g, '');
  var weight = arr[1].trim();
  var description = arr[0].match(/\(([^\)]+)\)/g);
  if ($.type(description) !== 'null') {
    description = description[0];
    description = description.substr(1,description.length-2);
  }

  return {name:name, weight:weight, price:price, description:description}
}

function add_new_menu_item(attrs){
  var html = $('#menu-item-for-cloning').html().replace(/randomizer/g, Math.floor(Math.random()*1000));
  html = $(html);
  if ($.type(attrs) !== 'undefined') {
    $(html).children('input.name').val(attrs.name);
    $(html).children('input.price').val(attrs.price);
    $(html).children('input.weight').val(attrs.weight);
    $(html).children('input.description').val(attrs.description);
  }
  $('#current-menu-items').append(html);
  bootstrap_menu_multiselects();
}

function calculate_total_price() {
  var _total = 0;
  $('ul.order input[type="checkbox"]').each(function(index, item){
    var checkbox = $(item);
    var li = checkbox.closest('li');
    if (checkbox.is(':checked')) {
      var _price = li.find('span.price').text().replace(/\D/,'') / 1;
      var _qtt = li.find('span.quantity input').val() / 1;
      _total += _price * _qtt;
    }
  });
  $('ul.order li.total').html('Итого: <span>' + _total + '</span>');
  return _total;
}

function bootstrap_dish_order() {
  $('ul.order li').each(function(i,li){
    li = $(li);
    if (li.children('input.order-item-select:checked').length > 0) {
      li.addClass('selected');
    }
  });
  $('ul.order input[type="checkbox"]').click(function(){
    var checkbox = $(this);
    li = checkbox.closest('li');
    if (checkbox.is(':checked')) {
      li.addClass('selected');
      li.find('input[type="text"]').focus();
    } else {
      li.removeClass('selected');
    }
    calculate_total_price();
  });
  $('ul.order span.quantity input').keyup(calculate_total_price);
}

function bootstrap_multiselects() {
  $('#current-menu-items select.jquery-multiselect').multiselect({
    minWidth:335,
    header:false,
    noneSelectedText:'Нет выбранных меток',
    selectedList: 5
  });

  $('#order_user_id').multiselect({
    multiple: false,
    header:false,
    selectedList: 1
  });
}

function bootstrap_qtips() {
  $('.order label[title]').qtip({
    position: {corner: {target:'topleft', tooltip: 'bottomLeft'}},
    style: 'mystyle'
  });
}

$(function(){
  $('input[placeholder], textarea[placeholder]').placeholder();
  $('.menu a.remove').live('click', function(){
    if (confirm('Вы уверены?')) {
      remove_menu_item($(this).closest('.menu-item'));
    }

    return false;
  });
  $('.menu a.add-menu-item').live('click', function(){
    add_new_menu_item();
    $('input[placeholder]').placeholder();
    return false;
  });
  $('textarea#bulk').elastic();

  bootstrap_dish_order();
  bootstrap_multiselects();
  bootstrap_qtips();
});

